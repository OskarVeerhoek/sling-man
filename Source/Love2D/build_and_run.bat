@ECHO OFF
"..\..\Lib\7za.exe" a "..\..\Temp\Love2D\sling-man.love" "..\..\Game\*.dds" "*.lua"
if exist "%PROGRAMFILES(X86)%" goto :64bit
goto :32bit
:32bit
START "" "%PROGRAMFILES%\LOVE\love.exe" "..\..\Temp\Love2D\sling-man.love"
goto end
:64bit
START "" "%PROGRAMFILES(x86)%\LOVE\love.exe" "..\..\Temp\Love2D\sling-man.love"
goto end
:end