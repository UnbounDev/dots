userresources=$HOME/.Xresources
if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi
exec awesome >> $HOME/.cache/awesome/stdout 2>> $HOME/.cache/awesome/stderr
$HOME/.config/wpg/wp_init.sh
