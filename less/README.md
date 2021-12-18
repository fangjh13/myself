首先安装 `pygments`

```
pipx install pygments
```

将 `.lessfilter` 放到用户 home 目录 `~/.lessfilter`

```
chmod u+x  ~/.lessfilter
```

`~/.bashrc` 或者 `~/.zshrc` 增加

```
export LESS='-R'
export LESSOPEN='|~/.lessfilter %s'
```

参考：[https://superuser.com/questions/117841/when-reading-a-file-with-less-or-more-how-can-i-get-the-content-in-colors](https://superuser.com/questions/117841/when-reading-a-file-with-less-or-more-how-can-i-get-the-content-in-colors)
