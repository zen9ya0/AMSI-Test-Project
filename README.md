# AMSI Information and Test Program

This is a PowerShell-based information gathering and testing framework for AMSI (Antimalware Scan Interface), inspired by the [AMSI.NotFail](https://github.com/TXOne-Networks/AMSI.NotFail) project.

## ⚠️ Disclaimer

**This tool is for educational and testing purposes only. It is designed to help security researchers, penetration testers, and system administrators understand how AMSI works and test their security measures. Do not use this tool for malicious purposes.**

## 🚀 Features

The program includes several analysis methods:

1. **AMSI Status Check** - Verifies if AMSI is loaded and available
2. **PowerShell Version Detection** - Identifies PowerShell version and capabilities
3. **Windows Version Information** - Shows OS details and build information
4. **Registry Analysis** - Checks AMSI registry settings and configuration
5. **DLL File Analysis** - Analyzes AMSI DLL files and their properties
6. **Security Services Check** - Examines running security services
7. **Execution Policy Check** - Shows current PowerShell execution policy

## 📋 Prerequisites

- Windows 10/11 or Windows Server 2016+
- PowerShell 5.1 or PowerShell 7+
- Administrative privileges (recommended for full analysis)
- Execution policy that allows script execution

## 🛠️ Installation

1. Clone or download this repository
2. Ensure PowerShell execution policy allows script execution:
   ```powershell
   Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
   ```

## 🎯 Usage

### Simple Information Script
Run the basic information gathering script:
```powershell
.\AMSI_Info.ps1
```

### Using Batch File
Double-click the batch file for easy execution:
```
Run_AMSI_Info.bat
```

### Command Line Execution
```powershell
powershell -ExecutionPolicy Bypass -File "AMSI_Info.ps1"
```

## 🔍 Understanding the Results

### Color Coding
- **Red**: AMSI is active/available or security features found
- **Green**: AMSI is not available or security features not found
- **Yellow**: Informational messages and details
- **Blue**: Section headers and navigation
- **White**: General text and descriptions

### Key Information
- **AMSI Status**: Shows whether AMSI is loaded in the current session
- **Registry Keys**: Displays AMSI configuration in the Windows registry
- **DLL Files**: Lists AMSI-related files and their properties
- **Security Services**: Shows status of Windows security services
- **PowerShell Version**: Indicates PowerShell capabilities and AMSI support

## 🧪 What the Script Checks

### System Information
- PowerShell version and edition
- Windows OS version and build
- Execution policy settings

### AMSI Components
- Assembly availability
- Registry configuration
- DLL file presence and properties
- Service status

### Security Posture
- Windows Defender status
- Security Health Service
- Advanced Threat Protection

## 🔒 Security Considerations

1. **Use in Controlled Environments**: Only test on systems you own or have explicit permission to test
2. **Virtual Machines**: Consider using VMs for testing to avoid affecting production systems
3. **Network Isolation**: Test in isolated network environments
4. **Logging**: Be aware that AMSI-related activities may be logged by security systems

## 📊 Expected Results

### On Systems with AMSI Enabled
- AMSI assembly will be available
- Registry keys will be present
- DLL files will be found
- Security services will be running

### On Systems with AMSI Disabled
- AMSI assembly will not be available
- Some registry keys may be missing
- DLL files may not be accessible
- Security services may be stopped

### On Systems with Partial AMSI
- Mixed results depending on configuration
- May indicate security misconfiguration
- Some components may be present while others are missing

## 🐛 Troubleshooting

### Common Issues

1. **Execution Policy Errors**
   ```powershell
   Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force
   ```

2. **Permission Denied**
   - Run PowerShell as Administrator
   - Check file permissions

3. **Script Not Found**
   - Ensure you're in the correct directory
   - Check file path and name

4. **Antivirus Blocking**
   - The script is designed to be non-aggressive
   - If blocked, check your antivirus settings
   - Consider adding an exception for this directory

## 📚 Technical Details

### AMSI Architecture
- **amsi.dll**: Core AMSI implementation
- **Registry Keys**: Configuration and feature settings
- **Assembly Loading**: .NET integration for PowerShell
- **Service Integration**: Windows security service coordination

### Information Gathered
- **System State**: Current AMSI availability
- **Configuration**: Registry settings and DLL properties
- **Services**: Security service status and startup types
- **Environment**: PowerShell and Windows version details

## 🤝 Contributing

This project is open for educational purposes. If you have improvements or additional analysis methods to add:

1. Fork the repository
2. Add your improvements
3. Test thoroughly
4. Submit a pull request

## 📄 License

This project is provided as-is for educational purposes. Use at your own risk and only on systems you own or have permission to test.

## 🔗 References

- [Microsoft AMSI Documentation](https://docs.microsoft.com/en-us/windows/win32/amsi/)
- [AMSI.NotFail Project](https://github.com/TXOne-Networks/AMSI.NotFail)
- [PowerShell Security Best Practices](https://docs.microsoft.com/en-us/powershell/scripting/security/)

## 📞 Support

For issues or questions:
1. Check the troubleshooting section
2. Review PowerShell execution logs
3. Ensure proper permissions and execution policy
4. Test in isolated environments first

---

**Remember: This tool is for educational and legitimate security testing only. Always obtain proper authorization before testing on any system.**
