-- Pull in the wezterm API
local wezterm = require 'wezterm'
local act = wezterm.action

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0
}

config.hide_tab_bar_if_only_one_tab = true

-- This is where you actually apply your config choices

-- -- For example, changing the color scheme:
-- config.color_scheme = 'AdventureTime'

-- config.keys = {
--   -- paste from the clipboard
--   { key = 'V', mods = 'CTRL', action = act.PasteFrom 'Clipboard' },
-- }

config.color_scheme = 'tokyonight_night'


-- and finally, return the configuration to wezterm
return config


-- return {
-- 	font = wezterm.font 'JetBrains Mono',
-- 	color_scheme = 'Batman',
-- 	scrollback_lines = 3500,
-- }

