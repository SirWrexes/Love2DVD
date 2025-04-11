local DVD = require "src.dvd"
local Util = require "lib.Util"
local Vector2D = require "lib.Vector2D"
local inspect = require "lib.inspect"

local logo = DVD()

---@class Context
local ctx = {
    delta = 0,
    window = {
        dim = Vector2D(),
    },
    mouse = { pos = Vector2D() },
}

local bgColour = "#232323"

function love.load()
    local r, g, b = Util.hexToRgb(bgColour)
    love.graphics.setBackgroundColor(love.math.colorFromBytes(r, g, b))
    logo:init()

    ---Remove all metatables and [`ExtendableObject`](lua://ExtendableObject) shenanigans from output
    function inspect.proc.NO_META(item, path)
        local i = #path
        if path[i] == inspect.METATABLE or path[i] == "__instanceof" then return end
        return item
    end
end

function love.update(delta)
    if love.keyboard.isDown "q" then
        if __DEV then
            love.window.close()
        else
            love.event.quit()
        end
    end

    ctx.delta = delta
    ctx.mouse.pos:set(love.mouse.getPosition())
    ctx.window.dim:set(love.graphics.getDimensions())

    logo:update(ctx)
end

function love.draw()
    logo:draw(ctx)

    if __DEV then
        love.graphics.print("Ctx: " .. inspect(ctx, { process = inspect.proc.NO_META }), 10, 10)
        love.graphics.print("Logo: " .. inspect(logo, { process = inspect.proc.NO_META }), 250, 10)
    end
end
