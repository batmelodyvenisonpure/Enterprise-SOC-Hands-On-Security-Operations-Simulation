param(
    [string]$CaseID,
    [string]$RuleID,
    [string]$Timestamp
)

$CasePath = "C:\SOC-Forensics\Cases\$CaseID"
New-Item -ItemType Directory -Path $CasePath -Force
New-Item -ItemType Directory -Path "$CasePath\artifacts" -Force
New-Item -ItemType Directory -Path "$CasePath\screenshots" -Force

Write-Host "Starting Forensics Collection for Case: $CaseID" -ForegroundColor Cyan

# Collect Event Logs
Write-Host "Collecting Event Logs..." -ForegroundColor Yellow
wevtutil epl Security "$CasePath\artifacts\Security.evtx"
wevtutil epl System "$CasePath\artifacts\System.evtx"
wevtutil epl "Windows PowerShell" "$CasePath\artifacts\PowerShell.evtx"
wevtutil epl "Microsoft-Windows-Sysmon/Operational" "$CasePath\artifacts\Sysmon.evtx"

# Collect Process Information
Write-Host "Collecting Running Processes..." -ForegroundColor Yellow
Get-Process | Export-Csv "$CasePath\artifacts\running-processes.csv"
Get-WmiObject Win32_Process | Export-Csv "$CasePath\artifacts\all-processes.csv"

# Collect Network Information
Write-Host "Collecting Network Info..." -ForegroundColor Yellow
netstat -an > "$CasePath\artifacts\netstat.txt"
Get-NetTCPConnection | Export-Csv "$CasePath\artifacts\tcp-connections.csv"

# Collect File System Info
Write-Host "Collecting Recent Files..." -ForegroundColor Yellow
Get-ChildItem C:\Users -Recurse -ErrorAction SilentlyContinue | 
    Where-Object {$_.LastWriteTime -gt (Get-Date).AddHours(-24)} | 
    Select-Object FullName, LastWriteTime, Length | 
    Export-Csv "$CasePath\artifacts\recent-files.csv"

# Collect Prefetch
Write-Host "Collecting Prefetch..." -ForegroundColor Yellow
Copy-Item C:\Windows\Prefetch\* "$CasePath\artifacts\prefetch\" -ErrorAction SilentlyContinue

# Forensics Completed
Write-Host "Forensics Collection Complete!" -ForegroundColor Green
Write-Host "Artifacts saved to: $CasePath\artifacts"
