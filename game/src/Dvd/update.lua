---@param self DVD
---@param ctx Context
return function(self, ctx)
    if ctx.pause then return end

    self:detectWindowCollision(ctx)
    self:updatePosition(ctx)

    if self:hasCollided() then
        -- self:changeColour()
        self.collision.u = false
        self.collision.d = false
        self.collision.l = false
        self.collision.r = false
    end
end
