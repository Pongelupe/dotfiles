all: install decrypt bind

H = ${HOME}
Z = ${ZSH_CUSTOM}

install:
	      @echo "Installing dependencies pacman"
				sudo pacman -Sy --noconfirm $$(tr '\n' ' ' < ./build/pkglist.txt)	

				@echo "Installing dependencies yay"
				yay -S input-remapper-git --noconfirm
				sudo systemctl enable input-remapper

				@echo "Installing Oh my ZSH plugins @ $Z"
				sudo git clone https://github.com/zsh-users/zsh-autosuggestions.git $Z/plugins/zsh-autosuggestions
				sudo git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $Z/plugins/zsh-syntax-highlighting
				sudo git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git $Z/plugins/fast-syntax-highlighting

				@echo "Installing vim plugins"
				vim +"PlugInstall --sync" +qall        

				@echo "Installing nvm"
				mkdir -p $H/.nvm
				curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.2/install.sh | bash

				@echo "Installing sdkman"
				curl -s "https://get.sdkman.io" | bash

				#source $H/.sdkman/bin/sdkman-init.sh
				#@echo "Installing sdkman SDKs"
				#sdk install java
				#sdk install maven

decrypt:
	      @echo "Decrypting values"
				bash ./scripts/unlock_secrets.sh

bind: 
	      @echo "Biding values"
				bash ./scripts/bind.sh

