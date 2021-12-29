
function random_double()
    return rand(Float64)
end

function random_double(min::Float64,max::Float64)
    return min + (max-min) * random_double()
end

function clamp(x::Float64,min::Float64,max::Float64)
    if x < min return min end
    if x > max return max end
    return x
end
