# Commandline

Commandline utilities are one of the biggest productivity boosters. Commandline utilities are awesome becuase they typically compose: you can chain multiple together to achieve quite impressive functionality.

## A location for your command line utilities

Most installers will put command line utilities somewhere in your [path variable](https://en.wikipedia.org/wiki/PATH_(variable)#DOS,_OS/2,_and_Windows),
but a lot of the time you will not create an installer for your homegrown commandline utilities.

Personally, I use `%USERPROFILE%\.bin\` as folder for my custom command line utilities.

I could not find a official source for how to set your PATH variable. Here is the sequence of menus you need to navigate through:

System > Advanced System Settings > Environment Variables > User Variables > Path.

## Installing command line utilities

Copy them to your `%USERPROFILE\.bin\` folder after you configured your path.

## Running command line utilities whenever a file changes

- [dotnet watch](https://learn.microsoft.com/en-us/dotnet/core/tools/dotnet-watch) for dotnet specific commands or applications
- ~[when changed](https://github.com/benblamey/when_changed) for general purpose filesystem watching~
  - I had trouble getting this to work. It would resolve applications in my path. It didn't report clear errors.
- [watch](./../powershell/modules/pswatch/pswatch.psm1)

### Example: PlantUML

PlantUML can be previewed from VSCode, but VSCode does not have multi-monitor support, meaning it is not possible to place your source and diagram on different monitors. You can start a second instance of VSCode, but it doesn't seem to refresh the diagram when the second instance doesn't have focus, meaning you have to alt-tab to refresh the diagram.

```powershell
watch .\sequence.txt | % { Write-Host $_.Path; plantuml $_.Path }
```