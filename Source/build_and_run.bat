@ECHO OFF
"..\Lib\7za.exe" a "..\Temp\Love2D\sling-man.love" "..\Game\*" "*.lua"
START "" "%PROGRAMFILES(x86)%\LOVE\love.exe" "..\Temp\Love2D\sling-man.love"