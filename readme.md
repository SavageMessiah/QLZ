## It's a Doom launcher!
### Supported Ports

Most sane ports should work fine, but I've only really tried the following [ports.

+ (G)zdoom
+ chocolate doom / crispy doom
+ prboom+
+ zandronum (for most things)

### Supported file types
These are the file types that the launcher knows the appropriate command line parameter for.

+ wad, pk3, pk7
+ zdoom savegames (zds)
+ chocolate doom savegames (dsg)
+ ini files
+ cfg files (-config in chocolate, +exec in zdoom/zandronum)
+ demo lumps
+ deh files

Sorry, no support for loading directories in zdoom yet. I need to add that.

### A Brief Guide To Doing Doom Stuff

#### Example Setup for GZDoom
1. Download QLZ from https://bitbucket.org/SavageMessiah/qlz/downloads/Launcher.exe. Stick the exe in your gzdoom directory.
2. Copy your doom.wad, doom2.wad, etc from wherever they are now into the gzdoom directory.
3. Run launcher.exe
4. Select gzdoom.exe for the gzdoom location
5. Select your gzdoom directory as the IWAD directory

#### To Play Something
1. Select the IWAD you want from the list
2. Click and drag the wads you want into additional files
3. Use up and down to rearrange the files if needed - sometimes load order matters.
4. Click Launch

It will remember all those settings between runs. If you want to switch between different things you play a lot, type a name in for the profile (at the bottom) and click save. Then you can switch profiles by selecting one and clicking load.

I rather like adding my gzdoom savegame to my profile for a megawad that I'm playing (I usually only play 1 or 2 levels at a time). Then I can just hit launch and get dropped right back into the action.
