import shutil;
import os

for file in os.listdir("."):
    extension = os.path.splitext(file)[1];    
    if extension == ".lua":
        fullsourcefilepath = os.getcwd() + "\\" + file
        fullcopyfilepath = os.getcwd() + "\\..\\Temp\\Love2D\\" + file
        print("Copying /Source/" + file + " to " + "/Temp/Love2D/" + file)
        shutil.copyfile(fullsourcefilepath, fullcopyfilepath)
for file in os.listdir("..\\Assets"):
    fullsourcefilepath = os.getcwd() + "\\..\\Assets\\" + file
    fullcopyfilepath = os.getcwd() + "\\..\\Temp\\Love2D\\" + file
    print("Copying /Assets/" + file + " to " + "/Temp/Love2D/" + file)
    shutil.copyfile(fullsourcefilepath, fullcopyfilepath)
fo = open(os.getcwd() + "\\..\\Temp\\Love2D\\run.bat", 'w+')
print("Generating /Temp/Love2D/run.bat")
fo.write("@ECHO OFF\nSTART \"\" \"C:\Program Files (x86)\LOVE\love\" \".\"\nPAUSE")
fo.close()
    
