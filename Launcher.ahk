#SingleInstance
INI_FILENAME = launcher.ini
IWAD_FILES = doom1.wad|doom.wad|doomu.wad|bfgdoom.wad|doombfg.wad|doom2.wad|bfgdoom2.wad|doom2bfg.wad|freedoom.wad|freedoom1.wad|freedoom2.wad|freedoomu.wad|freedm.wad|delaweare.wad|tnt.wad|plutonia.wad|heretic1.wad|heretic.wad|hexen.wad|strife.wad|strife0.wad|strife1.wad|sve.wad|chex.wad|chex3.wad|action2.wad|harm1.wad|hacx.wad|hacx2.wad|rotwb.wad|blasphem.wad|blasphemer.wad|square1.pk3|square.pk3|doom_complete.pk3

Title = Quickly Launchering Doom v1.7

Cmd := ""
Files := ""
Levels := ""
Pos := ""
Profiles := ""
Ports := ""

Loop, 32 {
    level := "MAP"
    if( StrLen(A_Index) == 1 )
        level = %level%0%A_Index%
    else
        level = %level%%A_Index%
    levels = %level%|%levels%
}
Loop, 4 {
    episode := A_Index
    Loop, 9
	levels = E%episode%M%A_Index%|%levels%
}

Gui, Add, Text, Section, Port Location
Gui, Add, Text, , IWAD Directory
Gui, Add, Text, , IWAD
Gui, Add, ComboBox, w200 Section YS vPort
Gui, Add, Edit, w200 XS vIwadDir
Gui, Add, DropDownList, XS vIwad W100
Gui, Add, Button, YS Center Section gSetPort, ...
Gui, Add, Button, XS Center gSetDir, ...
Gui, Add, Text, XM Section, Additional Files
Gui, Add, ListBox, R10 W330 Multi vFileDisplay HScroll, %filelist%
Gui, Add, Button, W75 Center Section gAdd, &Add File
Gui, Add, Button, W75 YS Center gRemove, &Remove File
Gui, Add, Button, W35 YS Center gUp, &Up
Gui, Add, Button, W35 YS Center gDown, &Down
Gui, Add, Button, W75 YS Center gClear, &Clear List
Gui, Add, Text, X15 Y+30 Section, Mode
Gui, Add, Text, , Skill
Gui, Add, Text, , Level
Gui, Add, DropDownList, YS Section Right vMode W100 gChangeMode, Client|Server|Single||
Gui, Add, DropDownList, W100 AltSubmit vSkill, Easy|Medium|Hard|UltraViolence|Nightmare| ||
Gui, Add, ComboBox, W100 vLevel, %Levels%
Gui, Add, Text, YS Section, Host IP
Gui, Add, Text, , Players
Gui, Add, CheckBox, Y+15 Checked vCheats, Cheats?
Gui, Add, Edit, YS Section W100 vIP
Gui, Add, Edit, W20 vPlayers Number,
Gui, Add, CheckBox, vItemRespawn, Item Respawn?
Gui, Add, Text, X15 Section, Params
Gui, Add, Edit, YS W230 vOptions R1
Gui, Add, Button, YS gHelp, ?
Gui, Add, Text, XM Y+10 Section, Profile
Gui, Add, ComboBox, W150 YS vCurrentProfile
Gui, Add, Button, YS Center gLoad, &Load
Gui, Add, Button, YS Center gSave, &Save
Gui, Add, Button, YS Center gDelete, &Delete
Gui, Add, Button, XM Y+5 W150 Section Center gLaunch default, &Launch
Gui, Add, Button, YS Center gShowCmd, &Preview
Gui, Add, GroupBox, X10 Y290 W330 H130, Options
Gui, Add, CheckBox, X270 Y345 vDeathmatch, DM

Menu, Tray, NoStandard
Menu, Tray, Add, Show, Show
Menu, Tray, Add, Exit, GuiClose
Menu, Tray, Default, Show

LoadSettings()
if( Pos = "" ) {
    Pos := "Center"
}
Gui, Show, AutoSize %Pos%, %Title%
return

Show:
    WinRestore, %Title%
    WinActivate, %Title%
return

SetDir:
    FileSelectFolder, folder, *%A_ScriptDir%, 0, Select IWAD Directory
    GuiControl, Text, IwadDir, %folder%
	GoSub, GetIwads
return

SetPort:
    FileSelectFile, file, 3, %A_WorkingDir%\gzdoom.exe, Select Port, Executables (*.exe)
    if( file = "" )
        return
    if( !InStr(Ports, file) ) {
        Ports := Ports . "|" . file
    }
    GuiControl, , Port, %Ports%
    GuiControl, ChooseString, Port, %file%
return

Add:
    FileSelectFile, selectedfiles, M3, ,Select File, Doom Files (*.wad; *.pk3; *.pk7; *.deh; *.cfg; *.dsg; *.zds; *.lmp; *.ini)
    if selectedfiles =
	return
    path := ""
    Loop, Parse, selectedfiles, `n
	if A_Index = 1
	    path := A_LoopField
	else
	    Files = %path%\%A_LoopField%|%Files%
    GuiControl, , FileDisplay, |%Files%
return

GuiDropFiles:
    Loop, parse, A_GuiEvent, `n
        if( RegExMatch( A_LoopField, "i)(wad|pk3|pk7|deh|cfg|dsg|zds|lmp|ini)$") > 0)
            Files = %A_LoopField%|%Files%
    GuiControl, , FileDisplay, |%Files%
return

Clear:
    GuiControl, , FileDisplay,|
    Files := ""
return

Remove:
    Gui, Submit, NoHide
    Loop, Parse, FileDisplay, |
	StringReplace, Files, Files, %A_LoopField%|
    GuiControl, ,FileDisplay, |%Files%
return

Up:
    Gui, Submit, NoHide
    StringSplit, selected, FileDisplay, |
    if( selected0 != 1 ) {
        Msgbox, Please select one file.
        return
    }

    StringSplit, farray, Files, |
    if( farray0 < 2 )
        return
    Loop, %farray0%
        if( farray%A_Index% = selected1 ) {
            if( A_Index = 1 )
                return
            field := A_Index - 1
            temp := farray%field%
            farray%field% := selected1
            farray%A_Index% := temp
            Break
        }

    Files := ""
    Loop, %farray0%
        if( farray%A_Index% != "" )
            Files := Files . farray%A_Index% . "|"

    GuiControl, , FileDisplay, |%Files%
    GuiControl, ChooseString, FileDisplay, %selected1%
return

Down:
    Gui, Submit, NoHide
    StringSplit, selected, FileDisplay, |
    if( selected0 != 1 ) {
        Msgbox, Please select one file.
        return
    }

    StringSplit, farray, Files, |
    if( farray0 < 2 )
        return
    Loop, %farray0%
        if( farray%A_Index% = selected1 ) {
            if( A_Index = farray0 - 1 )
                return
            field := A_Index + 1
            temp := farray%field%
            farray%field% := selected1
            farray%A_Index% := temp
            Break
        }

    Files := ""
    Loop, %farray0%
        if( farray%A_Index% != "" )
            Files := Files . farray%A_Index% . "|"

    GuiControl, , FileDisplay, |%Files%
    GuiControl, ChooseString, FileDisplay, %selected1%
return

MakeCmd:
    Gui, Submit, NoHide
    cmd = "%Port%" -iwad
    cmd = %cmd% "%IwadDir%\%Iwad%"
    cmd = %cmd% %Options%
    wads := ""
    Loop, Parse, Files, |
        if( RegexMatch(A_LoopField, "i)deh$") ) {
            cmd = %cmd% -deh "%A_LoopField%"
        } else if( RegexMatch(A_LoopField, "i)cfg$") ) {
            if( Chocolate() )
                cmd = %cmd% -config "%A_LoopField%"
            else
                cmd = %cmd% +exec "%A_LoopField%"
        } else if( RegexMatch(A_LoopField, "i)ini$") && !Chocolate() ) {
            cmd = %cmd% -config "%A_LoopField%"
        } else if( RegexMatch(A_LoopField, "i)dsg$") && Chocolate() ) {
            cmd = %cmd% -loadgame "%A_LoopField%"
        } else if( RegexMatch(A_LoopField, "i)zds$") && !Chocolate() ) {
            cmd = %cmd% -loadgame "%A_LoopField%"
        } else if( RegexMatch(A_LoopField, "i)lmp$") ) {
            cmd = %cmd% -playdemo "%A_LoopField%"
        } else if( A_LoopField != "" ) {
                wads = %wads%|%A_LoopField%
        }
    if( Mode = "Client" ) {
        If( Chocolate() )
            cmd = %cmd% -connect %IP%
        else if ( Skulltag() && IP != "" )
            cmd = %cmd% +connect %IP%
        else
            cmd = %cmd% -join %IP% -netmode 1
    } else {
        if( Level != "" ) {
            if( Chocolate() ) {
                chocolevel := RegExReplace(Level,"i)[A-Z]"," ")
                cmd = %cmd% -warp %chocolevel%
            } else
                cmd = %cmd% +map %Level%
        }
        if( Mode = "Server" ) {
            if( Chocolate() )
                cmd = %cmd% -server
            else if( Skulltag() )
                cmd = %cmd% -host +sv_maxplayers %Players% +sv_maxclients %Players%
            else
                cmd = %cmd% -host %Players% -netmode 1

            if( DeathMatch ) 
                cmd = %cmd% -deathmatch
        }
        if( ItemRespawn = 1 )
            cmd = %cmd% +sv_itemrespawn 1
        if( Cheats = "1" )
            cmd = %cmd% +sv_cheats 1
        if( Skill != "6" )
            cmd = %cmd% -skill %Skill%
    }
    if( wads != "") {
        cmd = %cmd% -file 
        Loop, Parse, wads, |
            if( A_LoopField != "") {
                cmd = %cmd% "%A_LoopField%"
            }
    }
return

Chocolate() {
    global Port
    return RegExMatch( Port, "i)(chocolate-doom|boom-plus|crispy)" ) > 0
}

SkullTag() {
    global Port
    return RegExMatch( Port, "i)skulltag|zandronum" ) > 0
}

PrBoom() {
    global Port
    return RegExMatch( Port, "i)boom-plus" ) > 0
}

ZDoom() {
    global Port
    return RegExMatch( Port, "i)zdoom" ) > 0
}

Validate() {
    Gui, Submit, NoHide
    global Port, IwadDir, Iwad
    if( StrLen(Port) == 0 ) {
        MsgBox, You need to specify a port!
        return 0
    }
    if( StrLen(IwadDir) == 0 || StrLen(Iwad) == 0 ) {
        MsgBox, You need to specify an Iwad dir and an Iwad!
        return 0
    }
    return 1
}

Launch:
    if( Validate() == 0 )
        return
    GoSub, MakeCmd
    SaveSettings()
    SplitPath, Port, , dir
    Run, %cmd%, %dir%
return

ShowCmd:
    if( Validate() == 0 )
        return
    GoSub, MakeCmd
    MsgBox, %cmd%
return

Save:
    Gui, Submit, NoHide
    SaveSettings("Default")
    if( CurrentProfile != "" )
        SaveSettings(CurrentProfile)
return

Load:
    Gui, Submit, NoHide
    if( !(CurrentProfile = "") && InStr(Profiles, CurrentProfile) )
        LoadSettings(CurrentProfile)
return

Delete:
    Gui, Submit, NoHide
    MsgBox, 1, Delete Profile?, Really delete profile %CurrentProfile%?
    IfMsgBox, Cancel
        return
    IniDelete, %INI_FILENAME%, %CurrentProfile%
    StringReplace, Profiles, Profiles, |%CurrentProfile%
    GuiControl, , CurrentProfile, %Profiles%
    if( Profiles = "" )
        GuiControl, Text, CurrentProfile, 
    Save("profiles",Profiles,"Default")
return

Help:
    Gui, Submit, NoHide
    if( Chocolate() && !PrBoom() )
        Run, http://www.chocolate-doom.org/wiki/index.php/Command_line_arguments 
    else if( Skulltag() )
        Run, http://wiki.zandronum.com/Command_Line_Parameters
    else if( Zdoom() )
        Run, http://zdoom.org/wiki/Command_line_parameters
    else
        Run, http://doomwiki.org/wiki/Source_port_parameters
return

ChangeMode:
    Gui, Submit, NoHide
    if( Mode = "Single" ) {
        GuiControl, Disable, IP
        GuiControl, Disable, Players
        GuiControl, Disable, Deathmatch
    } else if( Mode = "Server" ) {
        GuiControl, Disable, IP
        GuiControl, Enable, Players
        GuiControl, Enable, Deathmatch
    } else if( Mode = "Client" ) {
        GuiControl, Enable, IP
        GuiControl, Disable, Players
        GuiControl, Disable, Deathmatch
    }
return

SaveSettings(profile="Default") {
    global Iwad, Files, Level, Cheats, ItemRespawn, Skill, Options, IP, Mode, Players, 
    global IwadDir, Port, Profiles, CurrentProfile, Ports, Deathmatch
    if( profile != "Default" ) {
        if( !InStr(Profiles,profile) ) {
            Profiles := Profiles . "|" . profile
        }
    }
    Save("iwad",Iwad,profile)
    Save("files",Files,profile)
    Save("level",Level,profile)
    Save("cheats",Cheats,profile)
    Save("respawn",ItemRespawn,profile)
    Save("skill",Skill,profile)
    Save("options",Options,profile)
    Save("ip",IP,profile)
    Save("mode",Mode,profile)
    Save("players",Players,profile)
    Save("iwaddir",IwadDir,profile)
    Save("port",Port,profile)
    Save("deathmatch",Deathmatch,profile)
    WinGetPos, X, Y, W, H, ahk_class AutoHotkeyGUI
    Save("pos","X" . X . " " . "Y" . Y,"Default")
    Save("profiles",Profiles,"Default")
    Save("profile",CurrentProfile,"Default")
    Save("ports",Ports,"Default")
}

LoadSettings(profile="Default") {
    global INI_FILENAME, Pos, Profiles, Files, Ports
    ifExist %INI_FILENAME%
    {
        Files := Load("files",profile)
        GuiControl, Text, FileDisplay, |%Files%
        GuiControl, Text, Level, % Load("level",profile)
        GuiControl, , Cheats, % Load("cheats",profile)
        GuiControl, , ItemRespawn, % Load("respawn",profile)
        GuiControl, , Deathmatch, % Load("deathmatch",profile)
        GuiControl, Choose, Skill, % Load("skill",profile)
        GuiControl, , Options, % Load("options",profile)
        GuiControl, , IP, % Load("ip",profile)
        GuiControl, ChooseString, Mode, % Load("mode",profile)
        GuiControl, , Players, % Load("players",profile) 
        GuiControl, , IwadDir, % Load("iwaddir",profile)
        GoSub, GetIwads
        GuiControl, ChooseString, Iwad, % Load("iwad",profile)
        Ports := Load("ports","Default")
        GuiControl, , Port, %Ports%
        GuiControl, ChooseString, Port, % Load("port",profile)
        Pos := Load("pos","Default")
        Profiles := Load("profiles","Default")
        GuiControl, , CurrentProfile, %Profiles%
        if(profile != "Default") {
            p := profile
        } else {
            p := Load("profile","Default")
        }
        GuiControl, ChooseString, CurrentProfile, %p%
    }
    GoSub, ChangeMode
}

GetIwads:
    Gui, Submit, NoHide
    if( IwadDir != "" ) {
        Iwads := ""
        Between := "||"
        if( FileExist(IwadDir) ) {
            Loop, %IwadDir%\*.wad {
                if( InStr(IWAD_FILES, A_LoopFileName) ) {
                    Iwads = %Iwads%%A_LoopFileName%%Between%
                    Between := "|"
                }
            }
            Loop, %IwadDir%\*.pk3 {
                if( InStr(IWAD_FILES, A_LoopFileName) ) {
                    Iwads = %Iwads%%A_LoopFileName%%Between%
                    Between := "|"
                }
            }
        }
        ifExist %IwadDir% 
        GuiControl, Text, Iwad, |%Iwads%
    }
return

Save(key, value, section="save") {
    global INI_FILENAME
    IniWrite, %value%, %INI_FILENAME%, %section%, %key%
}

Load(key, section="save") {
    global INI_FILENAME
    IniRead, value, %INI_FILENAME%, %section%, %key%
    return value
}

GuiClose:
GuiEscape:
ExitApp
