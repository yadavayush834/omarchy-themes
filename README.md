# Omarchy Themes

A collection of fan-made themes for [Omarchy](https://omarchy.org/), beginning
with a complete *Mr. Robot* desktop treatment for Omarchy 4.

## Mr. Robot

![Mr. Robot theme running on Omarchy](screenshots/mr-robot-desktop.png)

*Live desktop preview showing the custom fsociety Waybar, workspace states,
Pomodoro session, system telemetry, and glitch wallpaper.*

The theme combines near-black terminal surfaces, fsociety red alerts,
phosphor-green interaction states, cyan glitch accents, seven wallpapers, and
a custom telemetry-heavy Waybar.

### Quick installation

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/yadavayush834/omarchy-themes/main/install.sh)
```

The installer:

- downloads this repository when needed;
- backs up an existing `mr-robot` theme instead of deleting it;
- installs `mr_robot/` as `~/.config/omarchy/themes/mr-robot`;
- applies the theme with Omarchy.

If you prefer to inspect everything first:

```bash
git clone --depth 1 https://github.com/yadavayush834/omarchy-themes.git
cd omarchy-themes
./install.sh
```

Cycle wallpapers after installation with:

```bash
omarchy theme bg next
```

### Waybar compatibility

The `mr_robot/waybar/` directory contains the complete fsociety Waybar layout,
CSS, uptime module, and self-contained Pomodoro timer. A compatible Waybar
theme manager can activate it automatically; standard Omarchy installations
still receive the complete native-shell styling and color palette.

## Repository layout

```text
omarchy-themes/
├── install.sh
├── README.md
└── mr_robot/
    ├── backgrounds/
    ├── colors.toml
    ├── shell.*.toml
    └── waybar/
```

## Disclaimer

This is an unofficial fan project and is not affiliated with or endorsed by
Omarchy or the creators, producers, broadcasters, or rights holders of
*Mr. Robot*. Supplied images remain the property of their respective copyright
holders.
