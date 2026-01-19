# SteamCMD Base Docker Image with Wine
This image provides SteamCMD and Wine for steam dedicated servers that are available for Windows only.

# How to use this image
It is recommended to use this image as a base image for other windows-based game servers.

## Configuration
The `steamcmd.sh` can be found in the following directory: `/home/steam/steamcmd`

This image's default user is `root`, but SteamCMD is installed as the `steam` user. You should execute SteamCMD and your game service as the `steam` user. The gosu package is installed by default.
_Note: Running the `steamcmd.sh` as `root` will fail because the owner is the user `steam`, either swap the active user using `su steam` or use chown to change the ownership of the directory._

Wine 11 no longer provides the `wine64` binary. You just need to call `wine` against the dedicated server binary, preferrably via `gosu` as the steam user.

## Image Info

This image is also available via ghcr.io/teejo75/steamcmd-wine

The image will automatically update whenever steamcmd-base updates.

If you have an image that uses this image as a base, and you would like your build workflow to trigger whenever this image updates, then open an issue with the name of your repo.

See [Action Repository Dispatch](https://github.com/peter-evans/repository-dispatch).

In your build workflow, add an event as follows:
```yaml
on:
    repository_dispatch:
        types: [steamcmd-wine-updated]
```

And so you know what triggered the workflow, you can add the following job before your main build job:

```yaml
jobs:
  echo-base-update:
    if: github.event_name == 'repository_dispatch'
    runs-on: ubuntu-latest
    steps:
      - name: Echo base image update
        run: echo "Base image steamcmd-wine has been updated, triggering rebuild of this image. ImageID ${{ github.event.client_payload.imageid }} Digest ${{ github.event.client_payload.digest }}"

```