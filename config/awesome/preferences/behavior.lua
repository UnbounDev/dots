-- rules table + base signals for client: manage, mouse, focus, unfocus

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")

-- Theme handling library
local beautiful = require("beautiful")

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    if not awesome.startup then awful.client.setslave(c) end

    -- if awesome.startup and
    --   not c.size_hints.user_position
    --   and not c.size_hints.program_position then
    --     -- Prevent clients from being unreachable after screen count changes.
    --     awful.placement.no_offscreen(c)
    -- end
end)

-- apply rounded corners to all clients
client.connect_signal("manage", function (c)
    c.shape = function(cr, w, h)
        gears.shape.rounded_rect(cr, w, h, beautiful.border_radius)
    end
end)

client.connect_signal("property::floating", function(c)

  -- Make sure to have an instance name
  -- It is here to prevent errors on startup or every after awesome.restart()
  if c.instance then
    -- Center all clients except QuakeTerminal and the clients with skip_center property
    if not c.skip_center then
      awful.placement.centered(c)
    end
  end
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
        and awful.client.focus.filter(c) then
        client.focus = c
    end
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}