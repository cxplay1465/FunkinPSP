-- =============================
-- === FUNKIN ENGINE FOR PSP ===
-- ======= by CXPLAY btw =======
-- =============================

--#region ПАРАМЕТРЫ

-- Библиотеки и базовые переменные 
local anim = require("libs.animation") -- библиотека для анимаций
local fade = require("libs.fade")
local transition = require("libs.transition")
local color_white = Color.new(255, 255, 255) -- Базовый белый цвет

local whitecube = Image.load("assets/images/white.png")

-- НАЧАЛЬНЫЙ ЭКРАН

-- Шрифт для начального текста (разработчики, ассоциация с нью граундс и т.д.)
local funkinfont = intraFont.load("assets/fonts/fnffont.ttf",24) 

-- Таблица случайных фраз в начальном экране
local randomphrases = {
    {"DANCIN'", "FOREVER", ""},
    {"FUNKIN'", "FOREVER", ""},
    {"DOPE-ASS GAME", "PLAYSTATION MAGAZINE", ""},
    {"I DONT KNOW HOW TO FIX THIS", "(from CXPLAY)", ""},
    {"TESTTESTTESTTESTTESTTESTTEST", "NOTE DELETE ON RELEASE", ""},
    {"WHEN ONESHOT PSP?", "I DONT KNOW :DDD"},
    {"GAME OF THE YEAR", "FOREVER", ""},
    {"LIKE PARAPPA", "BUT COOLER", ""},
    {"RHYTHM GAMING", "ULTIMATE", ""},
    {"TRENDING", "ONLY ON X", ""},
    {"KICKSTARTER EXCLUSIVE", "INTRO TEXT HEHE"},
    {"BETTER THAN PSX VERSION", "MAYBE OR", "MAYBE NOT"},
    {"THX TO KODILO FOR", "LUAPLAYER YT", ""},
    {"PICO FUNNY", "PICO FUNNY", ""},
    {"DID YOU KNOW DEAD SEA?", "I KILLED HIM", ""},
    {"DONT PLAY RUST", "WE ONLY FUNKIN", ""},
    {"NEWGROUNDS", "FOREVER", ""},
    {"VPN IN RUSSIAN", "NOT FOREVER", ""},
    {"U CAN MADE OR DOWNLOAD", "INDIE CROSS ON PSP", ""},
    {"SUBSCRIBE TO OUR", "TELEGRAM CHANNEL", "(pls)"},
    {"BETTER THAN GEOMETRY DASH", "FIGHT ME ROBTOP", ""},
    {"GEOMETRY DASH IS A", "RHYTHM GAME", "ISNT IT?"},
    {"WHEN BAD APPLE ON A MARS?", "NO, IM SERIOUS - WHEN?", ""},
    {"THIS IS A GODDAWN PROTOTYPE", "WE WORKING ON IT", ""},
    {"PRESS SQUARE", "TO OPEN POPUP", "(SERIOUSLY DO IT)"},
    {"IM TOO LAZY TO", "ADD MORE PHRASES", ""},
    {"ERROR:", "KID JOINED THE GAME", ""}
}

-- Выбранная с помощью рандома фраза из таблицы randomphrases
local selectedrandomphrase = LUA.getRandom(1, 27)

-- Изображение логотипа NewGrounds
local nglogo = Image.load("assets/images/tankman_nglogo.png")

-- Танцующая девка)
local gfimg = Image.load("assets/images/menu/titel/gfdancing_eee.png")
local gflua = require("assets.images.menu.titel.gfdancing_eee")

-- Текст внизу хехе
local pressimg = Image.load("assets/images/menu/titel/pressf.png")
local presslua = require("assets.images.menu.titel.pressf")

-- Ритмовый логотип 
local logoimg = Image.load("assets/images/logobumpin.png")
local logolua = require("assets.images.logobumpin")

local randomtext = {
    ["1"] = {"DOBAVLY TEXTA SYDA POSZHE"}
}
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

local beatsbeforeswith = 0

sound.cloud(currentsong.path, currentsong.soundchannel, false) -- Загрузка музыки в звуковой канал

local beattimer = timer.create() -- таймер для отсчета количество битов после старта песни

--#endregion

--#region АНИМАЦИИ

--#region Press Enter to Begin

local pressenteranims = {}

local currentscreenstate = 0 -- 0 - silent, 1 - transition

pressenteranims.idle = anim.playfromatlas(
    pressimg,
    240, 250,
    0, 0, 1.7,
    color_white,
    presslua.frames,
    true,
    10, 54,
    nil,
    0.05
)

pressenteranims.pressed = anim.playfromatlas(
    pressimg,
    240, 240,
    0, 0, 1.7,
    color_white,
    presslua.frames,
    false,
    1, 9,
    nil,
    0.05
)

--#endregion

--#region Girlfriend

local gfdancinAnim = anim.playfromatlas(
    gfimg,
    350, 165,
    0, 0, 2.5,
    color_white,
    gflua.frames,
    true,
    1, 30,
    currentsong.bpm / 2,
    nil, 1
)

--#endregion

--#region Bumpin Logo

local logoAnim = anim.playfromatlas(
    logoimg,
    125, 100,
    0, 0, 1.6,
    color_white,
    logolua.frames,
    true,
    1, 15,
    currentsong.bpm,
    nil, 15
)

--#endregion

--#endregion

--#region МЕТОДЫ


-- Отображение начальных текстов (фанкин крю, ньюграундс, рандом текст, фнф)
local function splashtext(newgroundstext, ngimage, devstext, randomtext) 
    if currentsong.currentbeat >= 1 and currentsong.currentbeat < 4 then
        intraFont.print(240, 90, devstext[1], color_white, funkinfont, 1, 0, false, intraFont.ALIGN_CENTER)
    end
    
    if currentsong.currentbeat >= 3 and currentsong.currentbeat < 4 then
        intraFont.print(240, 138, devstext[2], color_white, funkinfont, 1, 0, false, intraFont.ALIGN_CENTER)
    end

    if currentsong.currentbeat >= 5 and currentsong.currentbeat < 8 then
        intraFont.print(240, 65, newgroundstext[1], color_white, funkinfont, 1, 0, false, intraFont.ALIGN_CENTER)
    end
    
    if currentsong.currentbeat >= 7 and currentsong.currentbeat < 8 then
        intraFont.print(240, 89, newgroundstext[2], color_white, funkinfont, 1, 0, false, intraFont.ALIGN_CENTER)
        Image.draw(ngimage, 240, 195, 128, 128, color_white, 0, 0, 181, 175, 0, 255, Image.Center)
    end

    if randomtext[selectedrandomphrase][3] == "" or randomtext[selectedrandomphrase][3] == nil then
        if currentsong.currentbeat >= 9 and currentsong.currentbeat <= 12 then
            intraFont.print(240, 90, randomtext[selectedrandomphrase][1], color_white, funkinfont, 1, 0, false, intraFont.ALIGN_CENTER)
        end

        if currentsong.currentbeat >= 11 and currentsong.currentbeat <= 12 then
            intraFont.print(240, 114, randomtext[selectedrandomphrase][2], color_white, funkinfont, 1, 0, false, intraFont.ALIGN_CENTER)
        end
    else
        if currentsong.currentbeat >= 9 and currentsong.currentbeat <= 12 then
            intraFont.print(240, 90, randomtext[selectedrandomphrase][1], color_white, funkinfont, 1, 0, false, intraFont.ALIGN_CENTER)
        end

        if currentsong.currentbeat >= 10 and currentsong.currentbeat <= 12 then
            intraFont.print(240, 114, randomtext[selectedrandomphrase][2], color_white, funkinfont, 1, 0, false, intraFont.ALIGN_CENTER)
        end

        if currentsong.currentbeat >= 11 and currentsong.currentbeat <= 12 then
            intraFont.print(240, 138, randomtext[selectedrandomphrase][3], color_white, funkinfont, 1, 0, false, intraFont.ALIGN_CENTER)
        end
    end

    if currentsong.currentbeat >= 13  and currentsong.currentbeat <= 16 then
        intraFont.print(240, 90, "FRIDAY", color_white, funkinfont, 1, 0, false, intraFont.ALIGN_CENTER)
    end

    if currentsong.currentbeat >= 14  and currentsong.currentbeat <= 16 then
        intraFont.print(240, 114, "NIGHT", color_white, funkinfont, 1, 0, false, intraFont.ALIGN_CENTER)
    end

    if currentsong.currentbeat >= 15  and currentsong.currentbeat <= 16 then
        intraFont.print(240, 138, "FUNKIN", color_white, funkinfont, 1, 0, false, intraFont.ALIGN_CENTER)
    end

    if currentsong.currentbeat >= 16 then
        
        return
    end
end

local function pressbuttonscreen()

    local status = ""

    -- Текст "нажмите что-то там"
    if(buttons.pressed(buttons.cross)) or (buttons.pressed(buttons.start)) then
        currentscreenstate = 1
    end

    if currentscreenstate == 0 and ((buttons.pressed(buttons.cross)) or (buttons.pressed(buttons.start))) then
        local buttonpressedonbeat = currentsong.currentbeat
    end

    --#region Рендер изображений и анимаций

    -- Девка под бит
    anim.draw(gfdancinAnim)
    anim.update(gfdancinAnim)

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
    if(currentsong.currentbeat < 16) then
        splashtext({"IN ASSOSIATION WITH","NEWGROUNDS"}, nglogo, {"FUNKIN CREW\n\n\n\nAND ANYPORT TEAM", "PRESENTS"}, randomphrases)
    end

    if currentsong.currentbeat >= 16 then
        pressbuttonscreen()
    end
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
    LUA.print(0, 0, tostring(currentsong.currentbeat))
    LUA.print(0, 15, tostring(timer.time(beattimer)))
    LUA.print(0, 30, tostring(LUA.getRAM() / 1048576))

    if currentscreenstate == 1 then
        local beforesceneswith = timer.create()
        if timer.time(beforesceneswith) >= (60 / currentsong.bpm * 1000) then
            beatsbeforeswith = beatsbeforeswith + 1 -- +1 к биту
            timer.reset(beforesceneswith) -- Сброс таймера до нуля
            timer.start(beforesceneswith) -- Запуск таймера по новой
        end

        if beatsbeforeswith >= 2 then
            loadMenu()
        end
    end

    screen.flip() -- Вывод нового кадра
end

--#endregion

--#region ПРИ ВЫХОДЕ:

--#endregion