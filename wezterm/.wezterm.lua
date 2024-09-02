-- Pull in the wezterm API
local wezterm = require 'wezterm'
local mux = wezterm.mux

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices
config.font = wezterm.font 'YaHei Consolas Hybrid'
config.font_size = 15
config.scrollback_lines = 50000
config.use_ime = true
config.exit_behavior = 'CloseOnCleanExit'
config.enable_tab_bar = false
config.window_decorations = "RESIZE" 
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}
wezterm.on('gui-startup', function(cmd)
  local tab, pane, window = mux.spawn_window(cmd or {})
  window:gui_window():maximize()
end)
-- For example, changing the color scheme:
config.color_scheme = 'Dracula+'

-- and finally, return the configuration to wezterm
return config
