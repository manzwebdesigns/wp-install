ENV_ROOT="d:\xampp\htdocs"
ADMIN_USER="$1"
ADMIN_PASS="$2"
folderName="$3"
databasename="$4"
sitetitle="$5"

green=$(tput setaf 2)
reset=$(tput sgr0)

clear

while [ -z "$ADMIN_USER" ]
do
  read -r -p "Create an Admin Username: " ADMIN_USER
done

while [ -z "$ADMIN_PASS" ]; do
  read -r -p "Create an Admin Password: " ADMIN_PASS
done

while [ -z "$folderName" ]; do
  read -r -p "Name the WP folder to be created: " folderName
done

while [ -z "$databasename" ]; do
  read -r -p "Database name: " databasename
done

while [ -z "$sitetitle" ]; do
  read -r -p "Site title: " sitetitle
done

SITE_URL="https://localhost/$folderName"

echo "======================================================="
mkdir $ENV_ROOT\\"$folderName"
cd $ENV_ROOT\\"$folderName" || exit
echo "${green}Success:${reset} Created folder at: $ENV_ROOT\\$folderName"
echo "======================================================="

wp core download

echo "======================================================="

wp config create --dbname="$databasename" --dbprefix=xwp_ --dbuser="root"

echo "======================================================="

wp db create

echo "======================================================="

wp core install --url="$SITE_URL" --title="$sitetitle" --admin_user="$ADMIN_USER" --admin_password="$ADMIN_PASS" --admin_email="admin@manzwebdesigns.com"

echo "======================================================="

wp rewrite structure '/%postname%/'
wp rewrite flush --hard

echo "======================================================="

wp post delete 1 2 --force

echo "======================================================="

wp post create --post_type=page --post_title='Home' --post_status=publish
wp post create --post_type=page --post_title='About' --post_status=publish
wp post create --post_type=page --post_title='Contact' --post_status=publish

echo "======================================================="

wp option update page_on_front 3
wp option update show_on_front page

echo "======================================================="

wp scaffold _s "$folderName-theme" --theme_name="$sitetitle Theme" --author="Bud Manz" --author_uri="https://twitter.com/manzwebdesigns" --activate --sassify
wp theme delete twentyfifteen twentysixteen twentyseventeen twentyeighteen twentynineteen

echo "======================================================="

wp plugin delete hello akismet

wp plugin install wordpress-seo --activate
wp plugin install ninja-forms --activate

echo "======================================================="

wp menu create "Main Menu"
wp menu location assign main-menu menu-1
wp menu item add-post main-menu 3 --title="Home"
wp menu item add-post main-menu 4 --title="About"
wp menu item add-post main-menu 5 --title="Contact"

echo "======================================================="

# Open the WordPress Installation root folder in VS Code. Happy Coding :)
code ./

cd $ENV_ROOT\\"$folderName"\\wp-content\\themes\\"$folderName"-theme || exit
git init
git add .
git commit -m "Initial commit"

open -a "Google Chrome" "$SITE_URL"

echo "======================================================="
echo "${green}Success!${reset} Installation Script finished!"
echo
echo "Website: $SITE_URL"
echo "Admin area: $SITE_URL/wp-admin/"
echo
echo "Username: $ADMIN_USER"
echo "Password: $ADMIN_PASS"
echo "======================================================="
