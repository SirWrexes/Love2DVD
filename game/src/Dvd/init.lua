local Object = require "lib.object"
local Vector2D = require "lib.Vector2D"

local MAX_DIM = 128

---@class DVD
---@overload fun(): self

---@class DVD : ExtendableObject
local DVD = Object:extend()

function DVD:init(...)
    self.image = love.graphics.newImage "assets/dvd.png"

    local dim = Vector2D(self.image:getDimensions())
    local scaleTarget = (dim.x > dim.y and "x") or "y"

    self.scale = MAX_DIM / dim[scaleTarget]
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

DVD.detectWindowCollision = require "src.Dvd.detectWindowCollision"
DVD.hasCollided = require "src.Dvd.hasCollided"

DVD.updatePosition = require "src.Dvd.updatePosition"
DVD.update = require "src.Dvd.update"

DVD.draw = require "src.Dvd.draw"

return DVD
