using Printf
include("vec3.jl")
include("color.jl")
include("ray.jl")

function ray_color(r::ray)
    unit_direction = unit_vector(r.direction)
    t = 0.5*(unit_direction.y + 1)
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




