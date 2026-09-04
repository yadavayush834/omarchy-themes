# Mr. Robot for Omarchy

An unofficial fan-made Omarchy theme inspired by the visual language of
*Mr. Robot*: near-black terminal surfaces, phosphor-green interaction states,
signal-red alerts, and cyan glitch highlights.

## Design direction

- **Black terminal surfaces** keep the desktop quiet and cinematic.
- **Fsociety red** marks active borders, selections, and urgent states.
- **Phosphor green** identifies actions, cursors, and successful states.
- **Glitch cyan** provides focus contrast without overwhelming the red.
- The Omarchy shell uses thin, hard-edged borders and restrained fills for a
  surveillance-terminal feel that remains comfortable for daily use.

## Included

- A complete Omarchy 4 color palette for terminals, editors, Chromium, btop,
  Hyprland, and generated application themes.
- Custom shell styling for the bar, launcher, menus, panels, notifications,
  lock screen, and background picker.
- A custom fsociety Waybar with numbered workspaces, a surveillance timestamp,
  Pomodoro integration, conditional security-state indicators, and compact
  system telemetry. Its timer backend is self-contained, and compatible Waybar
  theme managers can activate the layout automatically when this theme is selected.
- Seven supplied Mr. Robot images, ordered so the high-resolution neon Times
  Square artwork is selected first.
- Yaru red dark icons.

## Install locally

Copy or link this directory to:

```text
~/.config/omarchy/themes/mr-robot
```

Then apply it with:

```bash
omarchy theme set mr-robot
```

Cycle through the supplied backgrounds with:

```bash
omarchy theme bg next
```

## Palette

| Role | Color |
| --- | --- |
| Background | `#080b0a` |
| Foreground | `#c8d5cf` |
| Fsociety red | `#e33b42` |
| Phosphor green | `#59f085` |
| Glitch cyan | `#4fd4d8` |

## Notice

This is an unofficial fan theme and is not affiliated with or endorsed by the
creators, producers, broadcasters, or rights holders of *Mr. Robot*. The image
files were supplied by the local user; their original copyrights remain with
their respective owners.
