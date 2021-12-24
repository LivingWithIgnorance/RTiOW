using Printf
include("vec3.jl")
include("color.jl")
include("ray.jl")


function hit_sphere(center::point3,radius::Float64,r::ray)
    oc = r.origin - center
    a = dot(r.direction,r.direction)
    b = 2.0 * dot(oc,r.direction)
    c = dot(oc,oc) - radius*radius
    discriminant = b*b - 4*a*c
    if discriminant < 0
        return -1.0
    else
        return (-b - sqrt(discriminant)) / (2.0* a)
    end
end

function ray_color(r::ray)
    t = hit_sphere(point3(0.0,0.0,-1.0),0.5,r)
    if t > 0.0
        N = unit_vector(at(r,t) - vec3(0.0,0.0,-1.0))
        return 0.5*color(N.x+1.0,N.y+1.0,N.z+1.0)
    end
    unit_direction = unit_vector(r.direction)
    t = 0.5*(unit_direction.y + 1.0)
    return (1.0-t)*color(1.0,1.0,1.0) + t*color(0.5,0.7,1.0)
end



function main()
    #Image
    aspect_ratio = 16.0/9.0
    image_width = 400
    image_height = trunc(UInt16,image_width/aspect_ratio)

    file = open("image.ppm","w")

    #Camera

    viewport_height = 2.0
    viewport_width = aspect_ratio * viewport_height
    focal_length = 1.0

    origin = point3(0.0,0.0,0.0)
    horizontal = vec3(viewport_width,0.0,0.0)
    vertical = vec3(0.0,viewport_height,0.0)
    lower_left_corner = origin - horizontal /2.0 - vertical/2.0 - vec3(0.0,0.0, focal_length)
    
    #Render
    write(file,"P3\n")
    write(file,string(image_width) * " ")
    write(file,string(image_height))
    write(file,"\n255\n")

    j = image_height - 1
    while j >= 0 
        @printf("\nScanlines remaining: %d",j)
        i = 0
        while i < image_width
            u = i / (image_width-1)
            v = j / (image_height-1)
            r = ray(origin,lower_left_corner + u * horizontal + v * vertical - origin)
            pixel_color = ray_color(r)
            write(file, write_color(pixel_color))
            i = i + 1
        end
        j = j - 1
    end
    close(file)
    println("\nDone!")
end

main()




