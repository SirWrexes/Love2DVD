---@param self DVD
---@param ctx Context
return function(self, ctx)
    self.collision.u = self.pos.y <= 0
    self.collision.d = self.pos.y + self.dim.y >= ctx.window.dim.y
    self.collision.l = self.pos.x <= 0
    self.collision.r = self.pos.x + self.dim.x >= ctx.window.dim.x
end
