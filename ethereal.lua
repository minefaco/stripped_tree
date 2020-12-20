--Register stripped trees
local mod_name = "ethereal"
local trunk_names = {
    "banana_trunk",
    "birch_trunk",
    "scorched_tree",
    "yellow_trunk",
    "willow_trunk",
    "redwood_trunk",
    "sakura_trunk",
    "frost_tree",
    "palm_trunk",
}

stripped_tree.register_trunk(mod_name,trunk_names)


--Register axes
local axe_types = {
"axe_crystal",
}
if not ENABLE_CHISEL then
stripped_tree.register_axes(mod_name,axe_types)
end
