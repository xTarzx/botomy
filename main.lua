
local StateMachine = require("core.statemachine")

local MenuScene = require("scenes.menu")
local PickerScene = require("scenes.scenePicker")
local SettingsScene = require("scenes.settings")


function love.load()
    local states = {
        menu = MenuScene.new(),
        picker = PickerScene.new(),
        settings = SettingsScene.new()
    }

    SceneManager = StateMachine.new(states)
    SceneManager:change("menu")
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
