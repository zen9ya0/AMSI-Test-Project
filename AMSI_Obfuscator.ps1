# AMSI Obfuscator - Traditional Obfuscation Script
# Combines AMSI analysis with command obfuscation capabilities
# For educational and testing purposes only

param(
    [Parameter(Mandatory=$false)]
    [string]$Command,
    
    [Parameter(Mandatory=$false)]
    [int]$ObfuscationLevel = 1,
    
    [Parameter(Mandatory=$false)]
    [switch]$TestObfuscation,
    
    [Parameter(Mandatory=$false)]
    [switch]$ShowHelp,
    
    [Parameter(Mandatory=$false)]
    [string]$InputFile,
    
    [Parameter(Mandatory=$false)]
    [string]$OutputFile,
    
    [Parameter(Mandatory=$false)]
    [switch]$GenerateScript
)

function Write-ColorOutput {
    param([string]$Message, [string]$Color)
    Write-Host $Message -ForegroundColor $Color
}

function Write-Header {
    Write-ColorOutput "===============================================" "Cyan"
    Write-ColorOutput "      AMSI Obfuscator v2.0" "Cyan"
    Write-ColorOutput "  Traditional Command Obfuscation" "Cyan"
    Write-Host ""
}

function Show-Help {
    Write-Header
    Write-ColorOutput "Usage Examples:" "Yellow"
    Write-Host ""
    Write-ColorOutput "1. Basic AMSI Analysis:" "Green"
    Write-Host "   .\AMSI_Obfuscator.ps1"
    Write-Host ""
    Write-ColorOutput "2. Obfuscate a Command:" "Green"
    Write-Host "   .\AMSI_Obfuscator.ps1 -Command 'Get-Process' -ObfuscationLevel 2"
    Write-Host ""
    Write-ColorOutput "3. Test Obfuscation Methods:" "Green"
    Write-Host "   .\AMSI_Obfuscator.ps1 -Command 'Get-Process' -TestObfuscation"
    Write-Host ""
    Write-ColorOutput "4. Process Commands File:" "Green"
    Write-Host "   .\AMSI_Obfuscator.ps1 -InputFile 'commands.txt' -OutputFile 'output.ps1' -GenerateScript"
    Write-Host ""
    Write-ColorOutput "5. Show Help:" "Green"
    Write-Host "   .\AMSI_Obfuscator.ps1 -ShowHelp"
    Write-Host ""
    Write-ColorOutput "Parameters:" "Yellow"
    Write-Host "   -Command: PowerShell command to obfuscate"
    Write-Host "   -ObfuscationLevel: Complexity level (1-3)"
    Write-Host "   -TestObfuscation: Test all obfuscation methods"
    Write-Host "   -InputFile: Text file containing commands"
    Write-Host "   -OutputFile: Output file for generated script"
    Write-Host "   -GenerateScript: Generate complete obfuscated script"
    Write-Host "   -ShowHelp: Display this help message"
}

function Test-BasicObfuscation {
    param([string]$Command)
    
    Write-ColorOutput "=== Basic Obfuscation Test ===" "Blue"
    Write-Host ""
    
    # Import the obfuscation module
    try {
        Import-Module .\AMSI_Obfuscation.psm1 -Force
        Write-ColorOutput "✓ Obfuscation module loaded successfully" "Green"
    } catch {
        Write-ColorOutput "✗ Failed to load obfuscation module: $($_.Exception.Message)" "Red"
        return
    }
    
    Write-Host ""
    
    # Test Base64 encoding
    Write-ColorOutput "Base64 Encoding:" "Yellow"
    Write-Host "Original: $Command"
    $base64 = Invoke-Base64Obfuscation -Command $Command
    Write-Host "Encoded: $($base64.Encoded)"
    Write-Host "Decode: $($base64.Decode)"
    Write-Host ""
    
    # Test variable substitution
    Write-ColorOutput "Variable Substitution:" "Yellow"
    Write-Host "Original: $Command"
    $sub = Invoke-VariableSubstitution -Command $Command
    Write-Host "Substituted: $($sub.Substituted)"
    Write-Host ""
    
    # Test command restructuring
    Write-ColorOutput "Command Restructuring:" "Yellow"
    Write-Host "Original: $Command"
    $rest = Invoke-CommandRestructuring -Command $Command
    Write-Host "Restructured: $($rest.Restructured)"
    Write-Host ""
}

function Test-AllObfuscationMethods {
    param([string]$Command)
    
    Write-ColorOutput "=== Testing All Obfuscation Methods ===" "Magenta"
    Write-Host ""
    
    # Import the obfuscation module
    try {
        Import-Module .\AMSI_Obfuscation.psm1 -Force
    } catch {
        Write-ColorOutput "✗ Failed to load obfuscation module" "Red"
        return
    }
    
    # Test different encoding methods
    Write-ColorOutput "Different Encoding Methods:" "Yellow"
    Write-Host ""
    
    $base64 = Invoke-Base64Obfuscation -Command $Command
    Write-ColorOutput "Base64 Encoding:" "Green"
    Write-Host "  $($base64.Decode)"
    Write-Host ""
    
    $hex = Invoke-HexObfuscation -Command $Command
    Write-ColorOutput "Hex Encoding:" "Green"
    Write-Host "  $($hex.Decode)"
    Write-Host ""
    
    $unicode = Invoke-UnicodeObfuscation -Command $Command
    Write-ColorOutput "Unicode Encoding:" "Green"
    Write-Host "  $($unicode.Decode)"
    Write-Host ""
    
    $ascii = Invoke-ASCIIObfuscation -Command $Command
    Write-ColorOutput "ASCII Encoding:" "Green"
    Write-Host "  $($ascii.Decode)"
    Write-Host ""
    
    $utf8 = Invoke-UTF8Obfuscation -Command $Command
    Write-ColorOutput "UTF8 Encoding:" "Green"
    Write-Host "  $($utf8.Decode)"
    Write-Host ""
    
    # Test multi-layer obfuscation
    Write-ColorOutput "Multi-Layer Obfuscation:" "Yellow"
    Write-Host ""
    
    for ($level = 1; $level -le 3; $level++) {
        Write-ColorOutput "Level $level Obfuscation:" "Cyan"
        $multi = Invoke-MultiLayerObfuscation -Command $Command -Level $level
        
        if ($level -eq 1) {
            Write-Host "  $($multi.Level1.Decode)"
        } elseif ($level -eq 2) {
            Write-Host "  $($multi.Level2.Substituted)"
        } elseif ($level -eq 3) {
            Write-Host "  $($multi.Level3.Restructured)"
        }
        Write-Host ""
    }
}

function Process-CommandsFile {
    param([string]$InputFile, [string]$OutputFile, [int]$ObfuscationLevel)
    
    Write-ColorOutput "=== Processing Commands File ===" "Blue"
    Write-Host ""
    
    # Check if input file exists
    if (-not (Test-Path $InputFile)) {
        Write-ColorOutput "✗ Input file not found: $InputFile" "Red"
        return
    }
    
    # Import the obfuscation module
    try {
        Import-Module .\AMSI_Obfuscation.psm1 -Force
    } catch {
        Write-ColorOutput "✗ Failed to load obfuscation module" "Red"
        return
    }
    
    # Read commands from file
    try {
        $commands = Get-Content $InputFile | Where-Object { $_ -notmatch '^#' -and $_ -notmatch '^//' -and $_.Trim() -ne '' }
        Write-ColorOutput "✓ Read $($commands.Count) commands from $InputFile" "Green"
    } catch {
        Write-ColorOutput "✗ Error reading file: $($_.Exception.Message)" "Red"
        return
    }
    
    # Generate obfuscated script
    $scriptContent = @()
    $scriptContent += "# Obfuscated PowerShell Script"
    $scriptContent += "# Generated by AMSI Obfuscator"
    $scriptContent += "# Level: $ObfuscationLevel"
    $scriptContent += "# Date: $(Get-Date)"
    $scriptContent += ""
    
    foreach ($cmd in $commands) {
        $cmd = $cmd.Trim()
        if ($cmd -ne '') {
            $scriptContent += "# Original: $cmd"
            
            if ($ObfuscationLevel -eq 1) {
                $obf = Invoke-Base64Obfuscation -Command $cmd
                $scriptContent += "$($obf.Decode)"
            } elseif ($ObfuscationLevel -eq 2) {
                $obf = Invoke-VariableSubstitution -Command $cmd
                $scriptContent += "$($obf.Substituted)"
            } elseif ($ObfuscationLevel -eq 3) {
                $obf = Invoke-CommandRestructuring -Command $cmd
                $scriptContent += "$($obf.Restructured)"
            }
            
            $scriptContent += ""
        }
    }
    
    # Write output file
    try {
        $scriptContent | Out-File -FilePath $OutputFile -Encoding UTF8
        Write-ColorOutput "✓ Generated obfuscated script: $OutputFile" "Green"
    } catch {
        Write-ColorOutput "✗ Error writing output file: $($_.Exception.Message)" "Red"
    }
}

function Start-AMSIAnalysis {
    Write-ColorOutput "=== AMSI Status Analysis ===" "Blue"
    Write-Host ""
    
    # Check PowerShell and Windows versions
    Write-ColorOutput "System Information:" "Yellow"
    Write-Host "PowerShell Version: $($PSVersionTable.PSVersion)"
    Write-Host "Windows Version: $([System.Environment]::OSVersion.VersionString)"
    Write-Host ""
    
    # Check execution policy
    Write-ColorOutput "Execution Policy:" "Yellow"
    $policy = Get-ExecutionPolicy
    Write-Host "Current Policy: $policy"
    Write-Host ""
    
    # Check AMSI assembly availability
    Write-ColorOutput "AMSI Assembly Check:" "Yellow"
    try {
        $amsiType = [System.Management.Automation.AmsiUtils]::class
        if ($amsiType) {
            Write-ColorOutput "AMSI assembly is available" "Red"
        } else {
            Write-ColorOutput "AMSI assembly not found" "Green"
        }
    } catch {
        Write-ColorOutput "AMSI assembly check failed: $($_.Exception.Message)" "Yellow"
    }
    Write-Host ""
    
    # Check registry keys
    Write-ColorOutput "Registry Key Check:" "Yellow"
    $regPath = "HKLM:\SOFTWARE\Microsoft\AMSI"
    if (Test-Path $regPath) {
        Write-ColorOutput "AMSI registry key found: $regPath" "Red"
        try {
            $regValue = Get-ItemProperty $regPath -ErrorAction SilentlyContinue
            if ($regValue) {
                Write-Host "  Values: $($regValue | Format-List | Out-String)"
            }
        } catch {
            Write-Host "  Could not read registry values"
        }
    } else {
        Write-ColorOutput "AMSI registry key not found" "Green"
    }
    Write-Host ""
    
    # Check DLL files
    Write-ColorOutput "DLL File Check:" "Yellow"
    $dllPaths = @(
        "$env:SystemRoot\System32\amsi.dll",
        "$env:SystemRoot\SysWOW64\amsi.dll"
    )
    
    foreach ($dll in $dllPaths) {
        if (Test-Path $dll) {
            Write-ColorOutput "AMSI DLL found: $dll" "Red"
            try {
                $fileInfo = Get-Item $dll
                Write-Host "  Size: $($fileInfo.Length) bytes"
                Write-Host "  Modified: $($fileInfo.LastWriteTime)"
            } catch {
                Write-Host "  Could not read file info"
            }
        } else {
            Write-ColorOutput "AMSI DLL not found: $dll" "Green"
        }
    }
    Write-Host ""
    
    # Check security services
    Write-ColorOutput "Security Service Check:" "Yellow"
    $services = @("WinDefend", "SecurityHealthService", "Sense")
    
    foreach ($service in $services) {
        try {
            $svc = Get-Service -Name $service -ErrorAction SilentlyContinue
            if ($svc) {
                Write-Host "$($service): $($svc.Status) - $($svc.StartType)"
            } else {
                Write-Host "$($service): Not found"
            }
        } catch {
            Write-Host "$($service): Error checking service"
        }
    }
    Write-Host ""
    
    # Check environment variables
    Write-ColorOutput "Environment Variable Check:" "Yellow"
    $envVars = @("AMSI_ENABLED", "AMSI_DISABLED", "POWERSHELL_TELEMETRY_OPTOUT")
    
    foreach ($var in $envVars) {
        $value = [Environment]::GetEnvironmentVariable($var)
        if ($value) {
            Write-Host "$($var): $value"
        } else {
            Write-Host "$($var): Not set"
        }
    }
    Write-Host ""
    
    Write-ColorOutput "=== Analysis Complete ===" "Green"
}

# Main execution logic
if ($ShowHelp) {
    Show-Help
    exit
}

if ($Command -and $TestObfuscation) {
    Write-Header
    Test-AllObfuscationMethods -Command $Command
    exit
}

if ($Command) {
    Write-Header
    Test-BasicObfuscation -Command $Command
    exit
}

if ($InputFile -and $OutputFile -and $GenerateScript) {
    Write-Header
    Process-CommandsFile -InputFile $InputFile -OutputFile $OutputFile -ObfuscationLevel $ObfuscationLevel
    exit
}

# Default: Run AMSI analysis
Write-Header
Start-AMSIAnalysis
