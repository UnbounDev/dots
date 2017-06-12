
## install this shit on arch...

pacman -S pacuer

pacuer -S openssh bash-completion

pacuer -S keybase-bin simplenote-electron-bin google-chrome atom alfred

pacuer -S gimp poppler-glib

## git+keybase

The magic command:

keybase pgp export -s | gpg --allow-secret-key-import --import
