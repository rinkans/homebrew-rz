# Homebrew tap for rz

rz is a keyboard-first window manager layer for macOS (Intel and Apple Silicon): CapsLock grids, workspaces and hints.

## Install

```bash
brew install rinkans/rz/rz
brew services start rz
```

Then allow rz to place windows: **System Settings > Privacy & Security > Accessibility**, switch on **rz**. macOS asks the first time rz starts.

CapsLock becomes rz's key: hold it alone to see every shortcut. While rz runs, the menu bar shows it.

## Update

```bash
brew upgrade rz
```

## Uninstall

```bash
brew services stop rz
brew uninstall rz
```

The formula is written by rz's release workflow for each release; please don't edit it here by hand.
