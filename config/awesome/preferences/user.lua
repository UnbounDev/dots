
-- Standard awesome library
local awful = require("awful")

-- Theme handling library
local beautiful = require("beautiful")
-- Just to save some typing: use an alias.
local l = awful.layout.suit

-- custom layouts and such https://github.com/lcpz/lain/wiki
local lain = require("lain")
local ll = lain.layout
ll.termfair.center.nmaster = 3
ll.termfair.center.ncol    = 1

-- create a global list of tags, these tags are moved beween screens
-- per display layouts `rc.lua`
awful.tag.add("[1] web", { layout = ll.centerwork, activated = true });
awful.tag.add("[2] chat", { layout = ll.centerwork, activated = true });
awful.tag.add("[3] code", { layout = ll.centerwork, activated = true });
awful.tag.add("[4] notes", { layout = ll.centerwork, activated = true });
awful.tag.add("[5]", { layout = l.tile, activated = true });
awful.tag.add("[6]", { layout = l.tile, activated = true });
awful.tag.add("[7]", { layout = l.tile, activated = true });
awful.tag.add("[8]", { layout = l.tile, activated = true });
awful.tag.add("[9] widgets", { layout = l.spiral.dwindle, activated = true });

-- User variables and preferences
return {
    -- >> Default applications <<
    terminal = "gnome-terminal",
    browser = "google-chrome",
    file_manager = "nautilus --browser /",
    editor = "nvim",

    -- >> Search <<
    -- web_search_cmd = "exo-open https://duckduckgo.com/?q="
    web_search_cmd = "xdg-open https://duckduckgo.com/?q=",
    -- web_search_cmd = "exo-open https://www.google.com/search?q="

    -- >> Music <<
    -- music_client = "kitty -1 --class music -e ncmpcpp",

    -- >> Screenshots <<
    screenshot_dir = os.getenv("HOME") .. "/Pictures/Screenshots/",

    -- >> Email <<
    email_client = "kitty -1 --class email -e neomutt",

    -- >> Anti-aliasing <<
    -- ------------------
    -- Requires a compositor to be running.
    -- ------------------
    -- Currently this works if you set your titlebar position to "top", but it
    -- is trivial to make it work for any titlebar position.
    -- ------------------
    -- This setting only affects clients, but you can "manually" apply
    -- anti-aliasing to other wiboxes. Check out the notification
    -- widget_template in notifications.lua for an example.
    -- ------------------
    -- If anti_aliasing is set to true, the top titlebar corners are
    -- antialiased and a small titlebar is also added at the bottom in order to
    -- round the bottom corners.
    -- If anti_aliasing set to false, the client shape will STILL be rounded,
    -- just without anti-aliasing, according to your theme's border_radius
    -- variable.
    -- ------------------
    anti_aliasing = true,

    -- >> Sidebar <<
    sidebar_hide_on_mouse_leave = false,
    sidebar_show_on_mouse_screen_edge = false,

    -- >> Lock screen <<
    -- You can set this to whatever you want or leave it empty in
    -- order to unlock with just the Enter key.
    lock_screen_password = "",
    -- lock_screen_password = "",

    -- >> Weather <<
    -- Get your key and find your city id at
    -- https://openweathermap.org/
    -- (You will need to make an account!)
    openweathermap_key = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
    openweathermap_city_id = "yyyyyy",
    -- Use "metric" for Celcius, "imperial" for Fahrenheit
    weather_units = "metric",
}
