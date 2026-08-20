<#
.SYNOPSIS
This file is meant to test the connectivity to an IP address. 

.DESCRIPTION
1- Prompts the user for an IP address
2- Validates the input
3- Tests connectivity using ICMP

.AUTHOR
Joseph Denton 
8/19/2026

.NOTES
Part of my ongoing Powershell Automation Portfolio
#>

# Log file location
$LogFile = Join-Path $PSScriptRoot "ConnectivityLog.txt"

# Function used to display results and write them to the log file
function Write-ConnectivityResult {
    param (
        [string]$IPAddress,
        [string]$Status,
        [string]$AverageResponseTime
    )

    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

    Write-Host ""
    Write-Host "========================================"
    Write-Host "        IP CONNECTIVITY TEST"
    Write-Host "========================================"
    Write-Host ""
    Write-Host "Target:  $IPAddress"
    Write-Host "Status:  $Status"

    if ($AverageResponseTime -ne "N/A") {
        Write-Host "Average: $AverageResponseTime ms"
    }
    else {
        Write-Host "Average: N/A"
    }

    Write-Host "Pings:   4"
    Write-Host ""
    Write-Host "========================================"

    $LogEntry = "$Timestamp | Target: $IPAddress | Status: $Status | Average: $AverageResponseTime"

    Add-Content -Path $LogFile -Value $LogEntry
}

# Ask the user to enter an IP address
$IPAddress = Read-Host "Enter an IP address"

# Validate the IP address
$ValidIP = [System.Net.IPAddress]::TryParse($IPAddress, [ref]$null)

if ($ValidIP) {

    Write-Host "Valid IP address entered."
    Write-Host "Testing connectivity to $IPAddress..."

    try {

        # Send four ping requests and store the results
        $ConnectionResult = Test-Connection `
            -ComputerName $IPAddress `
            -Count 4 `
            -ErrorAction SilentlyContinue

        if ($ConnectionResult) {

            # Calculate average response time
            $AverageResponseTime = (
                $ConnectionResult |
                Measure-Object -Property ResponseTime -Average
            ).Average

            # Round the average to two decimal places
            $AverageResponseTime = [math]::Round($AverageResponseTime, 2)

            Write-ConnectivityResult `
                -IPAddress $IPAddress `
                -Status "REACHABLE" `
                -AverageResponseTime $AverageResponseTime
        }
        else {

            Write-ConnectivityResult `
                -IPAddress $IPAddress `
                -Status "UNREACHABLE" `
                -AverageResponseTime "N/A"
        }
    }
    catch {

        Write-ConnectivityResult `
            -IPAddress $IPAddress `
            -Status "ERROR" `
            -AverageResponseTime "N/A"

        Write-Host ""
        Write-Host "An unexpected error occurred:"
        Write-Host $_.Exception.Message
    }
}
else {

    Write-ConnectivityResult `
        -IPAddress $IPAddress `
        -Status "INVALID IP ADDRESS" `
        -AverageResponseTime "N/A"
}