--Register nodes
local trunk_names = {
	"tree", "jungletree", "aspen_tree", "acacia_tree","pine_tree",
}

-- Register all trees
for _, name in ipairs(trunk_names) do

    minetest.register_node(":default:stripped_"..name, {
	    description = "Stripped "..name,
	    tiles = {
		    "stripped_"..name.."_top.png",
		    "stripped_"..name.."_top.png",
		    "stripped_"..name..".png"
	    },
	    groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
	    sounds = default.node_sound_wood_defaults(),
	    paramtype2 = "facedir",
	    on_place = minetest.rotate_node,
    })

end

--Register tool
minetest.register_tool("chisel_tree:chisel", {
	description = "A chisel for wood",
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

        for _, n in ipairs(trunk_names) do

            local tree = "default:"..n
            if tree==node then
                minetest.swap_node(pos, {name = "default:stripped_"..n})
		        itemstack:add_wear(65535 / 299) -- 300 uses
		        return itemstack
            end
        end

	end,
})

--Register craft

minetest.register_craft({
	output = "chisel_tree:chisel",
	recipe = {
		{"", "default:steel_ingot", ""},
		{"", "group:fence", ""},
	}
})




