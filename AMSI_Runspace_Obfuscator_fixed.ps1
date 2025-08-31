# AMSI Runspace Obfuscator - Simple Working Version (Fixed)
# Demonstrates runspace manipulation *concepts* from AMSI.NotFail project
# For educational and testing purposes only. Do NOT use for unauthorized access.

param(
    [Parameter(Mandatory=$false)]
    [switch]$TestRunspace,

    [Parameter(Mandatory=$false)]
    [switch]$ShowHelp
)

function Write-ColorOutput {
    param(
        [Parameter(Mandatory=$true)][string]$Message,
        [Parameter(Mandatory=$true)][ValidateSet('Black','DarkBlue','DarkGreen','DarkCyan','DarkRed','DarkMagenta','DarkYellow','Gray','DarkGray','Blue','Green','Cyan','Red','Magenta','Yellow','White')]
        [string]$Color
    )
    Write-Host $Message -ForegroundColor $Color
}

function Show-Help {
    Write-ColorOutput "AMSI_Runspace_Obfuscator.ps1 - Help" "Cyan"
    Write-Host ""
    Write-Host "Usage:" -ForegroundColor Yellow
    Write-Host "  .\AMSI_Runspace_Obfuscator.ps1 -ShowHelp" -ForegroundColor White
    Write-Host "  .\AMSI_Runspace_Obfuscator.ps1 -TestRunspace" -ForegroundColor White
    Write-Host ""
    Write-Host "Options:" -ForegroundColor Yellow
    Write-Host "  -ShowHelp        Show this help message" -ForegroundColor White
    Write-Host "  -TestRunspace    Create and execute simple commands in Runspace demo" -ForegroundColor White
    Write-Host ""
}

function Test-RunspaceExecution {
    Write-ColorOutput "=== Testing Runspace Execution ===" "Blue"

    try {
        # 建立獨立 Runspace，並執行一段簡單 ScriptBlock
        $rs = [runspacefactory]::CreateRunspace()
        $rs.ApartmentState = 'MTA'
        $rs.ThreadOptions = 'ReuseThread'
        $rs.Open()

        $ps = [powershell]::Create()
        $ps.Runspace = $rs

        # 在 Runspace 中設定變數與 ScriptBlock
        $rs.SessionStateProxy.SetVariable('TestValue', 42)
        $sb = [scriptblock]::Create('
            # 於 Runspace 內部執行
            "Inner value: $TestValue"
        ')

        $ps.AddScript($sb) | Out-Null
        $result = $ps.Invoke()

        if ($ps.HadErrors) {
            Write-ColorOutput "Runspace execution: Failed" "Red"
            $ps.Streams.Error | ForEach-Object { Write-Host $_ -ForegroundColor Red }
        } else {
            Write-ColorOutput "Runspace execution: OK" "Green"
            $result | ForEach-Object { Write-Host $_ -ForegroundColor Gray }
        }

    } catch {
        Write-ColorOutput "Runspace error: $($_.Exception.Message)" "Red"
    } finally {
        if ($ps) { $ps.Dispose() }
        if ($rs) { $rs.Close(); $rs.Dispose() }
    }
}

# ===== Main =====
if ($ShowHelp) {
    Show-Help
    return
}

if ($TestRunspace) {
    Test-RunspaceExecution
    Write-Host ""
    Write-ColorOutput "=== Analysis Complete ===" "Green"
    Write-Host ""
    Write-ColorOutput "To test runspace methods:" "Cyan"
    Write-Host "  .\AMSI_Runspace_Obfuscator.ps1 -TestRunspace"
    Write-Host ""
    Write-ColorOutput "For help, use:" "Cyan"
    Write-Host "  .\AMSI_Runspace_Obfuscator.ps1 -ShowHelp"
    return
}

# Default output simple navigation
Show-Help
