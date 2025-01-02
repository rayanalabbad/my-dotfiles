local wezterm = require 'wezterm'
local config = {}

config.window_frame = {
    font = wezterm.font { family = 'Inter', weight = 'Bold' },
    font_size = 12.0,
    active_titlebar_bg = '#202330',
    inactive_titlebar_bg = '#202330',
}

config.colors = {
    tab_bar = {
        active_tab = {
            bg_color = '#16161e',
            fg_color = '#787c99',
            intensity = 'Normal',
            underline = 'None',
            italic = false,
            strikethrough = false,
        },

        inactive_tab = {
            bg_color = '#202330',
            fg_color = '#787c99',
        },

        inactive_tab_hover = {
            bg_color = '#16161e',
            fg_color = '#787c99',
            intensity = 'Bold'
        },

        new_tab = {
            bg_color = '#292e42',
            fg_color = '#787c99',
        },

        new_tab_hover = {
            bg_color = '#292e42',
            fg_color = '#787c99',
            italic = true,
        },
    },
}

config.hide_tab_bar_if_only_one_tab = true
config.default_cursor_style = 'SteadyBar'
config.window_decorations = 'RESIZE'
config.color_scheme = 'Tokyo Night'
config.font = wezterm.font 'BitstromWera Nerd Font Mono'
config.font_size = 14.0
config.window_background_opacity = 0.6
config.macos_window_background_blur = 20

return config
