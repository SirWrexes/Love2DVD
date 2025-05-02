---@param self DVD
---@param ctx Context
return function(self, ctx)
    local cos, sin = math.cos(self.angle), math.sin(self.angle)

    if self.collision.u or self.collision.d then
        self.pos.y = self.collision.u and 0 or ctx.window.dim.y - self.dim.y
        sin = sin * -1
    end
    if self.collision.l or self.collision.r then
        self.pos.x = self.collision.l and 0 or ctx.window.dim.x - self.dim.x
        cos = cos * -1
    end
    local next = {
        x = self.pos.x + self.speed * cos * ctx.delta,
        y = self.pos.y + self.speed * sin * ctx.delta,
    }
    self.angle = math.atan2(next.y - self.pos.y, next.x - self.pos.x)
    self.pos:set(next)
end
