local StateMachine = require("core.statemachine")

local MenuScene = require("scenes.menu")
local PickerScene = require("scenes.levelPicker")
local SettingsScene = require("scenes.settings")
local PlayerScene = require("scenes.levelPlayer")

local serializeTable = require("core.utils.serializeTable")
local parseResolution = require("core.utils.parseResolution")

Settings = {
    fullscreen = false,
    resolution = "1280x720"
}

function SaveSettings()
    local out = "return " .. serializeTable(Settings)
    love.filesystem.write("settings.lua", out)
end

function LoadSettings()
    local chunk = love.filesystem.load("settings.lua")
    if chunk then
        Settings = chunk()
    end
    ApplySettings()
end

function ApplySettings()
    local res_w, res_h = parseResolution(Settings.resolution)
    if Settings.fullscreen then
        res_w, res_h = 0, 0
    end
    love.window.setMode(res_w, res_h, { fullscreen = Settings.fullscreen })
    local w, h = love.graphics.getDimensions()
    FontSize = h * 0.0443
    SaveSettings()
end


function love.load()
    LoadSettings()
    local states = {
        menu = MenuScene.new(),
        picker = PickerScene.new(),
        settings = SettingsScene.new(),
        player = PlayerScene.new()
    }

    SceneManager = StateMachine.new(states)
    SceneManager:change("menu")
    -- local w, h = love.graphics.getDimensions()
    -- FontSize = h * 0.0443
end

function love.update(dt)
    SceneManager:update(dt)
end

function love.draw()
    SceneManager:draw()
end

function love.keypressed(key)
    SceneManager:keypressed(key)
end

function love.keyreleased(key)
    SceneManager:keyreleased(key)
end

function ToggleFullscreen()
    Settings.fullscreen = not Settings.fullscreen
    ApplySettings()
end

