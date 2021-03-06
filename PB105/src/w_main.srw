$PBExportHeader$w_main.srw
forward
global type w_main from window
end type
type cb_3 from commandbutton within w_main
end type
type st_1 from statictext within w_main
end type
type sle_font from singlelineedit within w_main
end type
type cb_remove from commandbutton within w_main
end type
type dw_1 from datawindow within w_main
end type
type cb_add from commandbutton within w_main
end type
end forward

global type w_main from window
integer width = 1618
integer height = 1100
boolean titlebar = true
string title = "Add/Remove Font"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_3 cb_3
st_1 st_1
sle_font sle_font
cb_remove cb_remove
dw_1 dw_1
cb_add cb_add
end type
global w_main w_main

type prototypes
Function Long AddFontResourceExW( Readonly String as_FontFile, ULong aul_FontCharacteristics, ULong aul_Reserved ) Library "GDI32.dll" Alias For "AddFontResourceExW"
Function Boolean RemoveFontResourceExW( Readonly String as_FonfFile, ULong aul_FontCharacteristics, ULong aul_Reserved ) Library "GDI32.dll" Alias For "RemoveFontResourceExW"


end prototypes

type variables
String is_app
Constant Long FR_PRIVATE = 16
Constant Long FR_NOT_ENUM = 32

end variables

on w_main.create
this.cb_3=create cb_3
this.st_1=create st_1
this.sle_font=create sle_font
this.cb_remove=create cb_remove
this.dw_1=create dw_1
this.cb_add=create cb_add
this.Control[]={this.cb_3,&
this.st_1,&
this.sle_font,&
this.cb_remove,&
this.dw_1,&
this.cb_add}
end on

on w_main.destroy
destroy(this.cb_3)
destroy(this.st_1)
destroy(this.sle_font)
destroy(this.cb_remove)
destroy(this.dw_1)
destroy(this.cb_add)
end on

event open;is_app = GetCurrentDirectory ( )
end event

type cb_3 from commandbutton within w_main
integer x = 1426
integer y = 160
integer width = 110
integer height = 84
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "..."
end type

event clicked;String ls_file, ls_file_name
GetFileOpenName("Select Font File", ls_file, ls_file_name, ".TTF","Font Files, *.TTF")
If Not FileExists(ls_file_name) Then
	// ERROR CONDITION
	MessageBox("Font File Not Found","Cannot find Font File: "+ ls_file_name)
	Return -1
Else
	sle_font.Text = ls_file
End If



end event

type st_1 from statictext within w_main
integer x = 37
integer y = 160
integer width = 219
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Fonts:"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_font from singlelineedit within w_main
integer x = 256
integer y = 160
integer width = 1170
integer height = 84
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type cb_remove from commandbutton within w_main
integer x = 1134
integer y = 32
integer width = 398
integer height = 112
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Remove Font"
end type

event clicked;String ls_font
Long ll_row
Boolean lb_rc

ls_font = sle_font.Text
If ls_font = "" Then Return
If Not FileExists(ls_font) Then
	MessageBox("Warning","Font Not Exits" )
	Return
End If

lb_rc = RemoveFontResourceExW(ls_font ,FR_PRIVATE + FR_NOT_ENUM,0)
If Not lb_rc Then
	MessageBox("Warning","Remove Font Error" )
End If 

dw_1.Reset()
ll_row = dw_1.InsertRow(0)
dw_1.SetItem( ll_row, 1, "(212)00006847")


end event

type dw_1 from datawindow within w_main
integer x = 37
integer y = 288
integer width = 1499
integer height = 640
integer taborder = 20
string title = "none"
string dataobject = "d_tem"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_add from commandbutton within w_main
integer x = 37
integer y = 32
integer width = 288
integer height = 112
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Add Font"
end type

event clicked;String ls_font
Long    ll_rc, ll_row

ls_font = sle_font.Text
If ls_font = "" Then Return
If Not FileExists(ls_font) Then
	MessageBox("Warning","Font Not Exits" )
	Return
End If

ll_rc = AddFontResourceExW(ls_font ,FR_PRIVATE + FR_NOT_ENUM,0)
If ll_rc <> 1 Then
	MessageBox("Warning","Add Font Error" + String(ll_rc) )
End If

dw_1.Reset()
ll_row = dw_1.InsertRow(0)
dw_1.SetItem( ll_row, 1, "(212)00006847")



end event

