--Register nodes
local trunk_names = {
	"tree", "jungletree", "aspen_tree", "acacia_tree", "pine_tree",
}

-- Register all stripped trees
for _, name in ipairs(trunk_names) do
    minetest.register_node(":default:stripped_" .. name, {
	    description = "Stripped "..name,
	    tiles = {
		    "stripped_"..name.."_top.png",
		    "stripped_"..name.."_top.png",
		    "stripped_"..name..".png"
	    },
	    groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2, not_in_creative_inventory = 1},
	    sounds = default.node_sound_wood_defaults(),
	    paramtype2 = "facedir",
	    on_place = minetest.rotate_node,
    })
end

--list of axes to override
local axe_types = {
    "wood", "stone", "bronze", "steel", "mese", "diamond",
}

for _, axe_name in ipairs(axe_types) do

    minetest.override_item("default:axe_" .. axe_name, {
        on_place = function(itemstack, user, pointed_thing)

            if pointed_thing.type ~= "node" then
                return
            end

            local pos = pointed_thing.under
            local pname = user:get_player_name()

            if minetest.is_protected(pos, pname) then
                minetest.record_protection_violation(pos, pname)
                return
            end

            local node = minetest.get_node(pos).name

            for _, n in ipairs(trunk_names) do

                local tree = "default:"..n
                if tree==node then
                    local old_node = minetest.get_node(pos)
                    minetest.swap_node(pos, {name = "default:stripped_"..n, param2 = old_node.param2})
                    itemstack:add_wear(65535 / 299) -- 300 uses
                    return itemstack
                end
            end

        end,
    })
end

--register alias to support old tool
minetest.register_alias("chisel_tree:chisel", "default:axe_steel")




