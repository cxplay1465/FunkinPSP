local api = { camerax = 0, cameray = 0}
local debug = require("libs.debug")

--#region СИСТЕМНЫЕ ФУНКЦИИ

-- Функции Screen
local _screenflip = screen.flip
local _screenclear = screen.clear

-- Функции image
local _imagedraw = Image.draw
local _imagew = Image.W
local _imageh = Image.H

-- Функции дебага
local _debugupdate = debug.update 
local _debugdrawinfo = debug.drawinfo

--#endregion

--#region МЕТОДЫ

--- Обновляет экран (прописывать при запуске!)
---@param color? any
---@param showRAM? boolean
api.updatescreen = function (color, showRAM)
    -- Обновление экрана
    _screenflip()

    -- Очистка буфера экрана
    if color == nil then
        _screenclear()
    else
        _screenclear(color)
    end

    -- Обновление информации дебага
    _debugupdate()

    -- Нужно ли отображать оперативную память
    if showRAM == true then
        _debugdrawinfo("RAM: " .. tostring(debug.RAM()))
    end
end

--- Задает новую позицию камеры
---@param x number
---@param y number
api.setcameraposition = function (x, y)
    -- Параметры A для интерполяции
    api.oldcamerax = api.camerax
    api.oldcameray = api.cameray

    -- Параметры B для интерполяции (новая позиция камеры)
    api.camerax = x
    api.cameray = y
end

--- Отрисовка изображения
---@param image userdata
---@param x number
---@param y number
---@param rotation number
---@param size number
---@param color userdata
---@param srcx number
---@param srcy number
---@param srcw number
---@param srch number
---@param usecamera any
api.draw = function (image, x, y, rotation, size, color, srcx, srcy, srcw, srch, usecamera)

    local xpos = x - api.camerax
    local ypos = y - api.cameray

    -- Изначальные значения обрезки
    local croppedx = srcx
    local croppedy = srcy
    local croppedw = srcw
    local croppedh = srch

    if xpos + (srcw / 2) < 120 then
        local cropzone = srcw + xpos
        croppedx = cropzone
    end

    if xpos + (srcw / 2) > 360 then
        local cropzone = srcw - xpos
        croppedw = cropzone
    end

    if ypos + (srch / 2) < 68 then
        local cropzone = srch - ypos
        croppedy = cropzone
    end
    
    if ypos + (srch / 2) > 204 then
        local cropzone = srch + ypos
        croppedh = cropzone
    end

    -- Использовать камеру или нет
    if usecamera ~= true then
        _imagedraw(
            image,
            x, y,
            srcw * size, srch * size,
            color,
            croppedx, croppedy,
            croppedw, croppedh,
            rotation, 
            255,
            Image.Center
        )
    else
        _imagedraw(
            image,
            x - api.camerax, y - api.cameray,
            srcw * size, srch * size,
            color,
            srcx, srcy,
            srcw, srch,
            rotation, 
            255,
            Image.Center
        )
    end
end

--#endregion

return api