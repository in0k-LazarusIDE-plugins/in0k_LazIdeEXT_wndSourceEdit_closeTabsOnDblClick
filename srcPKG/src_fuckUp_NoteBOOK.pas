unit src_fuckUp_NoteBOOK;

{$mode objfpc}{$H+}

interface

{$include in0k_LazarusIdeSRC__Settings.inc}

uses {$ifDef in0k_LazarusIdeEXT__DEBUG} in0k_lazarusIdeSRC__wndDEBUG, {$endIf}
  in0k_lazarusIdeSRC__tControls_fuckUpWndProc,
  IDECommands,
  //---
  Controls,
  ComCtrls,
  Types,
  //--
  LMessages;

type

 tFuckUP_NoteBOOK=class(tIn0k_lazIdeSRC__tControls_fuckUpLAIR_CORE)
  protected
   _LastMouseInfo_:TLastMouseInfo;
    procedure _do_mouseDoubleClick_(const Control:TControl; const Message:Cardinal);
  public
    procedure Applay4Control(const Control:TControl);
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

{%region --- _tFuckUp_node_ --------------------------------------- /fold}
type
 _tFuckUp_node_=class(tIn0k_lazIdeSRC__tControls_fuckUpNODE)
   protected
     function _handle_(const AMousePos:TPoint; const AButton:Byte; const AMouseDown:Boolean):Cardinal; inline;
   protected
     procedure fuckUP__wndProc_BEFO(const {%H-}TheMessage:TLMessage); override;
   end;


function _tFuckUp_node_._handle_(const AMousePos:TPoint; const AButton:Byte; const AMouseDown:Boolean):Cardinal;
begin
    result:=CheckMouseButtonDownUp(TWinControl(_ctrl_).Handle,nil,tFuckUP_NoteBOOK(_ownr_)._LastMouseInfo_,AMousePos,AButton,AMouseDown);
end;

procedure _tFuckUp_node_.fuckUP__wndProc_BEFO(const {%H-}TheMessage:TLMessage);
var r:Cardinal;
begin
    // !!! ВСЕ СОДРАНО !!! оригинал смотри
    //     win32callback.inc(MainUnit win32int.pp)
    //     метод TWindowProcHelper.DoWindowProc применение DoMsgMouseDownUpClick
    case TheMessage.msg of
      LM_LBUTTONDOWN:r:=_handle_(TLMMouse(TheMessage).Pos, 1, true);
      LM_LBUTTONUP  :r:=_handle_(TLMMouse(TheMessage).Pos, 1, false);
      LM_RBUTTONDOWN:r:=_handle_(TLMMouse(TheMessage).Pos, 2, true);
      LM_RBUTTONUP  :r:=_handle_(TLMMouse(TheMessage).Pos, 2, false);
      LM_MBUTTONDOWN:r:=_handle_(TLMMouse(TheMessage).Pos, 3, true);
      LM_MBUTTONUP  :r:=_handle_(TLMMouse(TheMessage).Pos, 3, false);
      LM_XBUTTONDOWN:r:=_handle_(TLMMouse(TheMessage).Pos, 4, true);
      LM_XBUTTONUP  :r:=_handle_(TLMMouse(TheMessage).Pos, 4, false);
      else           r:= 0;
    end;
    //
    if (r = LM_LBUTTONDBLCLK)or
       (r = LM_RBUTTONDBLCLK)or
       (r = LM_MBUTTONDBLCLK)or
       (r = LM_XBUTTONDBLCLK)
    then begin
        // СЛУЧИЛОСЬ! событие Двойной-Клик случилось!
        tFuckUP_NoteBOOK(_ownr_)._do_mouseDoubleClick_(_ctrl_,r);
    end;
end;

{%endregion}

procedure tFuckUP_NoteBOOK.Applay4Control(const Control:TControl);
begin
    if NOT (Assigned(Control) and (Control is TCustomTabControl)) then EXIT;
    //
   _GetNODE_(Control,_tFuckUp_node_);
end;

procedure tFuckUP_NoteBOOK._do_mouseDoubleClick_(const Control:TControl; const Message:Cardinal);
var IDECommand:TIDECommand;
begin
    IDECommand:=IDECommandList.FindIDECommand(ecClose);
    if Assigned(IDECommand) then begin
        {$ifDef _debugLOG_}
        DEBUG('ddddddddddddddddddddddddddddd', 'ddddddddd');
        {$endIf}

        IDECommand.Execute(TPageControl(Control).ActivePage);
    end;


end;

//const //< тут возможно придется определять относительно ВЕРСИИ ЛАЗАРУСА
//_c_IDECommand_OpnOI_IdeCODE_=ecToggleObjectInsp;

{
function Form_ShowByCMD:TCustomForm;
var IDECommand:TIDECommand;
begin
result:=NIL;    //idewi
// ищем команду
IDECommand:=IDECommandList.FindIDECommand(_c_IDECommand_OpnOI_IdeCODE_);
if Assigned(IDECommand) and IDECommand.Execute(Application.MainForm) then begin
}

end.

