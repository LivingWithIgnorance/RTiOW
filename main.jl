using Printf

function main()
    imageWidth = 256
    imageHeight = 256

    file = open("image.ppm","w")
    
    write(file,"P3\n")
    write(file,string(imageWidth) * " ")
    write(file,string(imageHeight))
    write(file,"\n255\n")

    j = imageHeight - 1
    while j >= 0 
        @printf("\nScanlines remaining: %d",j)
        i = 0
        while i < imageWidth
            r = i / (imageWidth - 1)
            g = j / (imageHeight - 1)
            b = 0.25

            ir = trunc(UInt8,255.999 * r)
            ig = trunc(UInt8,255.999 * g)
            ib = trunc(UInt8,255.999 * b)

            output = string(ir) * " " * string(ig) * " " * string(ib) * "\n"
            write(file, output)

            i = i + 1
        end
        j = j - 1
    end
    println("\nDone!")
end

main()




