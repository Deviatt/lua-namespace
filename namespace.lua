-- https://github.com/Deviatt/lua-namespace
assert(tonumber(_VERSION:sub(5, 7)) < 5.3, "Module not supported in Lua 5.3 or high")

local envStack = {}

local setfenv, getfenv, setmetatable, pop = setfenv, getfenv, setmetatable, table.remove
return function(ns)
	if (not ns) then return setfenv(#envStack - 1, pop(envStack, #envStack)) end
	local stackLen = #envStack
	local env = getfenv(stackLen)
	stackLen = stackLen + 1
	envStack[stackLen] = env

	local namespace = env[ns] or setmetatable({}, {__index = envStack[stackLen - 1] or _G})
	env[ns] = namespace
	setfenv(stackLen, namespace)
end