-- =============================
-- === FUNKIN ENGINE FOR PSP ===
-- ======= by CXPLAY btw =======
-- =============================

-- Библиотеки и базовые переменные 
local anim = require("libs.animation") -- библиотека для анимаций
local color_white = Color.new(255, 255, 255) -- Базовый белый цвет

-- НАЧАЛЬНЫЙ ЭКРАН

-- Шрифт для начального текста (разработчики, ассоциация с нью граундс и т.д.)
local funkinfont = intraFont.load("assets/fonts/fnffont.ttf",24) 
-- Изображение логотипа NewGrounds
local nglogo = Image.load("assets/images/menu/titel/gfdancing_eee.png")

local bfmainimg = Image.load("assets/images/characters/boyfriend/bf_classic/bf_main.png")
local bfmainlua = require("assets/images/characters/boyfriend/bf_classic/bf_main")

local gfmainimg = Image.load("assets/images/menu/titel/gfdancing_eee.png")
local gfmainlua = require("assets.images.menu.titel.gfdancing_eee")

local logoimg = Image.load("assets/images/logobumpin.png")
local logolua = require("assets.images.logobumpin")

-- ФОНОВАЯ МУЗЫКА

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

local bfAnim = anim.playfromatlas(
    bfmainimg,        -- изображение
    80, 136,         -- позиция
    color_white,      -- цвет
    bfmainlua.frames, -- кадры (должна быть таблица с цифровыми индексами)
    true,             -- loop
    47,               -- firstframeid (bf_idle_01)
    60,               -- lastframeid (bf_idle_05)
    117,              -- BPM
    nil,              -- скорость
    48                -- beatframeid: кадр 14 на удар
)

local gfAnim = anim.playfromatlas(
    gfmainimg,        -- изображение
    400, 136,         -- позиция
    color_white,      -- цвет
    gfmainlua.frames, -- кадры (должна быть таблица с цифровыми индексами)
    true,             -- loop
    1,               -- firstframeid (bf_idle_01)
    30,               -- lastframeid (bf_idle_05)
    117,              -- BPM
    nil              -- скорость
)

local logoAnim = anim.playfromatlas(
    logoimg,        -- изображение
    240, 136,         -- позиция
    color_white,      -- цвет
    logolua.frames, -- кадры (должна быть таблица с цифровыми индексами)
    true,             -- loop
    1,               -- firstframeid (bf_idle_01)
    15,               -- lastframeid (bf_idle_05)
    117,              -- BPM
    nil,              -- скорость
    15                -- beatframeid: кадр 14 на удар
)

-- Основной цикл 
while true do
    screen.clear() -- Очистка экрана
    buttons.read() -- Считывание кнопок
    
    -- Запуск таймера для отсчета количества прошедших битов после старта песни
    timer.start(beattimer)

    -- Просчет битов за кадр
    if timer.time(beattimer) >= (60 / currentsong.bpm * 1000) then
        currentsong.currentbeat = currentsong.currentbeat + 1 -- +1 к биту
        timer.reset(beattimer) -- Сброс таймера до нуля
        timer.start(beattimer) -- Запуск таймера по новой
    end

    anim.draw(gfAnim)
    anim.draw(bfAnim)
    anim.draw(logoAnim)
    anim.update(logoAnim)
    anim.update(gfAnim)
    anim.update(bfAnim)

    --sound.play(sound.WAV_1, currentsong.looped)

    LUA.print(0, 0, tostring(currentsong.currentbeat))
    LUA.print(0, 15, tostring(timer.time(beattimer)))

    screen.flip() -- Вывод нового кадра
end