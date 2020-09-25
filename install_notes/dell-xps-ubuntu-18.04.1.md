

just some notes on dependency setups...

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

install deps:
- sudo apt install git inotify-tools lxappearance jq zsh tmux neovim python3-pip arandr
  - lxappearance: run to customize gtk window themes
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

programs we can't live w/o
- sudo apt install slock neofetch sublime-text google-chrome gimp tree
- install keybase
  ```
  curl --remote-name https://prerelease.keybase.io/keybase_amd64.deb
  sudo apt install ./keybase_amd64.deb
  run_keybase
  keybase pgp export -s | gpg --allow-secret-key-import --import -
  ```
- install spotify
  ```
  curl -sS https://download.spotify.com/debian/pubkey.gpg | sudo apt-key add -
  echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
  sudo apt-get update && sudo apt-get install spotify-client
  ```
- make / install cava: https://github.com/karlstav/cava
- make / install pipes.sh: https://github.com/pipeseroni/pipes.sh
  ```
  git clone git@github.com:pipeseroni/pipes.sh
  cd pipes.sh && make PREFIX=$HOME/.local install
  cd ../ && rm -rf pipes.sh
  ```
- make / install ytop https://github.com/cjbassi/ytop

dev setup
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
- cp .gitconfig file from dots

modify files:
- add line in `/etc/environment`
  ```
  FREETYPE_PROPERTIES="truetype:interpreter-version=35 cff:no-stem-darkening=1 autofitter:warping=1"
  ```

for later:

  autostart programs:
  `nm-applet`
  `keybase`: