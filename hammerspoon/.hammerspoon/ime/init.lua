local function switch2IME(ime)
    if hs.keycodes.currentSourceID() ~= ime then
    	hs.keycodes.currentSourceID(ime)
    end
end

local function Chinese()
    -- local ime = "com.apple.inputmethod.SCIM.Shuangpin"
    -- local ime = "com.sogou.inputmethod.sogou.pinyin"
    -- local ime = "com.apple.inputmethod.SCIM.WBX"  -- 五笔
    local ime = "im.rime.inputmethod.Squirrel.Hans" -- 鼠鬚管
    switch2IME(ime)
end

local function English()
    local ime = "com.apple.keylayout.ABC"
    switch2IME(ime)
end

-- app to expected ime config
local app2Ime = {
    {'/Applications/iTerm.app', 'English'},
    {'/Applications/Hyper.app', 'English'},
    {'/Applications/Xcode.app', 'English'},
    {'/Applications/WezTerm.app', 'English'},
    {'/Applications/Visual Studio Code.app', 'English'},
    {'/Applications/PyCharm.app', 'English'},
    {'/Applications/Firefox.app', 'English'},
    {'/System/Volumes/Preboot/Cryptexes/App/System/Applications/Safari.app', 'English'},
    {'/Applications/Safari.app', 'English'},
    {'/Applications/Google Chrome.app', 'English'},
    {'/System/Library/CoreServices/Finder.app', 'English'},
    {'/Applications/DingTalk.app', 'Chinese'},
    {'/Applications/WeChat.app', 'Chinese'},
    {'/Applications/System Preferences.app', 'English'},
    {'/Applications/Preview.app', 'Chinese'},
    {'/Applications/Raycast.app', 'English'},
}

function updateFocusAppInputMethod()
    local ime = 'English'
    local focusAppPath = hs.window.frontmostWindow():application():path()
    for index, app in pairs(app2Ime) do
        local appPath = app[1]
        local expectedIme = app[2]

        if focusAppPath == appPath then
            ime = expectedIme
            break
        end
    end

    if ime == 'English' then
        English()
    else
        Chinese()
    end
end

-- helper hotkey to figure out the app path and name of current focused window
hs.hotkey.bind({'ctrl', 'cmd'}, ".", function()
	local data = "App path:        "
    ..hs.window.focusedWindow():application():path()
    .."\n"
    .."App name:      "
    ..hs.window.focusedWindow():application():name()
    .."\n"
    .."IM source id:  "
    ..hs.keycodes.currentSourceID()
    print("\n" .. data)
    hs.alert.show(data)
end)

-- Handle cursor focus and application's screen manage.
function applicationWatcher(appName, eventType, appObject)
    if (eventType == hs.application.watcher.activated) then
        updateFocusAppInputMethod()
    end
end

appWatcher = hs.application.watcher.new(applicationWatcher)
appWatcher:start()
