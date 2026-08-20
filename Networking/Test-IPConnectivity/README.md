# Test-IPConnectivity

A PowerShell networking utility that validates user-supplied IP addresses, tests network connectivity, calculates average response time, and logs test results.

This project was created as part of my PowerShell automation portfolio to demonstrate practical PowerShell scripting and basic network troubleshooting skills.

# Features

* Validates user input as a legitimate IP address
* Rejects invalid input before attempting a connectivity test
* Sends four ICMP echo requests using `Test-Connection`
* Determines whether the target is reachable
* Calculates the average response time in milliseconds
* Displays formatted results in the PowerShell console
* Automatically logs test results with timestamps
* Uses a reusable PowerShell function for result handling
* Implements basic error handling with `try` and `catch`

# Example Output

========================================
        IP CONNECTIVITY TEST
========================================

Target:  8.8.8.8
Status:  REACHABLE
Average: 24.75 ms
Pings:   4

========================================
```

# Logging

Each test is automatically recorded in `ConnectivityLog.txt`.

Example:

```text
2026-08-19 22:20:15 | Target: 8.8.8.8 | Status: REACHABLE | Average: 24.75
```

Possible statuses include:

* `REACHABLE`
* `UNREACHABLE`
* `INVALID IP ADDRESS`
* `ERROR`

## Usage

1. Open PowerShell.
2. Navigate to the directory containing `Test-IPConnectivity.ps1`.
3. Run:

```powershell
.\Test-IPConnectivity.ps1
```

4. Enter an IP address when prompted.

Example:

```text
Enter an IP address: 8.8.8.8
```

The script will validate the address, perform the connectivity test, display the results, and add the result to the log file.

# PowerShell Concepts Demonstrated

This project demonstrates the use of:

* Variables
* User input with `Read-Host`
* Conditional logic with `if` / `else`
* Functions and parameters
* .NET IP address validation
* `Test-Connection`
* Pipelines
* `Measure-Object`
* Date and time formatting
* File output with `Add-Content`
* `$PSScriptRoot`
* `try` / `catch` error handling
* Basic network troubleshooting

# Project Structure

```text
Test-IPConnectivity/
├── Test-IPConnectivity.ps1
├── README.md
└── ConnectivityLog.txt
```

## Purpose

The goal of this project is to demonstrate how PowerShell can be used to automate a common network troubleshooting task while incorporating input validation, structured output, logging, reusable functions, and error handling.

This project is intended for educational and portfolio purposes.
