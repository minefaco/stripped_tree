


-- get modpath
local mpath = minetest.get_modpath("stripped_tree")

-- load functions
dofile(mpath .. "/functions.lua")

--load default
dofile(mpath .. "/default.lua")
dofile(mpath .. "/chiseling_machine.lua")

--load optional dependencies
if minetest.get_modpath("moretrees") then
    dofile(mpath .. "/moretrees.lua")
end

if minetest.get_modpath("ethereal") then
    dofile(mpath .. "/ethereal.lua")
end

if minetest.get_modpath("moreores") then
    dofile(mpath .. "/moreores.lua")
end

if stripped_tree.ENABLE_CHISEL then

    minetest.register_tool("stripped_tree:chisel", {
	    description = "Chisel for tree trunks",
	    inventory_image = "chisel.png",
	    wield_image = "chisel.png",
	    sound = {breaks = "default_tool_breaks"},
	    stack_max = 1,
	    on_use = function(itemstack, user, pointed_thing)

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
				local mod_name, node_name = unpack(node:split(":"))
                -- before concatenating check for nil
                if not mod_name then return end
                if not node_name then return end
				local has_stripped = minetest.registered_nodes[mod_name..":".."stripped_"..node_name]

		    if has_stripped then
                local stripped = mod_name..":".."stripped_"..node_name
			    minetest.swap_node(pos,{name=stripped})

		        if not minetest.settings:get_bool("creative_mode") then
                    local inv = user:get_inventory()
                    --check for room in inv, if not, drop item
			        if inv:room_for_item("main", "default:tree_bark") then
                        inv:add_item("main", {name="default:tree_bark"})
			        else
			            minetest.add_item(pos, "default:tree_bark")
			        end
                    itemstack:add_wear(65535 / 299) -- 300 uses
                end

			    return itemstack
		    end

	    end,
    })

    minetest.register_craft({
	    output = "stripped_tree:chisel",
	    recipe = {{"","default:steel_ingot",""},
			      {"","screwdriver:screwdriver",""},
			      {"","",""}}
        })
end
