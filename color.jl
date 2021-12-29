include("vec3.jl")

function write_color(pixel_color::color,samples_per_pixel::Int)
    r = pixel_color.x
    g = pixel_color.y
    b = pixel_color.z

    scale = 1.0 / samples_per_pixel
    r *= scale
    g *= scale
    b *= scale
    
    r_str = string(trunc(UInt8,255.999 * clamp(r,0.0,0.999)))
    g_str = string(trunc(UInt8,255.999 * clamp(g,0.0,0.999)))
    b_str = string(trunc(UInt8,255.999 * clamp(b,0.0,0.999)))

    return r_str * " " * g_str * " " * b_str * "\n"
end