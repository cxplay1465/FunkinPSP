-- =============================
-- === FUNKIN ENGINE FOR PSP ===
-- ======= by CXPLAY btw =======
-- =============================

local anim = require("libs.animation") -- либа для анимаций
local USGAPI = require("libs.USGAPI") -- юсгапи

local gfdancelua = require("assets/images/menu/titel/gfdancetitle")
local gfdanceimage = Image.load("assets/images/menu/titel/gfdancetitle.png")

local color_white = Color.new(255,255,255,255)

-- Основной цикл
while true do
    USGAPI.startFrame(nil, true)

    anim.playloop(gfdanceimage, 0, 0, gfdancelua, 1, 29, color_white)
end