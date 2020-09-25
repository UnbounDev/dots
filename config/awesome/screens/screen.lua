-- Module contains all logic necessary to assemble a single screen.
-- Used by other files in this directory for screen assembly across
-- various physical, and virtual, display configurations.

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")

-- Theme handling library
local beautiful = require("beautiful")

-- Widget and layout library
local wibox = require("wibox")

local menu_artifacts = require("screens.menu")

-- {{{ Helper functions
local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end
-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

local function client_menu_toggle_fn()
    local instance = nil

    return function ()
        if instance and instance.wibox.visible then
            instance:hide()
            instance = nil
        else
            instance = awful.menu.clients({ theme = { width = 250 } })
        end
    end
end

local function is_virtual(s)
    local isvirtual = true
    for k,v in pairs(s.outputs or {}) do
      -- assume that screens w/o xrandr outputs are virtual
      isvirtual = false
    end
    return isvirtual
end

local function print_screen_info(s)
    local isvirtual = is_virtual(s)
    print(string.format("INFO=> screen index:%s, virtual:%s, dpi:%s, geo.x:%s, geo.y:%s, geo.width:%s, geo.height:%s",
      s.index, isvirtual, s.dpi, s.geometry.x, s.geometry.y, s.geometry.width, s.geometry.height
    ))
    for k,v in pairs(s.outputs or {}) do
      print(string.format("INFO=> display name:%s, mm_width:%s, mm_width:%s", k, s.outputs[k].mm_width, s.outputs[k].mm_height))
    end
end
-- }}}

-- ===================================================================

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
  awful.button({ }, 1, function(t) t:view_only() end),
  awful.button({ modkey }, 1, function(t)
      if client.focus then
          client.focus:move_to_tag(t)
      end
  end),
  awful.button({ }, 3, awful.tag.viewtoggle),
  awful.button({ modkey }, 3, function(t)
      if client.focus then
          client.focus:toggle_tag(t)
      end
  end),
  awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
  awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end))

local tasklist_buttons = gears.table.join(
  awful.button({ }, 1, function (c)
      if c == client.focus then
          c.minimized = true
      else
          -- Without this, the following
          -- :isvisible() makes no sense
          c.minimized = false
          if not c:isvisible() and c.first_tag then
              c.first_tag:view_only()
          end
          -- This will also un-minimize
          -- the client, if needed
          client.focus = c
          c:raise()
      end
  end),
  awful.button({ }, 3, client_menu_toggle_fn()),
  awful.button({ }, 4, function ()
      awful.client.focus.byidx(1)
  end),
  awful.button({ }, 5, function ()
      awful.client.focus.byidx(-1)
  end))

-- ===================================================================

local assemble = function(s, options)
    -- log start of initialization
    print("INFO=> assembling screen")
    print_screen_info(s)

    local opt = {
        taglist = true,
        tasklist = true,
        wibox_rightwidget = true,

        taglist_start_index = 1,
        taglist_end_index = nil,

        wibox_launcher = true,
        wibox_keyboardlayout = true,
        wibox_systray = true,
        wibox_textclock = true
    }
    for k,v in pairs(options or {}) do opt[k] = v end

    -- Wallpaper
    set_wallpaper(s)

    ---- Move assigned tags to this screen.
    --local first_tag = true
    --for k,v in pairs({ table.unpack(root.tags(), opt.taglist_start_index, opt.taglist_end_index) }) do
    --  print(string.format("INFO=> assign tag `%s`", v.name))
    --  v.screen = s
    --  if first_tag then
    --    v.selected = true
    --    first_tag = false
    --  end
    --end

    --awful.tag({ table.unpack(user.tags.names, opt.taglist_start_index, opt.taglist_end_index) },
    --  s,
    --  { table.unpack(user.tags.layouts, opt.taglist_start_index, opt.taglist_end_index) })

    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    local mylayoutbox = awful.widget.layoutbox(s)
    mylayoutbox:buttons(gears.table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))

    -- Create a taglist widget: https://awesomewm.org/apidoc/widgets/awful.widget.taglist.html
    local mytaglist = awful.widget.taglist({ screen = s, filter = awful.widget.taglist.filter.all, buttons = taglist_buttons })
    -- Create a tasklist widget: https://awesomewm.org/apidoc/widgets/awful.widget.tasklist.html
    -- local mytasklist = awful.widget.tasklist({ screen = s, filter = awful.widget.tasklist.filter.currenttags, buttons = tasklist_buttons })
    local mytasklist = awful.widget.tasklist {
        screen   = s,
        filter   = awful.widget.tasklist.filter.currenttags,
        buttons  = tasklist_buttons,
        layout   = {
            spacing_widget = {
                {
                    forced_width  = beautiful.tasklist_spacing,
                    forced_height = beautiful.tasklist_spacing * 5,
                    thickness     = 1,
                    color         = beautiful.tasklist_fg_normal,
                    widget        = wibox.widget.separator
                },
                valign = 'center',
                halign = 'center',
                widget = wibox.container.place,
            },
            spacing = beautiful.tasklist_spacing,
            layout  = wibox.layout.flex.horizontal
        },
        -- inherit base theme styles via the widget_template
        widget_template = {
        {
          {
            {
              {
                id     = 'icon_role',
                widget = wibox.widget.imagebox,
              },
              margins = 2,
              widget  = wibox.container.margin,
            },
            {
              id     = 'text_role',
              widget = wibox.widget.textbox,
            },
            layout = wibox.layout.fixed.horizontal,
          },
          left  = 10,
          right = 10,
          widget = wibox.container.margin
        },
        id     = 'background_role',
        widget = wibox.container.background,
      }
    }

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create the wibox: https://awesomewm.org/apidoc/popups_and_bars/awful.wibar.html
    s.mywibox = awful.wibar({ position = "top", screen = s })
    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        opacity = beautiful.wibar_opacity or 1,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            { visible = opt.wibox_launcher, widget = menu_artifacts.get_launcher() },
            mytaglist,
            s.mypromptbox,
        },
        mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            { visible = opt.wibox_keyboardlayout, widget = awful.widget.keyboardlayout() },
            { visible = opt.wibox_systray, widget = wibox.widget.systray() },
            { visible = opt.wibox_textclock, widget = wibox.widget.textclock() },
            mylayoutbox,
        },
    }
end

local reset = function()
  local fakes = {}
  for s in screen do
    s.mywibox:remove()
    print(s.index, s.geometry.x, s.geometry.y, s.geometry.width, s.geometry.height, tostring(s.outputs))
    -- hack to see if the current screen is a fake
    local screen_name = nil
    for k,v in pairs(s.outputs) do
        screen_name = k
    end
    if s.outputs[screen_name] then
      print(screen_name)
      print(s.outputs[screen_name].mm_width, s.outputs[screen_name].mm_height)
      print(screen_width, screen_height)
    end
    if not s.outputs[screen_name] then
      fakes[s.index] = s.index
    end
  end
  for k,v in pairs(fakes) do
    screen[v]:fake_remove()
  end

  awful.tag({}, screen[1], {})
  -- for t in screen[1].tags() do
  --   t:delete()
  -- end
  local geo = screen[1].geometry
  screen[1]:fake_resize(geo.x,geo.y,geo.width +geo.width, geo.height)
  --screen[1]:fake_remove()
  require("screens.Rx1")
end

return { assemble = assemble, reset = reset, print_screen_info = print_screen_info, is_virtual = is_virtual }
