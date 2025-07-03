{
  description = "NixOS configuration";

  inputs = {
    nixpkgs = {
    	url = "github:nixos/nixpkgs/nixos-unstable";
    };
    zen-browser = {
    	url = "github:0xc000022070/zen-browser-flake";
    };
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    firefox-addons = { 
    	url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
	inputs.nixpkgs.follows = "nixpkgs"; 
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ { self, nixpkgs, home-manager, zen-browser, ... }: {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
		
	  #nixpkgs.config.allowUnfree = true;

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.rayanalabbad = import ./home.nix;
	    home-manager.backupFileExtension = "backup";
	    home-manager.extraSpecialArgs = {
	      inherit inputs;
	    };
	
            # Optionally, use home-manager.extraSpecialArgs to pass arguments to home.nix
          }
        ];
	specialArgs = {
          inherit inputs;
      	};
      };
    };
    
  };
}
