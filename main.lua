
local StateMachine = require("core.statemachine")

local MenuScene = require("scenes.menu")
local PickerScene = require("scenes.scenePicker")
local SettingsScene = require("scenes.settings")

local serializeTable = require("core.utils.serializeTable")

Settings = {
    fullscreen = false,
}

function SaveSettings()
    local out = "return " .. serializeTable(Settings)
    love.filesystem.write("settings.lua", ou)

end

function love.load()
    local states = {
        menu = MenuScene.new(),
        picker = PickerScene.new(),
        settings = SettingsScene.new()
    }

    SceneManager = StateMachine.new(states)
    SceneManager:change("menu")
    local w,h = love.graphics.getDimensions()
    FontSize = h*0.0443
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

function love.resize(w,h)
    FontSize = h*0.0443
end
