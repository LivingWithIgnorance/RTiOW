import Base

mutable struct vec3
    x::Float64
    y::Float64
    z::Float64
    vec3() = new(0.0,0.0,0.0)
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

const point3 = vec3
const color = vec3 