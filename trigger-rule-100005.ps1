# trigger-rule-100005.ps1
Write-Host "Triggering Rule 100005: Netcat C2 Connection (T1095)" -ForegroundColor Red

# Bypassing Execution Policy
Write-Host "Bypassing Execution Policy." -ForegroundColor Green
Set-ExecutionPolicy Bypass -Scope Process -Force

# Go to netcat directory and run the command
Write-Host "Go to Netcat Directory" -ForegroundColor Yellow
cd C:\tools\netcat

Write-Host "Running netcat connection to 127.0.0.1:4444..." -ForegroundColor Yellow
Write-Host "This will try to connect. It will hang - press Ctrl+C to stop." -ForegroundColor Magenta

# Execute netcat
.\nc.exe 127.0.0.1 4444

Write-Host "Test completed. Check Wazuh for Rule 100005 alert." -ForegroundColor Green
