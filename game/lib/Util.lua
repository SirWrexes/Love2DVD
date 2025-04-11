local M = {}

---@param hex string Colour in #xxxxxx format
---@return integer red
---@return integer green
---@return integer blue
function M.hexToRgb(hex)
    hex = hex:sub(2)

    local red = tonumber(hex:sub(1, 2), 16)
    local green = tonumber(hex:sub(3, 4), 16)
    local blue = tonumber(hex:sub(5, 6), 16)

    return red, green, blue
end

---Check that all elements of a table match a given value.<br>
---Will use `==` for equality unless a comparison function is provided.
---@generic T
---@param value T
---@param table unknown[]
---@param cmp? fun(value: T, element: unknown): boolean
---@return boolean
function M.all(value, table, cmp)
    if type(cmp) ~= "function" then
        function cmp(v, e)
            return v == e
        end
    end

    for _, element in ipairs(table) do
        if not cmp(value, element) then return false end
    end

    return true
end

return M
