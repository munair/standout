#! /bin/bash
#
# script name: setup.bash
# script author: munair simpson
# script created: 20190426
# script purpose: spin up node/express with Pixelarity's Standout template

# disable/enable debugging.
debug="false" && echo [$0] set debug mode to "$debug".

# step 1: enable the Yarn repository. import the repository’s GPG key using the following curl command:
if $debug ; then curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add - ; fi
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add - > /dev/null 2>&1 && echo [$0] enabled the Yarn repository. imported the repository’s GPG key.

# step 2: add the Yarn APT repository to system software repository list.
if $debug ; then echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list ; fi
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list > /dev/null 2>&1 && echo [$0] added the Yarn APT repository to system software repository list

# step 3: update the package list and install Yarn. this also installs Node. install unzip and install NPM last.
if $debug ; then sudo apt -y update && sudo apt -y install unzip && sudo apt -y install yarn && sudo apt -y install npm ; fi
sudo apt -y update > /dev/null 2>&1 && echo [$0] updated APT packages.
sudo apt -y install unzip > /dev/null 2>&1 && echo [$0] installed unzip APT.
sudo apt -y install yarn > /dev/null 2>&1 && echo [$0] installed Yarn APT.
sudo apt -y install npm > /dev/null 2>&1 && echo [$0] installed NPM APT.

# step 4: install Express Generator.
if $debug ; then sudo npm install -g express-generator ; fi
sudo npm install -g express-generator > /dev/null 2>&1 && echo [$0] installed Express Generator.

# step 5: verify the installation of the Yarn APT, the Node APT, the NPM APT and ExpressJS via NPM.
yarnversion=$(yarn --version) && echo [$0] verified the installation of yarn version $yarnversion.
nodeversion=$(nodejs --version) && echo [$0] verified the installation of nodejs version $nodeversion.
npmversion=$(npm --version) && echo [$0] verified the installation of npm version $npmversion.
expressversion=$(express --version) && echo [$0] verified the installation of express version $expressversion.

# step 6: install html2pug.
if $debug ; then sudo npm install -g html2pug ; fi
sudo npm install -g html2pug > /dev/null 2>&1 && echo [$0] installed html2pug.

# step 7: create application skeleton.
express --css sass --view pug standout && echo [$0] created web application skeleton.
cd standout && yarn init && yarn install && echo [$0] application initialized and essential node modules installed.

# step 8: download Standout template.
# wget https://html5up.net/standout/download --output-document=/tmp/html5up-standout.zip && echo [$0] downloaded Standout template.
curl --location https://pixelarity.com/standout/download/html --output /tmp/html5up-standout.zip && echo [$0] downloaded Standout template.

# step 9: install template.
unzip /tmp/html5up-standout.zip -d /tmp/html5up-standout && echo [$0] unzipped templated download.
cp -R /tmp/html5up-standout/assets/fonts public && echo [$0] installed fonts.
cp /tmp/html5up-standout/assets/js/* public/javascripts && echo [$0] installed javascripts.
cp -R /tmp/html5up-standout/assets/sass public/stylesheets && echo [$0] installed sass modules.
cp /tmp/html5up-standout/assets/css/* public/stylesheets && echo [$0] installed stylesheets.
cp -R /tmp/html5up-standout/images public && echo [$0] installed images.
html2pug < /tmp/html5up-standout/index.html > /tmp/output.pug && sed -e 's#assets/css#stylesheets#g;s#assets/js#javascripts#g' /tmp/output.pug > views/index.pug && echo [$0] installed index.html.
html2pug < /tmp/html5up-standout/generic.html > /tmp/output.pug && sed -e 's#assets/css#stylesheets#g;s#assets/js#javascripts#g' /tmp/output.pug > views/generic.pug && echo [$0] installed generic.html.
html2pug < /tmp/html5up-standout/elements.html > /tmp/output.pug && sed -e 's#assets/css#stylesheets#g;s#assets/js#javascripts#g' /tmp/output.pug > views/elements.pug && echo [$0] installed elements.html.
rm -rf /tmp/output.pug && echo [$0] removing temporary file.
rm -rf /tmp/html5up-standout && echo [$0] removing temporary directory.
rm -rf /tmp/html5up-standout.zip && echo [$0] removing template zip download.

# step 10: start application
echo [$0] starting web application && DEBUG=standout:* yarn start
