$a = $MyInvocation.UnboundArguments
$p = $a[1..($a.length -1)]
$process = Start-Process $a[0] -NoNewWindow -ArgumentList "$p" -PassThru
$waitforcr = Read-Host
Stop-Process $process.Id -Force
exit
