# Omarchy Themes

A collection of fan-made themes for [Omarchy](https://omarchy.org/): a
complete *Mr. Robot* desktop treatment and an original minimalist theme,
*Minimal Drift*, both for Omarchy 4.

## Minimal Drift

![Minimal Drift theme running on Omarchy](screenshots/minimal-drift-desktop.png)

*Live desktop preview showing the floating-pill Waybar, bone active
workspace, and warm-monochrome terminal palette.*

Warm grays, one bone accent, one sand warning. Slim floating pill bar with
hairline borders and strict module density (numbered workspaces, clock,
network, volume, battery, power — nothing else), six generated gradient
wallpapers including near-black variants, and full native-shell styling.
Install with `./install.sh minimal-drift` (see below);
details in [minimal_drift/](minimal_drift/).

## Mr. Robot

![Mr. Robot theme running on Omarchy](screenshots/mr-robot-desktop.png)

*Live desktop preview showing the custom fsociety Waybar, workspace states,
Pomodoro session, system telemetry, and glitch wallpaper.*

The theme combines near-black terminal surfaces, fsociety red alerts,
phosphor-green interaction states, cyan glitch accents, seven wallpapers, and
a custom telemetry-heavy Waybar.

### Quick installation

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/yadavayush834/omarchy-themes/main/install.sh) minimal-drift
```

Or pick a theme explicitly (defaults to `mr-robot` when omitted):

```bash
./install.sh minimal-drift
./install.sh mr-robot
```

The installer:

- downloads this repository when needed;
- validates the theme name against a fixed list (`mr-robot`, `minimal-drift`);
- backs up an existing theme instead of deleting it;
- installs the theme folder as `~/.config/omarchy/themes/<slug>`;
- applies the theme with Omarchy.

If you prefer to inspect everything first:

```bash
git clone --depth 1 https://github.com/yadavayush834/omarchy-themes.git
cd omarchy-themes
./install.sh minimal-drift
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
├── screenshots/
│   ├── minimal-drift-desktop.png
│   └── mr-robot-desktop.png
├── minimal_drift/        # slug: minimal-drift
│   ├── backgrounds/
│   ├── colors.toml
│   ├── shell.*.toml
│   └── waybar/
└── mr_robot/             # slug: mr-robot
    ├── backgrounds/
    ├── colors.toml
    ├── shell.*.toml
    └── waybar/
```

## Disclaimer

This is an unofficial fan project and is not affiliated with or endorsed by
Omarchy or the creators, producers, broadcasters, or rights holders of
*Mr. Robot*. Supplied images remain the property of their respective copyright
holders. *Minimal Drift* is an original creation; its wallpapers were
generated for this theme and need no attribution.
