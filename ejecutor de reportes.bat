@echo off
echo Ejecutando reporte de ventas con Git Bash...

REM Agregar encabezado con fecha al log
echo. >> "%~dp0reporte_log.txt"
echo ============================== >> "%~dp0reporte_log.txt"
    echo Fecha de ejecución: %date% %time% >> "%~dp0reporte_log.txt"
    echo ============================== >> "%~dp0reporte_log.txt"

    REM Ejecutar el script usando ruta válida sin comillas curvas
    "C:\Program Files\Git\bin\bash.exe" -c "bash '/d/UGB/ProgramacionScriptParaQue_Bloque333/ProgramacionScriptParaQue_Bloque3/Reporte_de_ventas.sh'" >> "%~dp0reporte_log.txt" 2>&1

    echo.
    echo El script finalizo. Salida guardada en: %~dp0reporte_log.txt
    pause
