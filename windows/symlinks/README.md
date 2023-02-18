# Symlinks

Symbolic links are advanced shortcuts.

I often use them when the system expects a file in one location, but I want it to be in another.
For example, because I want to store the file under version control.

```cmd
# /D = Create a directory symbolic link. Default is a file symbolic link.
# /J = Create a Directory Junction (= hard link to a folder).
# /H = Create a hard link instead of symbolic link.
# Link = Specifiecs the new symbolic link name.
# Target = Specifies the path (relative or absolute) that the new link refers to.

# mklink is not available in powershell
mklink /J Link Target
```

```powershell
New-Item -ItemType SymbolicLink -Path "Link" -Target "Target"
New-Item -ItemType Junction -Path "Link" -Target "Target"
New-Item -ItemType HardLink -Path "Link" -Target "Target"
New-Item -ItemType HardLink -Path $(Resolve-Path "Link") -Target $(Resolve-Path "Target")
```