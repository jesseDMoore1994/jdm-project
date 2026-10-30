# a nix flake to build the jdm-project static c library.

{
  description = "A flake to build the jdm-project static c library";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
    jdm-project = pkgs.stdenv.mkDerivation {
      pname = "jdm-project";
      version = "1.0.0";

      src = ./.;

      buildInputs = [ pkgs.cmake ];

      meta = with pkgs.lib; {
        description = "Hand-rolled project library for C";
        license = licenses.mit;
        maintainers = with pkgs.maintainers; [ jesseDMoore1994 ];
      };
    };
  in {
    packages.x86_64-linux.jdm-project = with nixpkgs.legacyPackages.x86_64-linux; stdenv.mkDerivation {
      pname = "jdm-project";
      version = "1.0.0";

      src = ./.;

      buildInputs = [ cmake ];

      meta = with lib; {
        description = "Hand-rolled project library for C";
        license = licenses.mit;
        maintainers = with maintainers; [ jesseDMoore1994 ];
      };

      doCheck = true;
    };

    # setup a devShell for development
    devShells.x86_64-linux.default = with nixpkgs.legacyPackages.x86_64-linux; mkShell {
      buildInputs = [ clang-tools cmake gcc gdb valgrind];
      shellHook = ''
        echo "Welcome to the jdm-project development shell!"
      '';
    };

    # set up defaultPackage to be the jdm-alloc package
    packages.x86_64-linux.default = self.packages.x86_64-linux.jdm-project;
  };
}
