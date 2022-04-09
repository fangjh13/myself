function acCallback()
  if hs.battery.powerSource() == "AC Power" and hs.brightness.get() ~= 100 then
	  hs.brightness.set(100)
  end
end



batterWatcher = hs.battery.watcher.new(acCallback)
print("auto max brightness register")
batterWatcher:start()
