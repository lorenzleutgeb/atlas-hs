{
  description = "lac-hs";
  inputs.nixpkgs = { url = "nixpkgs/nixos-20.09"; };
  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in rec {
      devShell."${system}" =
        with pkgs;
        mkShell {
          buildInputs = [
            dot2tex
            stack
            z3
          ];
          shellHook = ''
            stack --version

            z3 --version

            dot2tex --version
          '';
      };
  };
}
