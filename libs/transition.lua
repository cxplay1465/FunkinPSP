-- =============================
-- === FUNKIN ENGINE FOR PSP ===
-- ======= by CXPLAY btw =======
-- =============================

--#region ПАРАМЕТРЫ

local transition = {}

-- градиент затемнения
local fadeImg = Image.load("assets/images/fade_gradient.png")
local color_black = Color.new(0,0,0)
--#endregion


--#region МЕТОДЫ

transition.fadein = function ()
    local y = -256

    if(y < 392) then
        y = y + 1
    else
        return true
    end

    screen.filledRect(240, y - 256, 512, 512, color_black, 0, 255, Image.Center)
    Image.draw(fadeImg, 240, y)

end

--#endregion

return transition