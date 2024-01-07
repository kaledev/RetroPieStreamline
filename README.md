# RetroPieStreamline
A collection of scripts to make life easier on the RetroPie

## GameLists
Helps to check for integrity of the `gamelist.xml` files. I store mine in the roms directories and utilize skyscraper for scraping. Scraping is a tedious business and you're often left with incomplete gamelists or files that can't load in attract mode. Some of these could be combined, but when working manully it was a bit easier.

- 440-to-420.sh
    - Converts videos to encoding the RetroPie supports
- check_for_games.sh
    - Checks to ensure that games aren't missing from the `gamelist.xml`
- check_for_images.sh
    - Checks to ensure that images aren't missing from the `gamelist.xml`, AND that the actual file defined exists in the media folder.
- check_for_videos.sh
    - Checks to ensure that videos aren't missing from the `gamelist.xml`, AND that the actual file defined exists in the media folder.

## Monitor EmulationStation
A set of scripts that monitors whether or not EmulationStation is running and sends me an email if exited. I did this because RetroPie can still be buggy and will occasionally crash. This runs as a service. msmtp config is utilized and obviously not included.

## Saves
This is my solution for backing up saved game files to my NAS. I have private/public keys used to login to my NAS for security. I utilize `keychain` and included the `.bash_profile` I use for this, as it's a little tricky to get working if you also use encryption. Other than that, the bash script runs in a cron job nightly and backs up new save files to my NAS. The same concept could be utilized for a larger subset of the system - but when I attempted this things got overly complex.

## Boot
Sends email on boot. Largely did this so I knew whenever the system restarted unexpectedly. This runs as a service. msmtp config is utilized and obviously not included.