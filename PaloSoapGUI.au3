; Code by Rchockxm (rchockxm.silver@gmail.com)

#NoTrayIcon
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Outfile=Palo_Soap_API_Tools.exe
#AutoIt3Wrapper_Outfile_x64=Palo_Soap_API_Tools64.exe
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_Compile_Both=y
#AutoIt3Wrapper_UseX64=y
#AutoIt3Wrapper_Res_Comment=SOAP API Tools for Palo ETL Server
#AutoIt3Wrapper_Res_Description=Palo ETL Server SOAP API
#AutoIt3Wrapper_Res_Fileversion=1.1.0.0
#AutoIt3Wrapper_Res_LegalCopyright=Silence Unlimited, Inc
#AutoIt3Wrapper_Res_requestedExecutionLevel=asInvoker
#AutoIt3Wrapper_Res_Field=OriginalFilename|Palo Soap API Tools
#AutoIt3Wrapper_Res_Field=ProductName|Palo ETL Server SOAP API
#AutoIt3Wrapper_Res_Field=ProductVersion|1.1.0.0
#AutoIt3Wrapper_Run_After=Output\Tools\ResHacker.exe -delete %out%, %out%, Dialog, 1000,
#AutoIt3Wrapper_Run_After=Output\Tools\ResHacker.exe -delete %out%, %out%, Menu, 166,
#AutoIt3Wrapper_Run_After=Output\Tools\ResHacker.exe -delete %out%, %out%, Icon, 162,
#AutoIt3Wrapper_Run_After=Output\Tools\ResHacker.exe -delete %out%, %out%, Icon, 164,
#AutoIt3Wrapper_Run_After=Output\Tools\ResHacker.exe -delete %out%, %out%, Icon, 169,
#AutoIt3Wrapper_Run_Au3Stripper=y
#Au3Stripper_Parameters=/striponly
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
;#AutoIt3Wrapper_Run_Obfuscator=y
#Obfuscator_Parameters=/striponly
#include <WindowsConstants.au3>
#include <GUIConstantsEx.au3>
#include <EditConstants.au3>
#include <StaticConstants.au3>
#include <ComboConstants.au3>

Opt("TrayIconHide", 1)
Opt("MustDeclareVars", 1)

Global $Palo_ETL_Soap = "http://localhost:7775/etlserver/services/ETL-Server?wsdl"
Global $Palo_Send_XML = "" & _
	'<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:etl="http://ns.jedox.com/ETL-Server">' & _
	'<soapenv:Header/>' & _
	'<soapenv:Body>' & _
	'<etl:getLocators>' & _
	'<!--Optional:-->' & _
	'<etl:locator></etl:locator>' & _
	'</etl:getLocators>' & _
	'</soapenv:Body>' & _
	'</soapenv:Envelope>'

Global $Str_Open_Mode = "post"

Global $Str_Query = "soapenv:Envelope/soapenv:Body/ns:getLocatorsResponse/ns:return"
Global $Str_Xml_Mode_1 = "selectSingleNode", $Str_Xml_Mode_2 = "selectNodes"

Global $Hwnd = GUICreate("Palo ETL Server Soap API Tools 1.1 by Rchockxm", 600, 470, Default, Default, Bitor($WS_CAPTION, $WS_BORDER, $WS_SYSMENU))
Global $Input_1 = GUICtrlCreateInput($Palo_ETL_Soap, 105, 2, 420, 20)
Global $Combox_1 = GUICtrlCreateCombo($Str_Open_Mode, 530, 2, 65, 20, $CBS_DROPDOWNLIST)

GUICtrlCreateLabel("Palo Soap Address:", 4, 6)
GUICtrlCreateLabel("Send To Palo ETL Server (XML):", 4, 25)
GUICtrlCreateLabel("Return From Palo ETL Server (XML):", 300, 25)
GUICtrlCreateLabel("XML Query Nods:", 4, 330)
GUICtrlCreateLabel("XML Select Mode:", 4, 355)
GUICtrlCreateLabel("XML Analyze Sources:", 265, 355)

Global $Label_S = GUICtrlCreateLabel("Ready...", 4, 450, 200)
Global $Label_L = GUICtrlCreateLabel("Silence Unlimited", 200, 450)
Global $Edit_L = GUICtrlCreateEdit($Palo_Send_XML, 2, 40, 295, 280, Bitor($ES_AUTOVSCROLL, $WS_VSCROLL, $ES_WANTRETURN))
Global $Edit_R = GUICtrlCreateEdit("", 300, 40, 295, 280, Bitor($ES_AUTOVSCROLL, $WS_VSCROLL, $ES_WANTRETURN))
Global $Input_2 = GUICtrlCreateInput($Str_Query, 105, 325, 490, 20)
Global $Edit_B = GUICtrlCreateEdit("", 2, 374, 594, 70, Bitor($ES_AUTOVSCROLL, $WS_VSCROLL, $ES_WANTRETURN))
Global $Button_1 = GUICtrlCreateButton("&Copy", 295, 446, 100, 20)
Global $Button_2 = GUICtrlCreateButton("&Clear", 395, 446, 100, 20)
Global $Button_3 = GUICtrlCreateButton("&Run", 495, 446, 100, 20)
Global $Combox_2 = GUICtrlCreateCombo("", 105, 350, 150, 20, $CBS_DROPDOWNLIST)
Global $Combox_3 = GUICtrlCreateCombo("", 380, 350, 150, 20, $CBS_DROPDOWNLIST)
Global $Button_0 = GUICtrlCreateButton("&Get", 535, 350, 60, 20)

Global $MenuDummy = GUICtrlCreateDummy()
Global $MenuContext = GUICtrlCreateContextMenu($MenuDummy)
Global $Menu_Copy1 = GUICtrlCreateMenuItem("Copy - Send XML", $MenuContext)
Global $Menu_Copy2 = GUICtrlCreateMenuItem("Copy - Return XML", $MenuContext)
Global $Menu_Copy3 = GUICtrlCreateMenuItem("Copy - XML Nodes Value", $MenuContext)

GUICtrlSetFont($Label_L, 8, 400, 4, "Arial")
GUICtrlSetColor($Label_L, 0x0000FF)
GUICtrlSetCursor($Label_L, 0)
GUICtrlSetData($Combox_2, $Str_Xml_Mode_1 & "|" & $Str_Xml_Mode_2, $Str_Xml_Mode_1)
GUICtrlSetData($Combox_3, "Send_XML_File|Return_XML_File", "Return_XML_File")

Global $Obj_HTTP = ObjCreate("Msxml2.XMLHTTP") ;Local $Obj_HTTP = ObjCreate("Microsoft.XMLHTTP")
;Global $Obj_DOM = ObjCreate("Msxml2.DOMDocument.3.0") ;Local $Obj_DOM = ObjCreate("Microsoft.XMLDOM")
Global $Obj_DOM = ObjCreate("Msxml2.DOMDocument.4.0")
Global $Obj_Error = ObjEvent("AutoIt.Error", "MyErrFunc")

GUISetState(@SW_SHOW)

Global $Msg, $Str_Return

While 1
   $Msg = GUIGetMsg()

   Switch $Msg
		Case $GUI_EVENT_CLOSE
			ExitLoop
		Case $Label_L
			ShellExecute("http://rchockxm.com")
		Case $Button_0
			LoadNodeFromXML()
		Case $Button_1
			ShowMenu($Hwnd, $Msg, $MenuContext)
		Case $Button_2
			GUICtrlSetData($Edit_R, "")
			GUICtrlSetData($Edit_L, "")
			GUICtrlSetData($Edit_B, "")
			GUICtrlSetData($Label_S, "Ready!!")
		Case $Button_3
			GUICtrlSetData($Edit_R, "")
			GUICtrlSetData($Edit_B, "")
			GUICtrlSetData($Label_S, "Loading...")

			Local $Str_Soap = GUICtrlRead($Input_1)
			Local $Str_Envelope = GUICtrlRead($Edit_L)

			$Obj_HTTP.open($Str_Open_Mode, $Str_Soap, False)
			$Obj_HTTP.setRequestHeader("Content-Type", "text/xml")
			$Obj_HTTP.send($Str_Envelope)

			$Str_Return = $Obj_HTTP.responseText
			GUICtrlSetData($Edit_R, $Str_Return)

			LoadNodeFromXML()
		Case $Menu_Copy1
			ClipPut(GUICtrlRead($Edit_L))
		Case $Menu_Copy2
			ClipPut(GUICtrlRead($Edit_R))
		Case $Menu_Copy3
			ClipPut(GUICtrlRead($Edit_B))
	EndSwitch
WEnd

GUIDelete()

Func LoadNodeFromXML()
	Switch GUICtrlRead($Combox_3)
		Case "Send_XML_File"
			$Str_Return = GUICtrlRead($Edit_L)
		Case "Return_XML_File"
			If $Str_Return = "" Then $Str_Return = GUICtrlRead($Edit_R)
	EndSwitch

	$Str_Query = GUICtrlRead($Input_2)

	If Not $Obj_DOM.loadXML($Str_Return) Then GUICtrlSetData($Label_S, "XML Object Error.")

	Local $Str_Xml_Node, $Str_Xml_Node_List, $Str_Xml_Return

	Switch GUICtrlRead($Combox_2)
		Case $Str_Xml_Mode_1
			$Str_Xml_Node = $Obj_DOM.selectSingleNode($Str_Query)
		Case $Str_Xml_Mode_2
			$Str_Xml_Node = $Obj_DOM.selectSingleNode($Str_Query)
			$Str_Xml_Node_List = $Obj_DOM.selectNodes($Str_Query)
	EndSwitch

	If Not IsObj($Str_Xml_Node) Then GUICtrlSetData($Label_S, "XML Node Error.")

	Switch GUICtrlRead($Combox_2)
		Case $Str_Xml_Mode_1
			$Str_Xml_Return = $Str_Xml_Node.Text
			GUICtrlSetData($Edit_B, $Str_Xml_Return)
		Case $Str_Xml_Mode_2
			For $Node In $Str_Xml_Node_List
				GUICtrlSetData($Edit_B, $Node.Text & @CRLF, "Length:" & $Str_Xml_Node_List.length)
			Next
	EndSwitch

	GUICtrlSetData($Label_S, "Success!!")
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

Func ClientToScreen($hWnd, ByRef $x, ByRef $y)
    Local $stPoint = DllStructCreate("int;int")

    DllStructSetData($stPoint, 1, $x)
    DllStructSetData($stPoint, 2, $y)
    DllCall("user32.dll", "int", "ClientToScreen", "hwnd", $hWnd, "ptr", DllStructGetPtr($stPoint))

	$x = DllStructGetData($stPoint, 1)
    $y = DllStructGetData($stPoint, 2)

    $stPoint = 0
EndFunc

Func TrackPopupMenu($hWnd, $hMenu, $x, $y)
    DllCall("user32.dll", "int", "TrackPopupMenuEx", "hwnd", $hMenu, "int", 0, "int", $x, "int", $y, "hwnd", $hWnd, "ptr", 0)
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
