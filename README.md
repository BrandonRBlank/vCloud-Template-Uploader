# vCloud-Template-Uploader
Upload .ovf templates to your vCloud environment

**************************************************
vCloud Template Uploader

Last modified: 24-May-2018
**************************************************

__Required Software__:
- Powershell 5.1
- PowerCLI 6.5.2 Powershell module

__Uses__:
- Uploading folders and sub-folders with VM Templates to single vDC Organiations in vCloud
- (i.e. uploads one category of folders at a time, per run (SC, DE, etc.))

__Setup__:
- Install/Update to WMF 5.1 to get Powershell 5.1
-- "https://www.microsoft.com/en-us/download/details.aspx?id=54616"
-- Check "Win7-KB3191566-x86.zip" and click NEXT
-- Download and Install

- Get VMware PowerCLI module for Powershell
-- "https://www.powershellgallery.com/packages/VMware.PowerCLI/6.5.2.6268016"
-- Save and Install module

__To Run__:
- Have folder of VM Templates (per Organization)
- Open Powershell/PowerCLI window 
- Run script (Including quotes): ".\vCloud Template Uploader.ps1"
