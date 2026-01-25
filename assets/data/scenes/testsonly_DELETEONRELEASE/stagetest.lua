-- =============================
-- === FUNKIN ENGINE FOR PSP ===
-- ======= by CXPLAY btw =======
-- =============================

--#region МЕТОДЫ

local function debugInfo()
    LUA.print(0, 0, tostring(LUA.getRAM() / 1048576))
end

--#endregion

--#region ОСНОВНОЙ ЦИКЛ

while true do
    screen.clear()
    buttons.read()

    debugInfo()

    screen.flip()
end

--#endregion