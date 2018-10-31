$My_Computer = 17
$Shell = new-object -comobject shell.application
$NSComputer = $Shell.Namespace($My_Computer)
$NSComputer.self.name = $env:COMPUTERNAME