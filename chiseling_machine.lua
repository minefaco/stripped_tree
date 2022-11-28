local max_stack = tonumber(minetest.settings:get("default_stack_max")) or 99
--*************************************************************************
local machine_name = "Chiseling Machine"
local formspec = "size[8,9]"..
	            "label[0,0;"..machine_name.."]"..
	            "image[2,2;1,1;chisel.png]"..
	            "list[current_name;src;2,1;1,1;]"..
	            "list[current_name;dst;5,1;2,2;]"..
	            "list[current_player;main;0,5;8,4;]"..
	            "listring[current_name;dst]"..
	            "listring[current_player;main]"..
	            "listring[current_name;src]"..
	            "listring[current_player;main]"
minetest.register_node("stripped_tree:chiseling_machine", {
    description = machine_name,
    tiles = {"chiseling_machine.png", "chiseling_machine.png", "chiseling_machine_side.png", "chiseling_machine_side.png","chiseling_machine_side.png", "chiseling_machine_side.png"},
    groups = {cracky = 1},
    after_place_node = function(pos, placer)
        local meta = minetest.get_meta(pos)
        meta:set_string("formspec", formspec)
    end,
    on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", formspec)
		meta:set_string("infotext", machine_name)
		local inv = meta:get_inventory()
		inv:set_size("src", 1)
		inv:set_size("dst", 2)
		meta:set_int("elapsed", 0)
		meta:set_int("cook_time", 0)
		minetest.get_node_timer(pos):start(1.0)
	end,
	on_metadata_inventory_move = function(pos)
		minetest.get_node_timer(pos):start(1.0)
	end,
	on_metadata_inventory_put = function(pos)
        local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
            local stack = inv:get_stack("src", 1) 
            local nodename = stack:get_name()
            if nodename ~= "" then

                local count = stack:get_count()
                local mod_name, node_name = unpack(nodename:split(":"))
                local has_stripped = minetest.registered_nodes[mod_name..":".."stripped_"..node_name]
                local dstcount = inv:get_stack("dst",1):get_count()
                if has_stripped and dstcount < max_stack then
                    local stripped =mod_name..":".."stripped_"..node_name
                    inv:add_item("dst", stripped.." "..count)
                    inv:add_item("dst", "default:tree_bark "..count.."")
                    inv:remove_item("src", stack)
                end
            end

	end,

    on_receive_fields = function(pos, formname, fields, player)
        if fields.quit then
            return
        end

        print(fields.x)
    end,
        can_dig = function(pos)

            local meta = minetest.get_meta(pos)
            local inv = meta:get_inventory()
            return inv:is_empty("dst") and inv:is_empty("src")

        end,

	allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		if pos then
			return count
		end
		return 0
	end
})
minetest.register_craft({
	output = "stripped_tree:chiseling_machine",
	recipe = {
		{"group:wood","default:diamond","group:wood"},
		{"group:wood","stripped_tree:chisel","group:wood"},
		{"group:wood", "group:wood","group:wood"},
	},
})
