# AMSI Test Program - Simple Version
# Based on AMSI.NotFail project concepts
# For educational and testing purposes only

param(
    [switch]$Verbose,
    [switch]$TestAll,
    [string]$Method = "all"
)

# Colors for output
$Red = "Red"
$Green = "Green"
$Yellow = "Yellow"
$Blue = "Blue"
$White = "White"

function Write-ColorOutput {
    param(
        [string]$Message,
        [string]$Color = $White
    )
    Write-Host $Message -ForegroundColor $Color
}

function Test-AMSIStatus {
    Write-ColorOutput "=== AMSI Status Check ===" $Blue
    
    try {
        # Check if AMSI is available
        $amsi = [System.Reflection.Assembly]::LoadWithPartialName("System.Management.Automation.AntimalwareScanInterface")
        if ($amsi) {
            Write-ColorOutput "AMSI is loaded and available" $Red
            return $true
        }
    }
    catch {
        Write-ColorOutput "AMSI is not available" $Green
        return $false
    }
}

function Test-BasicAMSI {
    Write-ColorOutput "=== Testing Basic AMSI Detection ===" $Blue
    
    $testString = "Invoke-Mimikatz"
    Write-ColorOutput "Testing string: $testString" $Yellow
    
    try {
        $result = [System.Management.Automation.AntimalwareScanInterface]::ScanString($testString)
        Write-ColorOutput "AMSI Scan Result: $result" $Red
        if ($result -eq 0) {
            Write-ColorOutput "String blocked by AMSI" $Red
        } else {
            Write-ColorOutput "String allowed by AMSI" $Green
        }
    }
    catch {
        Write-ColorOutput "AMSI scan failed: $($_.Exception.Message)" $Yellow
    }
}

function Test-AMSIAnalysis1 {
    Write-ColorOutput "=== AMSI Analysis Method 1: Assembly Check ===" $Blue
    
    try {
        # Check what assemblies are loaded
        $assemblies = [System.AppDomain]::CurrentDomain.GetAssemblies()
        $amsiAssemblies = $assemblies | Where-Object { $_.FullName -like "*AMSI*" -or $_.FullName -like "*Antimalware*" }
        
        if ($amsiAssemblies) {
            Write-ColorOutput "AMSI-related assemblies found:" $Yellow
            foreach ($assembly in $amsiAssemblies) {
                Write-ColorOutput "  - $($assembly.FullName)" $Yellow
            }
        } else {
            Write-ColorOutput "No AMSI-related assemblies found" $Green
        }
        
        return $true
    }
    catch {
        Write-ColorOutput "AMSI analysis method 1 failed: $($_.Exception.Message)" $Red
        return $false
    }
}

function Test-AMSIAnalysis2 {
    Write-ColorOutput "=== AMSI Analysis Method 2: Registry Check ===" $Blue
    
    try {
        # Check AMSI registry settings
        $regPath = "HKLM:\SOFTWARE\Microsoft\AMSI"
        
        if (Test-Path $regPath) {
            Write-ColorOutput "AMSI registry key found at: $regPath" $Yellow
            $regValues = Get-ItemProperty -Path $regPath -ErrorAction SilentlyContinue
            if ($regValues) {
                $regValues.PSObject.Properties | Where-Object { $_.Name -ne "PSPath" -and $_.Name -ne "PSParentPath" -and $_.Name -ne "PSChildName" -and $_.Name -ne "PSDrive" -and $_.Name -ne "PSProvider" } | ForEach-Object {
                    Write-ColorOutput "  - $($_.Name): $($_.Value)" $Yellow
                }
            }
        } else {
            Write-ColorOutput "AMSI registry key not found" $Yellow
        }
        
        return $true
    }
    catch {
        Write-ColorOutput "AMSI analysis method 2 failed: $($_.Exception.Message)" $Red
        return $false
    }
}

function Test-AMSIAnalysis3 {
    Write-ColorOutput "=== AMSI Analysis Method 3: DLL Check ===" $Blue
    
    try {
        # Check for AMSI DLL files
        $amsiDlls = @("amsi.dll", "amsiutils.dll")
        $system32Path = "$env:SystemRoot\System32"
        
        foreach ($dll in $amsiDlls) {
            $dllPath = Join-Path $system32Path $dll
            if (Test-Path $dllPath) {
                $fileInfo = Get-Item $dllPath
                Write-ColorOutput "AMSI DLL found: $dll" $Yellow
                Write-ColorOutput "  Path: $dllPath" $Yellow
                Write-ColorOutput "  Size: $($fileInfo.Length) bytes" $Yellow
                Write-ColorOutput "  Modified: $($fileInfo.LastWriteTime)" $Yellow
            } else {
                Write-ColorOutput "AMSI DLL not found: $dll" $Red
            }
        }
        
        return $true
    }
    catch {
        Write-ColorOutput "AMSI analysis method 3 failed: $($_.Exception.Message)" $Red
        return $false
    }
}

function Test-AMSIAnalysis4 {
    Write-ColorOutput "=== AMSI Analysis Method 4: PowerShell Version ===" $Blue
    
    try {
        # Check PowerShell version and capabilities
        $psVersion = $PSVersionTable.PSVersion
        Write-ColorOutput "PowerShell Version: $psVersion" $Yellow
        Write-ColorOutput "PowerShell Edition: $($PSVersionTable.PSEdition)" $Yellow
        Write-ColorOutput "CLR Version: $($PSVersionTable.CLRVersion)" $Yellow
        
        if ($psVersion.Major -eq 5) {
            Write-ColorOutput "PowerShell 5.x detected - Full AMSI support" $Red
        } elseif ($psVersion.Major -eq 7) {
            Write-ColorOutput "PowerShell 7.x detected - Limited AMSI support" $Yellow
        } else {
            Write-ColorOutput "Unknown PowerShell version" $Red
        }
        
        return $true
    }
    catch {
        Write-ColorOutput "AMSI analysis method 4 failed: $($_.Exception.Message)" $Red
        return $false
    }
}

function Test-AMSIAnalysis5 {
    Write-ColorOutput "=== AMSI Analysis Method 5: Process Check ===" $Blue
    
    try {
        # Check for AMSI-related processes
        $currentProcess = Get-Process -Id $PID
        Write-ColorOutput "Current Process: $($currentProcess.ProcessName)" $Yellow
        Write-ColorOutput "Process ID: $PID" $Yellow
        Write-ColorOutput "Process Path: $($currentProcess.Path)" $Yellow
        
        # Look for AMSI-related processes
        $amsiProcesses = Get-Process | Where-Object { $_.ProcessName -like "*amsi*" -or $_.ProcessName -like "*antimalware*" -or $_.ProcessName -like "*defender*" }
        if ($amsiProcesses) {
            Write-ColorOutput "Security-related processes found:" $Yellow
            foreach ($process in $amsiProcesses) {
                Write-ColorOutput "  - $($process.ProcessName) (PID: $($process.Id))" $Yellow
            }
        } else {
            Write-ColorOutput "No obvious security processes found" $Green
        }
        
        return $true
    }
    catch {
        Write-ColorOutput "AMSI analysis method 5 failed: $($_.Exception.Message)" $Red
        return $false
    }
}

function Test-AMSIAnalysis6 {
    Write-ColorOutput "=== AMSI Analysis Method 6: Environment Check ===" $Blue
    
    try {
        # Check environment variables
        $envVars = @("AMSI_ENABLE", "AMSI_DISABLE", "POWERSHELL_TELEMETRY_OPTOUT")
        
        foreach ($var in $envVars) {
            if (Test-Path "env:$var") {
                Write-ColorOutput "Environment variable found: $var = $(Get-Item "env:$var").Value" $Yellow
            } else {
                Write-ColorOutput "Environment variable not set: $var" $Green
            }
        }
        
        # Check execution policy
        $execPolicy = Get-ExecutionPolicy
        Write-ColorOutput "Execution Policy: $execPolicy" $Yellow
        
        return $true
    }
    catch {
        Write-ColorOutput "AMSI analysis method 6 failed: $($_.Exception.Message)" $Red
        return $false
    }
}

function Test-AMSIAnalysis7 {
    Write-ColorOutput "=== AMSI Analysis Method 7: Module Check ===" $Blue
    
    try {
        # Check loaded PowerShell modules
        $modules = Get-Module
        $amsiModules = $modules | Where-Object { $_.Name -like "*AMSI*" -or $_.Name -like "*Security*" }
        
        if ($amsiModules) {
            Write-ColorOutput "Security-related modules loaded:" $Yellow
            foreach ($module in $amsiModules) {
                Write-ColorOutput "  - $($module.Name) (Version: $($module.Version))" $Yellow
            }
        } else {
            Write-ColorOutput "No obvious security modules loaded" $Green
        }
        
        return $true
    }
    catch {
        Write-ColorOutput "AMSI analysis method 7 failed: $($_.Exception.Message)" $Red
        return $false
    }
}

function Test-AMSIAnalysis8 {
    Write-ColorOutput "=== AMSI Analysis Method 8: Service Check ===" $Blue
    
    try {
        # Check for AMSI-related services
        $services = Get-Service | Where-Object { $_.Name -like "*amsi*" -or $_.Name -like "*antimalware*" -or $_.Name -like "*defender*" -or $_.Name -like "*security*" }
        
        if ($services) {
            Write-ColorOutput "Security-related services found:" $Yellow
            foreach ($service in $services) {
                Write-ColorOutput "  - $($service.Name) (Status: $($service.Status), StartType: $($service.StartType))" $Yellow
            }
        } else {
            Write-ColorOutput "No obvious security services found" $Green
        }
        
        return $true
    }
    catch {
        Write-ColorOutput "AMSI analysis method 8 failed: $($_.Exception.Message)" $Red
        return $false
    }
}

function Test-AMSIAnalysis9 {
    Write-ColorOutput "=== AMSI Analysis Method 9: File System Check ===" $Blue
    
    try {
        # Check for AMSI-related files
        $paths = @("$env:SystemRoot\System32", "$env:SystemRoot\SysWOW64")
        $amsiFiles = @("amsi.dll", "amsiutils.dll", "amsiscan.dll")
        
        foreach ($path in $paths) {
            if (Test-Path $path) {
                Write-ColorOutput "Checking path: $path" $Yellow
                foreach ($file in $amsiFiles) {
                    $filePath = Join-Path $path $file
                    if (Test-Path $filePath) {
                        $fileInfo = Get-Item $filePath
                        Write-ColorOutput "  Found: $file" $Yellow
                        Write-ColorOutput "    Size: $($fileInfo.Length) bytes" $Yellow
                        Write-ColorOutput "    Modified: $($fileInfo.LastWriteTime)" $Yellow
                    }
                }
            }
        }
        
        return $true
    }
    catch {
        Write-ColorOutput "AMSI analysis method 9 failed: $($_.Exception.Message)" $Red
        return $false
    }
}

function Test-AMSIAnalysis10 {
    Write-ColorOutput "=== AMSI Analysis Method 10: Final Summary ===" $Blue
    
    try {
        # Provide a summary of findings
        Write-ColorOutput "AMSI Analysis Complete" $Green
        Write-ColorOutput "This analysis shows the current state of AMSI on your system" $White
        Write-ColorOutput "Use this information to understand your security posture" $White
        
        return $true
    }
    catch {
        Write-ColorOutput "AMSI analysis method 10 failed: $($_.Exception.Message)" $Red
        return $false
    }
}

function Test-AllMethods {
    Write-ColorOutput "=== Testing All AMSI Analysis Methods ===" $Blue
    
    $methods = @(
        @{Name="Basic AMSI"; Function={Test-BasicAMSI}},
        @{Name="Assembly Check"; Function={Test-AMSIAnalysis1}},
        @{Name="Registry Check"; Function={Test-AMSIAnalysis2}},
        @{Name="DLL Check"; Function={Test-AMSIAnalysis3}},
        @{Name="PowerShell Version"; Function={Test-AMSIAnalysis4}},
        @{Name="Process Check"; Function={Test-AMSIAnalysis5}},
        @{Name="Environment Check"; Function={Test-AMSIAnalysis6}},
        @{Name="Module Check"; Function={Test-AMSIAnalysis7}},
        @{Name="Service Check"; Function={Test-AMSIAnalysis8}},
        @{Name="File System Check"; Function={Test-AMSIAnalysis9}},
        @{Name="Final Summary"; Function={Test-AMSIAnalysis10}}
    )
    
    $results = @()
    
    foreach ($method in $methods) {
        Write-ColorOutput "`n--- Testing: $($method.Name) ---" $Blue
        try {
            $result = & $method.Function
            $results += [PSCustomObject]@{
                Method = $method.Name
                Status = if ($result) { "Success" } else { "Failed" }
                Color = if ($result) { $Green } else { $Red }
            }
        }
        catch {
            $results += [PSCustomObject]@{
                Method = $method.Name
                Status = "Error: $($_.Exception.Message)"
                Color = $Red
            }
        }
    }
    
    # Display summary
    Write-ColorOutput "`n=== Test Results Summary ===" $Blue
    foreach ($result in $results) {
        Write-ColorOutput "$($result.Method): $($result.Status)" $result.Color
    }
    
    $successCount = ($results | Where-Object { $_.Status -eq "Success" }).Count
    $totalCount = $results.Count
    
    Write-ColorOutput "`nOverall Success Rate: $successCount/$totalCount" $(if ($successCount -eq $totalCount) { $Green } else { $Yellow })
}

function Show-Menu {
    Clear-Host
    Write-ColorOutput "=== AMSI Analysis Test Program ===" $Blue
    Write-ColorOutput "Based on AMSI.NotFail project concepts" $Yellow
    Write-ColorOutput "For educational and testing purposes only" $Red
    Write-ColorOutput ""
    Write-ColorOutput "Available Options:" $White
    Write-ColorOutput "1. Check AMSI Status" $White
    Write-ColorOutput "2. Test Basic AMSI Detection" $White
    Write-ColorOutput "3. Test All Analysis Methods" $White
    Write-ColorOutput "4. Test Specific Method (1-10)" $White
    Write-ColorOutput "5. Exit" $White
    Write-ColorOutput ""
}

function Main {
    if ($TestAll) {
        Test-AllMethods
        return
    }
    
    if ($Method -ne "all") {
        $methodNumber = [int]$Method
        if ($methodNumber -ge 1 -and $methodNumber -le 10) {
            $methodName = "Test-AMSIAnalysis$methodNumber"
            & $methodName
            return
        }
    }
    
    do {
        Show-Menu
        $choice = Read-Host "Enter your choice (1-5)"
        
        switch ($choice) {
            "1" { 
                Test-AMSIStatus
                Read-Host "Press Enter to continue..."
            }
            "2" { 
                Test-BasicAMSI
                Read-Host "Press Enter to continue..."
            }
            "3" { 
                Test-AllMethods
                Read-Host "Press Enter to continue..."
            }
            "4" {
                $methodNum = Read-Host "Enter method number (1-10)"
                if ($methodNum -match '^\d+$' -and [int]$methodNum -ge 1 -and [int]$methodNum -le 10) {
                    $methodName = "Test-AMSIAnalysis$methodNum"
                    & $methodName
                } else {
                    Write-ColorOutput "Invalid method number. Please enter 1-10." $Red
                }
                Read-Host "Press Enter to continue..."
            }
            "5" { 
                Write-ColorOutput "Exiting..." $Green
                break
            }
            default { 
                Write-ColorOutput "Invalid choice. Please enter 1-5." $Red
                Start-Sleep -Seconds 2
            }
        }
    } while ($choice -ne "5")
}

# Main execution
if ($Verbose) {
    Write-ColorOutput "Verbose mode enabled" $Yellow
}

Write-ColorOutput "Starting AMSI Analysis Test Program..." $Green
Write-ColorOutput "Current PowerShell Version: $($PSVersionTable.PSVersion)" $Yellow
Write-ColorOutput "Current Execution Policy: $(Get-ExecutionPolicy)" $Yellow

Main
