-- =============================
-- === FUNKIN ENGINE FOR PSP ===
-- ======= by CXPLAY btw =======
-- =============================

local fade = {}
fade.alphaOutValue = 255
fade.alphaInValue = 0

---Считает альфа от 0 до 255 с заданной скоростью
---@param speed integer Скорость альфа анимации
---@return integer
function fade.alphaIn(speed)
    if speed == nil or 0 then
        speed = 1
    end

    if (fade.alphaInValue < 0) then 
        fade.alphaInValue = 0
    end

    if (fade.alphaInValue > 255) then 
        fade.alphaInValue = 255 
    end

    if (fade.alphaInValue == 0) then 
        return fade.alphaInValue
    end

    fade.alphaInValue = fade.alphaInValue + speed
    return fade.alphaInValue
end

---Считает альфа от 255 до 0 с заданной скоростью
---@param speed integer Скорость альфа анимации
---@return integer
function fade.alphaOut(speed)
    if speed == nil or speed == 0 then
        speed = 1
    end

    fade.alphaOutValue = fade.alphaOutValue - speed

    if (fade.alphaOutValue < 0) then 
        fade.alphaOutValue = 0
    end

    if (fade.alphaOutValue > 255) then 
        fade.alphaOutValue = 255 
    end

    if (fade.alphaOutValue == 0) then 
        return fade.alphaOutValue
    end

    return fade.alphaOutValue
end

function fade.resetAll()
    fade.alphaInValue = 0
    fade.alphaOutValue = 255
    return
end

return fade

