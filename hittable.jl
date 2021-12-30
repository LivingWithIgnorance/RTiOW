abstract type material end



mutable struct hit_record
    p::point3
    normal::vec3
    mat_ptr::material
    t::Float64
    front_face::Bool
    hit_record() = new()
end

function set_face_normal(rec::hit_record,r::ray,outward_normal::vec3)
    rec.normal =  (dot(r.direction,outward_normal) < 0) ? outward_normal : -outward_normal
end

abstract type hittable end


function scatter(m::material,r_in::ray,rec::hit_record,attenuation::color,scattered::ray)
    return false
end

struct lambertian <: material
    albedo::color
    lambertian(a::color) = new(a)
end

function scatter(l::lambertian,r_in::ray,rec::hit_record,attenuation::color,scattered::ray)
    scatter_direction = rec.normal + random_unit_vector()
    #catch degenerate scatter
    if near_zero(scatter_direction)
        scatter_direction = rec.normal
    end
    #argument reassignment
    scattered.origin = rec.p
    scattered.direction = scatter_direction
    attenuation.x = l.albedo.x
    attenuation.y = l.albedo.y
    attenuation.z = l.albedo.z
    return true
end

struct metal <: material
    albedo::color
    metal(a::color) = new(a)
end

function scatter(m::metal,r_in::ray,rec::hit_record,attenuation::color,scattered::ray)
    reflected = reflect(unit_vector(r_in.direction), rec.normal)
    #argument reassignment
    scattered.origin = rec.p
    scattered.direction = reflected
    attenuation.x = m.albedo.x
    attenuation.y = m.albedo.y
    attenuation.z = m.albedo.z
    return dot(scattered.direction,rec.normal) > 0
end

