local Object = require "lib.object"
local Vector2D = require "lib.Vector2D"
local inspect = require "lib.inspect"

local MAX_DIM = 128

---@class DVD
---@overload fun(): self

---@class DVD : ExtendableObject
local DVD = Object:extend()

function DVD:init(...)
    self.image = love.graphics.newImage "assets/dvd.png"

    local dim = Vector2D(self.image:getDimensions())
    local scale_target = (dim.x > dim.y and "x") or "y"

    self.scale = MAX_DIM / dim[scale_target]
    self.dim = Vector2D {
        x = dim.x * self.scale,
        y = dim.y * self.scale,
    }
    self.centre = Vector2D()
    self.pos = Vector2D {
        x = 500,
        y = 400,
    }
    self.rotation = 0
    self.speed = 100
    self.angle = love.math.random() * math.pi
end

---@param ctx Context
function DVD:update(ctx)
    local cos, sin = math.cos(self.angle), math.sin(self.angle)

    self.pos:set {
        x = self.pos.x + self.speed * cos * ctx.delta,
        y = self.pos.y + self.speed * sin * ctx.delta,
    }

    self.centre:set {
        x = self.pos.x + self.dim.x / 2,
        y = self.pos.y + self.dim.y / 2,
    }
end

---@param ctx Context
function DVD:draw(ctx)
    love.graphics.draw(self.image, self.pos.x, self.pos.y, self.rotation, self.scale, self.scale)

    if __DEV then
        -- Velocities
        love.graphics.line(self.centre.x, self.centre.y, ctx.mouse.pos.x, self.centre.y)
        love.graphics.line(self.centre.x, self.centre.y, self.centre.x, ctx.mouse.pos.y)

        --The angle
        love.graphics.line(self.centre.x, self.centre.y, ctx.mouse.pos.x, ctx.mouse.pos.y)
    end
end

return DVD
