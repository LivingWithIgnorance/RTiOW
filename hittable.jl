abstract type material end

abstract type hittable end

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



