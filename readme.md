## It's a Doom launcher!
### Supported Ports

Most sane ports should work fine, but I've only really tried the following [ports.

+ (G)zdoom
+ chocolate doom / crispy doom
+ prboom+
+ zandronum (for most things)

### Supported file types
These are the file types that the launcher knows the appropriate command line parameter for.

+ wad, pk3
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

BSD Licensed, if you care:

Copyright 2010 Ken Allen (SavageMessiah). All rights reserved.

Redistribution and use in source and binary forms, with or without modification, are
permitted provided that the following conditions are met:

   1. Redistributions of source code must retain the above copyright notice, this list of
      conditions and the following disclaimer.

   2. Redistributions in binary form must reproduce the above copyright notice, this list
      of conditions and the following disclaimer in the documentation and/or other materials
      provided with the distribution.

THIS SOFTWARE IS PROVIDED BY KEN ALLEN ``AS IS'' AND ANY EXPRESS OR IMPLIED
WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> OR
CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

The views and conclusions contained in the software and documentation are those of the
authors and should not be interpreted as representing official policies, either expressed
or implied, of Ken Allen.
