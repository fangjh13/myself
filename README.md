# 分享自用配置文件
-------

## Sublime Text

> 所有`User`文件夹里面的文件

### 插件介绍

- AdvancedNewFile - 新建文件
- All Autocomplete - 对全部打开的文件进行查找补全
- Anaconda - python专用
- BracketHighlighter - 括号匹配高亮
- Emmet - 前端神器
- Git - git工具
- Markdown Preview - markdown预览
- Package Control - 包管理工具
- SideBarEnhancements - 增强sidebar右键
- Focus File on Siderbar - 选中当前 tab 时 SideBar 同步高亮到相应的目录位置
- TrailingSpaces - 高亮多余的空格，并在每次保存时删去
- Vintageou - vim模拟插件

##### 使用说明

1. 安装[`SUBLIME TEXT 3`](https://www.sublimetext.com/)
2. 安装[`Package Control`](https://packagecontrol.io/installation#Simple)
3. clone之后软链接`User`文件夹或者替换`sublime`的用户文件ubuntu默认在`~/.config/sublime-text-3/Packages`

---

## vim

> `.vimrc`文件

#### 使用

- 替换用户目录下的`.vimrc`文件

---

## AutoHotKey(windows)

> `AutoHotKey.ahk`

#### 使用

- 安装[AutoHotKey](http://ahkscript.org/)
- 开机启动`AutoHotKey.ahk`（管理员）

---

## aria2

> aria2  配置文件

#### 使用

- 修改配置文件`dir`下载目录，放在固定目录。 使用`aria2c --conf-path=path -D`启动，默认`~/.aria2/aria2.conf`。

---

## vsftpd

> vsftpd 配置文件，配置匿名下载

- 安装`vsftpd`，替换`/etc/vsftpd.conf`

---

## screen

> screen 用户配置文件 存放在`~/.screenrc`

---

## zsh
> mac上`.zshrc`配置文件(使用oh-my-zsh和zsh-autosuggestions)

---

## tmux
> `~/.tmux.conf`配置文件

因为用到了第三方主题需要先安装`git clone https://github.com/jimeh/tmux-themepack.git ~/.tmux-themepack`

---

## manjaro 
Arch i3中的配置文件
- `.zshrc`在manjaro使用urxvt上zsh的配置文件
- `config`i3桌面配置文件，软链接到`~/.i3/config`
- `Xresources`创建软链接到`~/.Xresources`
- `i3lock.service`自定义睡眠锁屏(i3lock)systemd服务，放入`/etc/systemd/system/`文件夹下，`systemctl enable i3lock.service`设置开机启动
- `bin`一些配置桌面的脚本
  + `monitor` 配置外置显示器，加入`~/.i3/config`中开机调用
  + `print-colors.sh`测试URxvt颜色显示

---

## aliases
自用alias，在`.bashrc`或`.zshrc`中source

---

## miAd
屏蔽小米电视广告，适用于dnsmasq

---

## hammerspoon
Hammerspoon配置文件

```
├── Spoons                  官方依赖包
│   ├── ModalMgr.spoon      modal 依赖模块
│   │   ├── docs.json
│   │   └── init.lua
│   └── WinWin.spoon        窗口管理依赖
│       ├── docs.json
│       └── init.lua
├── app_launcher            应用快捷键
│   └── init.lua
├── clipboard               历史剪切板
│   └── init.lua
├── ime                     输入法自动切换
│   └── init.lua
├── init.lua
├── switch                  多显示器窗口切换
│   └── init.lua
├── usb                     记录usb日志
│   └── init.lua
└── window                  窗口快捷管理
    └── init.lua
```

安装 Hammerspoon，将`.hammerspoon`软连接到`~/.hammerspoon`用户目录下

---

## hyper
Hyper.js 终端配置文件 `~/.hyper.js` 在mac上测试通过

---

## less
lessfilter 配置 ，具体配置参见内部文档

```
.
├── .lessfilter
└── README.md
```

## nvim
neovim 配置文件夹 将`nvim`软链接到`~/.config/nvim`用户home文件夹下
