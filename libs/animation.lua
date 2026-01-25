-- =============================
-- === FUNKIN ENGINE FOR PSP ===
-- ======= by CXPLAY btw =======
-- =============================

local animation = {
    instances = {},
    textureCache = {},
    timerCache = {}
}

local color_white = Color.new(255,255,255)

function animation.playfromatlas(image, x, y, offsetx, offsety, size, color, frames, islooping, firstframeid, lastframeid, bpm, speed, beatframeid)
    -- Безопасная проверка параметров
    if not image then
        print("ERROR: image is nil!")
        return nil
    end
    
    if type(frames) ~= "table" then
        print("ERROR: frames is not a table!")
        return nil
    end
    
    -- Преобразуем параметры в числа
    firstframeid = tonumber(firstframeid) or 1
    lastframeid = tonumber(lastframeid) or #frames
    bpm = tonumber(bpm)
    speed = tonumber(speed)
    beatframeid = tonumber(beatframeid)
    
    -- Проверяем границы
    if firstframeid < 1 then firstframeid = 1 end
    if lastframeid > #frames then lastframeid = #frames end
    if firstframeid > lastframeid then
        -- Меняем местами если first > last
        firstframeid, lastframeid = lastframeid, firstframeid
    end
    
    print(string.format("Animation: frames [%d-%d] from total %d", 
        firstframeid, lastframeid, #frames))
    
    -- Собираем выбранные кадры
    local selectedFrames = {}
    for i = firstframeid, lastframeid do
        local frame = frames[i]
        if frame and type(frame) == "table" and #frame >= 4 then
            table.insert(selectedFrames, {
                x = frame[1] or 0,
                y = frame[2] or 0,
                width = frame[3] or 0,
                height = frame[4] or 0
            })
        else
            print(string.format("WARNING: Frame %d invalid or missing", i))
        end
    end
    
    local frameCount = #selectedFrames
    if frameCount == 0 then
        print("ERROR: No valid frames found!")
        return nil
    end
    
    -- Рассчитываем длительность кадра
    local frameDuration = 100 -- по умолчанию 100ms (10 FPS)
    local isBeatSynced = false
    
    if bpm and bpm > 0 then
        if beatframeid and beatframeid >= firstframeid and beatframeid <= lastframeid then
            -- Режим синхронизации с битом
            frameDuration = (60 / bpm) * 1000 -- полный удар в мс
            isBeatSynced = true
        else
            -- Равномерная анимация под BPM
            frameDuration = (60 / bpm / frameCount) * 1000
        end
    elseif speed and speed > 0 then
        frameDuration = speed * 1000
    end
    
    -- Создаем инстанс анимации
    local instance = {
        image = image,
        frames = selectedFrames,
        currentFrame = 1,
        timer = timer.create(),
        frameDuration = frameDuration,
        isPlaying = true,
        isLooping = (islooping ~= false),
        x = x or 0,
        y = y or 0,
        offsetx = offsetx or 0,
        offsety = offsety or 0,
        size = size or 1,
        color = color or Color.new(255, 255, 255),
        totalFrames = frameCount,
        lastFrameChange = 0,
        
        -- Параметры для синхронизации с битом
        bpm = bpm,
        beatframeid = beatframeid,
        originalFirstFrame = firstframeid,
        originalLastFrame = lastframeid,
        isBeatSynced = isBeatSynced,
        beatTimer = isBeatSynced and timer.create() or nil,
        lastBeatTime = 0,
        currentBeat = 0
    }
    
    -- Запускаем таймеры
    if instance.timer then
        timer.start(instance.timer)
        table.insert(animation.timerCache, instance.timer)
    end
    
    if instance.beatTimer then
        timer.start(instance.beatTimer)
        table.insert(animation.timerCache, instance.beatTimer)
    end
    
    table.insert(animation.instances, instance)
    
    print(string.format("Created: %d frames, %s BPM, BeatSync: %s", 
        frameCount, tostring(bpm), tostring(isBeatSynced)))
    
    return instance
end

-- Обновление анимации с защитой от nil
function animation.update(instance)
    if not instance or not instance.isPlaying or instance.totalFrames == 0 then
        return false
    end
    
    if instance.isBeatSynced and instance.bpm then
        -- Режим синхронизации с битом
        local currentBeatTime = timer.time(instance.beatTimer)
        local beatDuration = (60 / instance.bpm) * 1000
        local timeSinceLastBeat = currentBeatTime - instance.lastBeatTime
        
        if timeSinceLastBeat >= beatDuration then
            instance.currentBeat = instance.currentBeat + 1
            instance.lastBeatTime = currentBeatTime
            
            -- Показываем ключевой кадр на удар
            if instance.beatframeid then
                -- Вычисляем индекс beatframeid в selectedFrames
                local beatFrameIndex = instance.beatframeid - instance.originalFirstFrame + 1
                if beatFrameIndex >= 1 and beatFrameIndex <= instance.totalFrames then
                    instance.currentFrame = beatFrameIndex
                    instance.lastFrameChange = timer.time(instance.timer)
                    return true
                end
            end
        else
            -- Между ударами показываем другие кадры
            local progress = timeSinceLastBeat / beatDuration -- 0..1
            local frameIndex = 1 + math.floor(progress * (instance.totalFrames - 1))
            
            -- Пропускаем beatframeid
            if instance.beatframeid then
                local beatFrameIndex = instance.beatframeid - instance.originalFirstFrame + 1
                if frameIndex >= beatFrameIndex then
                    frameIndex = frameIndex + 1
                end
            end
            
            if frameIndex <= instance.totalFrames and frameIndex ~= instance.currentFrame then
                instance.currentFrame = frameIndex
                return true
            end
        end
        return false
    else
        -- Стандартное обновление
        local currentTime = timer.time(instance.timer)
        local deltaTime = currentTime - instance.lastFrameChange
        
        if deltaTime >= instance.frameDuration then
            instance.currentFrame = instance.currentFrame + 1
            instance.lastFrameChange = currentTime
            
            if instance.currentFrame > instance.totalFrames then
                if instance.isLooping then
                    instance.currentFrame = 1
                else
                    instance.isPlaying = false
                    return false
                end
            end
            
            return true
        end
    end
    
    -- В конце функции добавь проверку:
    if instance.currentFrame == instance.totalFrames and not instance.isLooping then
        instance.isPlaying = false
        return true -- анимация завершилась
    end

    return false
end

-- Отрисовка с защитой от nil
function animation.draw(instance)
    if not instance or not instance.isPlaying or not instance.image then
        return
    end
    
    local frame = instance.frames[instance.currentFrame]
    if not frame then
        return
    end
    
    Image.draw(
        instance.image,
        instance.x,
        instance.y,
        frame.width * instance.size,
        frame.height * instance.size,
        instance.color,
        frame.x + instance.offsetx,
        frame.y + instance.offsety,
        frame.width,
        frame.height,
        0, 255, Image.Center
    )
end

-- Очистка с защитой
function animation.clearAll()
    for i = 1, #animation.timerCache do
        local t = animation.timerCache[i]
        if t then
            timer.stop(t)
            timer.remove(t)
        end
    end
    
    animation.instances = {}
    animation.timerCache = {}
end

-- Загрузка изображения с кэшированием
function animation.loadImage(path)
    if animation.textureCache[path] then
        return animation.textureCache[path]
    end
    
    local img = Image.load(path)
    if img then
        animation.textureCache[path] = img
    else
        print("ERROR: Failed to load image: " .. path)
    end
    
    return img
end

-- Очистка кэша изображений
function animation.clearImageCache()
    for path, img in pairs(animation.textureCache) do
        if img then
            Image.unload(img)
        end
    end
    animation.textureCache = {}
end

return animation