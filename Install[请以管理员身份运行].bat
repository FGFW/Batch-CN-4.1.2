@echo off
title Batch-CN 安装/卸载程序
echo;>"%SystemRoot%\System32\test.txt"
if not exist "%SystemRoot%\System32\test.txt" (
    echo;请以管理员身份运行!
    pause
    exit
)
del "%SystemRoot%\System32\test.txt"
setlocal enabledelayedexpansion
set "ProgramPath=%~dp0"
set "ProgramPath=%ProgramPath:~,-1%"
ver|findstr "5\.[1-9]\.[1-9]*"&&set "ProgramPath=%CD%"
echo;请选择任务:
echo;
echo;I - 安装     写入运行必需的注册表项与环境变量
echo;U - 卸载     删除Batch-CN的注册表项与环境变量
echo;
echo;   注:默认安装在当前目录^^!
echo;
set /p choice=请选择:
if /i "%choice%"=="I" (
    reg add "HKLM\SOFTWARE\Batch-CN" /v "ProgramPath" /t REG_SZ /d "#%ProgramPath%#" /f
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v "Path" /t REG_EXPAND_SZ /d "%ProgramPath%\Data\Tools;%ProgramPath%\Data;%Path%" /f
    echo;安装完成!(重新登陆后生效^)
) else if /i "%choice%"=="U" (
    for /f "skip=1 tokens=2 delims=#" %%i in ('reg query HKLM\SOFTWARE\Batch-CN /v ProgramPath') do (
        set "NewPath=!Path:%%i\Data\Tools;=!"
        set "NewPath=!NewPath:%%i\Data;=!"
        reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v "Path" /t REG_EXPAND_SZ /d "%NewPath%" /f
        reg delete HKLM\SOFTWARE\Batch-CN /f
        echo;卸载完成!
    )
)
pause