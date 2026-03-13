# =====================================================================
# TEMPLATE FILE – DO NOT EXECUTE DIRECTLY
#
# This file is a reusable template for creating Windows STIG remediation
# scripts. Copy this file and rename it using the STIG ID before use.
#
# REQUIRED CHANGES WHEN CREATING A NEW STIG SCRIPT
#
# 1. Rename the file
#    Example:
#    WN11-CC-000180.ps1
#
# 2. Update the STIG variable
#    Example:
#    $STIG = "WN11-CC-000180"
#
# 3. Update the .SYNOPSIS
#    Use the standard wording:
#    "This PowerShell script configures the system to [setting]
#    in accordance with Windows 11 STIG <STIG-ID>."
#
# 4. Update the .DESCRIPTION
#
# 5. Update registry configuration values
#
#       $RegistryPath
#       $ValueName
#       $ValueData
#
# 6. Adjust Requirements if necessary
#
#       HKLM → Administrator required
#       HKCU → user context required
#
# 7. Verify compliance logic if needed
#
# 8. Update Date fields if desired
#
# 9. Leave Author / LinkedIn / GitHub unchanged
# =====================================================================

<#
.SYNOPSIS
    This PowerShell script configures the system in accordance with Windows STIG ${STIG}.

.DESCRIPTION
    Creates the registry path if it does not exist and ensures the specified
    registry value is present and configured with the expected data required
    for STIG compliance. This remediation implements the policy setting by
    configuring the corresponding registry value.

.NOTES
    Author          : Elizabeth Harnisch
    LinkedIn        : https://www.linkedin.com/in/elizabeth-harnisch/
    GitHub          : https://github.com/elizabeth-a-h
    Date Created    : YYYY-MM-DD
    Last Modified   : YYYY-MM-DD
    Version         : 1.0

    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : ${STIG}

    Requirements    : Run as Administrator (writes to HKLM unless HKCU specified)
    Reboot Required : No (policy refresh may be required in managed environments)
    GPO/MDM Note    : If a Domain GPO or MDM policy manages this setting, it may overwrite local registry changes.

.TESTED ON
    Date(s) Tested  :
    Tested By       :
    Systems Tested  :
    PowerShell Ver. :

.USAGE
    Run the script in an elevated PowerShell session.

    Example syntax:

    .\${STIG}.ps1 -Verbose
#>

[CmdletBinding()]
param()

# =========================
# CONFIGURATION
# =========================

$STIG         = "<STIG-ID>"
$RegistryPath = "<Registry Path>"
$ValueName    = "<Registry Value Name>"
$ValueType    = "DWord"
$ValueData    = <Desired Value>

# =========================
# TEMPLATE SAFETY CHECK
# =========================

if ($STIG -eq "<STIG-ID>") {
    Write-Error "Template value '<STIG-ID>' detected. Update the `$STIG variable before running this script."
    exit 1
}

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

$ExistingProperty = Get-ItemProperty `
    -Path $RegistryPath `
    -Name $ValueName `
    -ErrorAction SilentlyContinue

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

if ($VerifiedValue -eq $ValueData) {

    Write-Output "STIG ${STIG}: COMPLIANT"

}
else {

    Write-Output "STIG ${STIG}: NON-COMPLIANT"

}
