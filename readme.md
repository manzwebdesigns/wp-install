# WordPress Installation Shell Script
Install this script by running `git clone https://github.com/manzwebdesigns/wp-install.git` in your webroot. 

## Special Instructions for the Windows OS.
To prepare for using the script, you may need to modify the `ENV_ROOT` variable 
at the top of the script to match the http_root of your webserver.  You must also install WP-CLI, which
is most easily done by installing composer using this link: https://getcomposer.org/Composer-Setup.exe.
Then use `composer global require wp-cli/wp-cli-bundle` to install WP-CLI. If you have an error about 
`mysql`, you will need to add the `xampp/mysql/bin` directory to your PATH variable.

## Linux/Mac Instructions
Be sure to have WP-CLI installed.  Again, the easiest way is to use composer (`composer global require wp-cli/wp-cli-bundle`) 

## Usage
You can use this script by simply running the command `sh wp-install` and providing the necessary answers or
by using positional parameters like this `wp-install/wp-install.sh <ADMIN_USER> <ADMIN_PASSWORD> <folderName> <databasename> "<sitetitle>"`

## What this script does:

1. Downloads the latest en_US version of WordPress into a predefined folder
2. Creates the `wp-config.php` file based on entered database credentials
3. Installs WordPress based on entered details
4. Changes the permalink structure to `/postname/` and flushes the previous setting
5. Deletes default WordPress posts and pages
6. Creates `Home`, `About` and `Contact` pages
7. Sets `Home` as landing page
8. Scaffolds an `_s` based Theme and sets it as default
9. Installs plugins
10. Removes default WordPress themes
11. Removes default WordPress plugins
12. Creates a Main Menu and adds the existing pages to it
13. Initialises a git repository for the Theme folder
