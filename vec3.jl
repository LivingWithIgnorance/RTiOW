#include("rtweekend.jl")
import Base

mutable struct vec3
    x::Float64
    y::Float64
    z::Float64
    vec3() = new()
    vec3(e0::Float64,e1::Float64,e2::Float64) = new(e0,e1,e2)
end

function Base.:-(v::vec3)
    return vec3(-v.x,-v.y,-v.z)
end

function plusEquals(v1::vec3,v2::vec3)
    v1.x += v2.x
    v1.y += v2.y
    v1.z += v2.z
    return v1
end

function scaleUp(v1::vec3, amount::Float64)
    v1.x *= amount
    v1.y *= amount
    v1.z *= amount
    return v1
end

function scaleDown(v1::vec3,amount::Float64)
    return scale(v1,1/amount)
end

function length(v1::vec3)
    return sqrt(length_squared(v1))
end

function length_squared(v1::vec3)
    return v1.x * v1.x + v1.y * v1.y + v1.z * v1.z
end

function Base.string(v::vec3)
    return string(v.x) * " " * string(v.y) * " " * string(v.z)
end

function Base.:+(v1::vec3, v2::vec3)
    return vec3(v1.x+v2.x,v1.y+v2.y,v1.z+v2.z)
end

function Base.:-(v1::vec3, v2::vec3)
    return vec3(v1.x-v2.x,v1.y-v2.y,v1.z-v2.z)
end

function Base.:*(v1::vec3, v2::vec3)
    return vec3(v1.x*v2.x,v1.y*v2.y,v1.z*v2.z)
end

function Base.:*(v::vec3, amount::Float64)
    return vec3(v.x*amount,v.y*amount,v.z*amount)
end

function Base.:*(amount::Float64,v::vec3)
    return v * amount
end

function Base.:/(v::vec3, amount::Float64)
    return (1/amount) * v
end

function dot(v1::vec3,v2::vec3)
    return v1.x * v2.x + v1.y * v2.y + v1.z * v2.z
end

function cross(v1::vec3,v2::vec3)
    newX = v1.y * v2.z - v1.z * v2.y
    newY = v1.z * v2.x - v1.x * v2.z
    newZ = v1.x * v2.y - v1.y * v2.x
    return vec3(newX,newY,newZ)
end

function unit_vector(v::vec3)
    return v / length(v)
end

function random(v::vec3=vec3(random_float(),random_float(),random_float()))
    return v
end

function random(min::Float64,max::Float64,v::vec3=vec3())
    v.x = random_float(min,max)
    v.y = random_float(min,max)
    v.z = random_float(min,max)
    return v
end

function random_in_unit_sphere()
    while true
        p = random(-1.0,1.0)
        if length_squared(p) >= 1 continue end
        return p
    end
end

function random_unit_vector()
    return unit_vector(random_in_unit_sphere())
end

function random_in_hemisphere(normal::vec3)
    in_unit_sphere = random_in_unit_sphere()
    if (dot(in_unit_sphere,normal) > 0.0) #in the hemisphere as the normal
        return in_unit_sphere
    else
        return -in_unit_sphere
    end
end

function near_zero(v::vec3)
    s = 1e-8
    return (abs(v.x) < s) && (abs(v.y) < s) && (abs(v.z) < s)
end

function reflect(v::vec3,n::vec3)
    return v- 2 * dot(v,n)*n
end

#Type aliases
point3 = vec3
color = vec3 
