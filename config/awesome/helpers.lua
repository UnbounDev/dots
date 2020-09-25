-- Functions that you use more than once and in different files would
-- be nice to define here.
local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local wibox = require("wibox")

local naughty = require("naughty")

local helpers = {}

local volume_get_cmd = "pactl list sinks | grep -m 1 'Volume:' | awk '{print $5}' | cut -d '%' -f1 "
local muted_get_cmd = "pactl list sinks | grep -m 1 'Mute:' | awk '{printf \"%s\", $2}'"
local volume_notif
function helpers.volume_control(step)
    local cmd
    if step == 0 then
        -- Toggle mute
        cmd = "pactl set-sink-mute @DEFAULT_SINK@ toggle && "..muted_get_cmd
        awful.spawn.with_shell(cmd)
        -- awful.spawn.easy_async_with_shell(cmd, function(out)
        --     local text
        --     if out:match('yes') then
        --         text = "Muted"
        --     else
        --         text = "Unmuted"
        --     end
        --     if not sidebar.visible then
        --         if volume_notif and not volume_notif.is_expired then
        --             volume_notif.message = text
        --         else
        --             volume_notif = naughty.notification({ title = "Volume", message = text, timeout = 2 })
        --         end
        --     end
        -- end)
    else
        if step > 0 then
            sign = "+"
        else
            sign = ""
        end
        cmd = "pactl set-sink-mute @DEFAULT_SINK@ 0 && pactl set-sink-volume @DEFAULT_SINK@ "..sign..tostring(step).."% && "..volume_get_cmd
        awful.spawn.easy_async_with_shell(cmd, function(out)
            print(out)
            out = out:gsub('^%s*(.-)%s*$', '%1')
            print(out)
            if volume_notif and not volume_notif.is_expired then
	        volume_notif.message = out
	    end
            -- if not sidebar.visible then
            --     if volume_notif and not volume_notif.is_expired then
            --         volume_notif.message = out
            --     else
            --         volume_notif = naughty.notification({ title = "Volume", message = out, timeout = 2 })
            --     end
            -- end

        end)
    end
end

function helpers.run_or_raise(match, move, spawn_cmd, spawn_args)
    local matcher = function (c)
        return awful.rules.match(c, match)
    end

    -- Find and raise
    local found = false
    for c in awful.client.iterate(matcher) do
        found = true
        c.minimized = false
        if move then
            c:move_to_tag(mouse.screen.selected_tag)
            client.focus = c
            c:raise()
        else
            c:jump_to()
        end

        -- -- Return if found
        -- return
        -- -- This would normally work, but some terminals (*cough* termite)
        -- -- create 2 instances of the same class, for just one window.
        -- -- So it is not reliable. We will use the helper variable "found"
        -- -- instead in order to determine if we have raised the window.
    end

    -- Spawn if not found
    if not found then
        awful.spawn(spawn_cmd, spawn_args)
    end
end

-- Create rounded rectangle shape (in one line)
helpers.rrect = function(radius)
    return function(cr, width, height)
        gears.shape.rounded_rect(cr, width, height, radius)
    end
end

helpers.prrect = function(radius, tl, tr, br, bl)
    return function(cr, width, height)
        gears.shape.partially_rounded_rect(cr, width, height, tl, tr, br, bl, radius)
    end
end

function helpers.colorize_text(txt, fg)
    return "<span foreground='" .. fg .."'>" .. txt .. "</span>"
end

function helpers.pad(size)
    local str = ""
    for i = 1, size do
        str = str .. " "
    end
    local pad = wibox.widget.textbox(str)
    return pad
end

-- Add a hover cursor to a widget by changing the cursor on
-- mouse::enter and mouse::leave
-- You can find the names of the available cursors by opening any
-- cursor theme and looking in the "cursors folder"
-- For example: "hand1" is the cursor that appears when hovering over
-- links
function helpers.add_hover_cursor(w, hover_cursor)
    local original_cursor = "left_ptr"

    w:connect_signal("mouse::enter", function ()
        local w = _G.mouse.current_wibox
        if w then
            w.cursor = hover_cursor
        end
    end)

    w:connect_signal("mouse::leave", function ()
        local w = _G.mouse.current_wibox
        if w then
            w.cursor = original_cursor
        end
    end)
end

return helpers
