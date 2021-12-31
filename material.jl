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

struct dielectric <: material
    ir::Float64
    dielectric(index_of_refraction::Float64) = new(index_of_refraction)
end

function scatter(d::dielectric,r_in::ray,rec::hit_record,attenuation::color,scattered::ray)
    attenuation.x = 1.0
    attenuation.y = 1.0
    attenuation.z = 1.0
    refraction_ratio = rec.front_face ? (1.0/d.ir) : d.ir

    unit_direction = unit_vector(r_in.direction)
    cos_theta = min(dot(-unit_direction, rec.normal),1.0)
    sin_theta = sqrt(1.0 - cos_theta * cos_theta)
    
    cannot_refract = refraction_ratio * sin_theta > 1.0
    direction = vec3()

    if cannot_refract
        direction = reflect(unit_direction, rec.normal)
        scattered.direction = direction
    else
        direction = refract(unit_direction,rec.normal,refraction_ratio)
        scattered.direction = direction
    end

    scattered.origin = rec.p
    return true
end




