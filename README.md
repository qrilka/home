# My home-manager config (using home-manager template)

This repo was originally based on https://github.com/ryantm/home-manager-template but now it uses home manager with flakes to bootstrap use

```
nix run home-manager -- switch --flake .#kirill
```

then it could be switched using

```
home-manager switch --flake .#kirill
```
