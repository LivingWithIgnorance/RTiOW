

abstract type material end

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
    scattered = ray(rec.p,scatter_direction)
    attenuation = l.albedo
    return true
end

struct metal <: material
    albedo::color
    metal(a::color) = new(a)
end

function scatter(m::metal,r_in::ray,rec::hit_record,attenuation::color,scattered::ray)
    reflected = reflect(unit_vector(r_in.direction), rec.normal)
    scattered = ray(rec.p,reflected)
    attenuation = m.albedo
    return dot(scattered.direction,rec.normal) > 0
end

