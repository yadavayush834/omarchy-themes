# Minimal Drift

Quiet paper in a dark room. A warm-monochrome minimalist Omarchy theme.

One bone accent (`#E8E4DA`), one sand warning (`#C9A86A`), muted clay for
errors. Everything else stays in warm grays so focused work stays calm.

![Minimal Drift desktop](../../screenshots/minimal-drift-desktop.png)

- **Omarchy slug:** `minimal-drift`
- **Repository folder:** `minimal_drift`

## Design

- **Palette:** `#141413` surfaces, `#E2DED4` text, bone active states
  (contrast 13.7:1, check with `omarchy dev theme preview`)
- **Geometry:** slim floating pill Waybar, 8px radius, 1px hairlines, flat
- **Density:** strict — workspaces (1–10 numbered), clock, network, volume,
  battery, power. No logo, no window title, no tray, no bluetooth or
  brightness modules, no permanent telemetry. Conditional indicators
  (recording, idle, silenced notifications, updates) take zero space
  until active.
- **Typography:** JetBrainsMono Nerd Font, lowercase labels, tight padding
- **Motion:** none, except a slow pulse for critical battery
- **States:** active workspace is a solid bone pill; disconnected/muted is
  clay; charging is bone; low battery is sand

## Contents

- `colors.toml` + `icons.theme` (`Yaru-dark`)
- `shell.*.toml` native Quickshell styling (bar, controls, Hyprland borders,
  launcher, menu, notifications, lock, polkit, popups, spacing, tooltip,
  image-picker)
- `backgrounds/` — six generated 1920×1080 gradients, original work, no
  attribution needed. `01-drift-horizon.jpg` is the default; `04-abyss`,
  `05-coal`, and `06-night` are near-black. Cycle with
  `omarchy theme bg next`.
- `waybar/` — bundled custom bar (`config.jsonc` + `style.css`), an optional
  enhancement. Without a Waybar manager the theme falls back to the native
  Omarchy bar in the same palette.

## Install

```bash
./install.sh minimal-drift
# or, from a running Omarchy desktop:
cp -a minimal_drift ~/.config/omarchy/themes/minimal-drift
omarchy theme set minimal-drift
```

No helper scripts, no machine-specific paths.
