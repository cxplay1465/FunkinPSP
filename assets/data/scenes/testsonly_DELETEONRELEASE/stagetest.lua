-- =============================
-- === FUNKIN ENGINE FOR PSP ===
-- ======= by CXPLAY btw =======
-- =============================

-- #region ПЕРЕМЕННЫЕ И БИБЛИОТЕКИ

debug = require("libs.debug")

--#endregion

--#region МЕТОДЫ

--#endregion

--#region ОСНОВНОЙ ЦИКЛ

while true do
    screen.clear()
    buttons.read()
    debug.update()

    debug.drawinfo("DEBUG: ")
    debug.drawinfo("RAM: " .. tostring(debug.RAM()))


    screen.flip()
end

--#endregion