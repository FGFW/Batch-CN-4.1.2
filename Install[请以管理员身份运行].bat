@echo off
title Batch-CN ��װ/ж�س���
echo;>"%SystemRoot%\System32\test.txt"
if not exist "%SystemRoot%\System32\test.txt" (
    echo;���Թ���Ա�������!
    pause
    exit
)
del "%SystemRoot%\System32\test.txt"
setlocal enabledelayedexpansion
set "ProgramPath=%~dp0"
set "ProgramPath=%ProgramPath:~,-1%"
ver|findstr "5\.[1-9]\.[1-9]*"&&set "ProgramPath=%CD%"
echo;��ѡ������:
echo;
echo;I - ��װ     д�����б����ע������뻷������
echo;U - ж��     ɾ��Batch-CN��ע������뻷������
echo;
echo;   ע:Ĭ�ϰ�װ�ڵ�ǰĿ¼^^!
echo;
set /p choice=��ѡ��:
if /i "%choice%"=="I" (
    reg add "HKLM\SOFTWARE\Batch-CN" /v "ProgramPath" /t REG_SZ /d "#%ProgramPath%#" /f
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v "Path" /t REG_EXPAND_SZ /d "%ProgramPath%\Data\Tools;%ProgramPath%\Data;%Path%" /f
    echo;��װ���!(���µ�½����Ч^)
) else if /i "%choice%"=="U" (
    for /f "skip=1 tokens=2 delims=#" %%i in ('reg query HKLM\SOFTWARE\Batch-CN /v ProgramPath') do (
        set "NewPath=!Path:%%i\Data\Tools;=!"
        set "NewPath=!NewPath:%%i\Data;=!"
        reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v "Path" /t REG_EXPAND_SZ /d "%NewPath%" /f
        reg delete HKLM\SOFTWARE\Batch-CN /f
        echo;ж�����!
    )
)
pause