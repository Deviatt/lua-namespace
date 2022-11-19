-- https://github.com/Deviatt/lua-namespace
assert(tonumber(_VERSION:sub(5, 7)) < 5.3, "Module not supported in Lua 5.3 or high")

local envStack = {}

local setfenv, getfenv, setmetatable, pop = setfenv, getfenv, setmetatable, table.remove
return function(ns)
	if (not ns) then return setfenv(1, pop(envStack)) end
	local env = getfenv(2)
	envStack[#envStack + 1] = env

	local namespace = env[ns] or setmetatable({}, {__index = envStack[#envStack] or _G})
	env[ns] = namespace
	setfenv(2, namespace)
end
