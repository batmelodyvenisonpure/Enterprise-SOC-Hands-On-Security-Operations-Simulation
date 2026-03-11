# trigger-rule-100001.ps1
Write-Host "Triggering Rule 100001: PowerShell Download Detection (T1059.001)" -ForegroundColor Cyan

# Bypassing Execution Policy
Write-Host "Bypassing Execution Policy." -ForegroundColor Green
Set-ExecutionPolicy Bypass -Scope Process -Force

# Running Atomic Red Team test for T1059.001
Write-Host "Running Atomic Red Team test for T1059.001." -ForegroundColor Yellow
Invoke-AtomicTest T1059.001

# Running Atomic Red Team test for T1059.001
Write-Host "Atomic test completed. Check Wazuh for Rule 100001 alert." -ForegroundColor Green
