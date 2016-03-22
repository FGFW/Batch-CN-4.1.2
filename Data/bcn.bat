@echo off
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
if "%~1"=="/?" (
    more "%ProgramPath%\readme.txt"
    goto :eof
)
for /f "useback tokens=1*" %%i in ("%ProgramPath%\COMMAND.txt") do (
    for %%k in (%%j) do if /i "%~1"=="%%k" set "Task=%%i"
)
if "%Task:~-1%"=="1" set "LIST=tool"
if "%Task:~-1%"=="2" set "LIST=example"

if "%Task%"=="00" (
    wget -O "%ProgramPath%\Lists\Ver.txt" -q "http://batch-cn.qiniudn.com/update/ver.txt"
    set /p ver=<"%ProgramPath%\Lists\Ver.txt"
    set /p n_ver=<"%ProgramPath%\readme.txt"
    if "!ver!" gtr "!n_ver!" (
        echo;升级中...
        wget -O "%ProgramPath%\!Ver:.=-!.rar" -q "http://batch-cn.qiniudn.com/update/!Ver:.=-!.rar"
        rar x -o+ -y "%ProgramPath%\!Ver:.=-!.rar" "%InstallPath%"
        if exist "%ProgramPath%\Update.bat" call "%ProgramPath%\Update.bat"
        echo;完成
    ) else echo;已是最新版本
) else if "%Task:~,1%"=="1" (
    if /i "%~2"=="" (
        wget -O "%ProgramPath%\Lists\!LIST!.txt" -q "http://batch-cn.qiniudn.com/list/!LIST:tool=tool.@version!.txt"
        echo;>"%ProgramPath%\Lists\TIME"
        call :show !LIST!.txt
        goto :eof
    ) else (
        for %%i in ("%ProgramPath%\Lists\TIME") do (
            for %%j in ("%ProgramPath%\Lists\!LIST!.txt") do (
                if not "%%~ti"=="%%~tj" (
                    wget -O "%ProgramPath%\Lists\!LIST!.txt" -q "http://batch-cn.qiniudn.com/list/!LIST:tool=tool.@version!.txt"
                    echo;>"%ProgramPath%\Lists\TIME"
                )
            )
        )
        set "Arg=%~2"
        set "Arg=!Arg:\=/!"
        if "!Arg:/=!"=="!Arg!" (
            >"%ProgramPath%\Lists\$tmp" grep -ioP "^^%~2( |\.).*" "%ProgramPath%\Lists\!LIST!.txt"
            >"%ProgramPath%\Lists\$upp" grep "@" "%ProgramPath%\Lists\$tmp"
            for /f "useback tokens=1,2" %%i in ("%ProgramPath%\Lists\$tmp") do (
                set "ToolName=%%i"
                set /a n+=1
            )
            if not "!n!"=="1" (
                for /f "useback tokens=1,2 delims=@ " %%i in ("%ProgramPath%\Lists\$upp") do set "ToolName=%%j/%%i"
            )
        ) else (
            for /f "tokens=1,2 delims=/" %%i in ("%~2") do (
                >"%ProgramPath%\Lists\$tmp" grep -ioP "^%%j( |\.).*%%i" "%ProgramPath%\Lists\!LIST!.txt"
                for /f "useback" %%k in ("%ProgramPath%\Lists\$tmp") do set "ToolName=%%i/%%k"
            )
        )
        if "!ToolName!"=="" (
            echo;未找到"%~2",请确认拼写是否正确
            goto :eof
        )
        if "%Task%"=="12" (
            wget -O "%ProgramPath%\Examples\!ToolName!.rar" -q "http://batch-cn.qiniudn.com/!LIST!/!ToolName!.rar"
            rar x -o+ -y "%ProgramPath%\Examples\!ToolName!.rar" "%ProgramPath%\Examples\" >nul
            echo;!ToolName!下载完毕,位于%ProgramPath%\Examples\!ToolName!
        ) else (
            for %%i in ("!ToolName!") do (
                if "%%~xi"=="" (
                    wget -O "%ProgramPath%\Tools\%%~ni.exe" -q "http://batch-cn.qiniudn.com/!LIST:.@version=!/!ToolName!.exe"
                ) else wget -O "%ProgramPath%\Tools\%%~nxi" -q "http://batch-cn.qiniudn.com/!LIST:.@version=!/!ToolName!"
                echo;%%~ni下载完毕
                if "%%~xi"==".rar" rar x -y "%ProgramPath%\Tools\%%~nxi" "%ProgramPath%\Tools\" >nul 2>nul
            )
        )
    )
) else if "%Task:~,1%"=="2" (
    if "%~2"=="" (
        (for %%i in ("%ProgramPath%\!LIST!s\*.*") do echo;^^%%~ni)>"%ProgramPath%\Lists\$tmp"
        >"%ProgramPath%\Lists\find.txt" grep -if "%ProgramPath%\Lists\$tmp" "%ProgramPath%\Lists\!LIST!.txt"
        call :show find.txt
    ) else (
        2>nul (del "%ProgramPath%\!LIST!s\%~2.exe"
        del "%ProgramPath%\!LIST!s\%~2.cmd"
        del "%ProgramPath%\!LIST!s\%~2.rar"
        rd /s /q "%ProgramPath%\!LIST!s\%~2")
    )
) else if "%Task:~,1%"=="3" (
    >"%ProgramPath%\Lists\find.txt" grep -P "%~2" "%ProgramPath%\Lists\!LIST!.txt"
    call :show find.txt
) else if "%Task%"=="4" (
    set /p Version=<"%ProgramPath%\readme.txt"
    echo;Batch-CN !Version!
)
goto :eof
:show
echo;名称          版本        大小    简介
for /f "useback tokens=1-4" %%i in ("%ProgramPath%\Lists\%~1") do (
    set "ToolName=%%i                              "
    set "ToolVer=%%j                              "
    set "ToolVer=!ToolVer:@=!"
    set "ToolSize=%%l"
    2>nul set /a ToolSize=!ToolSize:~,-5!/1024,lines+=1
    set "ToolSize=!ToolSize!KB                              "
    if /i not "%%i"=="Rem" (
        echo;!ToolName:~,14!!ToolVer:~,11! !ToolSize:~,8!%%k
    ) else echo;%%j%%k
    if "!lines!"=="23" (
        >nul pause
        set "lines="
    )
)
goto :eof
