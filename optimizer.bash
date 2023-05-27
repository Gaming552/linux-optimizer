#!/bin/bash

# Check if script is being run with root privileges
if [[ $(id -u) -ne 0 ]]; then
  echo "Please run this script with root privileges."
  exit 1
fi

# Disable unnecessary services
services=(
  "apache2"      # Apache HTTP Server
  "mysql"        # MySQL Database Server
  "cups"         # CUPS Print Service
)

for service in "${services[@]}"; do
  systemctl stop "$service"
  systemctl disable "$service"
done

# Clear package cache and remove unnecessary packages
apt clean
apt autoclean
apt autoremove --purge

# Disable startup applications
startup_dir="/etc/xdg/autostart"
disable_startup_apps=(
  "replace-this.desktop"  # Application to disable on startup
)

for app in "${disable_startup_apps[@]}"; do
  if [[ -f "$startup_dir/$app" ]]; then
    mv "$startup_dir/$app" "$startup_dir/$app.disabled"
  fi
done

# Optimize Swappiness
sysctl -w vm.swappiness=10
echo "vm.swappiness=10" >> /etc/sysctl.conf

# Disable unnecessary kernel modules
blacklist_file="/etc/modprobe.d/blacklist.conf"
blacklist_modules=(
  "pcspkr"      # PC speaker driver
  "floppy"      # Floppy disk driver
)

for module in "${blacklist_modules[@]}"; do
  echo "blacklist $module" >> "$blacklist_file"
done

# Disable graphical effects (if using X11)
disable_x11_effects() {
  xfconf-query -c xfwm4 -p /general/use_compositing -s false
  xfconf-query -c xfce4-session -p /general/SaveOnExit -s false
}

if [[ -n $DISPLAY && -x "$(command -v xfconf-query)" ]]; then
  disable_x11_effects
fi

echo "PC was optimized by cryart#2278, discord.gg/multipurpose"

