# Standout Express

This script sets up a fresh installation of Pixelarity's Standout on an Amazon EC2 Ubuntu NodeJS/Express Server.

## Purpose

The script was written to automate the process of preparing an Express web application with the Pixelarity Standout template. It should run without incident on a new Amazon EC2 instance running Ubuntu. Once the template is integrated into the Express web application the developer can veer off into more meaningful study and coding.

## Process

0. Enable the Yarn repository. Import the repository’s GPG key using a curl command.
1. Add the Yarn APT repository to system software repository list.
2. Update the package list and install Yarn. This also installs Node. Install unzip and then install NPM last.
3. Install Express Generator. This allows the user to issue the *express* command at the BASH prompt.
4. Verify that all the packages have been properly installed at this point. Make sure to verify the version numbers because version 4.0.0 of the Express Generator was buggy.
5. Install html2pug so that there is a command line utility that will allow for the conversion of HTML to PUG. Pixelarity is marked up in HTML.
6. Create the web application skeleton by issuing the express command with arguments (SASS and PUG support is required for Pixelarity templates).
7. Download the Pixelarity template.
8. Install the template into the generic Express generated directory structure.
9. Start the web application on port 3000. Make sure that access is configured for the network interface over at Amazon.

## Execution
```sh
git clone https://github.com/usefulcoin/standout.git
cd standout
bash setup.bash
```

## Debugging

Change the debug mode to **true** in the setup.bash script.
