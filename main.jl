using Printf
include("vec3.jl")
include("color.jl")
include("ray.jl")
include("hittable_list.jl")
include("sphere.jl")
include("camera.jl")
include("rtweekend.jl")

function ray_color(r::ray, world::hittable)
    rec = hit_record()
    if (hit(world,r,0.0,Inf,rec))
        return 0.5 * (rec.normal + color(1.0,1.0,1.0))
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
    samples_per_pixel = 100

    file = open("image.ppm","w")

    # World

    world = hittable_list()
    add(world,sphere(point3(0.0,0.0,-1.0),0.5))
    add(world,sphere(point3(0.0,-100.5,-1.0),100.0))

    #Camera
    cam = camera()
    
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
            pixel_color = color(0.0,0.0,0.0)
            s = 0
            while s < samples_per_pixel
                u = (i + random_double()) / (image_width - 1)
                v = (j + random_double()) / (image_height -1)
                r = get_ray(cam,u,v)
                pixel_color += ray_color(r,world)
                s += 1
            end
            write(file, write_color(pixel_color,samples_per_pixel))
            i = i + 1
        end
        j = j - 1
    end
    close(file)
    println("\nDone!")
end

main()




