-- https://github.com/Deviatt/lua-namespace
assert(tonumber(_VERSION:sub(5, 7)) < 5.3, "Module not supported in Lua 5.3 or high")

local envStack = {}

local setfenv, getfenv, setmetatable, getmetatable, pop = setfenv, getfenv, setmetatable, getmetatable, table.remove
return function(ns)
	if (not ns) then return setfenv(1, pop(envStack)) end
	local env = getfenv(1)
	envStack[#envStack + 1] = env

	local meta = getmetatable(env[ns]) or {}
	if (envStack[#envStack] ~= env[ns]) then meta.__index = envStack[#envStack] or _G end -- Fix 'loop in gettable' & 'possible loop'
	local namespace = setmetatable(env[ns] or {}, meta)
	env[ns] = namespace
	setfenv(1, namespace)
end
