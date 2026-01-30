-- =============================n-- === FUNKIN ENGINE FOR PSP ===
-- ======= by CXPLAY btw =======

-- =============================

-- Масштаб спрайтов: 1.0000
-- Масштаб изображения: 0.2500
-- Всего спрайтов в XML: 87
-- Уникальных спрайтов: 36
-- Экспортировано спрайтов: 87

local frames = {
    -- ARROW STATIC INSTANCE 1
    {488, 238, 155, 158}, -- id: 1

    -- ARROW STATIC INSTANCE 2
    {647, 238, 157, 155}, -- id: 2

    -- ARROW STATIC INSTANCE 3
    {808, 238, 155, 157}, -- id: 3

    -- ARROW STATIC INSTANCE 4
    {323, 240, 157, 154}, -- id: 4

    -- BLUE HOLD END INSTANCE 1
    {1062, 452, 51, 64}, -- id: 5

    -- BLUE HOLD PIECE INSTANCE 1
    {1282, 457, 51, 44}, -- id: 6

    -- BLUE INSTANCE 1
    {0, 240, 158, 154}, -- id: 7

    -- DOWN CONFIRM INSTANCE 1
    {0, 0, 240, 236}, -- id: 8
    {244, 0, 240, 236}, -- id: 9
    {1206, 235, 221, 218, frameX=-6, frameY=-12, frameWidth=240, frameHeight=236}, -- id: 10
    {1206, 235, 221, 218, frameX=-6, frameY=-12, frameWidth=240, frameHeight=236}, -- id: 11

    -- DOWN PRESS INSTANCE 1
    {805, 399, 143, 139, frameX=-4, frameY=-3, frameWidth=150, frameHeight=146}, -- id: 12
    {805, 399, 143, 139, frameX=-4, frameY=-3, frameWidth=150, frameHeight=146}, -- id: 13
    {1898, 0, 150, 146}, -- id: 14
    {1898, 0, 150, 146}, -- id: 15

    -- GREEN HOLD END INSTANCE 1
    {1007, 452, 51, 64}, -- id: 16

    -- GREEN HOLD PIECE INSTANCE 1
    {1227, 457, 51, 44}, -- id: 17

    -- GREEN INSTANCE 1
    {162, 240, 157, 154}, -- id: 18

    -- LEFT CONFIRM INSTANCE 1
    {972, 0, 230, 232}, -- id: 19
    {1438, 233, 220, 222, frameX=-5, frameY=-5, frameWidth=230, frameHeight=232}, -- id: 20
    {1438, 0, 227, 229, frameX=-2, frameY=-1, frameWidth=230, frameHeight=232}, -- id: 21
    {1438, 0, 227, 229, frameX=-2, frameY=-1, frameWidth=230, frameHeight=232}, -- id: 22

    -- LEFT PRESS INSTANCE 1
    {1898, 449, 139, 142, frameX=-4, frameY=-3, frameWidth=146, frameHeight=149}, -- id: 23
    {1898, 449, 139, 142, frameX=-4, frameY=-3, frameWidth=146, frameHeight=149}, -- id: 24
    {1898, 150, 146, 149}, -- id: 25
    {1898, 150, 146, 149}, -- id: 26
    {1898, 150, 146, 149}, -- id: 27
    {1898, 150, 146, 149}, -- id: 28
    {1898, 150, 146, 149}, -- id: 29
    {1898, 150, 146, 149}, -- id: 30
    {1898, 150, 146, 149}, -- id: 31
    {1898, 150, 146, 149}, -- id: 32
    {1898, 150, 146, 149}, -- id: 33
    {1898, 150, 146, 149}, -- id: 34
    {1898, 150, 146, 149}, -- id: 35
    {1898, 150, 146, 149}, -- id: 36
    {1898, 150, 146, 149}, -- id: 37
    {1898, 150, 146, 149}, -- id: 38
    {1898, 150, 146, 149}, -- id: 39
    {1898, 150, 146, 149}, -- id: 40
    {1898, 150, 146, 149}, -- id: 41
    {1898, 150, 146, 149}, -- id: 42

    -- PRUPLE END HOLD INSTANCE 1
    {1117, 452, 51, 64}, -- id: 43

    -- PURPLE HOLD PIECE INSTANCE 1
    {1337, 457, 51, 44}, -- id: 44

    -- PURPLE INSTANCE 1
    {0, 398, 154, 157}, -- id: 45

    -- RED HOLD END INSTANCE 1
    {952, 452, 51, 64}, -- id: 46

    -- RED HOLD PIECE INSTANCE 1
    {1172, 457, 51, 44}, -- id: 47

    -- RED INSTANCE 1
    {647, 397, 154, 157}, -- id: 48

    -- RIGHT CONFIRM INSTANCE 1
    {1669, 0, 225, 228, frameX=-1, frameY=-2, frameWidth=228, frameHeight=231}, -- id: 49
    {1669, 232, 225, 228, frameX=-1, frameY=-2, frameWidth=228, frameHeight=231}, -- id: 50
    {1206, 0, 228, 231}, -- id: 51
    {1206, 0, 228, 231}, -- id: 52

    -- RIGHT PRESS INSTANCE 1
    {469, 400, 139, 142, frameX=-3, frameY=-7, frameWidth=149, frameHeight=152}, -- id: 53
    {469, 400, 139, 142, frameX=-3, frameY=-7, frameWidth=149, frameHeight=152}, -- id: 54
    {316, 398, 149, 152}, -- id: 55
    {316, 398, 149, 152}, -- id: 56
    {316, 398, 149, 152}, -- id: 57
    {316, 398, 149, 152}, -- id: 58
    {316, 398, 149, 152}, -- id: 59
    {316, 398, 149, 152}, -- id: 60
    {316, 398, 149, 152}, -- id: 61
    {316, 398, 149, 152}, -- id: 62
    {316, 398, 149, 152}, -- id: 63
    {316, 398, 149, 152}, -- id: 64
    {316, 398, 149, 152}, -- id: 65
    {316, 398, 149, 152}, -- id: 66
    {316, 398, 149, 152}, -- id: 67
    {316, 398, 149, 152}, -- id: 68
    {316, 398, 149, 152}, -- id: 69
    {316, 398, 149, 152}, -- id: 70
    {316, 398, 149, 152}, -- id: 71
    {316, 398, 149, 152}, -- id: 72
    {316, 398, 149, 152}, -- id: 73
    {316, 398, 149, 152}, -- id: 74
    {316, 398, 149, 152}, -- id: 75
    {316, 398, 149, 152}, -- id: 76
    {316, 398, 149, 152}, -- id: 77
    {316, 398, 149, 152}, -- id: 78
    {316, 398, 149, 152}, -- id: 79

    -- UP CONFIRM INSTANCE 1
    {488, 0, 238, 234}, -- id: 80
    {730, 0, 238, 234}, -- id: 81
    {972, 236, 216, 212, frameX=-11, frameY=-11, frameWidth=238, frameHeight=234}, -- id: 82
    {972, 236, 216, 212, frameX=-11, frameY=-11, frameWidth=238, frameHeight=234}, -- id: 83

    -- UP PRESS INSTANCE 1
    {1898, 303, 144, 142, frameX=-6, frameY=-4, frameWidth=154, frameHeight=151}, -- id: 84
    {1898, 303, 144, 142, frameX=-6, frameY=-4, frameWidth=154, frameHeight=151}, -- id: 85
    {158, 398, 154, 151}, -- id: 86
    {158, 398, 154, 151}, -- id: 87
}

return {frames = frames}
