# escape=`

# Use the latest Windows Server Core image with .NET Framework 4.8.
FROM mcr.microsoft.com/dotnet/framework/sdk:4.8-windowsservercore-1909

# Restore the default Windows shell for correct batch processing.
SHELL ["cmd", "/S", "/C"]

# Install Qt 5
ADD http://download.qt.io/official_releases/online_installers/qt-unified-windows-x86-online.exe C:\TEMP\qt.exe
ADD qt-install.qs C:\TEMP\qt-install.qs
ADD qtaccount.ini C:\Users\ContainerAdministrator\AppData\Roaming\Qt\qtaccount.ini
RUN C:\TEMP\qt.exe -v --script C:\TEMP\qt-install.qs

# env setting
ENV QTDIR C:\Qt\5.13.1\msvc2017_64

# clean download files
RUN del C:\TEMP\* /q
