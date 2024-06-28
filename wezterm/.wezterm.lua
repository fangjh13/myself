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

-- How many lines of scrollback you want to retain per tab
config.scrollback_lines = 100000

-- Window
config.window_background_opacity = 1
config.window_padding = {
  left = "0.5cell",
  right = "0.5cell",
  top = "0.5cell",
  bottom = "0cell",
}
config.window_decorations = "RESIZE"

-- font
config.font = wezterm.font_with_fallback({
  -- { family = "Hack Nerd Font Mono", weight = "Bold" },
  { family = "Hack Nerd Font Mono" },
  { family = "HarmonyOS Sans SC" },
})
-- config.font = wezterm.font("LXGW WenKai", { weight = "Bold" })
if wezterm.target_triple == "aarch64-apple-darwin" then
  config.font_size = 13.5
else
  config.font_size = 10
end

-- Tab Bar
config.use_fancy_tab_bar = false
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
  -- CTRL-SHIFT-l activates the debug overlay
  { key = "L", mods = "CTRL", action = wezterm.action.ShowDebugOverlay },
}
config.keys = keymaps

if wezterm.target_triple:find("darwin") then
  config.native_macos_fullscreen_mode = true
end

-- and finally, return the configuration to wezterm
return config
