local anim = require("libs.animation")

local animations = {}
local images = {}
local sheets = {}

local color_white = Color.new(255,255,255,255)

images.main = Image.load("assets/images/characters/boyfriend/bf_classic/bf_main.png")
images.miss = Image.load("assets/images/characters/boyfriend/bf_classic/bf_miss.png")
images.death_loop = Image.load("assets/images/characters/boyfriend/bf_classic/bf_death_loop.png")
images.death_start = Image.load("assets/images/characters/boyfriend/bf_classic/bf_death_start.png")

sheets.main = require("assets/images/characters/boyfriend/bf_classic/bf_main")
sheets.miss = require("assets/images/characters/boyfriend/bf_classic/bf_miss")
sheets.death_loop = require("assets/images/characters/boyfriend/bf_classic/bf_death_loop")
sheets.death_start = require("assets/images/characters/boyfriend/bf_classic/bf_death_start")

animations.init = function (x, y, size, bpm)
    animations.idle = anim.playfromatlas(
        images.main,
        x, y,
        0, 0, size,
        color_white,
        sheets.idle.frames,
        true,
        47, 60,
        bpm,
        nil,
        60
    )

    animations.left = anim.playfromatlas(
        images.main,
        x, y,
        -5, 0, size,
        color_white,
        sheets.left.frames,
        true,
        32, 36,
        bpm,
        nil,
        nil
    )

    animations.right = anim.playfromatlas(
        images.main,
        x, y,
        5, 0, size,
        color_white,
        sheets.right.frames,
        true,
        37, 41,
        bpm,
        nil,
        nil
    )

    animations.up = anim.playfromatlas(
        images.main,
        x, y,
        0, 5, size,
        color_white,
        sheets.main.frames,
        true,
        42, 46,
        bpm,
        nil,
        nil
    )

    animations.down = anim.playfromatlas(
        images.main,
        x, y,
        0, 0, size,
        color_white,
        sheets.main.frames,
        true,
        27, 31,
        bpm,
        nil,
        nil
    )

    animations.hey = anim.playfromatlas(
        images.main,
        x, y,
        0, 0, size,
        color_white,
        sheets.main.frames,
        false,
        1, 26,
        bpm,
        nil,
        nil
    )

    animations.missdown = anim.playfromatlas(
        images.miss,
        x, y,
        0, 0, size,
        color_white,
        sheets.idle.frames,
        false,
        1, 29,
        bpm,
        nil,
        nil
    )

    animations.missleft = anim.playfromatlas(
        images.main,
        x, y,
        0, 0, size,
        color_white,
        sheets.idle.frames,
        false,
        30, 63,
        bpm,
        nil,
        nil
    )

    animations.missup = anim.playfromatlas(
        images.main,
        x, y,
        0, 0, size,
        color_white,
        sheets.idle.frames,
        false,
        110, 133,
        bpm,
        nil,
        nil
    )

    animations.missright = anim.playfromatlas(
        images.main,
        x, y,
        64, 90, size,
        color_white,
        sheets.idle.frames,
        false,
        64, 90,
        bpm,
        nil,
        nil
    )

    animations.deathstart = anim.playfromatlas(
        images.death_start,
        x, y,
        64, 90, size,
        color_white,
        sheets.idle.frames,
        false,
        1, 58,
        bpm,
        nil,
        nil
    )

    animations.deathloop = anim.playfromatlas(
        images.death_start,
        x, y,
        64, 90, size,
        color_white,
        sheets.idle.frames,
        true,
        1, 58,
        bpm,
        nil,
        nil
    )
end

return animations