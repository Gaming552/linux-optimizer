# linux-optimizer

> Disables unnecessary services specified in the __services__ variabile.
> Clears the package cache and removes unnecessary packages using the __apt__ package manager.
> Disables specified startup applications located in the `/etc/xdg/autostart` directory.
> Sets the **Swappiness** value to 10 to optimize memory usage.
> Blacklists unnecessary kernel modules in the `/etc/modprobe.d/blacklist.conf` file.
> Disables graphical effects (specific to **X11-based** environments, like XFCE) if the X server is running.

# How to run optimizer.bash ?

* execute this in command prompt: ``chmod +x optimizer.bash``
* after execute this in command prompt: ``./optimizer.bash
``
