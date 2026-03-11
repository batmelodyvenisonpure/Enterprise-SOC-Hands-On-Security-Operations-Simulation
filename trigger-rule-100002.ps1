# trigger-rule-100002.ps1
Write-Host "Triggering Rule 100002: Mimikatz Credential Dumping (T1003.001)" -ForegroundColor Cyan

# Bypassing Execution Policy
Write-Host "Bypassing Execution Policy." -ForegroundColor Green
Set-ExecutionPolicy Bypass -Scope Process -Force

# Running Atomic Red Team test for T1003.001
Write-Host "Running Atomic Red Team test for T1003.001." -ForegroundColor Yellow
Invoke-AtomicTest T1003.001

Write-Host "Atomic test completed. Check Wazuh for Rule 100002 alert." -ForegroundColor Green
