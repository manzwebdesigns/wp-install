# WordPress Installation Shell Script

This version is for Windows.  To prepare for using the script, you must modify the `ENV_ROOT` variable 
at the top of the script to match the http_root of your webserver.  You must also install WP-CLI, which
is most easily done by installing [composer][https://getcomposer.org/Composer-Setup.exe].
Then use `composer global require wp-cli/wp-cli-bundle` to install WP-CLI.

## What this script does:

1. Downloads the latest en_US version of WordPress into a predefined folder
2. Creates the `wp-config.php` file based on entered database credentials
3. Installs WordPress based on entered details
4. Changes the permalink structure to `/postname/` and flushes the previous setting
5. Deletes default WordPress posts and pages
6. Creates `Home`, `About` and `Contact` pages
7. Sets `Home` as landing page
8. Scaffolds an `_s` based Theme and sets it as default
9. Installs plugins `Yoast SEO` and `Ninja Forms`
10. Removes default WordPress themes
11. Removes default WordPress plugins
12. Creates a Main Menu and adds the existing pages to it
13. Initialises a git repository for the Theme folder
14. Opens the theme folder in VS Code and the project in Google Chrome


[https://getcomposer.org/Composer-Setup.exe]: composer
