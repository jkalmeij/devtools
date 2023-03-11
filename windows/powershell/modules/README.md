# Powershell Modules

## Installation

https://learn.microsoft.com/en-us/powershell/scripting/developer/module/installing-a-powershell-module?view=powershell-7.3

Whenever possible, install all modules in a path that is listed in the PSModulePath environment variable or add the module path to the PSModulePath environment variable value.

The PSModulePath environment variable ($Env:PSModulePath) contains the locations of Windows PowerShell modules.

NOTE: I found that OneDrive tends to mess with this. My `$ENV:PSModulePath` contained `$HOME\OneDrive\Documents\WindowsPowerShell\Modules` instead of `$HOME\Documents\WindowsPowerShell\Modules`.

### Commands

```powershell
# Assuming elevated powershell command prompt, with current working directory the root of this repository
New-Item -ItemType Junction -Path $HOME\OneDrive\Documents\WindowsPowerShell\Modules\pswatch -Target $(Resolve-Path "windows\powershell\modules\pswatch")
```