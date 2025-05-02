---@diagnostic disable: duplicate-set-field

local Object = require "lib.object"
local inspect = require "lib.inspect"

---@class Vector2D.Partial
---@field x number?
---@field y number?

---@class Vector2D
---@overload fun(): self Default constructor

---@class Vector2D
---@overload fun(value: Vector2D.Partial): self Parameterised constructor

---@class Vector2D
---@overload fun(to_clone: self): self Copy constructor

---@class Vector2D: ExtendableObject
local Vector2D = Object:extend()

function Vector2D:__tostring()
    return string.format("(%.2f, %.2f)", self.x, self.y)
end

---@param value unknown
---@return self? value Input `value` cast as [`Vector2D`](lua://Vector2D) when `isVector2d == true`
function Vector2D.validate(value)
    if type(value) ~= "table" then return end
    if value.x and type(value.x) ~= "number" then return end
    if value.y and type(value.y) ~= "number" then return end
    return value
end

---@private
---@param x number
---@param y number
function Vector2D:init(x, y)
    if x == nil and y == nil then
        ---@diagnostic disable-next-line: cast-local-type
        x = { x = 0, y = 0 }
    elseif y ~= nil then
        ---@diagnostic disable-next-line: cast-local-type
        x = { x = x, y = y }
    end

    local value = assert(self.validate(x), "Invalid vector value: " .. inspect(x, {
        depth = 1,
        newline = " ",
        indent = " ",
    }))

    ---@type number
    self.x = value.x and value.x or 0

    ---@type number
    self.y = value.y and value.y or 0
end

---@param value Vector2D.Partial
function Vector2D:set(value) end

---@param value Vector2D
function Vector2D:set(value) end

---@param x number
---@param y number
function Vector2D:set(x, y)
    self:init(x, y)
end

function Vector2D:toTable()
    return { x = self.x, y = self.y }
end

---@return number x
---@return number y
function Vector2D:unpack()
    return self.x, self.y
end

return Vector2D
