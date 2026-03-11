# trigger-rule-100004.ps1
Write-Host "Triggering Rule 100004: Scheduled Task Persistence (T1053.005)" -ForegroundColor Red

# Bypassing Execution Policy
Write-Host "Bypassing Execution Policy." -ForegroundColor Green
Set-ExecutionPolicy Bypass -Scope Process -Force

Write-Host "Running Atomic Red Team test for T1053.005." -ForegroundColor Yellow
Invoke-AtomicTest T1053.005

Write-Host "Atomic test completed. Check Wazuh for Rule 100004 alert." -ForegroundColor Green
