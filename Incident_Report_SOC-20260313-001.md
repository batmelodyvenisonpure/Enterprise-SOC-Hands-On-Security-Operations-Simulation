# Incident Report: [INCIDENT TITLE]
**Case ID:** SOC-20260313-001
**Date:** 13.03.2026
**Status:** Closed
**Classification:** Internal

---

## 1. Executive Summary

On **March 13, 2026 at 21:01 UTC (23:01 local time)**, a security incident was detected on host `VULN-WIN` (192.168.0.175). The attack involved **credential dumping, Active Directory enumeration, privilege escalation, and attempted defense evasion**. The investigation confirmed a **successful compromise** of the host with the attacker achieving **SYSTEM-level privileges**.

---

## 2. Incident Timeline

| Timestamp (UTC) | Event | Details |
|-----------------|-------|---------|
| 21:01:59 | Initial Access | Trigger script executed from Downloads |
| 21:01:59 | Credential Dumping | Mimikatz executed |
| 21:02:05 | AD Enumeration | SharpHound #1 |
| 21:02:06 | AD Enumeration | SharpHound #2 |
| 21:02:09 | Privilege Escalation | SYSTEM access achieved |
| 21:02:11 | Data Collection | Security policy exported |
| 21:02:12 | Defense Evasion | Audit policy checked |
| 21:02:18 | Persistence Attempt | UAC bypass attempted |

---

## 3. Technical Findings

### 3.1 Initial Access Vector
- **File:** `C:\Users\MOTH\Downloads\trigger-rule-100001.ps1`
- **Method:** PowerShell execution policy bypass
- **User:** VULN-WIN\MOTH

### 3.2 Tools Used
| Tool | Purpose | MITRE ID | Evidence |
|------|---------|----------|----------|
| Mimikatz | Credential dumping | T1003.001 | Sysmon Event 1 |
| SharpHound | AD enumeration | T1482 | Sysmon Event 1 |
| Netcat | Remote access | T1095 | Prefetch |
| SecEdit | Policy export | T1005 | Sysmon Event 1 |
| AuditPol | Defense evasion | T1562.001 | Sysmon Event 1 |

### 3.3 Indicators of Compromise (IOCs)

**File Hashes:**

```
9785001B0DCF755EDDB8AF294A373C0B87B2498660F724E76C4D53F9C217C7A3
```

**Process IOCs:**

```
powershell.exe with DownloadString/IEX
cmd.exe
net.exe, net1.exe
secedit.exe with /export
netstat.exe
```

---

## 4. Impact Assessment

| Asset | Impact | Details |
|-------|--------|---------|
| VULN-WIN | High | SYSTEM access achieved |
| Domain Credentials | High | SharpHound enumeration |
| Security Policy | High | Complete policy saved to disk |
| Other Hosts | No impact | No lateral movement detected |

---

## 5. Remediation Actions

| Action | Status | Owner |
|--------|--------|-------|
| Isolate affected host | Complete | SOC |
| Reset user credentials | Complete | IT |
| Preserve forensic artifacts | Complete | SOC |
| Rebuild host from image | Complete | IT |
| Update detection rules | Complete | Detection Engineering |

---

## 6. Lessons learned

### What Went Well 
- Alert triggered immediately (Rule 100001)
- Host isolated within 8 minutes
- Full forensic evidence preserved

### What Needs Improvement
- PowerShell logging not enabled
- Users can execute scripts from Downloads
- No LSASS protection
- AppLocker not deployed

---

## 7. Recommendations

| Priority | Recommendation | Owner |
|----------|----------------|-------|
| P0 | Enable PowerShell Script Block Logging | IT |
| P0 | Deploy Sysmon with SwiftOnSecurity config | Security |
| P1 | Implement AppLocker | IT |
| P1 | Enable Credential Guard | Security |
| P2 | Deploy UAC hardening | IT |

---

**Report Prepared By:** Cristian
**Date:** 14.03.2026 
**Approved By:** [Manager]

