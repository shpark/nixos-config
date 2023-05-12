{
  inputs.vscode-server.url = "github:nix-community/nixos-vscode-server";

  outputs = { self, nixpkgs, vscode-server }: {
    nixosConfigurations.rockpro64 = nixpkgs.lib.nixosSystem {
      modules = [
        vscode-server.nixosModule
	./configuration.nix
      ];
    };
  };
}