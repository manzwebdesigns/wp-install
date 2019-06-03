ENV_ROOT="~/Development/"

green=`tput setaf 2`
reset=`tput sgr0`

function restart {
    echo 'Exit programm'
    exit 1
}

clear

read -p "Create an Admin Username: " ADMIN_USER
if [ -z $ADMIN_USER ]; then
    echo 'Please enter a username!'
    restart
fi

read -p "Create an Admin Password: " ADMIN_PASS
if [ -z $ADMIN_PASS ]; then
    echo 'Please enter a password!'
    restart
fi

read -p "Name the WP folder to be created: " folderName
if [ -z $folderName ]; then
    echo 'Please enter a folder name!'
    restart
fi

read -p "Database name: " databasename
if [ -z $databasename ]; then
    echo 'Please enter a database name!'
    restart
fi

read -p "Site title: " "sitetitle"
if [ -z "$sitetitle" ]; then
    echo 'Please enter a site title!'
    restart
fi


SITE_URL="https://localhost/$folderName"


echo "======================================================="
mkdir $ENV_ROOT/$folderName
cd $ENV_ROOT/$folderName
echo "${green}Success:${reset} Created folder at: $ENV_ROOT/$folderName"
echo "======================================================="

wp core download --locale=en_GB

echo "======================================================="

wp config create --dbname=$databasename --dbprefix=xwp_

echo "======================================================="

wp db create

echo "======================================================="

wp core install --url=$SITE_URL --title="$sitetitle" --admin_user=$ADMIN_USER --admin_password=$ADMIN_PASS

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

wp scaffold _s "$folderName-theme" --theme_name="$sitetitle Theme" --author="Jacob Herper" --author_uri="https://twitter.com/jakeherp" --activate --sassify
wp theme delete twentyfifteen twentysixteen twentyseventeen

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

cd $ENV_ROOT/$folderName/wp-content/themes/$folderName-theme
git init
git add .
git commit -m "Initial commit"

open -a "Google Chrome" $SITE_URL

echo "======================================================="
echo "${green}Success!${reset} Installation Script finished!"
echo
echo "Website: $SITE_URL"
echo "Admin area: $SITE_URL/wp-admin/"
echo
echo "Username: $ADMIN_USER"
echo "Password: $ADMIN_PASS"
echo "======================================================="