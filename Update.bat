@echo off 2>nul 3>&1
setlocal enabledelayedexpansion
::CODE BY bailong360 @bbs.bathome.net
for /f "skip=1 tokens=2 delims=#" %%i in ('reg query HKLM\SOFTWARE\Batch-CN /v ProgramPath') do (
    if not exist "%%i" (
        echo;找不到安装路径,请重新安装
        goto :eof
    ) else (
        set "InstallPath=%%i"
        set "ProgramPath=%%i\Data"
    )
)
rd /s /q "%ProgramPath%\Data"
del "%ProgramPath%\Install[请以管理员身份运行].bat"
rar x -o+ -y "%ProgramPath%\!Ver:.=-!.rar" "%InstallPath%"
del %0