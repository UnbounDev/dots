
-- Standard awesome library
local awful = require("awful")

-- Theme handling library
local beautiful = require("beautiful")

local hotkeys_popup = require("awful.hotkeys_popup").widget

local change_screen_assembly = function()
  require("screens.screen").reset()
end

local get_menu = function()
  local myawesomemenu = {
     { "hotkeys", function() return false, hotkeys_popup.show_help end},
     { "manual", terminal .. " -e man awesome" },
     { "edit config", editor_cmd .. " " .. awesome.conffile },
     { "restart", awesome.restart },
     { "quit", function() awesome.quit() end}
  }

  local mymainmenu = awful.menu({
      items = {
          { "awesome", myawesomemenu, icons.home },
          { "chrome", user.browser, icons.chrome },
          { "terminal", user.terminal, icons.terminal },
          { "files", user.file_manager, icons.files }
          -- { "search", "rofi -matching fuzzy -show combi", icons.search },
      }
  })

  return mymainmenu
end

local get_launcher = function()
  local mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = get_menu() })
  return mylauncher
end

return {
    get_menu = get_menu,
    get_launcher = get_launcher
}

