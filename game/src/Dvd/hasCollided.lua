---@param self DVD
return function(self)
    return self.collision.l or self.collision.r or self.collision.u or self.collision.d
end
