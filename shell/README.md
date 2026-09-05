# Todo + Pomodoro top bar

This adds two native Omarchy shell widgets while retaining the default top-bar
layout:

- **Todo** sits after the workspace switcher. Click it to add, complete, delete,
  or clear tasks.
- **Pomodoro** sits immediately before the centered clock. Its popup supports
  focus, short-break, long-break, and custom timers.

Both tools store their state under `~/.local/state`, so shell restarts and theme
changes do not lose tasks or timer progress.

Install with:

```bash
./shell/install.sh
```

The installer backs up `~/.config/omarchy/shell.json`, installs the plugins and
backend scripts, updates the bar layout idempotently, and restarts Omarchy Shell.
