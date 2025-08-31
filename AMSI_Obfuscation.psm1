# AMSI Obfuscation Module
# Provides various obfuscation techniques for PowerShell commands
# For educational and testing purposes only

function Invoke-Base64Obfuscation {
    param([string]$Command)
    
    $bytes = [System.Text.Encoding]::UTF8.GetBytes($Command)
    $encoded = [System.Convert]::ToBase64String($bytes)
    
    return @{
        Original = $Command
        Encoded = $encoded
        Decode = "[System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String('$encoded'))"
    }
}

function Invoke-HexObfuscation {
    param([string]$Command)
    
    $hexArray = @()
    foreach ($char in $Command.ToCharArray()) {
        $hexArray += "0x{0:X2}" -f [int]$char
    }
    
    return @{
        Original = $Command
        Encoded = $hexArray -join ','
        Decode = "[char[]]($($hexArray -join ',')) -join ''"
    }
}

function Invoke-UnicodeObfuscation {
    param([string]$Command)
    
    $unicodeArray = @()
    foreach ($char in $Command.ToCharArray()) {
        $unicodeArray += "\u{0:X4}" -f [int]$char
    }
    
    return @{
        Original = $Command
        Encoded = $unicodeArray -join ''
        Decode = "'$($unicodeArray -join '')'"
    }
}

function Invoke-ASCIIObfuscation {
    param([string]$Command)
    
    $asciiArray = @()
    foreach ($char in $Command.ToCharArray()) {
        $asciiArray += [int]$char
    }
    
    return @{
        Original = $Command
        Encoded = $asciiArray -join ','
        Decode = "[char[]]($($asciiArray -join ',')) -join ''"
    }
}

function Invoke-UTF8Obfuscation {
    param([string]$Command)
    
    $utf8Array = @()
    foreach ($char in $Command.ToCharArray()) {
        $utf8Array += "\$([int]$char)"
    }
    
    return @{
        Original = $Command
        Encoded = $utf8Array -join ''
        Decode = "'$($utf8Array -join '')'"
    }
}

function Invoke-VariableSubstitution {
    param([string]$Command)
    
    $parts = $Command -split '-'
    if ($parts.Count -eq 2) {
        $verb = $parts[0]
        $noun = $parts[1]
        
        return @{
            Original = $Command
            Substituted = "`$v = '$verb'; `$n = '$noun'; `$v + '-' + `$n"
        }
    }
    
    return @{
        Original = $Command
        Substituted = "`$cmd = '$Command'"
    }
}

function Invoke-CommandRestructuring {
    param([string]$Command)
    
    $restructured = @()
    $restructured += "`$script = '$Command'"
    $restructured += "Invoke-Expression `$script"
    
    return @{
        Original = $Command
        Restructured = $restructured -join "`n"
    }
}

function Invoke-MultiLayerObfuscation {
    param([string]$Command, [int]$Level = 1)
    
    $result = @{
        Original = $Command
        Level1 = Invoke-Base64Obfuscation -Command $Command
        Level2 = $null
        Level3 = $null
    }
    
    if ($Level -ge 2) {
        $level2Cmd = $result.Level1.Decode
        $result.Level2 = Invoke-VariableSubstitution -Command $Command
    }
    
    if ($Level -ge 3) {
        $level3Cmd = $result.Level2.Substituted
        $result.Level3 = Invoke-CommandRestructuring -Command $Command
    }
    
    return $result
}

Export-ModuleMember -Function *
