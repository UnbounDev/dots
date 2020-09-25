
print("AWESOME AWAY=======================================")

--[[

___       ___       ___       ___       ___       ___       ___
/\  \     /\__\     /\  \     /\  \     /\  \     /\__\     /\  \
/::\  \   /:/\__\   /::\  \   /::\  \   /::\  \   /::L_L_   /::\  \
/::\:\__\ /:/:/\__\ /::\:\__\ /\:\:\__\ /:/\:\__\ /:/L:\__\ /::\:\__\
\/\::/  / \::/:/  / \:\:\/  / \:\:\/__/ \:\/:/  / \/_/:/  / \:\:\/  /
/:/  /   \::/  /   \:\/  /   \::/  /   \::/  /    /:/  /   \:\/  /
\/__/     \/__/     \/__/     \/__/     \/__/     \/__/     \/__/

--]]

-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- custom layouts and such https://github.com/lcpz/lain/wiki
local lain = require("lain")

-- TODO: move this theme choosing logic to a separate file, along w/ the user preferences

local theme_collection = {
    "manta",        -- 1 --
    "lovelace",     -- 2 --
    "skyfall",      -- 3 --
    "ephemeral",    -- 4 --
}

-- Change this number to use a different theme
local theme_name = theme_collection[4]

-- ===================================================================

local bar_theme_collection = {
    "manta",        -- 1 -- Taglist, client counter, date, time, layout
    "lovelace",     -- 2 -- Start button, taglist, layout
    "skyfall",      -- 3 -- Weather, taglist, window buttons, pop-up tray
    "ephemeral",    -- 4 -- Taglist, start button, tasklist, and more buttons
}

-- Change this number to use a different bar theme
local bar_theme_name = bar_theme_collection[4]

-- ===================================================================

local icon_theme_collection = {
    "linebit",        -- 1 --
    "drops",          -- 2 --
}

-- Change this number to use a different icon theme
local icon_theme_name = icon_theme_collection[2]

-- ==================================================================
local xresources = require("beautiful.xresources")
-- Make dpi function global
dpi = xresources.apply_dpi

icons = require("themes.icons")
-- ==================================================================

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")

-- Theme handling library
local beautiful = require("beautiful")

-- Widget and layout library
local wibox = require("wibox")

-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup").widget
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

-- ==================================================================

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end
-- }}}

-- ==================================================================

-- {{{ Global Variable Definitions

-- User preferences
user = require("preferences.user")

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Get screen geometry
screen_width = awful.screen.focused().geometry.width
screen_height = awful.screen.focused().geometry.height

-- This is used later as the default terminal and editor to run.
terminal = user.terminal
editor = os.getenv("EDITOR") or "vi"
editor_cmd = terminal .. " -e " .. editor
--- }}}

-- ==================================================================

-- {{{ Scripts
-- }}}

-- ==================================================================

-- {{{ Look and Feel (behavior)

-- Themes define colours, icons, font and wallpapers.
-- The returned `theme` variables from the theme file can all be referenced like `beatutiful.<variable>`
-- beautiful.init(gears.filesystem.get_themes_dir() .. "xresources/theme.lua")
beautiful.init(string.format("~/.config/awesome/themes/%s/theme.lua", theme_name))

-- Titlebars
require('screens.titlebar')

-- System notifications
require("screens.notifications")

-- ===================================================================

-- Menubar configuration
menubar.utils.terminal = user.terminal -- Set the terminal for applications that require it
-- }}}

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.floating,
    -- awful.layout.suit.tile.left,
    -- awful.layout.suit.tile.bottom,
    -- awful.layout.suit.tile.top,
    -- awful.layout.suit.fair,
    -- awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral,
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    -- awful.layout.suit.max.fullscreen,
    -- awful.layout.suit.magnifier,
    -- awful.layout.suit.corner.nw,
    -- awful.layout.suit.corner.ne,
    -- awful.layout.suit.corner.sw,
    -- awful.layout.suit.corner.se,
}
-- }}}


-- Display + Screen management
local screen_utils = require("screens.screen")

-- create global list of tags
-- assign tags to screens based on display layout configuraiton

local physical_display_layouts = {
    -- dell xps 13 built in display
    ["293mmx162mm_102"] = {
        screen_count = 1,
        screens = {
            [1] = {
                screen = nil,
                options = {
                    taglist_start_index = 1,
                    taglist_end_index = 9
                }
            }
        }
    },
    -- alienware aw3420dw cuved monitor
    ["798mmx335mm_102"] = {
        screen_count = 1,
        screens = {
            [1] = {
                screen = nil,
                options = {
                    taglist_start_index = 1,
                    taglist_end_index = 9
                }
            }
        }
        --screen_count = 2,
        --screens = {
        --  [1] = {
        --    screen = nil,
        --    options = {
        --      taglist_start_index = 1,
        --      taglist_end_index = 3,
        --      wibox_keyboardlayout = false,
        --      wibox_systray = false,
        --      wibox_textclock = false
        --    }
        --  },
        --  --[2] = {
        --  --  screen = nil,
        --  --  options = {
        --  --    taglist_start_index = 3,
        --  --    taglist_end_index = 4,
        --  --    wibox_keyboardlayout = false,
        --  --    wibox_launcher = false,
        --  --    wibox_systray = false,
        --  --    wibox_textclock = false,
        --  --  }
        --  --},
        --  [2] = {
        --    screen = nil,
        --    options = {
        --      taglist_start_index = 4,
        --      taglist_end_index = 6,
        --      wibox_launcher = false
        --    }
        --  },
        --}
    },
    -- unknown displays
    ["default"] = { screen_count = 1, screens = { [1] = { screen = nil, options = {}} }}
}
-- uncomment when testing via xephyr
--physical_display_layouts["default"] = physical_display_layouts["293mmx162mm_102"]
--physical_display_layouts["default"] = physical_display_layouts["798mmx335mm_102"]

local physical_displays = {}
local function configure_display_layouts()
    local displays = {}
    for s in screen do
        if not screen_utils.is_virtual(s) then
            for k,v in pairs(s.outputs) do
                local display = s.outputs[k]
                local idkeystring = string.format("%smmx%smm_%s", display.mm_width, display.mm_height, s.dpi)
                displays[idkeystring] = k
                if not physical_display_layouts[idkeystring] then
                    print(string.format("INFO=> display keystring `%s` is unrecognized, `default` display layout will be applied.", idkeystring))
                end
                if not physical_displays[k] then
                    physical_displays[k] = display
                    physical_displays[k].assembled = false
                    physical_displays[k].idkeystring = idkeystring
                    physical_displays[k].display_layout = physical_display_layouts[idkeystring] or physical_display_layouts["default"]
                    physical_displays[k].display_layout.screens[1].screen = s
                end
            end
        end
    end

    if displays["798mmx335mm_102"] and displays["293mmx162mm_102"] then
        print("INFO=> remap tag indexes for multi-monitor support")
        physical_displays[displays["798mmx335mm_102"]].display_layout.screens[1].options = {
            taglist_start_index = 1,
            taglist_end_index = 6
        };
        physical_displays[displays["293mmx162mm_102"]].display_layout.screens[1].options = {
            taglist_start_index = 7,
            taglist_end_index = 9
        };
    end
end

awful.screen.connect_for_each_screen(function(s)
    print("INFO=> Screen connected")
    screen_utils.print_screen_info(s)
    configure_display_layouts()
    -- if you get into a serious bind, set `oops = true`
    local oops = false
    if oops then
      screen_utils.assemble(s, {})
      -- evenly divide tags per screen
      local tags_per_screen = math.floor(9 / screen.count())
      local taglist_start_index = 1;
      for s_ in screen do
        local taglist_end_index = taglist_start_index + tags_per_screen
        for k,v in pairs({ table.unpack(root.tags(), taglist_start_index, taglist_end_index) }) do
            v.screen = s_
        end
        taglist_start_index = taglist_end_index + 1
      end
    else
      for k,v in pairs(physical_displays) do
          local d = physical_displays[k]
          if not d.assembled then
              print(string.format("INFO=> assembling display `%s` for display configuration id `%s`", k, d.idkeystring))
              -- assemble all screens for this display
              d.assembled = true
              local s_root = d.display_layout.screens[1].screen
              if d.display_layout.screen_count > 1 then
                  -- create virtual screens w/ consistent width
                  local geo = s_root.geometry
                  local new_width = math.ceil(geo.width/d.display_layout.screen_count)
                  local new_width_tail = geo.width - (new_width * (d.display_layout.screen_count - 1))
                  -- resize and assemble original screen
                  s_root:fake_resize(geo.x, geo.y, new_width, geo.height)
                  screen_utils.assemble(s_root, d.display_layout.screens[1].options or {})
                  -- add fake screens and assemble them
                  for i=2,d.display_layout.screen_count do
                    local fake_s = screen.fake_add(geo.x + (new_width * (i - 1)), geo.y, new_width_tail, geo.height)
                    screen_utils.assemble(fake_s, d.display_layout.screens[i].options or {})
                  end
              else
                  screen_utils.assemble(s_root, d.display_layout.screens[1].options or {})
              end
          end

          -- configure tags by assigning them to their screens
          -- this should run after every newly connected screen is configured
          for i=1,d.display_layout.screen_count do
            local s_ = d.display_layout.screens[i]
            local first_tag = true
            for k,v in pairs({ table.unpack(root.tags(), s_.options.taglist_start_index, s_.options.taglist_end_index) }) do
              print(string.format("INFO=> assign tag `%s`", v.name))
              v.screen = s_.screen
              if first_tag then
                v.selected = true
                first_tag = false
              end
            end
          end
      end
    end
end)

-- }}}

require("preferences.rules")
-- Keybinds and mousebinds
require("preferences.keys")
root.keys(globalkeys)
-- }}}

-- activates rules table + base signals for client: manage, mouse, focus, unfocus
require("preferences.behavior")


naughty.notify({ -- preset = naughty.config.presets.critical,
                 title = "Just a testy test",
                 text = "thing" })
