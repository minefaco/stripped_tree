local max_stack = tonumber(minetest.settings:get("default_stack_max"))
--*************************************************************************
minetest.register_node("stripped_tree:chiseling_machine", {
    description = "Rightclick me!",
    tiles = {"chiseling_machine.png", "chiseling_machine.png", "chiseling_machine_side.png", "chiseling_machine_side.png","chiseling_machine_side.png", "chiseling_machine_side.png"},
    groups = {cracky = 1},
    after_place_node = function(pos, placer)
        local meta = minetest.get_meta(pos)
        meta:set_string("formspec",
	            "size[8,9]"..
	            "label[0,0;Chiseling Machine]"..
	            "image[2,2;1,1;chisel.png]"..
	            "list[current_name;src;2,1;1,1;]"..
	            "list[current_name;dst;5,1;2,2;]"..
	            "list[current_player;main;0,5;8,4;]"..
	            "listring[current_name;dst]"..
	            "listring[current_player;main]"..
	            "listring[current_name;src]"..
	            "listring[current_player;main]"
        )
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
		-- start timer function, it will sort out whether furnace can burn or not.
		minetest.get_node_timer(pos):start(1.0)
            local stack = inv:get_stack("src", 1)
            local nodename = stack:get_name()
            local count = stack:get_count()
            local mod_name, node_name = unpack(nodename:split(":"))
            local has_stripped = minetest.registered_nodes[mod_name..":".."stripped_"..node_name]
            local dstcount = inv:get_stack("dst",1):get_count()
            if has_stripped and dstcount < max_stack then
                minetest.chat_send_all(dstcount)
                local stripped =mod_name..":".."stripped_"..node_name
                inv:add_item("dst", stripped.." "..count)
                inv:add_item("dst", "default:tree_bark "..count.."")
                inv:remove_item("src", stack)
            end

	end,

    on_receive_fields = function(pos, formname, fields, player)
        if fields.quit then
            return
        end

        print(fields.x)
    end,

	allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		if pos then
			return count
		end
		return 0
	end
})

--[[
minetest.register_node("stripped_tree:chiseling_machine", {
	        description = "Chiseling machine for trees",
	        tiles = {
		        "chiseling_machine.png"
	        },
	        groups = {choppy = 2, oddly_breakable_by_hand = 1},
	        sounds = default.node_sound_wood_defaults(),
	        paramtype2 = "facedir",
	        on_rightclick = function(pos,node,clicker,itemstack)
            minetest.chat_send_all("todo correcto")
            formspec(pos)
            end,
        })
]]--
minetest.register_craft({
	output = "stripped_tree:chiseling_machine",
	recipe = {
		{"group:wood","default:diamond","group:wood"},
		{"group:wood","stripped_tree:chisel","group:wood"},
		{"group:wood", "group:wood","group:wood"},
	},
})
