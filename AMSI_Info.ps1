# AMSI Information Script
# Simple information gathering about AMSI status
# For educational purposes only

Write-Host "=== AMSI Information Script ===" -ForegroundColor Blue
Write-Host "This script provides basic information about AMSI on your system" -ForegroundColor White
Write-Host ""

# Check PowerShell version
Write-Host "PowerShell Version: $($PSVersionTable.PSVersion)" -ForegroundColor Yellow
Write-Host "PowerShell Edition: $($PSVersionTable.PSEdition)" -ForegroundColor Yellow
Write-Host ""

# Check execution policy
Write-Host "Execution Policy: $(Get-ExecutionPolicy)" -ForegroundColor Yellow
Write-Host ""

# Check if AMSI assembly is available
Write-Host "Checking AMSI availability..." -ForegroundColor Blue
try {
    $amsi = [System.Reflection.Assembly]::LoadWithPartialName("System.Management.Automation.AntimalwareScanInterface")
    if ($amsi) {
        Write-Host "AMSI is available on this system" -ForegroundColor Red
    } else {
        Write-Host "AMSI is not available on this system" -ForegroundColor Green
    }
} catch {
    Write-Host "AMSI check failed: $($_.Exception.Message)" -ForegroundColor Yellow
}
Write-Host ""

# Check Windows version
Write-Host "Windows Version Information:" -ForegroundColor Blue
$os = Get-WmiObject -Class Win32_OperatingSystem
Write-Host "OS Name: $($os.Caption)" -ForegroundColor Yellow
Write-Host "OS Version: $($os.Version)" -ForegroundColor Yellow
Write-Host "OS Build: $($os.BuildNumber)" -ForegroundColor Yellow
Write-Host ""

# Check for AMSI registry key
Write-Host "Checking AMSI Registry..." -ForegroundColor Blue
$regPath = "HKLM:\SOFTWARE\Microsoft\AMSI"
if (Test-Path $regPath) {
    Write-Host "AMSI registry key found at: $regPath" -ForegroundColor Yellow
    try {
        $regValues = Get-ItemProperty -Path $regPath -ErrorAction SilentlyContinue
        if ($regValues) {
            $regValues.PSObject.Properties | Where-Object { $_.Name -notin @("PSPath", "PSParentPath", "PSChildName", "PSDrive", "PSProvider") } | ForEach-Object {
                Write-Host "  $($_.Name): $($_.Value)" -ForegroundColor Yellow
            }
        }
    } catch {
        Write-Host "  Could not read registry values" -ForegroundColor Red
    }
} else {
    Write-Host "AMSI registry key not found" -ForegroundColor Yellow
}
Write-Host ""

# Check for AMSI DLL files
Write-Host "Checking AMSI DLL files..." -ForegroundColor Blue
$system32Path = "$env:SystemRoot\System32"
$amsiDlls = @("amsi.dll", "amsiutils.dll")

foreach ($dll in $amsiDlls) {
    $dllPath = Join-Path $system32Path $dll
    if (Test-Path $dllPath) {
        $fileInfo = Get-Item $dllPath
        Write-Host "Found: $dll" -ForegroundColor Yellow
        Write-Host "  Size: $($fileInfo.Length) bytes" -ForegroundColor Yellow
        Write-Host "  Modified: $($fileInfo.LastWriteTime)" -ForegroundColor Yellow
    } else {
        Write-Host "Not found: $dll" -ForegroundColor Red
    }
}
Write-Host ""

# Check for security services
Write-Host "Checking Security Services..." -ForegroundColor Blue
$securityServices = @("WinDefend", "SecurityHealthService", "Sense")
foreach ($service in $securityServices) {
    try {
        $svc = Get-Service -Name $service -ErrorAction SilentlyContinue
        if ($svc) {
            Write-Host "$($service): $($svc.Status) (StartType: $($svc.StartType))" -ForegroundColor Yellow
        } else {
            Write-Host "$($service): Not found" -ForegroundColor Red
        }
    } catch {
        Write-Host "$($service): Error checking service" -ForegroundColor Red
    }
}
Write-Host ""

Write-Host "=== Analysis Complete ===" -ForegroundColor Blue
Write-Host "This information shows the current state of AMSI on your system" -ForegroundColor White
Write-Host "Use this information to understand your security posture" -ForegroundColor White
