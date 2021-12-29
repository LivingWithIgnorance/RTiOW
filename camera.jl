include("rtweekend.jl")
include("vec3.jl")
include("ray.jl")

mutable struct camera
    origin::point3
    lower_left_corner::point3
    horizontal::vec3
    vertical::vec3
    function camera() 
        aspect_ratio = 16.0/9.0
        viewport_height = 2.0
        viewport_width  = aspect_ratio*viewport_height
        focal_length = 1.0

        origin = point3(0.0,0.0,0.0)
        horizontal = vec3(viewport_width,0.0,0.0)
        vertical = vec3(0.0,viewport_height,0.0)
        lower_left_corner = origin - horizontal/2.0 - vertical/2.0 - vec3(0.0,0.0,focal_length)
        new(origin,lower_left_corner,horizontal,vertical)
    end
end

function get_ray(c::camera,u::Float64,v::Float64)
    return ray(c.origin,c.lower_left_corner+ u*c.horizontal + v * c.vertical - c.origin)
end


