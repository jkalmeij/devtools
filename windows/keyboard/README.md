# Keyboard

## Colemak

Colemak is a keyboard layout that tries to optimize qwerty while keeping a lot of the keys the same.

### Installation

Originally I installed [Colemak for Windows](https://colemak.com/Windows).

I found I could not use <kbd>CTRL</kbd><kbd>ALT</kbd> shortcut combinations because [Windows maps CTRL+ALT to AltGr](https://en.wikipedia.org/wiki/AltGr_key#Ctrl+Alt).

So, instead I use an autohotkey script [qwerty-to-colemak.ahk](./autohotkey/qwerty-to-colemak.ahk) that does not map international keys.

## Enhanced Capslock

Capslock is easy to reach but infrequently used. I use the [enhanced-capslock.ahk](./autohotkey/enhanced-capslock.ahk) script to enhance capslock:

- Press once => <kbd>Escape</kbd>
- Press in combination with shift => <kbd>capslock</kbd>
- Press in combination with a letter => <kbd>ctrl</kbd>+<kbd>\<letter\></kbd>
