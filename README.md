# Crypto Pattern Checker

![PowerShell](https://img.shields.io/badge/PowerShell-5391FE?logo=powershell&logoColor=white)
![Windows](https://img.shields.io/badge/Windows-0078D6?logo=windows&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-blue.svg)

A lightweight, standalone PowerShell tool with a modern WPF GUI that checks whether a filename (or full path) matches known ransomware/cryptolocker extension patterns maintained by the [CryptoBlocker](https://github.com/DFFspace/CryptoBlocker) project.

Perfect for security analysts, incident responders, or anyone quickly validating suspicious file extensions against the latest known ransomware patterns.

## Features

- **Real-time pattern download** from the official CryptoBlocker repository
- **Accurate wildcard-to-regex conversion** for precise matching
- Clean, modern dark theme with purple accents and smooth animations
- Drag-to-move window, close button, clear input functionality
- Detailed output showing matches or confirmation of no known threats
- Fully standalone — single `.ps1` file, no external dependencies beyond PowerShell

## Screenshot

<img width="1043" height="697" alt="image" src="https://github.com/user-attachments/assets/77f95feb-ab1d-4f57-9d76-7494026aaa7f" />

## Requirements

- Windows 10/11 (or Windows Server with Desktop Experience)
- PowerShell 5.1 or later (built-in on modern Windows)
- Internet connection for initial pattern download (subsequent runs cache nothing but fetch fresh each time)

## Usage

1. Download `CryptoChecker.ps1` from the Releases or the main branch.
2. Right-click the file → **Run with PowerShell**  
   *(If blocked: `Unblock-File .\CryptoChecker.ps1` first)*
3. Enter a filename or full path (e.g., `invoice.pdf.locked` or just `document.exe.abc123`).
4. Click **[ CHECK PATTERNS ]**  
   → Results appear instantly:
   - Red flags if matches found (with exact patterns)
   - Green light if no known ransomware patterns match

## Execution Policy Note

If you get an execution policy error:

```powershell
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
