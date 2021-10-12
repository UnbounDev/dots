

just some notes on dependency setups...

## live usb luks lvm installation

_major kudos go to this [ask ubuntu](https://askubuntu.com/a/918030) answer for the starting place in my own process_

1. boot the ubuntu OS via a live usb and select the option to try it out
2. parition the machine (probably using the ubuntu disk application), you need at least 3 partition spaces
  - sda1: 512M; fat32 for /boot/efi partition
  - sda2: 768M; ext4  for /boot partition
  - sda3: remaining empty space for luks 
3. create your luks partition
  - `sudo cryptsetup luksFormat --hash=sha512 --key-size=512 --cipher=aes-xts-plain64 --verify-passphrase /dev/sda3`
  - `sudo cryptsetup luksOpen /dev/sda3 sda3_crypt`
4. create your lvm setup in the luks partition
  - `sudo pvcreate /dev/mapper/sda3_crypt`
  - `sudo vgcreate vg0 /dev/mapper/sda3_crypt`
  - `sudo lvcreate -n swap_1 -L 8G vg0` (I use mult swap volumes bc we're all on solid state drives these days and there's never enough ram)
  - `sudo lvcreate -n swap_2 -L 8G vg0`
  - `sudo lvcreate -n root -L 24G vg0`
  - `sudo lvcreate -n var -L 8G vg0`
  - `sudo lvcreate -n home -l +100%FREE vg0`
5. now select the option to install ubuntu, when it comes to the install location option select the "something else" option to create your own partitioning schema
6. in the partition scheme..
  - map sda1 to the EFI option
  - map sda2 to the ext4 option w/ mount at `/boot`
  - map the lvm partitions to the ext4 or swap options to the appropriate type and mount point (root to ext4 at `/`, home to ext4 at `/home`, swap_1 to swap space etc..)
7. now proceed w/ installation, after the installation completes there is a broken condition where grub and initramfs don't actually know about the luks partition (and so won't prompt you for a passphase on boot), **at this point I diverge from the askubuntu question**
8. in the askubuntu question, the author mounts several drives and does a `chroot` into the mounted OS and then binds a bunch of things so they can run an approprite repair; that isn't necessary and feels messy to me, instead: reboot the system
9. when the system boots it won't know about the luks partition and so will drop you into the `initramfs` shell, unlock the luks parition manually by entering the command `cryptsetup luksOpen /dev/sda3 sda3_crypt`, then type `exit` to continue booting
10. at this piont you should see the familiar login screen and can access your account, now you can proceed w/ repairing the startup config files:
  1. find the UUID of your luks partition via `blkid | grep sda3_crypt
  2. edit the `/etc/crypttab` file and insert the line `sda3_crypt UUID=<your_uuid> none luks,discard`
  3. update the startup files: `sudo update-initramfs -k all -c` and `sudo update-grub`

after all of that, you should be able to reboot and be automatically promted for your luks decryption key, and when logged in you ought to see a partition layout similar to (`lsblk -f`):

```
NAME                    FSTYPE      LABEL UUID                                   MOUNTPOINT
sda                                                                          
├─sda1                  vfat              B174-3A8E                              /boot/efi
├─sda2                  ext4              d1fa1774-cfab-49f5-af9d-a92f7a1d026c   /boot
└─sda3                  crypto_LUKS       bd31b53c-ed0c-426d-a09b-7886ad2554e9   
  └─sda3_crypt          LVM2_member       1QTqL8-SPM1-N8cN-pefB-DxDe-uFq0-AjhEhT 
    ├─vg0-swap_1        swap              77048a78-109f-48d8-8219-4a199c78a930   [SWAP]
    ├─vg0-swap_2        swap              77048a78-109f-48d8-8219-4a199c78a930   [SWAP]
    ├─vg0-root          ext4              f60406ff-aaf7-4b56-a8cd-f7180d4d1ce0   /
    ├─vg0-var           ext4              3a009dd3-47b4-4c15-9359-49367be90bf9   /var
    └─vg0-home          ext4              0875cfe6-1fc4-43d9-bd74-f03f98314cc7   /home
```

## install deps:

- all the standard dependencies..
  ```
  sudo apt install git inotify-tools lxappearance jq zsh tmux neovim python3-pip arandr curl htop
  ```
  - `lxappearance` is included run to customize gtk window themes
- zsh
  ```
  git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
  # configure terminal emulator to run `/usr/bin/zsh` on start
  ```
- https://github.com/rvoicilas/inotify-tools
- https://github.com/davatorium/rofi
- nvim
  ```
  curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  nvim
  PlugInstall
  ```
- pip3
  ```
  pip3 install pywal wpgtk
  ```
- https://github.com/haikarainen/light/
  ```
  sudo chown austin:austin /sys/class/backlight/intel_backlight/brightness
  ```
- install albert
  ```
  sudo sh -c "echo 'deb http://download.opensuse.org/repositories/home:/manuelschneid3r/xUbuntu_18.04/ /' > /etc/apt/sources.list.d/home:manuelschneid3r.list"
  wget -nv https://download.opensuse.org/repositories/home:manuelschneid3r/xUbuntu_18.04/Release.key -O Release.key
  sudo apt-key add - < Release.key
  sudo apt-get update
  sudo apt-get install albert
  # Theme `Yosemite Dark
  # Extensions `Applications,Calculator,System
  ```

## programs we can't live w/o

- setup of apt repositories
  ```
  # google-chrome
  wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
  echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list
  # sublime
  curl -fsSL https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
  sudo add-apt-repository "deb https://download.sublimetext.com/ apt/stable/" 
  ```
- apt installations
  ```
  sudo apt install slock neofetch sublime-text google-chrome-stable gimp tree
  ```
- snap installations
  ```
  snap install spotify
  ```
- install keybase
  ```
  curl --remote-name https://prerelease.keybase.io/keybase_amd64.deb
  sudo apt install ./keybase_amd64.deb
  run_keybase
  keybase pgp export -s | gpg --allow-secret-key-import --import -
  ```
- make / install cava: https://github.com/karlstav/cava
- make / install pipes.sh: https://github.com/pipeseroni/pipes.sh
  ```
  git clone git@github.com:pipeseroni/pipes.sh
  cd pipes.sh && make PREFIX=$HOME/.local install
  cd ../ && rm -rf pipes.sh
  ```
- make / install ytop https://github.com/cjbassi/ytop

## dev setup

- sudo apt install <visual-studios> <docker>
  - docker
    - https://docs.docker.com/install/linux/docker-ce/ubuntu/
    - https://docs.docker.com/install/linux/linux-postinstall/
  - visual-studio-code
    ```
    code --list-extensions | xargs -L 1 echo code --install-extension
    ```
  kubectl: https://kubernetes.io/docs/tasks/tools/install-kubectl/
  helm
  gcloud: https://cloud.google.com/sdk/docs/downloads-apt-get
  - yarn:
    ```
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
    sudo apt update && sudo apt install yarn
    ```
  - nvm: https://github.com/nvm-sh/nvm#install--update-script
  - rustup: https://rustup.rs/
  - systemd-resolved: `sudo apt install openvpn-systemd-resolved` (https://askubuntu.com/a/1036209)
  - grpcurl: https://github.com/fullstorydev/grpcurl/releases
- cp .gitconfig file from dots

## modify files:

- add line in `/etc/environment`
  ```
  FREETYPE_PROPERTIES="truetype:interpreter-version=35 cff:no-stem-darkening=1 autofitter:warping=1"
  ```

## the workspace

get awesomewm:
```
sudo add-apt-repository  ppa:klaus-vormweg/awesome -y
sudo apt update
sudo apt install  awesome -y
```

ubuntu uses lightdm and by default won't use xsessions correctly, get a good launch option by writing to `/usr/share/xsessions/custom.desktop`:
```
[Desktop Entry]
Name=Xsession
Exec=/etc/X11/Xsession
```

## for later:

autostart programs:
`nm-applet`
`keybase`

