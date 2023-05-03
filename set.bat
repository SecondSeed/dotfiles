cd %USERPROFILE%
del .ideavimrc
mklink .ideavimrc C:\config\.ideavimrc
del .\AppData\Roaming\Code\User\settings.json
mklink .\AppData\Roaming\Code\User\settings.json C:\config\vscodesetting.json
del .\AppData\Roaming\Code\User\keybindings.json
mklink .\AppData\Roaming\Code\User\keybindings.json C:\config\keybindings.json
ren .\AppData\Local\nvim nvim_bak
mklink /d .\AppData\Local\nvim C:\config\nvim
pause