all: install decrypt bind checkout

install:
	      @echo "Installing dependencies pacman"
			  pacman -Sy --noconfirm $(tr '\n' ' ' < ./build/pkglist.txt)	
decrypt:
	      @echo "Decrypting values"
				bash ./scripts/unlock_secrets.sh

bind: 
	      @echo "Biding values"
				bash ./scripts/bind.sh

checkout:
	      @echo "Checkout operations"
				vim +'PlugInstall --sync' +qall 
				source ~/.zshrc
	      
