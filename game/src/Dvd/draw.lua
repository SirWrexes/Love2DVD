local Colours = require "lib.Util.Colours"
local Vector3 = require "lib.Vector3"

local shader = love.graphics.newShader [[
extern vec3 replacement;

vec4 effect(vec4 colour, Image tex, vec2 tex_pos, vec2 scr_pos) {
    vec4 tex_colour = Texel(tex, tex_pos);

    if (tex_colour.a > 0)
        return vec4(replacement, 1.0);
    return tex_colour * colour;
}
]]

---@param self DVD
---@param ctx Context
return function(self, ctx)
    love.graphics.setShader(shader)
    shader:send("replacement", { self.colour:unpack() })
    love.graphics.draw(self.image, self.pos.x, self.pos.y, self.rotation, self.scale, self.scale)
    love.graphics.setShader()

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
