## tiling window manager (MacOS)

--- Using `yabai` as tiling window manager. Similar to `chunkwm` but more maintained

To install `yabai`, enable SIP without fs and debug

```
csrutil enable --without debug --without fs
```

SIP needs to be enabled by booting from recovery mode

Check SPI status: `csrutil status`

```
System Integrity Protection status: unknown (Custom Configuration).

Configuration:
	Apple Internal: disabled
	Kext Signing: enabled
	Filesystem Protections: disabled
	Debugging Restrictions: disabled
	DTrace Restrictions: enabled
	NVRAM Protections: enabled
	BaseSystem Verification: enabled

This is an unsupported configuration, likely to break in the future and leave your machine in an unknown state.
```

Install yabai: `brew tap koekeishiya/formulae && brew install yabai`

Install scripting addition (will work only if SIP fs debug disabled)

```
sudo yabai --install-sa
```

Default dotfile for yabai

`cp /usr/local/opt/yabai/share/yabai/examples/yabairc ~/.yabairc`

Default dotfile for skhd

`cp /usr/local/opt/yabai/share/yabai/examples/skhdrc ~/.skhdrc`

Start yabai as a service

`brew services start koekeishiya/formulae/yabai`


--- Install `skhd` (keyboard shortcuts) and `spectacle` (window manager)

```
brew install koekeishiya/formulae/skhd && brew services start skhd && brew cask install spectacle
```


