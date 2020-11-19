-- get modpath
local mpath = minetest.get_modpath("stripped_tree")

-- load functions
dofile(mpath .. "/functions.lua")

--load default
dofile(mpath .. "/default.lua")

--load optional dependencies
if minetest.get_modpath("moretrees") then
    dofile(mpath .. "/moretrees.lua")
end

if minetest.get_modpath("ethereal") then
    dofile(mpath .. "/ethereal.lua")
end



