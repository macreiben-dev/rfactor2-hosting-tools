# rfactor2-hosting-tools
A repository with a bunch of tools to ease Rf2 server creation.

## Documentation on how to create paid content

This guide is based on [rFactor 2 Quick Guide: Creating Custom RaceEvents](https://steamcommunity.com/sharedfiles/filedetails/?id=554544322)

On a computer with rfactor 2 game installed.

### Open MAS2 utility

#### First time setup

- Click on the 4th icon on the toolbar "Set package directory"
- In the game installation folder select the package folder

#### Create the package

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

### Checking that package works

- Start the game
- Go to single player
- Click on "Select series"
  - You should see you package name here

## Mod installation

### On a pc with RF2 game installed

- Launch the server 
- Select the package you created
- Go all the way to the point where the server is running.
- Go to steamapps\common\rFactor 2\UserData
- Grab ServerKeys.bin file
- Launch the game in single player
- Close the game
- Go to steamapps\common\rFactor 2\UserData
- Grab ServerUnlock.bin
- Go to steamapps\common\rFactor 2\Packages
- Grab the rfmod file related to your package

### On a PC with rf2 dedicated server installed

- Copy ServerKeys.bin and ServerUnlock.bin to dedicated server UserData folder
- Copy all elements used by your mas package to installed folder

- Create a shortuct to your mod manager with the working dir as the game installation folder
  - Example C:\SteamLibrary\steamapps\common\rFactor 2\Bin64
  - other wise the mod manager won't be able to load your installed mods/tracks.
- Open mod manager using the created shortcut
