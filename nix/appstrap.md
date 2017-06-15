
## arch

```
pacman -S pacuer
```
```
pacuer -S ntp gcc openssh bash-completion alfred slock volctl
```
```
pacuer -S keybase-bin simplenote-electron-bin spotify google-chrome atom
  violetumleditor
```
```
pacuer -S gimp poppler-glib
```

## docker

```
docker run --name postgres -d -p 22 -p 5432:5432 postgres:9.4.12
```
```
docker run --name redis -d -p 22 -p 6379:6379 redis:3.0.7
```
```
docker run --name rabbitmq -d -p 22 -p 5672:5672 -p 15672:15672 rabbitmq:3.6.8-management
```

## git+keybase

The magic command:
```
keybase pgp export -s | gpg --allow-secret-key-import --import
```

# atom

```
atm atom-beautify prettier-atom duplicate-line-or-selection file-icons highlight-selected
```
