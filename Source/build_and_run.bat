@ECHO OFF
DEL "..\Temp\Love2D\*"
COPY "3rdParty\*" "..\Temp\Love2D\"
"C:\Program Files (x86)\Python\python.exe" build_debug.py
START "" "..\Temp\Love2D\love.exe" "..\Temp\Love2D\."