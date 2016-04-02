@echo off
::2016年4月2日 17:39:16 codegay
if "%1"=="" (
	echo 正确用法:
	echo gt 命令工具名
	echo gt xxx
	echo gt curl
	) else (
			bcn gt "%1"
			)