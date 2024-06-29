launcherHotkey = {'option'}


applist = {
    {shortcut = '1',appname = 'Finder'},
    {shortcut = '2',appname = 'Google Chrome'},
    {shortcut = '3',appname = '/Applications/WezTerm.app'},
    {shortcut = '4',appname = 'WeChat'},
    {shortcut = '5',appname = 'PyCharm'},
}

hs.fnutils.each(applist, function(entry)
    hs.hotkey.bind(launcherHotkey, entry.shortcut, entry.appname, function()
        hs.application.launchOrFocus(entry.appname)
        hs.alert.closeAll()
    end)
end)

