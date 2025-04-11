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
    ctx.window.dim:set(love.graphics.getHeight(), love.graphics.getWidth())
    logo:update(ctx)
end

local function nometa(item, path)
    local i = #path
    if path[i] == inspect.METATABLE or path[i] == "__instanceof" then return end
    return item
end

function love.draw()
    logo:draw(ctx)

    if __DEV then
        love.graphics.print("Ctx: " .. inspect(ctx, { process = nometa }), 10, 10)
        love.graphics.print("Logo: " .. inspect(logo, { process = nometa }), 250, 10)
    end
end
