import time
import os
import subprocess
import psutil

from libqtile import bar, layout, widget, qtile, hook
from libqtile.config import Click, Drag, Group, ScratchPad, DropDown, Key, Match, Screen
from libqtile.lazy import lazy

MOD = "mod4"
ALT = "mod1"
TERMINAL = "alacritty"
FILE_MANAGER = "pcmanfm --no-desktop -n"
SCREENSHOT = "gnome-screenshot"
SCREENSHOT_UTILITY = "gnome-screenshot -i"
CALCULATOR = "gnome-calculator"
CALENDAR = "gnome-calendar"
SHOW_KEYBINDS = f"{TERMINAL} -t Keybinds -e /home/grfreire/Projects/thirdparty/qtile/.venv/bin/python3 /home/grfreire/.config/qtile/list_keybinds.py"
POWER_MENU = os.path.expanduser(
    "~/.scripts/bin/simple-power-menu"
)
CHECK_UPDATES = os.path.expanduser(
    "~/.scripts/bin/check_updates"
)

MEDIA_CONTROL = os.path.expanduser("~/.config/qtile/media_control.sh")
MONITOR_CONTROL = os.path.expanduser("~/.config/qtile/monitor_control.sh")

keys = [
    # Closes window.
    Key([MOD], "q", lazy.window.kill(), desc="Kill focused window"),
    # Switch between windows
    Key([MOD], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([MOD], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([MOD], "j", lazy.layout.down(), desc="Move focus down"),
    Key([MOD], "k", lazy.layout.up(), desc="Move focus up"),
    Key([ALT], "Tab", lazy.layout.next(), desc="Move window focus to other window"),
    Key([MOD], "dead_grave", lazy.next_screen(), desc="Move window focus to other screen"),
    # Move windows between left/right columns.
    Key([MOD, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([MOD, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([MOD, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([MOD, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    # Grow and shrink windows.
    Key([MOD, "control"], "h", lazy.layout.shrink_main(), desc="Grow window to the left"),
    Key([MOD, "control"], "l", lazy.layout.grow_main(), desc="Grow window to the right"),
    Key([MOD, "control"], "j", lazy.layout.shrink_main(), desc="Grow window down"),
    Key([MOD, "control"], "k", lazy.layout.grow_main(), desc="Grow window up"),
    Key([MOD], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    # Toggle between different layouts.
    Key([MOD], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([MOD], "m", lazy.window.toggle_fullscreen(), desc="Toggle maximize state of the window"),
    Key([MOD], "t", lazy.window.toggle_floating(), desc="Toggle floating state of the window"),
    Key([MOD, "shift"], "t", lazy.function(lambda q: toggle_swallow(q.current_window)), desc="Toggle swallow state of the window"),
    # QTile
    Key([MOD, "control"], "r", lazy.restart(), desc="Restart Qtile"),
    Key([MOD, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([MOD], "slash", lazy.spawn(SHOW_KEYBINDS), desc="Show list of qtile keybinds"),
    # System
    Key([MOD], "BackSpace", lazy.spawn(POWER_MENU), desc="Open power menu"),
    Key([], "Print", lazy.spawn(SCREENSHOT), desc="Take a screenshot of all the screens"),
    Key([MOD], "Print", lazy.spawn(SCREENSHOT_UTILITY), desc="Open screenshot utility"),
    # Media
    Key([], "XF86AudioPlay", lazy.spawn(f"{MEDIA_CONTROL} play"), desc="Media control - play"),
    Key([], "XF86AudioStop", lazy.spawn(f"{MEDIA_CONTROL} stop"), desc="Media control - stop"),
    Key([], "XF86AudioNext", lazy.spawn(f"{MEDIA_CONTROL} next"), desc="Media control - next"),
    Key([], "XF86AudioPrev", lazy.spawn(f"{MEDIA_CONTROL} prev"), desc="Media control - prev"),
    Key([], "XF86AudioRaiseVolume", lazy.spawn(f"{MEDIA_CONTROL} vol_up"), desc="Media control - volume up"),
    Key([], "XF86AudioLowerVolume", lazy.spawn(f"{MEDIA_CONTROL} vol_down"), desc="Media control - volume down"),
    Key([], "XF86MonBrightnessUp", lazy.spawn(f"{MONITOR_CONTROL} b_up"), desc="Monitor control - brihtness up"),
    Key([], "XF86MonBrightnessDown", lazy.spawn(f"{MONITOR_CONTROL} b_down"), desc="Monitor control - brihtness down"),
    Key([], "XF86AudioMute", lazy.spawn(f"{MEDIA_CONTROL} vol_mute"), desc="Media control - mute volume"),
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

scratch_pads = [
    [
        DropDown("calculator", CALCULATOR, x=0.75, y=0.45, width=0.2, height=0.4, opacity=0.9, on_focus_lost_hide=False),
        [[MOD], "c"]
    ],
    [
        DropDown("filemanager", FILE_MANAGER, x=0.65, y=0.1, width=0.35, height=0.8, opacity=0.9, on_focus_lost_hide=False),
        [[MOD, "control"], "f"]
    ]
]

groups = [Group(name, **kwargs) for name, kwargs in group_names]

for i, (name, kwargs) in enumerate(group_names, 1):
    # Switch to another group
    keys.append(Key([MOD], str(i), lazy.group[name].toscreen(), desc=f"Switch to group {name}"))

    # Send current window to another group
    keys.append(Key([MOD, "shift"], str(i), lazy.window.togroup(name), desc=f"Send current window to group {name}"))

sp_groups = []
sp_keys = []
for sp in scratch_pads:
    sp_groups.append(sp[0])
    sp_keys.append(sp[1])

groups.append(ScratchPad("scratchpad", sp_groups))

for i, (mod, k) in enumerate(sp_keys, 0):
    name = sp_groups[i].name
    keys.append(Key(mod, *k, lazy.group['scratchpad'].dropdown_toggle(name), desc=f"Open {name} scratchpad"))

colors = {
    "background": "#1E1E1E",
    "background_highlight": "#241F31",
    "text": "#DEDDDA",
    "accent_color_dark": "#4A3321",
    "accent_color_light": "#6E4D31",
    "accent_highlight": "#63452C",
    "active": "#B5835A",
    "inactive": "#DEDDDA",
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
                text="", background=bg, foreground=fg, padding=-8, fontsize=60
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
        inactive=colors["inactive"],
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
            widget.WindowName(),
            widget.Systray(padding=10),
        ],
        right=[
            [
                widget.TextBox(text="⟳", fontsize=18),
                widget.CheckUpdates(
                    distro="Debian", custom_command=CHECK_UPDATES, display_format="{updates} Updates"
                ),
            ],
            [
                widget.CurrentLayoutIcon(scale=0.75),
                widget.CurrentLayout(),
            ],
            [
                widget.Memory(format='Mem {MemPercent}%'),
                widget.CPU(format='CPU {load_percent}%'),
                widget.ThermalSensor(fmt='Temp {}'),
            ],
            [
                widget.TextBox(
                    text="Volume:",
                    mouse_callbacks={
                        "Button1": lambda: qtile.spawn(
                            "amixer -q -D pulse sset Master toggle"
                        )
                    },
                ),
                widget.Volume(mute_command="amixer -q -D pulse sset Master toggle"),
            ],
            [
                widget.Clock(
                    format="%d / %m / %y",
                    mouse_callbacks={"Button1": lambda: qtile.spawn(CALENDAR)},
                ),
                widget.Clock(format="%I:%M %p", font=FONT + " Bold"),
            ],
            [
                widget.BatteryIcon(),
                widget.Battery(format='{percent:2.0%} {hour:d}h{min:02d}m'),
            ],
            [
                widget.TextBox(
                    text="⏻",
                    fontsize=22,
                    mouse_callbacks={"Button1": lambda: qtile.spawn(POWER_MENU)},
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
            widget.WindowName(),
            widget.Memory(format='Memory {MemPercent}%'),
            widget.ThermalSensor(fmt='Temp: {}'),
            widget.CPU(format='CPU {load_percent}%'),
            widget.Sep(
                linewidth=8,
                background=colors["background"],
                foreground=colors["background"],
            ),
            widget.Clock(
                format="%d / %m / %y",
                mouse_callbacks={"Button1": lambda: qtile.spawn(CALENDAR)},
            ),
            widget.Clock(format="%I:%M %p", font=FONT + " Bold"),
        ]
    )


screens = [
    Screen(top=bar.Bar(main_bar(), 30)),
    Screen(top=bar.Bar(aux_bar(), 32)),
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
        Match(wm_class="pinentry-gtk-2"),  # GPG key password entry
        Match(wm_class="gnome-calculator"),  # Calculator
        Match(wm_class="bitwarden"),  # Bitwarden
        Match(wm_class="pavucontrol"),  # Audio mixer
        Match(wm_class="gnome-calendar"),  # Calendar
        Match(wm_class="yad"),  # Yad
        Match(title="Krita - Edit Text — Krita"),  # Keybinds window
        Match(title="Keybinds"),  # Keybinds window
    ]
)

# Exceptions rules to disable floating in default config
@hook.subscribe.client_new
def disable_floating(window):
    rules = [
        Match(wm_class="mpv")
    ]

    if any(window.match(rule) for rule in rules):
        window.togroup(qtile.current_group.name)
        window.cmd_disable_floating()

auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True


@hook.subscribe.startup_once
def autostart():
    autostart_script = os.path.expanduser("~/.config/qtile/autostart.sh")
    subprocess.call([autostart_script])

@hook.subscribe.restart
def restart_hook():
    os.system(os.path.expanduser("~/.config/qtile/on_restart.sh"))


@hook.subscribe.client_new
def try_swallow(window):
    swallow_from=[
        Match(wm_class="Alacritty"),
    ]

    not_swallow=[]

    if any(window.match(rule) for rule in not_swallow):
        return

    if hasattr(window, 'parent'):
        swallow(window, window.parent)
        return

    pid = window.window.get_net_wm_pid()                                                       # Window PID
    ppid = psutil.Process(pid).ppid()                                                          # Parent Window PID
    cpids = {c.window.get_net_wm_pid(): wid for wid, c in window.qtile.windows_map.items()}    # All Windows PIDs
    for _ in range(len(cpids)):
        if not ppid:
            return
        if ppid in cpids:
            parent = window.qtile.windows_map.get(cpids[ppid])
            if not any(parent.match(rule) for rule in swallow_from):
                return

            swallow(window, parent)
            return
        ppid = psutil.Process(ppid).ppid()


def swallow(window, parent):
    parent.minimized = True
    window.parent = parent

@hook.subscribe.client_killed
def try_unswallow(window):
    if hasattr(window, 'parent'):
        unswallow(window.parent)

def unswallow(parent):
    parent.minimized = False

def toggle_swallow(window):
    if hasattr(window, 'parent'):
        if window.parent.minimized:
            unswallow(window.parent)
        else:
            swallow(window, window.parent)

@hook.subscribe.client_new
def try_regroup_window(client):
    time.sleep(0.01)
    apps_wm_class = {
        "google-chrome": "WWW",
        "Navigator": "WWW",
        "code": "DEV",
        "Steam": "GMG",
        "heroic": "GMG",
        "lutris": "GMG",
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
        "resolve": "EDT",
        "audacity": "EDT",
        "krita": "EDT",
        "mypaint": "EDT",
    }

    # Notion for class is notion-nativefier-xxxx for example
    apps_wm_class_incomplete = {
        "notion": "DOC",
        "todoist": "DOC",
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
