local max_stack = tonumber(minetest.settings:get("default_stack_max")) or 99
local machine_name = "Chiseling Machine" -- "Chiseladora para troncos"
minetest.register_node("stripped_tree:chiseling_machine", {
    description = machine_name,
    tiles = {"chiseling_machine.png", "chiseling_machine.png", "chiseling_machine_side.png", "chiseling_machine_side.png","chiseling_machine_side.png", "chiseling_machine_side.png"},
    groups = {cracky = 1},

    after_place_node = function(pos, placer)
        local meta = minetest.get_meta(pos)
        meta:set_string("formspec", "size[8,9]label[0,0;" .. machine_name .. "]image[2,2;1,1;chisel.png]list[current_name;src;2,1;1,1;]list[current_name;dst;5,1;2,2;]list[current_player;main;0,5;8,4;]listring[current_name;dst]listring[current_player;main]listring[current_name;src]listring[current_player;main]")
    end,

    on_construct = function(pos)
        local inv = minetest.get_meta(pos):get_inventory()
        inv:set_size("src", 1)
        inv:set_size("dst", 2)
        minetest.get_node_timer(pos):start(1.0)
    end,

    on_metadata_inventory_put = function(pos, listname, index, stack, player)
        local inv = minetest.get_meta(pos):get_inventory()
        local src_stack = inv:get_stack("src", 1)
        local dst_stack = inv:get_stack("dst", 1)
        if listname == "src" and not src_stack:is_empty() then
            local src_name = src_stack:get_name()
            local src_count = src_stack:get_count()
            local mod_name, node_name = unpack(src_name:split(":"))
            local stripped_name = mod_name .. ":stripped_" .. node_name
            local has_stripped = minetest.registered_nodes[stripped_name]
            local dst_count = dst_stack:get_count()
            if has_stripped and dst_count < max_stack then
                inv:add_item("dst", stripped_name .. " " .. src_count)
                inv:add_item("dst", "default:tree_bark " .. src_count)
                inv:remove_item("src", src_stack)
            end
        end
    end,

    on_receive_fields = function(pos, formname, fields, sender)
        if fields.quit then return end
        print(fields.x)
    end,
        can_dig = function(pos)

            local meta = minetest.get_meta(pos)
            local inv = meta:get_inventory()
            return inv:is_empty("dst") and inv:is_empty("src")

        end,

    allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
        return count
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
