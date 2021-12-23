include("vec3.jl")

mutable struct ray
    origin::point3
    direction::vec3
    ray(origin::point3,direction::vec3) = new(origin,direction)
end

function at(r::ray,t::Float64)
    return r.origin + t * r.direction
end