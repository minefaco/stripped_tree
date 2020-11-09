chisel_tree = {}

--function to register nodes
function chisel_tree.register_trunk(mod_name,trunk_names)
    for _, name in ipairs(trunk_names) do
        minetest.register_node(":"..mod_name..":stripped_" .. name, {
	        description = "Stripped "..name,
	        tiles = {
		        "stripped_"..mod_name.."_"..name.."_top.png",
		        "stripped_"..mod_name.."_"..name.."_top.png",
		        "stripped_"..mod_name.."_"..name..".png"
	        },
	        groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2, not_in_creative_inventory = 1},
	        sounds = default.node_sound_wood_defaults(),
	        paramtype2 = "facedir",
	        on_place = minetest.rotate_node,
        })
    end
end

function chisel_tree.trunk_names(trunk_list)
    trunk_names = trunk_list
end

--function to override axes
function chisel_tree.register_axes(mod_name,axe_types)
    for _, axe_name in ipairs(axe_types) do
        minetest.override_item(mod_name..":" .. axe_name, {
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

                    local tree = mod_name..":"..n
                    if tree==node then
                        local old_node = minetest.get_node(pos)
                        minetest.swap_node(pos, {name = mod_name..":".."stripped_"..n, param2 = old_node.param2})
                        itemstack:add_wear(65535 / 299) -- 300 uses

		        if not creative_mode then
                            local inv = user:get_inventory()
                            --check for room in inv, if not, drop item
			    if inv:room_for_item("main", "default:tree_bark") then
                                inv:add_item("main", {name="default:tree_bark"})
			    else
			        minetest.add_item(pos, "default:tree_bark")
			    end
                        end

                        return itemstack
                    end
                end

            end,
        })
    end
end
--register alias to support old tool
minetest.register_alias("chisel_tree:chisel", "default:axe_steel")




