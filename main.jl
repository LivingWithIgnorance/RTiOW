using Printf
include("vec3.jl")
include("color.jl")

println(typeof(color))

function main()
    #Image
    imageWidth = 256
    imageHeight = 256

    file = open("image.ppm","w")
    
    #Render
    write(file,"P3\n")
    write(file,string(imageWidth) * " ")
    write(file,string(imageHeight))
    write(file,"\n255\n")

    j = imageHeight - 1
    while j >= 0 
        @printf("\nScanlines remaining: %d",j)
        i = 0
        while i < imageWidth
            pixel_color = color(i/(imageWidth-1),j/(imageHeight-1),0.25)
            write(file, write_color(pixel_color))
            i = i + 1
        end
        j = j - 1
    end
    close(file)
    println("\nDone!")
end

main()




