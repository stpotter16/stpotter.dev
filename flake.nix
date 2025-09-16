{
    description = "Dev environment for stpotter.dev";

    inputs = {
        flake-utils.url = "github:numtide/flake-utils";

        # 0.148.2
        hugo-nixpkgs.url = "github:NixOS/nixpkgs/648f70160c03151bc2121d179291337ad6bc564b";
    };

    outputs = {
        self,
        flake-utils,
        hugo-nixpkgs
    } @inputs:
        flake-utils.lib.eachDefaultSystem (system: let
            hugo = hugo-nixpkgs.legacyPackages.${system}.hugo;
        in {
            devShells.default = hugo-nixpkgs.legacyPackages.${system}.mkShell {
                packages = [
                    hugo
                ];

                shellHook = ''
                    hugo version
                '';
            };
        });
}

