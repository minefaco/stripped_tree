--Register tree bark
minetest.register_craftitem(":default:tree_bark", {
	description = "Tree bark",
	inventory_image = "tree_bark.png",
	groups = {not_in_creative_inventory = 1}
})
--register bark as fuel
minetest.register_craft({
	type = "fuel",
	recipe = "default:tree_bark",
	burntime = 15,
})

--Register craft for string
if minetest.get_modpath("farming") then

        minetest.register_craft({
	        output = "farming:string 4",
	        recipe = {{"default:tree_bark","default:tree_bark","default:tree_bark"},
			      {"default:tree_bark","default:tree_bark","default:tree_bark"},
			      {"default:tree_bark","default:tree_bark","default:tree_bark"}}
        })
end

--Register craft for paper
minetest.register_craft({
    output = "default:paper 8",
    recipe = {{"default:tree_bark","default:tree_bark","default:tree_bark"},
			  {"default:tree_bark","bucket:bucket_water","default:tree_bark"},
			  {"default:tree_bark","default:tree_bark","default:tree_bark"}},
    replacements = {{"bucket:bucket_water", "bucket:bucket_empty"}}
})

--Register craft for mulch
if minetest.get_modpath("bonemeal") then

        minetest.register_craft({
	    output = "bonemeal:mulch 4",
	    recipe = {{"default:tree_bark","default:tree_bark","default:tree_bark"},
			      {"default:tree_bark","default:tree_bark","default:tree_bark"},
			      {"","",""}}
        })
end
--Register stripped trees
local mod_name = "default"
local trunk_names = {
    "tree",
    "jungletree",
    "aspen_tree",
    "acacia_tree",
    "pine_tree",
}

stripped_tree.register_trunk(mod_name,trunk_names)


--Register axes
local axe_types = {
"axe_wood",
"axe_stone",
"axe_bronze",
"axe_steel",
"axe_mese",
"axe_diamond",
}
if not stripped_tree.ENABLE_CHISEL then
stripped_tree.register_axes(mod_name,axe_types)
end

