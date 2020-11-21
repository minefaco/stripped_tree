--Register stripped trees
local mod_name = "moretrees"
local trunk_names = {
    "beech_trunk",
    "apple_tree_trunk",
    "oak_trunk",
    "sequoia_trunk",
    "birch_trunk",
    "palm_trunk",
    "date_palm_trunk",
    "spruce_trunk",
    "cedar_trunk",
    "poplar_trunk",
    "willow_trunk",
    "rubber_tree_trunk",
    "fir_trunk",
    "jungletree_trunk",

}

stripped_tree.register_trunk(mod_name,trunk_names)

--register tree variations using the same texture as default moretree trunks

minetest.register_node(":"..mod_name..":stripped_date_palm_ffruit_trunk", {
    description = "Stripped date_palm_fruit_trunk",
	tiles = {
		        "stripped_"..mod_name.."_date_palm_trunk_top.png",
		        "stripped_"..mod_name.."_date_palm_trunk_top.png",
		        "stripped_"..mod_name.."_date_palm_trunk.png"
	        },
	groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2, not_in_creative_inventory = 1},
	sounds = default.node_sound_wood_defaults(),
	paramtype2 = "facedir",
	on_place = minetest.rotate_node,
})

minetest.register_node(":"..mod_name..":stripped_date_palm_mfruit_trunk", {
    description = "Stripped date_palm_fruit_trunk",
	tiles = {
		        "stripped_"..mod_name.."_date_palm_trunk_top.png",
		        "stripped_"..mod_name.."_date_palm_trunk_top.png",
		        "stripped_"..mod_name.."_date_palm_trunk.png"
	        },
	groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2, not_in_creative_inventory = 1},
	sounds = default.node_sound_wood_defaults(),
	paramtype2 = "facedir",
	on_place = minetest.rotate_node,
})

minetest.register_node(":"..mod_name..":stripped_date_palm_ffruit_trunk", {
    description = "Stripped date_palm_fruit_trunk",
	tiles = {
		        "stripped_"..mod_name.."_date_palm_trunk_top.png",
		        "stripped_"..mod_name.."_date_palm_trunk_top.png",
		        "stripped_"..mod_name.."_date_palm_trunk.png"
	        },
	groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2, not_in_creative_inventory = 1},
	sounds = default.node_sound_wood_defaults(),
	paramtype2 = "facedir",
	on_place = minetest.rotate_node,
})

minetest.register_node(":"..mod_name..":stripped_date_palm_fruit_trunk", {
    description = "Stripped date_palm_fruit_trunk",
	tiles = {
		        "stripped_"..mod_name.."_date_palm_trunk_top.png",
		        "stripped_"..mod_name.."_date_palm_trunk_top.png",
		        "stripped_"..mod_name.."_date_palm_trunk.png"
	        },
	groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2, not_in_creative_inventory = 1},
	sounds = default.node_sound_wood_defaults(),
	paramtype2 = "facedir",
	on_place = minetest.rotate_node,
})

minetest.register_node(":"..mod_name..":stripped_rubber_tree_trunk_empty", {
    description = "Stripped date_palm_fruit_trunk",
	tiles = {
		        "stripped_"..mod_name.."_rubber_tree_trunk_top.png",
		        "stripped_"..mod_name.."_rubber_tree_trunk_top.png",
		        "stripped_"..mod_name.."_rubber_tree_trunk.png"
	        },
	groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2, not_in_creative_inventory = 1},
	sounds = default.node_sound_wood_defaults(),
	paramtype2 = "facedir",
	on_place = minetest.rotate_node,
})
