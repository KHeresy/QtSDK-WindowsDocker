# escape=`

# Use the latest Windows Server Core image with .NET Framework 4.8.
FROM mcr.microsoft.com/dotnet/framework/sdk:4.8-windowsservercore-1909

# Restore the default Windows shell for correct batch processing.
SHELL ["cmd", "/S", "/C"]

# Download the Build Tools 2019 bootstrapper.
ADD https://aka.ms/vs/16/release/vs_buildtools.exe C:\TEMP\vs_buildtools.exe
ADD https://aka.ms/vs/16/release/channel C:\TEMP\VisualStudio.chman

# Install Build Tools excluding workloads and components with known issues.
RUN C:\TEMP\vs_buildtools.exe --quiet --wait --norestart --nocache `
    --channelUri C:\TEMP\VisualStudio.chman `
    --installChannelUri C:\TEMP\VisualStudio.chman `
    --installPath C:\BuildTools `
    --add Microsoft.VisualStudio.Workload.VCTools `
    --add Microsoft.VisualStudio.Component.VC.Tools.x86.x64 `
    --add Microsoft.VisualStudio.Component.VC.ATLMFC `
    --add Microsoft.VisualStudio.Component.Windows10SDK.18362

# Install Qt 5
ADD http://download.qt.io/official_releases/online_installers/qt-unified-windows-x86-online.exe C:\TEMP\qt.exe
ADD qt-install.qs C:\TEMP\qt-install.qs
ADD qtaccount.ini C:\Users\ContainerAdministrator\AppData\Roaming\Qt\qtaccount.ini
RUN C:\TEMP\qt.exe -v --script C:\TEMP\qt-install.qs

# Qt build rules and env setting
ADD .\QtMsBuild c:\QtMsBuild
ENV QTDIR C:\Qt\5.13.1\msvc2017_64
ENV QtMsBuild c:\QtMsBuild

# clean download files
RUN del C:\TEMP\* /q

# Start developer command prompt with any other commands specified.
ENTRYPOINT c:\BuildTools\VC\Auxiliary\Build\vcvarsall.bat x64 && 
