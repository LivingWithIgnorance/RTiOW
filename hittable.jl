include("vec3.jl")
include("ray.jl")

mutable struct hit_record
    p::point3
    normal::vec3
    t::Float64
    front_face::Bool
    hit_record() = new(point3(0.0,0.0,0.0),vec3(0.0,0.0,0.0),0.0,false)
end

function set_face_normal(rec::hit_record,r::ray,outward_normal::vec3)
    front_face = dot(r.direction,outward_normal) < 0
    rec.normal = front_face ? outward_normal : -outward_normal
end

abstract type hittable end


