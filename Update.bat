@echo off 2>nul 3>&1
setlocal enabledelayedexpansion
::CODE BY bailong360 @bbs.bathome.net
for /f "skip=1 tokens=2 delims=#" %%i in ('reg query HKLM\SOFTWARE\Batch-CN /v ProgramPath') do (
    if not exist "%%i" (
        echo;�Ҳ�����װ·��,�����°�װ
        goto :eof
    ) else (
        set "InstallPath=%%i"
        set "ProgramPath=%%i\Data"
    )
)
rd /s /q "%ProgramPath%\Data"
del "%ProgramPath%\Install[���Թ���Ա�������].bat"
rar x -o+ -y "%ProgramPath%\!Ver:.=-!.rar" "%InstallPath%"
del %0