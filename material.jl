include("hittable.jl")


function scatter(m::material,r_in::ray,rec::hit_record,attenuation::color,scattered::ray)
    return false
end

struct lambertian <: material
    albedo::color
    lambertian(a::color) = new(a)
end

function scatter(l::lambertian,r_in::ray,rec::hit_record,attenuation::color,scattered::ray)
    scatter_direction = rec.normal + random_unit_vector()
    #catch degenerate scatter
    if near_zero(scatter_direction)
        scatter_direction = rec.normal
    end
    #argument reassignment
    scattered.origin = rec.p
    scattered.direction = scatter_direction
    attenuation.x = l.albedo.x
    attenuation.y = l.albedo.y
    attenuation.z = l.albedo.z
    return true
end

struct metal <: material
    albedo::color
    fuzz::Float64
    metal(a::color,f::Float64) = new(a,(f < 1 ? f : 1))
end

function scatter(m::metal,r_in::ray,rec::hit_record,attenuation::color,scattered::ray)
    reflected = reflect(unit_vector(r_in.direction), rec.normal)
    #argument reassignment
    scattered.origin = rec.p
    scattered.direction = reflected + m.fuzz*random_in_unit_sphere()
    attenuation.x = m.albedo.x
    attenuation.y = m.albedo.y
    attenuation.z = m.albedo.z
    return dot(scattered.direction,rec.normal) > 0
end



