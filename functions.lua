stripped_tree = {}
--Select between chisel tool or axes.
stripped_tree.ENABLE_CHISEL = core.settings:get_bool"stripped_tree_enable_chisel"
local creative_mode = minetest.settings:get_bool("creative_mode")

--Function to verify that stripped tree trunk exists
stripped_tree.has_stripped = function(pos)
    local node = minetest.get_node(pos).name or pos
    local mod_name, node_name = unpack(node:split(":"))
    local has_stripped = minetest.registered_nodes[mod_name..":".."stripped_"..node_name]
    return has_stripped
end

--Function to swap nodes
stripped_tree.swap_node = function(pos,user,creative_mode)
    local old_node = minetest.get_node(pos)
    local stripped =mod_name..":".."stripped_"..node_name
    minetest.swap_node(pos,{name=stripped,param2=old_node.param2})
    --itemstack:add_wear(65535 / 299) this is not useful at moment.

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

--function to register nodes
function stripped_tree.register_trunk(mod_name,trunk_names)
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

        minetest.register_craft({
	    output = mod_name..":"..name,
	    recipe = {{"","default:tree_bark",""},
			      {"default:tree_bark",mod_name..":stripped_" .. name,"default:tree_bark"},
			      {"","default:tree_bark",""}}
        })
    end
end

--function to override axes
if stripped_tree.ENABLE_CHISEL ~= true then
    function stripped_tree.register_axes(mod_n,axe_types)
        for _, axe_name in ipairs(axe_types) do
            minetest.override_item(mod_n..":" .. axe_name, {
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

                    if stripped_tree.has_stripped(pos) then
                        stripped_tree.swap_node(pos,user,creative_mode)
                    end

                end,
            })
        end
    end
end
