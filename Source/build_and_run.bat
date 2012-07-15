@ECHO OFF
DEL "..\Temp\Love2D\*"
"C:\Program Files (x86)\Python\python.exe" build_debug.py
START "" "C:\Program Files (x86)\LOVE\love" "..\Temp\Love2D\."