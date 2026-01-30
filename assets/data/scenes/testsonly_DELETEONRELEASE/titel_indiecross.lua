-- =============================
-- === FUNKIN ENGINE FOR PSP ===
-- ======= by CXPLAY btw =======
-- =============================

--#region ПАРАМЕТРЫ

-- Библиотеки и базовые переменные 
local anim = require("libs.animation") -- библиотека для анимаций
local fade = require("libs.fade")
local transition = require("libs.transition")
local debug = require("libs.debug")
local color_white = Color.new(255, 255, 255) -- Базовый белый цвет

local whitecube = Image.load("assets/images/white.png")

-- background
local bgimg = Image.load("mods/IndieCross/assets/images/menu/titel/bg.png")
local bglua = require("mods/IndieCross/assets/images/menu/titel/bg")

-- Бойфриенд
local bfimg = Image.load("mods/IndieCross/assets/images/menu/titel/bf.png")
local bflua = require("mods/IndieCross/assets/images/menu/titel/bf")

-- фон кнопки играть 
local pressimg = Image.load("mods/IndieCross/assets/images/menu/titel/playbuttonbg.png")
local presslua = require("mods/IndieCross/assets/images/menu/titel/playbuttonbg")

-- Ритмовый логотип 
local logoimg = Image.load("mods/IndieCross/assets/images/menu/titel/Logo.png")
local logolua = require("mods/IndieCross/assets/images/menu/titel/Logo")

--#region ИНТРО
PMP.setVolume(100) -- звук на 100
local introplayed = false
local introPath = "mods/IndieCross/assets/videos/intro.pmp"
--#endregion

--#endregion

--#region ФОНОВАЯ МУЗЫКА

-- Параметры текущей фоновой музыки
local currentsong = {
    path = "assets/audio/freakinmenu_indiecross.wav", -- Путь к аудио файлу
    soundchannel = sound.WAV_1, -- Канал для загрузки файла музыки
    bpm = 117, -- Битов в минуту
    looped = true, -- Зацикленно или нет
    currentbeat = 0 -- Сколько битов прошло после запуска аудио
}

sound.cloud(currentsong.path, currentsong.soundchannel, false) -- Загрузка музыки в звуковой канал

local beattimer = timer.create() -- таймер для отсчета количество битов после старта песни

--#endregion

--#region АНИМАЦИИ

--#region Press Enter to Begin

local pressenteranims = {}

local currentscreenstate = 0 -- 0 - silent, 1 - transition

pressenteranims.idle = anim.playfromatlas(
    pressimg,
    325, 225,
    1.25,
    color_white,
    presslua.frames,
    true,
    1, 17,
    currentsong.bpm,
    nil, 1
)

--#endregion

--#region Girlfriend

local bfdancinAnim = anim.playfromatlas(
    bfimg,
    360, 165,
    1,
    Color.new(255, 255, 255),
    bflua.frames,
    true,
    1, 14,
    currentsong.bpm,
    nil, 1
)

--#endregion

--#region Bumpin Logo

local logoAnim = anim.playfromatlas(
    logoimg,
    125, 136,
    1.6,
    color_white,
    logolua.frames,
    true,
    1, 14,
    currentsong.bpm,
    nil, 1
)

--#endregion

--#region BG

local bgAnim = anim.playfromatlas(
    bgimg,
    240, 136,
    2.1,
    color_white,
    bglua.frames,
    true,
    1, 11,
    currentsong.bpm,
    nil, 1
)

--#endregion

--#endregion

--#region МЕТОДЫ

local function pressbuttonscreen()

    local status = ""

    -- Текст "нажмите что-то там"
    if(buttons.pressed(buttons.cross)) or (buttons.pressed(buttons.start)) then
        currentscreenstate = 1
    end

    --#region Рендер изображений и анимаций

    -- Девка под бит
    anim.draw(bgAnim)
    anim.update(bgAnim)

    -- Девка под бит
    anim.draw(bfdancinAnim)
    anim.update(bfdancinAnim)

    -- Битовое лого
    anim.draw(logoAnim)
    anim.update(logoAnim)

    -- Отрисовка текста "Нажмите кнопку чтобы продолжить"
    if currentscreenstate == 0 then
        anim.update(pressenteranims.idle)
        anim.draw(pressenteranims.idle)
    elseif currentscreenstate == 1 then
        anim.update(pressenteranims.pressed)
        anim.draw(pressenteranims.pressed)
    end

    if currentsong.currentbeat >= 16 and currentsong.currentbeat <= 20 then
        if(fade.alphaOutValue <= 255) then
            Image.draw(whitecube, 240, 136, 480, 272, color_white, 0,0, 32, 32, 0, fade.alphaOut(30), Image.Center)
        end
    end

    --#endregion
end

local function screenstate()
    if introplayed == false then
        PMP.play(introPath, false, false, nil, buttons.start)
        introplayed = true
    end

    pressbuttonscreen()
end

local function loadMenu()
    dofile("assets/data/scenes/animationtest.lua")
end

--#endregion

--#region ОСНОВНОЙ ЦИКЛ
while true do
    screen.clear() -- Очистка экрана
    buttons.read() -- Считывание кнопок

    -- Запуск таймера для отсчета количества прошедших битов после старта песни
    timer.start(beattimer)

    -- Обновляет методы отвечающие за экран 
    screenstate()

    -- Просчет битов за кадр
    if timer.time(beattimer) >= (60 / currentsong.bpm * 1000) then
        currentsong.currentbeat = currentsong.currentbeat + 1 -- +1 к биту
        timer.reset(beattimer) -- Сброс таймера до нуля
        timer.start(beattimer) -- Запуск таймера по новой
    end

    --воспроизведение музыки
    sound.play(sound.WAV_1, currentsong.looped)

    -- Информация для дебага (по умолчанию - отключить)
    debug.update()

    debug.drawinfo("FUNKIN ENGINE")
    debug.drawinfo("CURRENT BEAT: " .. tostring(currentsong.currentbeat))
    debug.drawinfo("RAM: " .. tostring(debug.RAM()))

    screen.flip() -- Вывод нового кадра
end

--#endregion

--#region ПРИ ВЫХОДЕ:

--#endregion