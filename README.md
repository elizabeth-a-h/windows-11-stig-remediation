# Windows 11 STIG Remediation Scripts

## Project Purpose

This project demonstrates automation of Windows security configuration using PowerShell by implementing registry-based controls from the DISA Windows 11 Security Technical Implementation Guide (STIG).  

Each script remediates a single STIG control and verifies system compliance.

The goal of this repository is to demonstrate practical security automation and structured implementation of compliance controls.


PowerShell remediation scripts implementing selected controls from the **DISA Windows 11 Security Technical Implementation Guide (STIG)**.

Each script configures the registry value required for a specific STIG control and verifies whether the system is **COMPLIANT** or **NON-COMPLIANT**.

Scripts follow a standardized template to maintain consistent formatting, remediation logic, and verification output.

---

# Repository Structure

```
windows-11-stig-remediation
│
├─ scripts
│   ├─ WN11-CC-000155.ps1
│   ├─ WN11-CC-000180.ps1
│   ├─ WN11-CC-000185.ps1
│   ├─ WN11-CC-000190.ps1
│   ├─ WN11-CC-000197.ps1
│   ├─ WN11-CC-000295.ps1
│   ├─ WN11-CC-000370.ps1
│   ├─ WN11-CC-000390.ps1
│   ├─ WN11-CC-000391.ps1
│   └─ WN11-AU-000500.ps1
│
└─ templates
   └─ STIG-Remediation-Template.ps1
```

---

# STIG Scripts

| STIG ID | Script | Description |
|-------|-------|-------------|
| WN11-CC-000155 | [WN11-CC-000155.ps1](scripts/WN11-CC-000155.ps1) | Solicited Remote Assistance must not be allowed |
| WN11-CC-000180 | [WN11-CC-000180.ps1](scripts/WN11-CC-000180.ps1) | AutoPlay must be disabled for non-volume devices |
| WN11-CC-000185 | [WN11-CC-000185.ps1](scripts/WN11-CC-000185.ps1) | Default AutoRun behavior must prevent AutoRun commands |
| WN11-CC-000190 | [WN11-CC-000190.ps1](scripts/WN11-CC-000190.ps1) | AutoRun must be disabled for all drive types |
| WN11-CC-000197 | [WN11-CC-000197.ps1](scripts/WN11-CC-000197.ps1) | Microsoft consumer experiences must be turned off |
| WN11-CC-000295 | [WN11-CC-000295.ps1](scripts/WN11-CC-000295.ps1) | RSS feed attachments must not be downloaded |
| WN11-CC-000370 | [WN11-CC-000370.ps1](scripts/WN11-CC-000370.ps1) | Domain PIN logon must be disabled |
| WN11-CC-000390 | [WN11-CC-000390.ps1](scripts/WN11-CC-000390.ps1) | Windows Spotlight third-party suggestions must be disabled |
| WN11-CC-000391 | [WN11-CC-000391.ps1](scripts/WN11-CC-000391.ps1) | Internet Explorer 11 must be disabled as a standalone browser |
| WN11-AU-000500 | [WN11-AU-000500.ps1](scripts/WN11-AU-000500.ps1) | Application event log must be at least 32 MB |

---

# Usage

Run scripts in an **elevated PowerShell session** unless the control applies to `HKCU`.

Example:

```powershell
.\scripts\WN11-CC-000197.ps1 -Verbose
```

Example output:

```
STIG WN11-CC-000197: COMPLIANT
```

---

# Notes

- Some settings may be overridden by **Domain Group Policy or MDM policies**.
- Scripts configure the **local policy equivalent** using registry values.
- Each script includes a `.TESTED ON` section intended for independent validation and testing environments.

---

# Template

A reusable template for creating additional STIG remediation scripts is located in:

```
templates/STIG-Remediation-Template.ps1
```

---

# Author

Elizabeth Harnisch

LinkedIn  
https://www.linkedin.com/in/elizabeth-harnisch/

GitHub  
https://github.com/elizabeth-a-h
