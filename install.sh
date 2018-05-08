BASE_DIR=/Library/Fonts
DIR=MAkinE

#check root permissions
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

##check for homebrew & install if not present
command -v brew >/dev/null 2>&1 || { echo "Homebrew missing." >&2; echo "Installing homebrew." ;/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" ; exit 1; }
echo "Found homebrew."

##check for rsync
command -v rsync >/dev/null 2>&1 || { echo "Rsync missing." >&2; echo "Installing Rsync" ; brew install rsync; exit 1; }
echo "Found rsync."

##check MAkinE folder
if [ ! -d $BASE_DIR"/"$DIR ]; then
	mkdir -p $BASE_DIR"/"$DIR
	echo "Creating MAkinE folder."
	else
	echo "Found MAkinE folder".
fi

##Set permissions.
chgrp -R editorial-graphics $BASE_DIR"/"$DIR
chmod -R 775 $BASE_DIR"/"$DIR

#sync Fonts
echo "Syncing Fonts...".
rsync -r --del /Volumes/pegasus/00_LIBRARY/.font_suppository/MAkinE/ $BASE_DIR"/"$DIR"/"

##Set permissions.
echo "Fixing permissions..."
chgrp -R editorial-graphics $BASE_DIR"/"$DIR
chmod -R 775 $BASE_DIR"/"$DIR

echo "Done."

