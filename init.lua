---@class Mo
---@field C nvim.config
---@field U nvim.util
local ns = {}

local function load_module(key)
  if key == "C" then
    return require("nvim.config")
  elseif key == "U" then
    return require("nvim.util")
  end
end

Mo = setmetatable(ns, {
  __index = function(t, key)
    local module = load_module(key)
    if module then
      rawset(t, key, module)
    end
    return module
  end,
})

Mo.C.setup()
