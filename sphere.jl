#include("ray.jl")
include("hittable.jl")
#include("material.jl")

mutable struct sphere <: hittable
    center::point3
    radius::Float64
    mat_ptr::material
    sphere(cen::point3,r::Float64) = new(cen,r)
    sphere(cen::point3,r::Float64,m::material) = new(cen,r,m)
end

function hit(s::sphere,r::ray,t_min::Float64,t_max::Float64,rec::hit_record)
    oc = r.origin - s.center
    a = length_squared(r.direction)
    half_b = dot(oc,r.direction)
    c = length_squared(oc) - s.radius * s.radius

    discriminant = half_b * half_b - a * c
    if (discriminant < 0)
        return false
    end

    sqrtd = sqrt(discriminant)

    #Find the nearest root that lies in the acceptable range
    root = (-half_b - sqrtd) / a
    if root < t_min || t_max < root
        root = (-half_b + sqrtd) / a
        if root < t_min || t_max < root
            return false
        end
    end

    # In c++ the assumption is that this should change the underlying rec that is passed to the method.
    # It should do the same in Julia normaly...
    rec.t = root
    rec.p = at(r,rec.t)
    outward_normal = (rec.p - s.center) / s.radius
    set_face_normal(rec,r,outward_normal)
    rec.mat_ptr = s.mat_ptr

    return true
end




