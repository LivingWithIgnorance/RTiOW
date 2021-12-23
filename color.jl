include("vec3.jl")

function write_color(pixel_color::color)
    r = string(trunc(UInt8,255.999 * pixel_color.x))
    g = string(trunc(UInt8,255.999 * pixel_color.y))
    b = string(trunc(UInt8,255.999 * pixel_color.z))

    return r * " " * g * " " * b * "\n"
end