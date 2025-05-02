---@param self DVD
---@param ctx Context
return function(self, ctx)
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
