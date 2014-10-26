; Code by Rchockxm (rchockxm.silver@gmail.com)

#NoTrayIcon
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Outfile=Palo_ETL_Client_Tools.exe
#AutoIt3Wrapper_Outfile_x64=Palo_ETL_Client_Tools64.exe
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_Compile_Both=y
#AutoIt3Wrapper_UseX64=y
#AutoIt3Wrapper_Res_Comment=Commandline Tools for Palo ETL Server
#AutoIt3Wrapper_Res_Description=Palo ETL Server Tools
#AutoIt3Wrapper_Res_Fileversion=1.1.0.0
#AutoIt3Wrapper_Res_LegalCopyright=Silence Unlimited, Inc
#AutoIt3Wrapper_Res_requestedExecutionLevel=asInvoker
#AutoIt3Wrapper_Run_Au3Stripper=y
#Au3Stripper_Parameters=/striponly
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Run_Obfuscator=y
#Obfuscator_Parameters=/striponly
#include <WindowsConstants.au3>
#include <GUIConstantsEx.au3>
#include <EditConstants.au3>
#include <StaticConstants.au3>
#include <ComboConstants.au3>

Opt("TrayIconHide", 1)
Opt("MustDeclareVars", 1)

Global $Obj_Error = ObjEvent("AutoIt.Error", "MyErrFunc")

Global $ETL_Location = RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\Palo Web - ETL Server", "Install_Dir")
Global $ETL_Test = ""

If $CmdLine[0] > 0 Then
	$ETL_Test = $CmdLineRaw
EndIf

Global $Hwnd = GUICreate("Palo ETL Server Commandline Tools 1.1 by Rchockxm", 600, 390, Default, Default, Bitor($WS_CAPTION, $WS_BORDER, $WS_SYSMENU))
Global $Input_1 = GUICtrlCreateInput($ETL_Location, 124, 3, 450, 16)
Global $Button_1 = GUICtrlCreateButton("...", 578, 2, 18, 18)
Global $Combox_1 = GUICtrlCreateCombo("", 4, 42, 100, 20, $CBS_DROPDOWNLIST)
Global $Input_2 = GUICtrlCreateInput("", 110, 42, 100, 20)
Global $Edit_R = GUICtrlCreateEdit("", 216, 42, 380, 70, Bitor($ES_AUTOVSCROLL, $WS_VSCROLL, $ES_WANTRETURN))
Global $Input_3 = GUICtrlCreateInput("", 4, 92, 206, 20)
Global $Label_A = GUICtrlCreateLabel("&Add", 445, 120, 25, 14)
Global $Label_B = GUICtrlCreateLabel("&Cls", 470, 120, 25, 14)
Global $Label_C = GUICtrlCreateLabel("&Copy", 495, 120, 30, 14)
Global $Input_4 = GUICtrlCreateInput($ETL_Test, 4, 136, 520, 20)
Global $Button_2 = GUICtrlCreateButton("&Run", 528, 136, 70, 20)
Global $Edit_B1 = GUICtrlCreateEdit("", 4, 178, 294, 180, Bitor($ES_AUTOVSCROLL, $WS_VSCROLL, $ES_WANTRETURN))
Global $Edit_B2 = GUICtrlCreateEdit("", 302, 178, 294, 180, Bitor($ES_AUTOVSCROLL, $WS_VSCROLL, $ES_WANTRETURN))
Global $Label_L = GUICtrlCreateLabel("Silence Unlimited", 150, 366, 100)
Global $Button_3 = GUICtrlCreateButton("&Etlclient.bat", 256, 364, 70, 20)
Global $Button_4 = GUICtrlCreateButton("&Log.txt", 328, 364, 70, 20)
Global $Button_5 = GUICtrlCreateButton("&Copy", 456, 364, 70, 20)
Global $Button_6 = GUICtrlCreateButton("&Clear", 528, 364, 70, 20)
Global $Label_S = GUICtrlCreateLabel("Ready...", 4, 368, 100)

Global $MenuDummy = GUICtrlCreateDummy()
Global $MenuContext = GUICtrlCreateContextMenu($MenuDummy)
Global $Menu_Copy1 = GUICtrlCreateMenuItem("Copy - Etlclient.bat", $MenuContext)
Global $Menu_Copy2 = GUICtrlCreateMenuItem("Copy - Exec Log", $MenuContext)

GUICtrlCreateLabel("Palo Web - ETL Server:", 4, 6, 120, 14)
GUICtrlCreateLabel("Option:", 4, 26, 120, 14)
GUICtrlCreateLabel("Parameters:", 110, 26, 120, 14)
GUICtrlCreateLabel("Description:", 216, 26, 120, 14)
GUICtrlCreateLabel("Example:", 4, 76, 120, 14)
GUICtrlCreateLabel("Commandline:", 4, 120, 120, 14)
GUICtrlCreateLabel("Etlclient.bat:", 4, 162, 120, 14)
GUICtrlCreateLabel("Log.txt:", 302, 162, 120, 14)

GUICtrlSetData($Combox_1, "-a|-c|-d|-e|-g|-h|-i|-j|-l|-ll|-m|-n|-o|-p|-r|-s|-t|-v", "")

SetLabelFontURL($Label_A)
SetLabelFontURL($Label_B)
SetLabelFontURL($Label_C)
SetLabelFontURL($Label_L)
GetSpeciedFile($ETL_Location & "\client\etlclient.bat", $Edit_B1)
GetSpeciedFile($ETL_Location & "\client\logs\etlclient.log", $Edit_B2)

GUISetState(@SW_SHOW)
GUIRegisterMsg($WM_COMMAND, "WM_COMMAND")

Global $Msg, $Str_Return

While 1
   $Msg = GUIGetMsg()

   Switch $Msg
		Case $GUI_EVENT_CLOSE
			ExitLoop
		Case $Label_A
			GUICtrlSetData($Input_4, GUICtrlRead($Input_4) & " " & GUICtrlRead($Combox_1) & " " & GUICtrlRead($Input_2))
		Case $Label_B
			GUICtrlSetData($Input_4, "")
		Case $Label_C
			ClipPut(GUICtrlRead($Input_4))
		Case $Label_L
			ShellExecute("http://rchockxm.com")
		Case $Button_1
			Local $Ret = FileSelectFolder("Select Palo Web - ETL Server Folder", @ProgramFilesDir & "\", 6, "", $Hwnd)
			If $Ret Then
				GUICtrlSetData($Input_1, $Ret)
				GetSpeciedFile(GUICtrlRead($Input_1) & "\client\etlclient.bat", $Edit_B1)
				GetSpeciedFile(GUICtrlRead($Input_1) & "\client\logs\etlclient.log", $Edit_B2)
				$ETL_Location = $Ret
			EndIf
		Case $Button_2
			GUICtrlSetData($Label_S, "Exectue...")
			FileChangeDir($ETL_Location & "\client")
			RunWait("etlclient.bat " & GUICtrlRead($Input_4), "", @SW_HIDE)
			GetSpeciedFile($ETL_Location & "\client\etlclient.bat", $Edit_B1)
			GetSpeciedFile($ETL_Location & "\client\logs\etlclient.log", $Edit_B2)
			GUICtrlSetData($Label_S, "Succees!!")
		Case $Button_3
			GetSpeciedFile($ETL_Location & "\client\etlclient.bat", $Edit_B1)
		Case $Button_4
			GetSpeciedFile($ETL_Location & "\client\logs\etlclient.log", $Edit_B2)
		Case $Button_5
            ShowMenu($Hwnd, $Msg, $MenuContext)
        Case $Button_6
			GUICtrlSetData($Input_4, "")
			GUICtrlSetData($Edit_B1, "")
			GUICtrlSetData($Edit_B2, "")
		Case $Menu_Copy1
			ClipPut(GUICtrlRead($Edit_B1))
		Case $Menu_Copy2
			ClipPut(GUICtrlRead($Edit_B1))
	EndSwitch
WEnd

GUIDelete()

Func WM_COMMAND($hWnd, $iMsg, $iwParam, $ilParam)
    #forceref $hWnd, $iMsg
    Local $hWndFrom, $iIDFrom, $iCode

    $hWndFrom = $ilParam
    $iIDFrom = BitAND($iwParam, 0xFFFF)
    $iCode = BitShift($iwParam, 16)

    Switch $hWndFrom
        Case GUICtrlGetHandle($Combox_1)
            Switch $iCode
                Case $CBN_SELCHANGE
					GetCommandlineDes(GUICtrlRead($Combox_1))
             EndSwitch
	EndSwitch

    Return $GUI_RUNDEFMSG
EndFunc

Func ShowMenu($hWnd, $CtrlID, $nContextID)
    Local $arPos, $x, $y
    Local $hMenu

	$hMenu = GUICtrlGetHandle($nContextID)
    $arPos = ControlGetPos($hWnd, "", $CtrlID)

    $x = $arPos[0]
    $y = $arPos[1] + $arPos[3]

    ClientToScreen($hWnd, $x, $y)
    TrackPopupMenu($hWnd, $hMenu, $x, $y)
EndFunc

Func TrackPopupMenu($hWnd, $hMenu, $x, $y)
    DllCall("user32.dll", "int", "TrackPopupMenuEx", "hwnd", $hMenu, "int", 0, "int", $x, "int", $y, "hwnd", $hWnd, "ptr", 0)
EndFunc

Func ClientToScreen($hWnd, ByRef $x, ByRef $y)
    Local $stPoint = DllStructCreate("int;int")

    DllStructSetData($stPoint, 1, $x)
    DllStructSetData($stPoint, 2, $y)
    DllCall("user32.dll", "int", "ClientToScreen", "hwnd", $hWnd, "ptr", DllStructGetPtr($stPoint))

    $x = DllStructGetData($stPoint, 1)
    $y = DllStructGetData($stPoint, 2)
    $stPoint = 0
EndFunc

Func GetCommandlineDes($Switch_V)
	Local $Str_Par, $Str_Desc

	Switch $Switch_V
		Case "-a"
			$Str_Par = "<projectfile>"
			$Str_Desc = "Add the specified project to the server. " & _
			            "The path to the project file can be set globally or locally"
		Case "-c"
			$Str_Par = "<variable>=<value>"
			$Str_Desc = "Set context variables to use for execution for jobs, " & _
			            "exports and sources."
		Case "-d"
			$Str_Par = "<sourcename>"
			$Str_Desc = "Display data from the specified source. Intended for testing. " & _
			            "Valid only in combination with -p option"
		Case "-e"
			$Str_Par = "<exportname>"
			$Str_Desc = "Execute the specified export of the project. Valid only" & _
                    	" in combination with -p option."
		Case "-g"
			$Str_Par = "<projectname>"
			$Str_Desc = "Get a project from serve."
		Case "-h"
			$Str_Par = ""
			$Str_Desc = "Show help messag."
		Case "-i"
			$Str_Par = ""
			$Str_Desc = "Get Info about the server status and the jobs running."
		Case "-j"
			$Str_Par = "<jobname>"
			$Str_Desc = "Execute the specified job of the project. If no job is" & _
			            " specified, the default job of a project is processed. Valid " & _
						"only in combination with the -p option."
		Case "-l"
			$Str_Par = ""
			$Str_Desc = "List all projects on the serve."
		Case "-ll"
			$Str_Par = "<level>"
			$Str_Desc = "Set the log level. Possible values: OFF, FATAL, ERROR, WARN," & _
 			            " INFO, DEBUG, ALL. Valid only in combination with -p option"
		Case "-m"
			$Str_Par = "<projectfile>"
			$Str_Desc = "Migrate project definition to the current definition standar."
		Case "-n"
			$Str_Par = "<size>"
			$Str_Desc = "Limitation of data from a source to sample of n. Valid only in" & _
			            " combination with the -d option."
		Case "-o"
			$Str_Par = "<filename>"
			$Str_Desc = "Write output to a fil."
		Case "-p"
			$Str_Par = "<projectname>"
			$Str_Desc = "Execute specified project. The project has to be added to the" & _
			            " server with option -a before."
		Case "-r"
			$Str_Par = "<projectname>"
			$Str_Desc = "Remove the specified project from server"
		Case "-s"
			$Str_Par = "<name[:port]>"
			$Str_Desc = "IP-Address of ETL Server. Obligatory for Client-Server mode: If omitted the" & _
			            " ETL-process is started in Stand-alone mode with SSL: -s https://localhost:8443 or" & _
						" -s https://localhost or -s localhost without SSL: -s http://localhost:8082 or -s http://localhost"
		Case "-t"
			$Str_Par ="<execution-id>"
			$Str_Desc = "Terminate a running execution by its id."
		Case "-v"
			$Str_Par = "<projectfile>"
			$Str_Desc = "Validate the correctness of a project definitio."
	EndSwitch

	GUICtrlSetData($Input_2, $Str_Par)
	GUICtrlSetData($Edit_R, $Str_Desc)
	GUICtrlSetData($Input_3, GUICtrlRead($Combox_1) & " " & $Str_Par)
	GUICtrlSetData($Input_4, GUICtrlRead($Input_4) & " " & GUICtrlRead($Combox_1) & " " & $Str_Par)
EndFunc

Func GetSpeciedFile($V_Path, $C_IDs)
	GUICtrlSetData($Label_S, "Load File...")
	GUICtrlSetData($C_IDs, "")

	Local $File = FileOpen($V_Path, 0)

	If $File = -1 Then
		GUICtrlSetData($Label_S, "Load File Error(s)...")
		Return
	EndIf

	While 1
		Local $Str = FileReadLine($File)
		If @error = -1 Then ExitLoop
		GUICtrlSetData($C_IDs, $Str, $V_Path)
	WEnd

	FileClose($File)
	GUICtrlSetData($Label_S, "Succees!!")
EndFunc

Func SetLabelFontURL($C_IDs)
	GUICtrlSetFont($C_IDs, 9, 400, 4, "Arial")
	GUICtrlSetColor($C_IDs, 0x0000FF)
	GUICtrlSetCursor($C_IDs, 0)
EndFunc

Func MyErrFunc()
	Local $HexNumber = Hex($Obj_Error.number,8)

	Msgbox(0,   "COM Test","We intercepted a COM Error !"           & @CRLF  & @CRLF & _
				"err.description is: "    & @TAB & $Obj_Error.description    & @CRLF & _
				"err.windescription:"     & @TAB & $Obj_Error.windescription & @CRLF & _
				"err.number is: "         & @TAB & $HexNumber                & @CRLF & _
				"err.lastdllerror is: "   & @TAB & $Obj_Error.lastdllerror   & @CRLF & _
				"err.scriptline is: "     & @TAB & $Obj_Error.scriptline     & @CRLF & _
				"err.source is: "         & @TAB & $Obj_Error.source         & @CRLF & _
				"err.helpfile is: "       & @TAB & $Obj_Error.helpfile       & @CRLF & _
				"err.helpcontext is: "    & @TAB & $Obj_Error.helpcontext)
	SetError(1)
Endfunc
