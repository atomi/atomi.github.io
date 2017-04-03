---
title: "Changing Cursor Color in gnome-terminal and tmux"
date: "2016-01-30"
---

If you need to change the cursor color of your gnome-terminal you can use the following command:

```bash
echo -ne "\e]12;orange\a"
```

Change `orange` to your choice of color name or hex color code.

If you use gnome-terminal with tmux, gnome-terminal does not support the default color reset code `\033]112\007` that tmux uses. Fortunately, tmux allows you to override the default color reset by using `terminal-overrides`
Here is the configuration command I came up with for my `.tmux.conf` file (where everything following `cr=` is the color reset code):

```bash
set-option -ag terminal-overrides ',xterm*:Cr=\E]12;gray\007'
```

In this case, I’ve set color reset to gray which seems to work without issue.

Reference:  https://github.com/tmux/tmux/issues/266 :)
