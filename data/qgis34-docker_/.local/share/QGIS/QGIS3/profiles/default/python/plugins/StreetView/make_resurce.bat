set OSGEO4W_ROOT=C:\OSGeo4W64
echo on
set PATH=%OSGEO4W_ROOT%\bin;%PATH%
set PATH=%PATH%;%OSGEO4W_ROOT%\apps\qgis\bin

call "%OSGEO4W_ROOT%\bin\o4w_env.bat"
call "%OSGEO4W_ROOT%\bin\qt5_env.bat"
call "%OSGEO4W_ROOT%\bin\py3_env.bat"
path %OSGEO4W_ROOT%\apps\qgis-dev\bin;%OSGEO4W_ROOT%\apps\grass\grass-7.2.2\lib;%OSGEO4W_ROOT%\apps\grass\grass-7.2.2\bin;%PATH%

cd C:\Users\Gisplan Paolo\AppData\Roaming\QGIS\QGIS3\profiles\default\python\plugins\streetview
@C:\\OSGeo4W64\apps\Python36\python.exe -m PyQt5.pyrcc_main -o resources_rc.py  resources.qrc