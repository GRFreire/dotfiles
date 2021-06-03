#     ____ ____  _____         _
#    / ___|  _ \|  ___| __ ___(_)_ __ ___
#   | |  _| |_) | |_ | '__/ _ \ | '__/ _ \     Guilherme Rugai Freire
#   | |_| |  _ <|  _|| | |  __/ | | |  __/     https://grfreire.com
#    \____|_| \_\_|  |_|  \___|_|_|  \___|     https://github.com/GRFreire
#

import time
import os
import subprocess
from typing import List  # noqa: F401

from libqtile import bar, layout, widget, qtile, hook
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy

MOD = "mod4"
TERMINAL = "alacritty"
LAUNCHER = "rofi -show drun"
WEB = "google-chrome"
FILE_MANAGER = "nautilus -w"
POWER_MENU = os.path.expanduser(
    "~/.local/bin/spm"
)  # https://github.com/GRFreire/simple-power-menu

keys = [
    # Launch programs
    Key([MOD], "Return", lazy.spawn(TERMINAL), desc="Launch terminal"),
    Key([MOD], "r", lazy.spawn(LAUNCHER), desc="Open application launcher"),
    Key([MOD], "w", lazy.spawn(WEB), desc="Open web browser"),
    Key([MOD], "f", lazy.spawn(FILE_MANAGER), desc="Open file manager"),
    # Closes window.
    Key([MOD, "shift"], "c", lazy.window.kill(), desc="Kill focused window"),
    # Switch between windows
    Key([MOD], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([MOD], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([MOD], "j", lazy.layout.down(), desc="Move focus down"),
    Key([MOD], "k", lazy.layout.up(), desc="Move focus up"),
    Key([MOD], "space", lazy.layout.next(), desc="Move window focus to other window"),
    # Move windows between left/right columns.
    Key(
        [MOD, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"
    ),
    Key(
        [MOD, "shift"],
        "l",
        lazy.layout.shuffle_right(),
        desc="Move window to the right",
    ),
    Key([MOD, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([MOD, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    # Grow and shrink windows.
    Key(
        [MOD, "control"], "h", lazy.layout.shrink_main(), desc="Grow window to the left"
    ),
    Key(
        [MOD, "control"], "l", lazy.layout.grow_main(), desc="Grow window to the right"
    ),
    Key([MOD, "control"], "j", lazy.layout.shrink_main(), desc="Grow window down"),
    Key([MOD, "control"], "k", lazy.layout.grow_main(), desc="Grow window up"),
    Key([MOD], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    # Toggle between different layouts.
    Key([MOD], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    # QTile
    Key([MOD, "control"], "r", lazy.restart(), desc="Restart Qtile"),
    Key([MOD, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
]

group_names = [
    ("WWW", {"layout": "monadtall"}),
    ("DEV", {"layout": "max"}),
    ("GMG", {"layout": "max"}),
    ("SYS", {"layout": "ratiotile"}),
    ("DOC", {"layout": "monadtall"}),
    ("CHAT", {"layout": "max"}),
    ("MUS", {"layout": "max"}),
    ("VID", {"layout": "monadtall"}),
    ("EDT", {"layout": "max"}),
]

groups = [Group(name, **kwargs) for name, kwargs in group_names]

for i, (name, kwargs) in enumerate(group_names, 1):
    # Switch to another group
    keys.append(Key([MOD], str(i), lazy.group[name].toscreen()))

    # Send current window to another group
    keys.append(Key([MOD, "shift"], str(i), lazy.window.togroup(name)))


colors = {
    "background": "#272A34",
    "background_highlight": "#363D54",
    "text": "#EAEDF6",
    "accent_color_dark": "#1C325E",
    "accent_color_light": "#49659C",
    "accent_highlight": "#214897",
    "active": "#9EBEFF",
    "inactive": "#B4C5E4",
}

layout_theme = {
    "border_width": 2,
    "margin": 6,
    "border_focus": colors["accent_color_light"],
    "border_normal": colors["background"],
}

layouts = [
    layout.MonadTall(**layout_theme),
    layout.Max(**layout_theme),
    layout.MonadWide(**layout_theme),
    layout.RatioTile(**layout_theme),
]

FONT = "Ubuntu"
widget_defaults = dict(
    font=FONT,
    fontsize=14,
    padding=4,
    background=colors["background"],
    foreground=colors["text"],
)
extension_defaults = widget_defaults.copy()


def generate_bar(left=[], right=[]):
    current_bg_color = colors["background"]
    current_fg_color = colors["text"]

    widgets = []

    def create_sep(width=10):
        widgets.append(
            widget.Sep(
                padding=0,
                size_percent=100,
                linewidth=width,
                foreground=current_bg_color,
            )
        )

    def create_arrow(bg=current_bg_color, fg=current_fg_color):
        widgets.append(
            widget.Sep(
                padding=0,
                size_percent=100,
                linewidth=10,
                background=fg,
                foreground=bg,
            )
        )
        widgets.append(
            widget.TextBox(
                text="", background=bg, foreground=fg, padding=0, fontsize=60
            )
        )

    create_sep(4)

    for w in left:
        widgets.append(w)

    create_sep(4)

    is_even = True
    is_first_widget = True
    for g in right:
        if is_even:
            current_bg_color = colors["accent_color_dark"]
            is_even = False
        else:
            current_bg_color = colors["accent_color_light"]
            is_even = True

        if is_first_widget:
            create_arrow(colors["background"], colors["accent_color_dark"])

            is_first_widget = False
        else:
            create_arrow(
                colors["accent_color_dark"]
                if is_even
                else colors["accent_color_light"],
                colors["accent_color_light"]
                if is_even
                else colors["accent_color_dark"],
            )

        for w in g:
            w.background = current_bg_color
            w.foreground = current_fg_color
            widgets.append(w)

    create_sep()

    return widgets


def group_box():
    return widget.GroupBox(
        disable_drag=True,
        use_mouse_wheel=False,
        font=FONT + " Bold",
        fontsize=10,
        margin_y=6,
        margin_x=0,
        padding=5,
        borderwidth=3,
        highlight_method="line",
        rounded=False,
        active=colors["active"],
        inactive=colors["text"],
        highlight_color=colors["background_highlight"],
        this_current_screen_border=colors["active"],
        this_screen_border=colors["accent_highlight"],
        other_current_screen_border=colors["active"],
        other_screen_border=colors["accent_highlight"],
        foreground=colors["text"],
        background=colors["background"],
    )


def main_bar():
    return generate_bar(
        left=[
            group_box(),
            widget.Sep(
                linewidth=8,
                background=colors["background"],
                foreground=colors["background"],
            ),
            widget.TextBox(text="-"),
            widget.Sep(
                linewidth=8,
                background=colors["background"],
                foreground=colors["background"],
            ),
            widget.WindowName(),
            widget.Notify(),
            widget.Systray(padding=10),
        ],
        right=[
            [
                widget.TextBox(text="⟳", fontsize=18),
                widget.CheckUpdates(
                    distro="Ubuntu", display_format="{updates} Updates"
                ),
            ],
            [
                widget.CurrentLayoutIcon(scale=0.75),
                widget.CurrentLayout(),
            ],
            [
                widget.TextBox(
                    text="Vol:",
                    mouse_callbacks={
                        "Button1": lambda: qtile.cmd_spawn(
                            "amixer -q -D pulse sset Master toggle"
                        )
                    },
                ),
                widget.Volume(mute_command="amixer -q -D pulse sset Master toggle"),
            ],
            [
                widget.Clock(
                    format="%d / %m / %y",
                    mouse_callbacks={"Button1": lambda: qtile.cmd_spawn("gsimplecal")},
                ),
                widget.Clock(format="%I:%M %p", font=FONT + " Bold"),
            ],
            [
                widget.TextBox(
                    text="⏻",
                    fontsize=22,
                    mouse_callbacks={"Button1": lambda: qtile.cmd_spawn(POWER_MENU)},
                ),
            ],
        ],
    )


def aux_bar():
    return generate_bar(
        left=[
            widget.CurrentLayoutIcon(scale=0.65),
            group_box(),
            widget.Sep(
                linewidth=8,
                background=colors["background"],
                foreground=colors["background"],
            ),
            widget.TextBox(text="-"),
            widget.Sep(
                linewidth=8,
                background=colors["background"],
                foreground=colors["background"],
            ),
            widget.WindowName(),
        ]
    )


screens = [
    Screen(top=bar.Bar(main_bar(), 28)),
    Screen(top=bar.Bar(aux_bar(), 28)),
]

# Drag floating layouts.
mouse = [
    Drag(
        [MOD],
        "Button1",
        lazy.window.set_position_floating(),
        start=lazy.window.get_position(),
    ),
    Drag(
        [MOD], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()
    ),
    Click([MOD], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False

floating_layout = layout.Floating(
    **layout_theme,
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
        Match(wm_class="gnome-calculator"),  # Calculator
        Match(wm_class="pavucontrol"),  # Audio mixer
        Match(wm_class="gnome-calendar"),  # Calendar
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True


@hook.subscribe.startup_once
def autostart():
    home = os.path.expanduser("~/.config/qtile/autostart.sh")
    subprocess.call([home])


@hook.subscribe.client_new
def try_regroup_window(client):
    time.sleep(0.01)
    apps_wm_class = {
        "google-chrome": "WWW",
        "Navigator": "WWW",
        "code": "DEV",
        "Steam": "GMG",
        "nitrogen": "SYS",
        "VirtualBox Manager": "SYS",
        "virt-manager": "SYS",
        "baobab": "SYS",
        "gnome-disks": "SYS",
        "gedit": "DOC",
        "discord": "CHAT",
        "microsoft teams - preview": "CHAT",
        "spotify": "MUS",
        "obs": "VID",
        "ghb": "VID",
        "audacity": "EDT",
        "krita": "EDT",
    }

    # Notion for class is notion-nativefier-xxxx for example
    apps_wm_class_incomplete = {
        "notion": "DOC",
    }

    wm_class = client.window.get_wm_class()[0]
    group = apps_wm_class.get(wm_class, None)
    if group:
        client.togroup(group, switch_group=True)
    else:
        for key in apps_wm_class_incomplete:
            if key in wm_class:
                client.togroup(apps_wm_class_incomplete[key], switch_group=True)


# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"