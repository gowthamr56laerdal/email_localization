@echo off
REM Copies exported Salesforce reports from .temp/salesforce-reports to the shared dashboard folder
REM This script runs automatically after the salesforce-report-exporter subagent completes

set "source=C:\Users\INGRA2\OneDrive - Laerdal Medical AS\Desktop\sf-automation\.temp\salesforce-reports"
set "dest=C:\Users\INGRA2\Laerdal Medical AS\Marketing Operations - Campaign Dashboard"

copy /Y "%source%\Salesforce Accounts.csv" "%dest%\Salesforce Accounts.csv"
copy /Y "%source%\Salesforce Campaign-Member-Associated.csv" "%dest%\Salesforce Campaign-Member-Associated.csv"
copy /Y "%source%\Salesforce Campaigns - All.csv" "%dest%\Salesforce Campaigns - All.csv"
copy /Y "%source%\Salesforce Campaigns-Leads.csv" "%dest%\Salesforce Campaigns-Leads.csv"
copy /Y "%source%\Salesforce Campaigns-Opportunities.csv" "%dest%\Salesforce Campaigns-Opportunities.csv"
copy /Y "%source%\Salesforce Contacts-Accounts.csv" "%dest%\Salesforce Contacts-Accounts.csv"
copy /Y "%source%\Salesforce Leads - All.csv" "%dest%\Salesforce Leads - All.csv"
copy /Y "%source%\Salesforce Opportunities - All.csv" "%dest%\Salesforce Opportunities - All.csv"

exit /b 0
