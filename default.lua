--Register tree bark
minetest.register_craftitem(":default:tree_bark", {
	description = "Tree bark",
	inventory_image = "tree_bark.png",
	groups = {not_in_creative_inventory = 1, wood = 1}
})
--register bark as fuel
minetest.register_craft({
	type = "fuel",
	recipe = "default:tree_bark",
	burntime = 15,
})

--Register stripped trees
local mod_name = "default"
local trunk_names = {
    "tree",
    "jungletree",
    "aspen_tree",
    "acacia_tree",
    "pine_tree",
}

chisel_tree.register_trunk(mod_name,trunk_names)


--Register axes
local axe_types = {
"axe_wood",
"axe_stone",
"axe_bronze",
"axe_steel",
"axe_mese",
"axe_diamond",
}

chisel_tree.trunk_names(trunk_names)
chisel_tree.register_axes(mod_name,axe_types)

