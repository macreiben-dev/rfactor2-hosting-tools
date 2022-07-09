# rfactor2-hosting-tools

A repository with a bunch of tools and resources to ease Rf2 server usage.

This guide is based on:
- [rFactor 2 Quick Guide: Creating Custom RaceEvents](https://steamcommunity.com/sharedfiles/filedetails/?id=554544322)
- [rFactor2 Dedicated Hosting (on AWS for free)](https://github.com/afloesch/rfactor2-server-setup)

To do so, you need a license of the rFactor 2 game plus the DLCs you wish to add to the server.

# Installing the dedicated server

## Pre requisite

- A **directory** on the target computer with **read/write access**
- The target computer has **access to internet**.

## Installation scenario

- Create directory on the target computer
- Copy the script [install-new-dedicated-server](./installation-scripts/install-new-dedicated-server.ps1)
  - Set the *Rf2InstallationDirectory* parameter to set the dedicated server installation path
- Run the script

The steamcmd archive is downloaded to the current directory. Then the steamcmd command is invoked to download rFactor2 dedicated server.

## Generating the shortcuts

- Copy the [install-create-serverShortcut](./installation-scripts/install-create-serverShortcut.ps1) to the target computer
- Launch the script with *ServerInstallPath* and *ShortcutSuffix* parameters
- By default, the shortcut are generated at the same level as the script.
  - Set *ShortcutDestinationPath* so specify a custom destination.

## Download items from the workshop

In order to have tracks and car on the dedicated server, you need to download the addons you wish to use to you dedicated server Packages folder.

- Copy the [download-item-workshop.ps1](./installation-scripts/download-item-workshop.ps1) to the target computer
- Set *SteamCMDFolder* to the steamCMD folder path
- To pass workshop item, you have to options
  - Comma separated list using the *WorkshopItems* parameter
  - A file with one item id per row using the *ItemsIdFilePath* parameter

### How to get the workshop item id ?

- Go to steam from a webbrowser. 
- For free content
  - Then go to rFactor 2 workshop and look for the url *workshop/community/filedetails?id=123456789*
  - The id parameter is the one to use with the scripts
- For paid content
  - **Login** to steam
  - Go to your **profile**
  - Click on **your name > Inventory**
  - Select **rFactor 2**
  - Click on a **badge** then on the left "**See workshop item**"
  - You land on an error page, but the url is *sharedfiles/filedetails/?id=123456789*
  - The **id parameter** is the one to use with the scripts

# Allow DLCs on your server

## On the dedicated server computer

- On the **dedicated server computer launch the server once**
- Grab the **ServerKeys.bin** file
- Send it **to your gaming PC** with rFactor 2 installed

## On the gaming computer with rF2 installed

- Copy the *ServerKeys.bin* file to the **UserData** folder of your **rFactor2 game installation**
- **Launch the game** and get to the main menu
- **Close the game**
- Go to the **UserData** folder of your **rFactor2 game **
- Grab **ServerUnlock.bin**
- Send it to the dedicated server computer

## On the dedicated server computer

- Copy **ServerUnlock.bin** to the dedicated server UserData folder - **replacing the existing one**.

## How to check keys are ok ?

- Launch mod manager using the generated shortcut
- OK: **title** should have "**keys loaded**"

# Make DLCs available to the dedicated server

SteamCMD has downloaded the items from the workshop, but they are not installed in the dedicated server yet.

## Copy the DLCs to the dedicated server

- Copy [copy-dlc-to-packages.ps1](./installation-scripts/copy-dlc-to-packages.ps1) to the dedicated server computer
- Set SteamCMDFolder and ServerInstallationDirectory
- Launch the script

## Install the DLCs on the dedicated server

- Launch mod manager, and ensure you see "keys loaded" in the title
- Select the DLCs you want to install
- Click install

The workshop item are downloaded as rfcmp file in the steamCMD content folder. The script recursively copy them to the Packages folder of the dedicated server installation.

# Create a serie on the dedicated server

## Open MAS2 utility

### First time setup

- On the **toolbar**, click on the **4th icon from the left**, "Set package directory"
- Select the **dedicated server Packages folder**

### Create the package

- Click on the 6th icon on the toolbar to create a package
- Click on "Create New Mod Package"
  - Give the mod a name
- Select the track(s)
- Select the car(s)
- You arrive at the Create Mod Package screen

![Create mod package screen](./assets/createModPackage.png)

- Click package
- Click install
- Click done

# Create a steam item

Based on this guide [Publishing to the Steam Workshop](https://steamcommunity.com/sharedfiles/filedetails/?id=553110627).

- In a folder copy the rfcm file of your mode
- Create a text file with a vdf extension
- Use the vdf body bellow

```vdf
"workshopitem"
{
	"appid"		"365960"
	"publishedfileid"		"0"
	"contentfolder"		"<CURRENTFOLDER_ABSOLUTE_PATH_HERE>\OutSteam\content"
	"previewfile"		"<CURRENTFOLDER_ABSOLUTE_PATH_HERE>\OutSteam\preview.jpg"
	"visibility"		"0"
	"title"		"<TITLE_DISPLAYED_IN_STEAM>"
	"description"		"<DESCRIPTION_OF_THE_ITEM_IN_STEAM>"
	"changenote"		"<CHANGENOTE_OF_THE_ITEM_IN_STEAM>"
}
```
Path have to be set in an absolute way to work. The OutSteam folder contains a content folder. The content folder contains the rfcmp file we created for the car.

- Copy [uploadToSteam.ps1](./steam-publication-scripts/uploadToSteam.ps1) to the CURRENTFOLDER_ABSOLUTE_PATH
- Replace the login and password parameters
- Run the script

## Post upload tasks

Once the upload is done, the vdf file publishedfileid is updated to the file id of your item.

This id is the one the item url :

```
https://steamcommunity.com/sharedfiles/filedetails/?id=123456789
```

The VDF file has to be kept for the next update.