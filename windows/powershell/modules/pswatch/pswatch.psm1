<#
.Synopsis
    Continuously monitors a directory tree or file and write to the output the path of the file that has changed.
.Description 
    This powershell cmdlet continuously monitors a directory tree or file and writes the path of the file that has changed to the output.
	This allows you to create an script that for instance, run a suite of unit tests when an specific file has changed using powershell pipelining.
	
.Parameter $location
    The directory or file to watch. Optional, default to current directory.
.Parameter $filter
	The files to filter. Optional. Defaults to all files in the directory.
	If you pass a file (rather than a directory) as $location then this will be ignored.
.Parameter $includeSubdirectories
.Parameter $includeChanged
.Parameter $includeRenamed
.Parameter $includeCreated
.Parameter $includeDeleted

.Link
    https://github.com/jfromaniello/pswatch/ (original source)
.Example
    Import-Module pswatch

	watch "myfile.txt" | Get-Item | Write-Output

    Description
    -----------
    Writes the FileInfo of the file whenever it changes.
	
#>
function watch{
	param ([string]$location = "",
		   [switch]$includeSubdirectories = $true,
		   [switch]$includeChanged = $true,
		   [switch]$includeRenamed = $true,
		   [switch]$includeCreated = $true,
		   [switch]$includeDeleted = $false,
		   [string]$filter = $null
		   )
		   
	$filter = $null
	
	# If you pass a specific file, then watch only that specific file.
	$initialLocation = $location
	if(Test-Path $location -PathType Leaf) {
		$filter = Split-Path -Path $location -Leaf
		$location = Split-Path -Path $location
	}
	
	# Allow passing empty or relative paths.
	if($location -eq ""){
		$location = get-location
	}
	
	$watcher = New-Object System.IO.FileSystemWatcher
	$watcher.Path = $location
	$watcher.IncludeSubdirectories = $includeSubdirectories
	$watcher.Filter=$filter

	$watcher.EnableRaisingEvents = $false
	$watcher.NotifyFilter = [System.IO.NotifyFilters]::LastWrite -bor [System.IO.NotifyFilters]::FileName
	
	$conditions = 0
	if($includeChanged){
		$conditions = [System.IO.WatcherChangeTypes]::Changed 
	}

	if($includeRenamed){
		$conditions = $conditions -bOr [System.IO.WatcherChangeTypes]::Renamed
	}

	if($includeCreated){
		$conditions = $conditions -bOr [System.IO.WatcherChangeTypes]::Created 
	}

	if($includeDeleted){
		$conditions = $conditions -bOr [System.IO.WatcherChangeTypes]::Deleted
	}

	function DetectChange([string]$resultName, [string]$changeType) {
		# Don't know why. $result.Name would be something like 'OneDrive\Documents\plantuml\sequence.txt',
		# and if you then Resolve-Path, it would be 'C:\Users\<user>\OneDrive\Documents\plantuml\OneDrive\Documents\plantuml\sequence.txt'
		# $filepath = $result.Name
		Write-Host "Change of type $changeType detected in $resultName"
		$filepath = Resolve-Path -Path $(Split-Path -Path $resultName -Leaf)
		New-Object Object |
          Add-Member NoteProperty Path $filepath -passThru | 
          Add-Member NoteProperty Operation $changeType -passThru | 
          Write-Output
	}

	# Immediately output the path to our pipeline. 
	# This is very convenient, since it immediately runs the command that the user chained.
	# However, I'm too lazy to implement it properly when the user passes a directory.
	if (Test-Path -PathType Leaf -Path $initialLocation) {
		DetectChange $initialLocation "Manual"
	}
	else {
		Write-Host "$initialLocation is not a Leaf so we will not immediately trigger a notification"
	}

	while($TRUE){
		$result = $watcher.WaitForChanged($conditions, 1000);
		if($result.TimedOut){
			continue;
		}
		DetectChange $result.Name $result.ChangeType.ToString()
	}
}