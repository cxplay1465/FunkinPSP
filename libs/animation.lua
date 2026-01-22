-- =============================
-- === FUNKIN ENGINE FOR PSP ===
-- ======= by CXPLAY btw =======
-- =============================

local USGAPI = require("libs.USGAPI")

local function playloop(image, x, y, frames, firstframe, lastframe, color)
    local curframe = firstframe 
    while curframe <= lastframe  do
        curframe = curframe + 1
        if frames[curframe] == nil then
            curframe = -1
            return
        end

        Image.draw(image, x, y, frames.resolution[1], frames.resolution[2], color, frames.animation[curframe][1], frames.animation[curframe][2], frames.animation[curframe][3], frames.animation[curframe][4])
        return
    end
end

-- ВАЖНО: возвращаем таблицу с функциями
return {
    playloop = playloop
}