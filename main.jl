using Printf
include("vec3.jl")
include("color.jl")
include("ray.jl")
include("sphere.jl")
include("camera.jl")
include("rtweekend.jl")
include("hittable_list.jl")
include("material.jl")


function ray_color(r::ray, world::hittable,depth::Int)
    rec = hit_record()
    #A depth to safeguard against blowing the stack on a lot of recursive calls. AKA Limiting child rays.
    if depth<= 0
        return color(0.0,0.0,0.0)
    end

    if (hit(world,r,0.001,Inf,rec))
        scattered = ray()
        attenuation = color()
        if scatter(rec.mat_ptr,r,rec,attenuation,scattered)
            return attenuation * ray_color(scattered,world,depth-1)
        end
        return color(0.0,0.0,0.0)
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
    max_depth = 50

    file = open("image.ppm","w")

    # World

    world = hittable_list()

    material_ground = lambertian(color(0.8,0.8,0.0))
    material_center = lambertian(color(0.1,0.2,0.5))
    material_left = dielectric(1.5)
    material_right = metal(color(0.8,0.6,0.2), 0.0)

    add(world,sphere(point3(0.0,-100.5, -1.0), 100.0, material_ground))
    add(world,sphere(point3(0.0,0.0,-1.0), 0.5, material_center))
    add(world,sphere(point3(-1.0,0.0,-1.0),0.5,material_left))
    add(world,sphere(point3(-1.0,0.0,-1.0),-0.45,material_left))
    add(world,sphere(point3(1.0,0.0,-1.0),0.5,material_right))


    #Camera
    lookfrom = point3(3.0,3.0,2.0)
    lookat = point3(0.0,0.0,-1.0)
    vup = vec3(0.0,1.0,0.0)
    dist_to_focus = length(lookfrom - lookat)
    aperture = 2.0

    cam = camera(lookfrom,lookat,vup,20.0,aspect_ratio,aperture,dist_to_focus)
    
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
                u = (i + random_float()) / (image_width - 1)
                v = (j + random_float()) / (image_height -1)
                r = get_ray(cam,u,v)
                pixel_color += ray_color(r,world,max_depth)
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




