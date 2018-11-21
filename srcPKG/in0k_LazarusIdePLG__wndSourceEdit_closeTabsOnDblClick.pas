unit in0k_LazarusIdePLG__wndSourceEdit_closeTabsOnDblClick;

{$mode objfpc}{$H+}

interface

{$include in0k_LazarusIdeSRC__Settings.inc}

uses {$ifDef in0k_LazarusIdeEXT__DEBUG}in0k_lazarusIdeSRC__wndDEBUG,{$endIf}
  in0k_lazarusIdeSRC__TMPLT_4SourceWindow,
  //----
  src_fuckUp_NoteBOOK,
  //----
  ExtendedNotebook,
  Controls,
  Forms;

type

 tIn0k_LazIdePLG__wndSourceEdit_closeTabsOnDblClick=class(tIn0k_lazIdeSRC__TMPLT_4SourceWindow)
  protected
   _fucUp_:tFuckUP_NoteBOOK;
  protected
    function  _srcNoteBook_TST_(const sender:TControl):boolean;
    function  _srcNoteBook_FND_(const sender:TCustomForm):TControl;
  protected
    procedure _wrkEvent_(const sender: tObject); override;
  public
    constructor Create;
    destructor DESTROY; override;
  end;

implementation {%region --- возня с ДЕБАГОМ (включить/выключить) -- /fold}
{$define DEBUG_ON} //< ВКЛЮЧИТЬ ЛОКАЛЬНЫЙ `DEBUG` режим
{$if declared(in0k_lazarusIdeSRC_DEBUG)}
    // `in0k_lazarusIdeSRC_DEBUG` - это функция ИНДИКАТОР что используется
    //                              моя "система"
    {$define _debugLOG_} //< и типа да ... можно делать ДЕБАГ отметки
{$endIf}
{$ifnDEF DEBUG_ON}
    {$unDef _debugLOG_}
{$endIf}
{%endregion}

constructor tIn0k_LazIdePLG__wndSourceEdit_closeTabsOnDblClick.Create;
begin
    inherited;
   _fucUp_:=tFuckUP_NoteBOOK.Create;
end;

destructor tIn0k_LazIdePLG__wndSourceEdit_closeTabsOnDblClick.DESTROY;
begin
    inherited;
   _fucUp_.FREE;
end;

//------------------------------------------------------------------------------

function tIn0k_LazIdePLG__wndSourceEdit_closeTabsOnDblClick._srcNoteBook_TST_(const sender:TControl):boolean;
begin {todo: возможно это менять под РАЗНЫЕ версии}
    result:=Assigned(sender) and (sender is TExtendedNotebook);
end;

function tIn0k_LazIdePLG__wndSourceEdit_closeTabsOnDblClick._srcNoteBook_FND_(const sender:TCustomForm):TControl;
var i:integer;
begin
    result:=nil;
    for i:=0 to TCustomForm(sender).ControlCount-1 do begin
        if _srcNoteBook_TST_(sender.Controls[i]) then begin
            result:=sender.Controls[i];
            BREAK;
        end;
    end;
    {$ifDef _debugLOG_}
    if Assigned(result)
    then DEBUG(self.ClassName+'._srcNoteBook_FND_', 'control:'+result.ClassName+addr2txt(result))
    else DEBUG(self.ClassName+'._srcNoteBook_FND_', 'control: NOT found')
    {$endIf}
end;

procedure tIn0k_LazIdePLG__wndSourceEdit_closeTabsOnDblClick._wrkEvent_(const sender: tObject);
var i:integer;
  tmp:TControl;
begin
    if NOT ( Assigned(sender) and (sender is TCustomForm) ) then EXIT;
    //---
    tmp:=_srcNoteBook_FND_(TCustomForm(sender));
    if Assigned(tmp) then _fucUp_.Applay4Control(tmp);
end;

end.

