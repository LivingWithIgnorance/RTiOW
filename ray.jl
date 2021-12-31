
mutable struct ray
    origin::point3
    direction::vec3
    #this will allow us to create empty rays by setting their fields to #undef
    ray() = new()
    ray(origin::point3,direction::vec3) = new(origin,direction)
end

function at(r::ray,t::Float64)
    return r.origin + t * r.direction
end