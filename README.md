# sandbox

A disposable podman container for working in a project directory.

> [!NOTE]
> Instead, I have settled on configuring sandboxing through ClaudeCode using the following settings:
> ```json
> {
>   "sandbox": {
>     "enabled": true,
>     "filesystem": {
>       "denyRead": ["~/"],
>       "allowRead": ["~/.pixi", "~/.cache"],
>       "allowWrite": ["~/.cache/rattler", "~/.cache/uv"]
>     },
>     "credentials": {
>       "envVars": [
>         { "name": "<ADD SENSITIVE ENV VAR HERE>", "mode": "deny" }
>       ]
>     }
>   }
> }
> ```

## Set up a new machine

```sh
git clone https://github.com/avcopan/sandbox ~/.local/share/sandbox
bash ~/.local/share/sandbox/install.sh
```

`install.sh` symlinks `sandbox.sh` into `~/.local/bin` as `sandbox`. It does not touch
`~/.bashrc`. If `~/.local/bin` isn't on your PATH, the installer says so.

## Use it

```sh
cd ~/some/project
sandbox
```

The current directory is mounted at `/workspace`; everything else is thrown away
when you exit. Nothing is written into the project. The `claude-config` volume
persists `/root/.claude` between runs so you don't log in every time.

The image is built on first use and shared by every project.

## Rebuilding

The image is only built when it doesn't exist, so edits to `Containerfile` (or a
`git pull`) won't take effect on their own. To pick them up, run this command:

```sh
podman rmi sandbox
```

The next `sandbox` rebuild will now re-build the image.
