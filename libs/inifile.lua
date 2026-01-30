local ini = {}

--- Добавление информации в текстовый файл в формате ключ = значение
---@param path string
---@param savedata string
function ini.save(path, savedata) 
    local file = io.open(path, "a")

    if savedata[2] ~= nil then
        for str = 1, #savedata do
            io.write(file, savedata[str])
        end
    end

    io.close(file)
end

--- Проверка на наличие файла 
---@param path any
---@return boolean
function ini.check(path)
    local file = io.open(path, "r")
    if file then
        return true
    else
        return false
    end
end

function ini.load(path, searchkey)
    local file = io.open(path, "r")
    if file then
        for line in file:lines() do
            local key, value = line:match("^(.-)=(.*)$");
            if key == searchkey then
                io.close(file)
                return value 
            end
        end
    end
end

return ini
