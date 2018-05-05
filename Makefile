remote-add:
	flatpak remote-add --no-gpg-verify --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
	flatpak remote-add --no-gpg-verify --if-not-exists gnome https://sdk.gnome.org/gnome.flatpakrepo
	flatpak --user remote-add --no-gpg-verify --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
	flatpak --user remote-add --no-gpg-verify --if-not-exists gnome https://sdk.gnome.org/gnome.flatpakrepo

install-runtime:
	# Install the freedesktop 1.4 platform and SDK (runtime for building the app)
	# flatpak remote-add --if-not-exists gnome http://sdk.gnome.org/repo/
	wget -P /home/developer https://sdk.gnome.org/keys/gnome-sdk.gpg
	wget -P /home/developer https://sdk.gnome.org/keys/gnome-sdk-autobuilder.gpg
# install gnome under user space
	flatpak --user install gnome org.gnome.Platform//3.22 || true
	flatpak --user install gnome org.gnome.Sdk//3.22 || true
	flatpak --user install gnome org.gnome.Platform//3.24 || true
	flatpak --user install gnome org.gnome.Sdk//3.24 || true
# install gnome globally
	flatpak install gnome org.gnome.Platform//3.22 || true
	flatpak install gnome org.gnome.Sdk//3.22 || true
	flatpak install gnome org.gnome.Platform//3.24 || true
	flatpak install gnome org.gnome.Sdk//3.24 || true
# install freedesktop stuff under user space
	flatpak --user install gnome org.freedesktop.Sdk//1.4 || true
	flatpak --user install gnome org.freedesktop.Platform//1.4 || true
	flatpak --user install gnome org.freedesktop.Sdk//1.6 || true
	flatpak --user install gnome org.freedesktop.Platform//1.6 || true
# install freedesktop stuff globaly
	flatpak install gnome org.freedesktop.Sdk//1.4 || true
	flatpak install gnome org.freedesktop.Platform//1.4 || true
	flatpak install gnome org.freedesktop.Sdk//1.6 || true
	flatpak install gnome org.freedesktop.Platform//1.6 || true
	flatpak remotes
	flatpak --user remote-list --show-details
	flatpak --user list --runtime --show-details
	flatpak remote-list --show-details
	flatpak list --runtime --show-details

install-gnome-2.6-runtime:
	flatpak --user install gnome org.gnome.Platform//3.26 || true
	flatpak --user install gnome org.gnome.Sdk//3.26 || true
	flatpak remotes
	flatpak --user remote-list --show-details
	flatpak --user list --runtime --show-details
	flatpak remote-list --show-details
	flatpak list --runtime --show-details

delete-remotes:
	flatpak remotes
	flatpak --user remote-delete --force gnome
	flatpak --user remote-delete --force flathub
	flatpak remote-delete --force gnome
	flatpak remote-delete --force flathub

install-flatpak-system-deps:
	sudo dnf install flatpak-devel flatpak-builder flatpak-runtime-config wget git bzip2 elfutils make ostree -y

############################################################
# Tutorial starts here
############################################################

run-build:
	flatpak-builder --repo=tutorial-repo dictionary org.gnome.Dictionary.json
# display contents of dictonary dir


add-new-repository:
	flatpak -v --user remote-add --no-gpg-verify --if-not-exists tutorial-repo tutorial-repo
# display contants of tutorial-repo dir
	tree tutorial-repo

install-the-app:
	flatpak -v --user install tutorial-repo org.gnome.Dictionary

check-app-installed:
	echo -e "\n"
	flatpak info org.gnome.Dictionary
	echo -e "\n"
	flatpak info org.gnome.Dictionary.Locale
	echo -e "\n"

run-app:
	flatpak run org.gnome.Dictionary

all: run-build add-new-repository install-the-app check-app-installed run-app

step1: run-build
step2: add-new-repository
step3: install-the-app
step4: check-app-installed
step5: run-app
