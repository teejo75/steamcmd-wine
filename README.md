# SteamCMD Base Docker Image with Wine
This image provides SteamCMD and Wine for steam dedicated servers that are available for Windows only.

# How to use this image
It is recommended to use this image as a base image for other windows-based game servers.

## Configuration
The `steamcmd.sh` can be found in the following directory: `/home/steam/steamcmd`

This image's default user is `root`, but SteamCMD is installed as the `steam` user. You should execute SteamCMD and your game service as the `steam` user. The gosu package is installed by default.
_Note: Running the `steamcmd.sh` as `root` will fail because the owner is the user `steam`, either swap the active user using `su steam` or use chown to change the ownership of the directory._

Wine 11 no longer provides the `wine64` binary. You just need to call `wine` against the dedicated server binary, preferrably via `gosu` as the steam user.

This image is also available via ghcr.io/teejo75/steamcmd-wine