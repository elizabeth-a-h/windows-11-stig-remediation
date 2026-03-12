<#
.SYNOPSIS
Configures the Windows policy to turn off Microsoft consumer experiences.
WN11-CC-000197 - Microsoft consumer experiences must be turned off.


.DESCRIPTION
Creates the registry path if it does not exist and ensures the specified
registry value is present and configured with the expected data required
for STIG compliance. This remediation implements Windows 11 STIG
WN11-CC-000197 by disabling Microsoft consumer experiences.

.NOTES
Author          : Elizabeth Harnisch
LinkedIn        : https://www.linkedin.com/in/elizabeth-harnisch/
GitHub          : https://github.com/elizabeth-a-h
Date Created    : 2026-03-12
Last Modified   : 2026-03-12
Version         : 1.0

CVEs            : N/A
Plugin IDs      : N/A
STIG-ID         : WN11-CC-000197

Requirements    : Run in an elevated PowerShell session (Administrator)

.TESTED ON
Date(s) Tested  :
Tested By       :
Systems Tested  :
PowerShell Ver. :

.USAGE
Run this script in an elevated PowerShell session to configure the policy
that turns off Microsoft consumer experiences.

Example syntax:
.\WN11-CC-000197.ps1 -Verbose
#>

[CmdletBinding()]
param()

# =========================
# CONFIGURATION
# =========================

$RegistryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent"
$ValueName    = "DisableWindowsConsumerFeatures"
$ValueType    = "DWord"
$ValueData    = 1

# =========================
# ENSURE REGISTRY PATH EXISTS
# =========================

if (-not (Test-Path -Path $RegistryPath)) {
    New-Item -Path $RegistryPath -Force | Out-Null
    Write-Verbose "Created registry path: $RegistryPath"
}

# =========================
# CHECK CURRENT VALUE
# =========================

$ExistingProperty = Get-ItemProperty -Path $RegistryPath -Name $ValueName -ErrorAction SilentlyContinue

if ($null -eq $ExistingProperty) {
    New-ItemProperty `
        -Path $RegistryPath `
        -Name $ValueName `
        -Value $ValueData `
        -PropertyType $ValueType `
        -Force | Out-Null

    Write-Verbose "Created registry value '$ValueName' with data '$ValueData'."
}
else {
    $CurrentValue = $ExistingProperty.$ValueName

    if ($CurrentValue -ne $ValueData) {
        Set-ItemProperty `
            -Path $RegistryPath `
            -Name $ValueName `
            -Value $ValueData

        Write-Verbose "Updated registry value '$ValueName' from '$CurrentValue' to '$ValueData'."
    }
    else {
        Write-Verbose "Registry value '$ValueName' already configured correctly."
    }
}

# =========================
# VERIFICATION
# =========================

$VerifiedValue = (Get-ItemProperty -Path $RegistryPath -Name $ValueName).$ValueName
Write-Output "Verified: $RegistryPath\$ValueName = $VerifiedValue"
