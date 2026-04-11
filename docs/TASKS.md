# Mise Tasks

Quick reference for tasks defined in `mise/config.toml`. Run with `mise run <task>`.

## Setup & Maintenance

| Task | Description |
|------|-------------|
| `setup` | Full system setup (prereqs + brew + tools) |
| `check` | Validate entire setup |
| `update` | Update all tools (brew + mise) |
| `update-brew` | Update Homebrew packages |
| `update-mise` | Update mise and tools |
| `backup-brew` | Dump current Brewfile |

## Validation

| Task | Description |
|------|-------------|
| `check-prereqs` | Check prerequisites (brew, git) |
| `check-tools` | Show tool versions |
| `check-paths` | Check for PATH duplicates |
| `check-env` | Check JAVA_HOME, ANDROID_HOME |

## iOS Development

| Task | Description |
|------|-------------|
| `ios-list` | List available simulators |
| `ios-runtimes` | List installed iOS runtimes |
| `ios-boot <device>` | Boot a simulator by name or UUID |
| `ios-shutdown` | Shutdown all simulators |
| `ios-open` | Open Simulator app |
| `ios-install <app>` | Install .app on booted simulator |
| `ios-check` | Check iOS dev environment |

## Android Development

| Task | Description |
|------|-------------|
| `android-list` | List Android emulators |
| `android-boot <avd>` | Boot Android emulator by AVD name |
| `android-check` | Check Android SDK installation |
| `android-avd-list` | List Android Virtual Devices |

## Appium

| Task | Description |
|------|-------------|
| `appium-check` | Check Appium installation and drivers |
| `appium-doctor` | Run Appium driver diagnostics |
| `appium-start` | Start Appium server |
| `mobile-check` | Full mobile dev environment check |

## Examples

```bash
# Full setup on new machine
mise run setup

# Check everything is working
mise run check

# Boot iPhone simulator
mise run ios-boot "iPhone 15 Pro"

# Start Appium for testing
mise run appium-start
```
