{
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = {
    flake-utils,
    nixpkgs,
    self,
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {inherit system;};
        enable-flake = true; # Flag to quickly disable the flake
      in
        if enable-flake
        then {
          devShells.default = nixpkgs.legacyPackages."${system}".mkShellNoCC {
            nativeBuildInputs = with pkgs; [
              boost
              capnproto
              clang
              cmake
              glog
              gtest
              ibus
              leveldb
              libnotify
              llvm
              marisa
              ninja
              opencc
              pkg-config
              yaml-cpp
            ];
            packages = with pkgs; [rust-cbindgen doxygen nodejs];
            shellHook = ''
              echo "Hello from ${system}!"
            '';
          };
        }
        else {}
    );
}
