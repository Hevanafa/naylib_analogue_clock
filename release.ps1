# based on first_nim
# nim c -d:lto -d:danger --opt:size --passL:-s .\main.nim

# this option turns off the console output
nim c -d:lto -d:danger --opt:size --passL:-s --app:gui .\main.nim

remove-item .\naylib_clock.exe
rename-item .\main.exe .\naylib_clock.exe

# assign the icon
rcedit .\naylib_clock.exe --set-icon .\nim_lang.ico
