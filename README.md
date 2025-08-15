# DisplaySwitcher

A minimal macOS utility that switches your main display between built-in and external monitors.

## Features

- 🚀 **Instant switching** - Launches, switches display, and exits
- 🖥️ **Auto-detects** all connected displays
- ⚡ **Zero UI** - No interface, just pure functionality
- 🎯 **Perfect for automation** - Ideal for shortcuts and scripts

## How It Works

1. Launch the app
2. It instantly switches to the next available display
3. App exits automatically
4. That's it!

## Usage

### Quick Switch

Simply run `DisplaySwitcher.app` and your main display will switch immediately.

### Automation Examples

- **Keyboard shortcut**: Assign to a hotkey using System Preferences
- **Terminal**: `open -a DisplaySwitcher`
- **Scripts**: Include in your automation workflows
- **Dock**: Add to dock for one-click switching

## Build Instructions

1. Open `DisplaySwitcher.xcodeproj` in Xcode
2. Set your signing team and bundle identifier
3. Build and run (⌘+R)

The app includes custom icons showing two displays with a switch arrow - perfect for identifying the app in Dock, Spotlight, and Applications folder.

## Installation

After building:

1. Copy `DisplaySwitcher.app` to `/Applications/`
2. Add to Dock for quick access
3. Set up keyboard shortcuts in System Preferences
4. Use with Spotlight search or automation tools

## Requirements

- macOS 13.0 or later
- Multiple displays connected
- Xcode 14 or later (for building)

## File Structure

```text
DisplaySwitcher/
├── DisplaySwitcherApp.swift     # Complete app implementation
└── DisplaySwitcher.entitlements # App permissions
```

---

*Clean, simple, effective display switching.*
