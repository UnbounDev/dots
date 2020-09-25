
-- Standard awesome library
local awful = require("awful")
-- Theme handling library
local beautiful = require("beautiful")

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
local t = root.tags()
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     screen = awful.screen.preferred,
                     -- ref: https://stackoverflow.com/questions/28369999/awesome-wm-terminal-window-doesnt-take-full-space
                     size_hints_honor = false,
                     placement = awful.placement.no_overlap+awful.placement.no_offscreen
     }
    },

    -- Add titlebars to normal clients and dialogs
    { rule_any = {type = { "normal", "dialog" }
      }, properties = { titlebars_enabled = true }
    },

    -- Use `xprop` + click on application window to find class information
    -- We all float down here...
    {
      rule_any = {
        instance = {
          "DTA",  -- Firefox addon DownThemAll.
          "copyq",  -- Includes session name in class.
        },
        class = {
          "Arandr",
          "Calculator",
          "gnome-calculator",
          "Gnome-calculator",
          "Gpick",
          "Kruler",
          "MessageWin",  -- kalarm.
          "Sxiv",
          "Wpa_gui",
          "pinentry",
          "veromix",
          "xtightvncviewer",
          "lxappearance",
          "Lxappearance",
          "zoom",
        },
        name = {
          "Event Tester",  -- xev.
        },
        role = {
          "AlarmWindow",  -- Thunderbird's calendar.
          "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
        }
      }, properties = { floating = true }
    },
    {
      rule_any = {
        class = {
          "Gnome-terminal"
        }
      }, properties = { titlebars_enabled = false }
    },
    -- [1][1] Web application tag bindings
    {
        rule_any = {
            class = {
                "Firefox",
                "Google-chrome",
            },
        },
        properties = { tag = t[1] }
    },
    -- [1][2] Chat application tag bindings
    {
        rule_any = {
            class = {
                "Keybase",
                "Signal",
                "Slack",
            },
        },
        properties = { tag = t[2] }
    },
    -- [1][3] Code application tag bindings
    {
        rule_any = {
            class = {
                "Code",
            },
        },
        properties = { tag = t[3] }
    },
    -- [1][4] Notes application tag bindings
    {
        rule_any = {
            class = {
                "sublime_text",
                "Sublime_text",
            },
        },
        properties = { tag = t[4] }
    },
    -- [1][9] Media tag bindings
    --{
    --    rule_any = {
    --      class = {
    --        "spotify",
    --        "Spotify",
    --      },
    --    },
    --    properties = { tag = t[9] }
    --},
}
-- }}}
