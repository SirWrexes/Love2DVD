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
    self.pos = Vector2D {
        x = 500 - self.dim.x / 2,
        y = 400 - self.dim.y / 2,
    }
    self.rotation = 0
    self.speed = 150
    self.angle = -math.pi + love.math.random() * (2 * math.pi)
    self.collision = {
        l = false,
        r = false,
        u = false,
        d = false,
    }
end

---@param ctx Context
function DVD:update(ctx)
    if ctx.pause then return end

    local cos, sin = math.cos(self.angle), math.sin(self.angle)
    self.collision.u = self.pos.y <= 0
    self.collision.d = self.pos.y + self.dim.y >= ctx.window.dim.y
    self.collision.l = self.pos.x <= 0
    self.collision.r = self.pos.x + self.dim.x >= ctx.window.dim.x

    if self.collision.u or self.collision.d then
        self.pos.y = self.collision.u and 0 or ctx.window.dim.y - self.dim.y
        self.collision.u = false
        self.collision.d = false
        sin = sin * -1
    end
    if self.collision.l or self.collision.r then
        self.pos.x = self.collision.l and 0 or ctx.window.dim.x - self.dim.x
        self.collision.l = false
        self.collision.r = false
        cos = cos * -1
    end

    local next = {
        x = self.pos.x + self.speed * cos * ctx.delta,
        y = self.pos.y + self.speed * sin * ctx.delta,
    }

    self.angle = math.atan2(next.y - self.pos.y, next.x - self.pos.x)
    self.pos:set(next)
end

---@param ctx Context
function DVD:draw(ctx)
    love.graphics.draw(self.image, self.pos.x, self.pos.y, self.rotation, self.scale, self.scale)

    if __DEV then -- draw a visualitation of the trajectory vector
        local cos, sin = math.cos(self.angle), math.sin(self.angle)
        local vx = self.pos.x + self.speed * cos
        local vy = self.pos.y + self.speed * sin

        -- Velocities
        love.graphics.line(self.pos.x, self.pos.y, vx, self.pos.y)
        love.graphics.line(self.pos.x, self.pos.y, self.pos.x, vy)

        -- Angle
        love.graphics.line(self.pos.x, self.pos.y, vx, vy)
    end
end

return DVD
