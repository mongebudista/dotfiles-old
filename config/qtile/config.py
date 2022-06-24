# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

from libqtile import qtile
from libqtile import bar, layout, widget, hook
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from spotify import Spotify
import subprocess
import os

mod = "mod4"
terminal = "alacritty"

keys = [
    # A list of available commands that can be bound to keys can be found
    # at https://docs.qtile.org/en/latest/manual/config/lazy.html
    # Switch between windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key(
        [mod],
        "space",
        lazy.layout.next(),
        desc="Move window focus to other window"
    ),  # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key([mod, "shift"],
        "h",
        lazy.layout.shuffle_left(),
        desc="Move window to the left"),
    Key([mod, "shift"],
        "l",
        lazy.layout.shuffle_right(),
        desc="Move window to the right"),
    Key([mod, "shift"],
        "j",
        lazy.layout.shuffle_down(),
        desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "control"],
        "h",
        lazy.layout.grow_left(),
        desc="Grow window to the left"),
    Key([mod, "control"],
        "l",
        lazy.layout.grow_right(),
        desc="Grow window to the right"),
    Key([mod, "control"],
        "j",
        lazy.layout.grow_down(),
        desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key(
        [mod, "shift"],
        "Return",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod, "shift"], "c", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "shift"], "w", lazy.spawn("vivaldi-stable"), desc="Browser"),
    Key([mod, "shift"], "d", lazy.spawn("dmenu_run"), desc="DMenu"),
    Key([mod, "shift"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "shift"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod], "t", lazy.spawn("kitty -e dooit")),
    Key([mod], "p", lazy.spawn(terminal + " -e ncmpcpp")),
    Key([mod], "e", lazy.spawn("thunar")),
    Key([mod], "f", lazy.window.toggle_fullscreen(), desc='toggle fullscreen'),
    Key([mod], "x",
        lazy.spawn("/home/jarco/.config/qtile/rofi/bin/powermenu")),

    # Media Keys
    Key([], "XF86AudioPlay", lazy.spawn("playerctl play-pause")),
    Key([], "XF86AudioPause", lazy.spawn("playerctl pause")),
    Key([], "XF86AudioNext", lazy.spawn("playerctl next")),
    Key([], "XF86AudioPrev", lazy.spawn("playerctl previous")),
    Key([mod, "control"], "l", lazy.spawn("betterlockscreen -l")),
    
    # Wallpaper
    Key([mod, "shift"], "n", lazy.spawn("variety -p")),
    Key([mod, "shift"], "m", lazy.spawn("variety -n")),
]

groups = []
group_names = ["1", "2", "3", "4", "5", "6", "7", "8"]
group_extranames = ["www", "vim", "sys", "chat", "mus", "xyz", "vid"]
group_labels = ["", "", "", "", "", "", "", ""]

for i in range(len(group_extranames)):
    groups.append(Group(
        name=group_names[i],
        label=group_labels[i],
    ))

for i in groups:
    keys.extend([
        # mod1 + letter of group = switch to group
        Key(
            [mod],
            i.name,
            lazy.group[i.name].toscreen(),
            desc="Switch to group {}".format(i.name),
        ),
        # mod1 + shift + letter of group = switch to & move focused window to group
        Key(
            [mod, "shift"],
            i.name,
            lazy.window.togroup(i.name, switch_group=True),
            desc="Switch to & move focused window to group {}".format(i.name),
        ),
        # Or, use below if you prefer not to switch to that group.
        # # mod1 + shift + letter of group = move focused window to group
        # Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
        #     desc="move focused window to group {}".format(i.name)),
    ])

layouts = [
    layout.Columns(border_focus_stack=["#d75f5f", "#8f3d3d"], border_width=4),
    layout.Max(),
    # Try more layouts by unleashing below layouts.
    # layout.Stack(num_stacks=2),
    # layout.Bsp(),
    # layout.Matrix(),
    # layout.MonadTall(),
    # layout.MonadWide(),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]

colors = [["#282c34", "#282c34"], ["#1c1f24",
                                   "#1c1f24"], ["#dfdfdf", "#dfdfdf"],
          ["#ff6c6b", "#ff6c6b"], ["#79eb95",
                                   "#79eb95"], ["#da8548", "#da8548"],
          ["#51afef", "#51afef"], ["#ede180",
                                   "#ede180"], ["#000c18", "#000c18"],
          ["#52caff", "#52caff"], ["#ed8b40", "#ed8b40"]]

widget_defaults = dict(font="Ubuntu Mono Bold",
                       fontsize=12,
                       padding=2,
                       background=colors[2])

extension_defaults = widget_defaults.copy()


def init_widgets_list():
    widgets_list = [
        widget.Sep(linewidth=0,
                   padding=6,
                   foreground=colors[2],
                   background=colors[8]),
        widget.Image(
            filename="~/.config/qtile/icons/imp.png",
            margin_y=1,
            background=colors[8],
            scale="False",
            mouse_callbacks={
                'Button1':
                lambda: qtile.cmd_spawn("rofi -modi drun,run -show drun")
            }),
        widget.Sep(linewidth=0,
                   padding=6,
                   foreground=colors[2],
                   background=colors[8]),
        widget.GroupBox(font="Ubuntu Nerd Font",
                        fontsize=12,
                        margin_y=3,
                        margin_x=0,
                        padding_y=5,
                        padding_x=3,
                        borderwidth=3,
                        active=colors[7],
                        inactive=colors[2],
                        rounded=False,
                        highlight_color=colors[8],
                        highlight_method="line",
                        this_current_screen_border=colors[9],
                        this_screen_border=colors[4],
                        other_current_screen_border=colors[6],
                        other_screen_border=colors[4],
                        foreground=colors[2],
                        background=colors[8]),
        widget.TextBox(text='|',
                       font="Ubuntu Mono",
                       background=colors[8],
                       foreground='474747',
                       padding=2,
                       fontsize=14),
        widget.CurrentLayoutIcon(
            custom_icon_paths=[os.path.expanduser("~/.config/qtile/icons")],
            foreground=colors[2],
            background=colors[8],
            padding=0,
            scale=0.7),
        widget.CurrentLayout(foreground=colors[2],
                             background=colors[8],
                             padding=5),
        widget.TextBox(text='|',
                       font="Ubuntu Mono",
                       background=colors[8],
                       foreground='474747',
                       padding=2,
                       fontsize=14),
        widget.WindowName(foreground=colors[2],
                          background=colors[8],
                          max_chars=30,
                          padding=0),
        widget.Sep(linewidth=0,
                   padding=10,
                   foreground=colors[2],
                   background=colors[8]),
        Spotify(background=colors[8], max_chars=25),
        widget.Sep(linewidth=0,
                   padding=300,
                   foreground=colors[2],
                   background=colors[8]),
        widget.Battery(battery="BAT1",
                       discharge_char=" ",
                       font="Ubuntu Nerd Font",
                       charge_char=" ",
                       show_short_text=False,
                       empty_char="x",
                       full_char=" ",
                       fontsize=12,
                       format='{char}  {percent:2.0%}',
                       background=colors[8],
                       foreground=colors[2],
                       update_interval=30),
        widget.TextBox(text='×',
                       font="Ubuntu Nerd Font",
                       background=colors[8],
                       foreground=colors[6],
                       padding=5,
                       fontsize=14),
        widget.PulseVolume(foreground=colors[2],
                           background=colors[8],
                           limit_max_volume=False,
                            font="Ubuntu Nerd Font",
                           fmt=' {}',
                           padding=5),
        widget.TextBox(text='×',
                       font="Ubuntu Nerd Font",
                       background=colors[8],
                       foreground=colors[6],
                       padding=5,
                       fontsize=14),
        widget.Clock(foreground=colors[2],
                     background=colors[8],
                     format="%H:%M "),
        widget.TextBox(text='×',
                       font="Ubuntu Nerd Font",
                       background=colors[8],
                       foreground=colors[6],
                       padding=5,
                       fontsize=14),
        widget.Systray(background=colors[8], padding=2),
    ]
    return widgets_list


screens = [Screen(top=bar.Bar(widgets=init_widgets_list(), size=20))]

# Drag floating layouts.
mouse = [
    Drag([mod],
         "Button1",
         lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod],
         "Button3",
         lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False

floating_layout = layout.Floating(float_rules=[
    # Run the utility of `xprop` to see the wm class and name of an X client.
    *layout.Floating.default_float_rules,
    Match(wm_class="confirmreset"),  # gitk
    Match(wm_class="makebranch"),  # gitk
    Match(wm_class="maketag"),  # gitk
    Match(wm_class="ssh-askpass"),  # ssh-askpass
    Match(title="branchdialog"),  # gitk
    Match(title="pinentry"),  # GPG key password entry
])
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True


# Autostart applications
@hook.subscribe.startup
def start_once():
    home = os.path.expanduser('~')
    subprocess.call([home + '/.config/qtile/autostart.sh'])


# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "qtile"
