# RIDE

Dotfiles for Arch Linux.

Use the `xorg` profile of `archintall`, then run the dotties install
script.

Need to figure out:
* power management for laptops


## Optional

Reverse touchpad scroll direction:
```sh
device="$(xinput list | egrep "slave.*pointer" | grep -v XTEST | sed -e 's/^.*id=//' -e 's/\s.*$//' | head -n1)"
xinput set-button-map "$device" 1 2 3 5 4 6 7
```

Set Trackpoint speed:
```sh
xinput list-props 12 | grep "Accel"
xinpit set-prop 12 333 1.0
```

