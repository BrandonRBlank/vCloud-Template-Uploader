[boolean]$notValid = $true

# -----------------------------------------------------------------------------------------------------
# INPUT LOGIN CREDENTIALS
# -----------------------------------------------------------------------------------------------------
$IP = Read-Host "Enter vCD server IP"
$Username = Read-Host "Enter vCD username"
$Password = Read-Host "Enter vCD password"


# -----------------------------------------------------------------------------------------------------
# LOGIN TO vCLOUD
# -----------------------------------------------------------------------------------------------------
try {
    Connect-CIServer $IP -User $Username -Password $Password -ErrorAction Stop
} catch {
    throw "Invalid login credentials"
}


# -----------------------------------------------------------------------------------------------------
# FILE PATH TO FOLDER OF vAPP TEMPLATES
# -----------------------------------------------------------------------------------------------------
do {
    $TemplatePATH = Read-Host "Enter path to folder of vApp Templates"
    if ((Test-Path $TemplatePATH) -eq $false) {
        Write-Host -fore Red "File Path not found, try again..."
    } else {
        $notValid = $false
    }
} while($notValid)

$notValid = $true


# -----------------------------------------------------------------------------------------------------
# INPUT vDC ORGANIZATION TO STORE vAPP TEMPLATE
# -----------------------------------------------------------------------------------------------------
$ActiveOrgs = Get-Orgvdc | Select Name
Write-Host -fore Yellow "Current vDC Organizations ---------------"
foreach($_ in $ActiveOrgs) {
    Write-Host -fore Green $_.Name
}
Write-Host -fore Yellow "-----------------------------------------"

do {
    $vDCOrg = Read-Host "Enter the vDC Org you want to import the templates to"
    try {
        $temp = Get-OrgVdc -Name $vDCOrg -ErrorAction Stop
        $notValid = $false
    } catch {
        Write-Host -fore Red "vDC Organization not found, try again..."
    }
} while($notValid)


# -----------------------------------------------------------------------------------------------------
# IMPORT vAPP TEMPLATES TO vCloud
# -----------------------------------------------------------------------------------------------------
Get-ChildItem $TemplatePATH -Recurse -Filter *.ovf | 
    ForEach-Object {
        # Gets path to .ovf
        $VAppTemplate = $_.FullName
        $VAppName = Split-Path (Split-Path $VAppTemplate -Parent) -Leaf
        #$VAppName = $_.Name.Trim(".ovf") //Alt Version

        Start-Transcript -Path "vCD Template upload log.txt" -Append -NoClobber -IncludeInvocationHeader
        Import-CIVAppTemplate -SourcePath $VAppTemplate -OrgVdc $vDCOrg -Name $VAppName
        Stop-Transcript
}
