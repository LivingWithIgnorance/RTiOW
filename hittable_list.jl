include("hittable.jl")

mutable struct hittable_list <: hittable
    objects::Vector{hittable}
    hittable_list(object::hittable) = new([object])
    hittable_list() = new([])
end

function clear(hl::hittable_list)
    hl.objects = []
end

function add(hl::hittable_list,object::hittable)
    push!(hl.objects,object)
end

function hit(hl::hittable_list,r::ray,t_min::Float64,t_max::Float64,rec::hit_record)
    temp_rec = hit_record()
    hit_anything = false
    closest_so_far = t_max
    for object in hl.objects
        if hit(object,r,t_min,closest_so_far,temp_rec)
            hit_anything = true
            closest_so_far = temp_rec.t
            #reassign record 
            rec.front_face = temp_rec.front_face
            rec.normal = temp_rec.normal
            rec.p = temp_rec.p
            rec.t = temp_rec.t
            rec.mat_ptr = temp_rec.mat_ptr
        end
    end

    return hit_anything
end
