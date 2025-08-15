launcherHotkey = { "option" }

applist = {
  { shortcut = "1", appname = "Finder" },
  { shortcut = "2", appname = "Google Chrome" },
  { shortcut = "3", appname = "/Applications/WezTerm.app" },
}

hs.fnutils.each(applist, function(entry)
  hs.hotkey.bind(launcherHotkey, entry.shortcut, entry.appname, function()
    hs.application.launchOrFocus(entry.appname)
    hs.alert.closeAll()
  end)
end)

-- use `command+shift+p` open/hide keepassxc
hs.hotkey.bind({ "cmd", "shift" }, "p", function()
  local bundleID = "org.keepassxc.keepassxc"
  local frontmostApp = hs.application.frontmostApplication()
  if frontmostApp and frontmostApp:bundleID() == bundleID then
    hs.eventtap.keyStroke({ "cmd" }, "h")
  else
    hs.application.launchOrFocusByBundleID(bundleID)
  end
end)
