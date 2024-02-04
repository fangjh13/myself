-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

config.color_scheme = "Dracula"
config.use_fancy_tab_bar = false

-- How many lines of scrollback you want to retain per tab
config.scrollback_lines = 100000

-- Window
config.window_background_opacity = 1
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}
config.window_decorations = "RESIZE"

-- font
config.font = wezterm.font_with_fallback({
  -- { family = "Hack Nerd Font Mono", weight = "Bold" },
  { family = "Hack Nerd Font Mono" },
  { family = "HarmonyOS Sans" },
})
-- config.font = wezterm.font("LXGW WenKai", { weight = "Bold" })
config.font_size = 12.5

-- hide tab bar
config.hide_tab_bar_if_only_one_tab = true

-- keymap
local keymaps = {
  { key = "z", mods = "ALT", action = wezterm.action.ShowLauncher },
  {
    key = '"',
    mods = "CTRL|SHIFT|ALT",
    action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
  },
  -- Alt-b as backward-word
  { key = "b", mods = "ALT", action = wezterm.action({ SendString = "\x1bb" }) },
  -- Alt-f as forward-word
  { key = "f", mods = "ALT", action = wezterm.action({ SendString = "\x1bf" }) },
  -- Alt-d as delete-word
  { key = "d", mods = "ALT", action = wezterm.action({ SendString = "\x1bd" }) },
}
config.keys = keymaps

if wezterm.target_triple:find("darwin") then
  config.native_macos_fullscreen_mode = true
end
-- and finally, return the configuration to wezterm
return config
