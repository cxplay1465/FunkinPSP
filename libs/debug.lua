-- =============================
-- === FUNKIN ENGINE FOR PSP ===
-- ======= by CXPLAY btw =======
-- =============================

-- Библиотека для отладки

--#region ПЕРЕМЕННЫЕ

local debug = {}

--Текущая свободная следующая линия для debug.drawinfo()
local currentline = 0

--#endregion

--#region МЕТОДЫ

debug.update = function ()
    currentline = 0
end

---Возвращает оператвиную память в мегабайтах
---@return number
debug.RAM = function ()
    local ram = LUA.getRAM() / 1048576
    return ram
end

---Отрисовывает нужную информацию в левом верхнем углу (по X = 0, по Y = позиция столбца * 24 [высота текста])
---@param text string
debug.drawinfo = function (text)
    LUA.print(0, currentline * 12, text)
    currentline = currentline + 1
end

debug.log = function (text, type)
    
end

--#endregion

return debug