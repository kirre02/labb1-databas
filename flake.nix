{
  description = "devshell for this project";

  inputs = {
    copilotchat.flake = false;
    copilotchat.url = "github:CopilotC-Nvim/CopilotChat.nvim?ref=canary";
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = inputs @ {
    self,
    flake-parts,
    ...
  }:
    flake-parts.lib.mkFlake {inherit inputs;} {
      debug = true;

      flake = {
        lib = import ./lib {inherit inputs;};
      };

      systems = ["aarch64-darwin" "aarch64-linux" "x86_64-darwin" "x86_64-linux"];

      perSystem = {
        config,
        pkgs,
        system,
        ...
      }: let
        inherit (pkgs) just mkShell;
      in {
        devShells = {
          default = mkShell {
            buildInputs = [just];
          };
        };


      };
    };
}
