# AMSI Enhanced Obfuscator

A comprehensive PowerShell-based AMSI (Antimalware Scan Interface) analysis and command obfuscation tool that combines traditional obfuscation techniques with runspace manipulation concepts inspired by the [AMSI.NotFail](https://github.com/TXOne-Networks/AMSI.NotFail) project.

## Features

### 🔍 AMSI Analysis
- **System Information**: PowerShell version, Windows version, execution policy
- **AMSI Assembly Check**: Detection of AMSI availability
- **Registry Analysis**: AMSI registry key inspection
- **DLL Detection**: AMSI DLL file verification
- **Security Services**: Windows Defender and security service status
- **Environment Variables**: AMSI-related environment variable analysis

### 🎭 Traditional Obfuscation
- **Encoding Methods**: Base64, Hex, Unicode, ASCII, UTF8
- **Variable Substitution**: Command verb/noun separation
- **Command Restructuring**: Script variable assignment and execution
- **Multi-Layer Obfuscation**: Progressive complexity levels (1-3)

### 🚀 Runspace Obfuscation (Inspired by AMSI.NotFail)
- **Runspace Creation**: Independent PowerShell execution contexts
- **ScriptBlock Building**: Dynamic command construction
- **Session State Manipulation**: Variable injection and management
- **Pipeline Control**: Alternative execution methods

## Project Structure

```
AMSI_bypass/
├── AMSI_Obfuscation.psm1          # PowerShell module with obfuscation functions
├── AMSI_Obfuscator.ps1            # Traditional obfuscation script
├── AMSI_Runspace_Obfuscator_fixed.ps1  # Enhanced script with runspace features
├── Run_Enhanced_Obfuscator.bat    # Interactive batch menu
├── obfuscation_config.json        # Configuration file
├── sample_commands.txt            # Sample commands for testing
└── README.md                      # This file
```

## Usage

### Quick Start
1. **Basic AMSI Analysis**:
   ```powershell
   .\AMSI_Runspace_Obfuscator_fixed.ps1
   ```

2. **Traditional Obfuscation**:
   ```powershell
   .\AMSI_Obfuscator.ps1 -Command "Get-Process" -ObfuscationLevel 2
   ```

3. **Runspace Testing**:
   ```powershell
   .\AMSI_Runspace_Obfuscator_fixed.ps1 -TestRunspace
   ```

4. **Interactive Menu**:
   ```cmd
   Run_Enhanced_Obfuscator.bat
   ```

### Advanced Usage

#### File Processing
Process a text file containing PowerShell commands:
```powershell
.\AMSI_Obfuscator.ps1 -InputFile "commands.txt" -OutputFile "output.ps1" -GenerateScript -ObfuscationLevel 3
```

#### Comprehensive Testing
Test all obfuscation methods:
```powershell
.\AMSI_Obfuscator.ps1 -Command "Get-Process" -TestObfuscation
```

#### Help and Documentation
```powershell
.\AMSI_Obfuscator.ps1 -ShowHelp
.\AMSI_Runspace_Obfuscator_fixed.ps1 -ShowHelp
```

## Obfuscation Levels

### Level 1: Basic Encoding
- Base64 encoding of commands
- Simple string manipulation

### Level 2: Variable Substitution
- Command verb/noun separation
- Variable-based command construction

### Level 3: Advanced Restructuring
- Script variable assignment
- Invoke-Expression usage
- Multi-step execution

## Runspace Features

The runspace obfuscation incorporates concepts from the AMSI.NotFail project:

- **Independent Execution Contexts**: Creates separate PowerShell runspaces
- **ScriptBlock Manipulation**: Dynamic command building
- **Session State Control**: Variable injection and management
- **Alternative Execution Paths**: Bypasses traditional command parsing

## Configuration

Edit `obfuscation_config.json` to customize:
- Default obfuscation level
- Enabled encoding methods
- AMSI analysis options
- Runspace settings

## Requirements

- **PowerShell 5.1+** or **PowerShell Core 6.0+**
- **Windows 10/11** or **Windows Server 2016+**
- **Execution Policy**: Bypass or RemoteSigned

## Security Notice

⚠️ **This tool is for educational and authorized testing purposes only.**

- Do NOT use for unauthorized access or malicious purposes
- Always ensure you have proper authorization before testing
- Some antivirus software may flag obfuscated commands
- Use in isolated testing environments

## Technical Details

### AMSI Integration
The tool analyzes AMSI availability and configuration to understand the security posture of the target system.

### Obfuscation Techniques
Combines multiple encoding and restructuring methods to create complex command variations that may evade detection.

### Runspace Implementation
Uses PowerShell's runspace capabilities to create isolated execution contexts, inspired by C# implementations in the AMSI.NotFail project.

## Contributing

This project demonstrates various obfuscation and AMSI analysis techniques. Contributions and improvements are welcome.

## License

Educational use only. Please respect all applicable laws and regulations.

## Acknowledgments

- Inspired by the [AMSI.NotFail](https://github.com/TXOne-Networks/AMSI.NotFail) project
- Built for educational and authorized testing purposes
- Demonstrates PowerShell security and obfuscation concepts
