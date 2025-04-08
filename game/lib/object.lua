--
-- Project: lua-object
-- objects for Lua
-- Original source: https://github.com/nusov/lua-object/blob/master/src/lua-object/object.lua
--
-- Copyright 2015 Alexander Nusov. Licensed under the MIT License.
-- See @license text at http://www.opensource.org/licenses/mit-license.php
--
--

---@class Object
local object = {}

function object:__getinstance()
	local o = setmetatable({ ___instanceof = self }, self)
	self.__index = self
	return o
end

function object:init(...) end

function object:new(...)
	local o = self:__getinstance()
	o:init(...)
	return o
end

function object:extend(...)
	local cls = self:__getinstance()
	cls.init = function() end

	for _, f in pairs({ ... }) do
		f(cls, self)
	end
	return cls
end

function object.is_typeof(instance, class)
	return instance ~= nil and (instance.___instanceof == class)
end

function object.is_instanceof(instance, class)
	return instance ~= nil and (instance.___instanceof == class or object.is_instanceof(instance.___instanceof, class))
end

return object
