这里的版本比官方的版本修改一些小问题,每次使用bcn gt xx下载都同步list.txt.

4.1.2
首发地址:http://www.bathome.net/thread-32322-1-1.html

帮助:

bcn Get-Update
描述:该命令检查更新
别名:GU
示例:bcn Get-Update

bcn Get-Tool [ToolName]
描述:该命令从互联网上获取相应第三方,单独键入该命令获得在线第三方列表
别名:GT Get
示例:bcn Get-Tool sed

bcn Get-Example [ToolName]
描述:该命令从互联网上获取相应第三方教程,单独键入该命令获得在线教程列表
别名:GE
示例:bcn GE amos

bcn Del-Tool [TooName]
描述:该命令将一个第三方从本地删除,单独键入该命令获得本地第三方列表
别名:DT Del
示例:bcn Del sed

bcn Del-Example [ToolName]
描述:该命令将一个第三方教程从本地删除,单独键入该命令获得本地教程列表
别名:DE
示例:bcn DE amos

bcn Find-Tool [Keyword]
描述:该命令在第三方列表中寻找包含关键词的行并打印
别名:FT Find
示例:bcn FT "注册表"

bcn Find-Example [Keyword]
描述:该命令在教程中寻找包含关键词的行并打印
别名:FE
示例:bcn FE "amos"

bcn Version
描述:查看当前版本
别名:Ver
示例:bcn Ver

注:一部分第三方的帮助需要使用 --help -help --h -h,或键入不带参数的命令来查询

BUG报告:bailong360@126.com

4.1.2
 修复了Get-Tool读取不到最新list的问题
 修复了Get-Update解压时目录不对的问题

4.1.1
 修复了部分bug
 修改了第三方列表的获取源