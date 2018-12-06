unit src_fuckUp_NoteBOOK;

{$mode objfpc}{$H+}

interface

{$include in0k_LazarusIdeSRC__Settings.inc}

uses {$ifDef in0k_LazarusIdeEXT__DEBUG} in0k_lazarusIdeSRC__wndDEBUG, {$endIf}
  in0k_lazarusIdeSRC__tControl_fuckUpWndProc,
  //---
  Controls,
  ComCtrls,
  Types,
  Classes,
  //--
  LMessages;

type

  // событие - ДВОЙНОЕ нажатие мышки
  // @prm Control объект "на котором" произошло сыбытие
  // @prm Message какое именно событи произошло (LM_LBUTTONDBLCLK.. и т.д.)
 mFuckUP_TPageControl_onDblCLK=procedure(const Control:TPageControl; const Message:Cardinal) of object;

 tFuckUP_TPageControl_onDblCLK=class(tIn0k_lazIdeSRC__tControls_fuckUpWndProcLAIR_CORE)
  protected
   _m_EVENT_:mFuckUP_TPageControl_onDblCLK;
    procedure _do_EVENT_(const Control:TControl; const TheMessage:Cardinal);
  public
    procedure Applay4Control(const Control:TControl);
  public
    property OnMouseDblCLK:mFuckUP_TPageControl_onDblCLK read _m_EVENT_ write _m_EVENT_;
  public
    constructor Create;
  end;

// OnMouseDown


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
uses LCLVersion;

{%region --- СООТВЕТСТВИЕ ВЕРСИЯМ --------------------------------- /fold}
// ПОИСК ДВОЙНОГО КЛИКА
{$define _NOT_TESTED_}
{$if (lcl_fullversion=01040400)} //< test by in0k
    {$unDef _NOT_TESTED_}
    {$define _wndProcUse_SIMPLE_}
{$endIf}
{$if (lcl_fullversion=01060004)} //< test by in0k
    {$unDef _NOT_TESTED_}
    {$define _wndProcUse_SIMPLE_}
{$endIf}
{$if (lcl_fullversion=01080400)} //< test by in0k
    {$unDef _NOT_TESTED_}
    {$define _wndProcUse_COMMON_LCL_}
{$endIf}
{$if (lcl_fullversion=02000002)} //< test by in0k
    {$unDef _NOT_TESTED_}
    {$define _wndProcUse_COMMON_LCL_}
{$endIf}
//--------------------
{$ifdef _NOT_TESTED_}
    {$if (01080000<lcl_fullversion)}
      {$define _wndProcUse_COMMON_LCL_}
    {$else}
      {$define _wndProcUse_SIMPLE_}
    {$endIf}
    //-----
    {$WARNING 'recording of events `lm_XbuttonDBLclk` NOT tested in this version !'}
    {$WARNING 'If You have this "code" will work NOT correctly, please inform the developer.'}
{$endIf}
{%endregion}

{%region --- _tFuckUp_node_ --------------------------------------- /fold}
type
 _tFuckUp_node_=class(tIn0k_lazIdeSRC__tControls_fuckUpWndProcNODE)
   {$ifdef _wndProcUse_SIMPLE_}
   protected
     function _wndProc_SIMPLE_(const TheMessage:TLMessage):Cardinal;
   {$endIf}
   {$ifdef _wndProcUse_COMMON_LCL_}
   protected
    _LastMouseInfo_:TLastMouseInfo;
     function _wndProc_COMMON_LCL_handle_(const AMousePos:TPoint; const AButton:Byte; const AMouseDown:Boolean):Cardinal; {$ifOpt D-}inline;{$endIf}
     function _wndProc_COMMON_LCL_(const TheMessage:TLMessage):Cardinal;
   {$endIf}
   {$ifDef in0k_LazarusIdeEXT---disableDefaultBehavior}
   protected
    _ctrl_original_OnMouseDown_:TMouseEvent;
     procedure _my_OnMouseDown_(Sender:TObject; Button:TMouseButton; Shift:TShiftState; X,Y:Integer);
   {$endIf}
   protected
     procedure fuckUP__onSET; override; //< дополнительный "сабЕвентинг"
     procedure fuckUP__onCLR; override; //< очистка "сабЕвентинга"
   protected
     procedure fuckUP__wndProc_BEFO(const {%H-}TheMessage:TLMessage); override;
   end;

//------------------------------------------------------------------------------

{$ifdef _wndProcUse_SIMPLE_}
function _tFuckUp_node_._wndProc_SIMPLE_(const TheMessage:TLMessage):Cardinal;
begin //< САМА система сообщает нам о события ДвойногоКлика
    case TheMessage.msg of
        LM_LBUTTONDBLCLK,
        LM_RBUTTONDBLCLK,
        LM_MBUTTONDBLCLK,
        LM_XBUTTONDBLCLK: result:=TheMessage.msg;
        else result:=0;
    end;
end;
{$endIf}

//------------------------------------------------------------------------------

{$ifdef _wndProcUse_COMMON_LCL_}

function _tFuckUp_node_._wndProc_COMMON_LCL_handle_(const AMousePos:TPoint; const AButton:Byte; const AMouseDown:Boolean):Cardinal;
begin
    result:=CheckMouseButtonDownUp(TWinControl(_ctrl_).Handle,nil,_LastMouseInfo_,AMousePos,AButton,AMouseDown);
end;

function _tFuckUp_node_._wndProc_COMMON_LCL_(const TheMessage:TLMessage):Cardinal;
begin
    // !!! ВСЕ СОДРАНО !!! оригинал смотри
    //     win32callback.inc(MainUnit win32int.pp)
    //     метод TWindowProcHelper.DoWindowProc применение DoMsgMouseDownUpClick
    case TheMessage.msg of
      LM_LBUTTONDOWN:result:=_wndProc_COMMON_LCL_handle_(TLMMouse(TheMessage).Pos, 1, true);
      LM_LBUTTONUP  :result:=_wndProc_COMMON_LCL_handle_(TLMMouse(TheMessage).Pos, 1, false);
      LM_RBUTTONDOWN:result:=_wndProc_COMMON_LCL_handle_(TLMMouse(TheMessage).Pos, 2, true);
      LM_RBUTTONUP  :result:=_wndProc_COMMON_LCL_handle_(TLMMouse(TheMessage).Pos, 2, false);
      LM_MBUTTONDOWN:result:=_wndProc_COMMON_LCL_handle_(TLMMouse(TheMessage).Pos, 3, true);
      LM_MBUTTONUP  :result:=_wndProc_COMMON_LCL_handle_(TLMMouse(TheMessage).Pos, 3, false);
      LM_XBUTTONDOWN:result:=_wndProc_COMMON_LCL_handle_(TLMMouse(TheMessage).Pos, 4, true);
      LM_XBUTTONUP  :result:=_wndProc_COMMON_LCL_handle_(TLMMouse(TheMessage).Pos, 4, false);
      else           result:= 0;
    end;
end;
{$endIf}

//------------------------------------------------------------------------------

{$ifDef in0k_LazarusIdeEXT---disableDefaultBehavior}

// Вся "ОРИГИНАЛЬНАЯ" функциональность по закрытию вклядок при нажатии
// мышки локализована в процедуре
// `/%lazDIR/ide/SourceEditor.pp:TSourceNotebook.NotebookMouseDown`
// которая в конечном итоге используется в TPageControl(_ctrl_).OnMouseDown
//
// наивное решение. ЗАБАНИТЬ это событие.

procedure _tFuckUp_node_._my_OnMouseDown_(Sender:TObject; Button:TMouseButton; Shift:TShiftState; X,Y:Integer);
begin
    // пока просто ИГНОРИРУЕМ, потом возможно придется извращаться
   _ctrl_original_OnMouseDown_(Sender,Button,Shift,X,Y);
end;

{$endIf}

//------------------------------------------------------------------------------

procedure _tFuckUp_node_.fuckUP__onSET; //< дополнительный "сабЕвентинг"
begin
    inherited;
    //
    {$ifDef in0k_LazarusIdeEXT---disableDefaultBehavior}
   _ctrl_original_OnMouseDown_:=TPageControl(_ctrl_).OnMouseDown;
    TPageControl(_ctrl_).OnMouseDown:=@_my_OnMouseDown_;
    {$endIf}
end;

procedure _tFuckUp_node_.fuckUP__onCLR; //< очистка "сабЕвентинга"
begin
    {$ifDef in0k_LazarusIdeEXT---disableDefaultBehavior}
    TPageControl(_ctrl_).OnMouseDown:=_ctrl_original_OnMouseDown_;
    {$endIf}
    //
    inherited;
end;

//------------------------------------------------------------------------------

procedure _tFuckUp_node_.fuckUP__wndProc_BEFO(const {%H-}TheMessage:TLMessage);
var r:Cardinal;
begin
    {$ifdef _wndProcUse_SIMPLE_}
    r:=_wndProc_SIMPLE_(TheMessage);
    {$endIf}
    {$ifdef _wndProcUse_COMMON_LCL_}
    r:=_wndProc_COMMON_LCL_(TheMessage);
    {$endIf}
    //
    if (r = LM_LBUTTONDBLCLK)or
       (r = LM_RBUTTONDBLCLK)or
       (r = LM_MBUTTONDBLCLK)or
       (r = LM_XBUTTONDBLCLK)
    then begin
        // СЛУЧИЛОСЬ! событие Двойной-Клик случилось!
        tFuckUP_TPageControl_onDblCLK(_OWNER_)._do_EVENT_(_ctrl_,r);
    end;
end;

{%endregion}

//------------------------------------------------------------------------------

constructor tFuckUP_TPageControl_onDblCLK.Create;
begin
    inherited;
   _m_EVENT_:=NIL;
end;

// subClassing объекто ОПРЕДЕЛЕННОГО типа
procedure tFuckUP_TPageControl_onDblCLK.Applay4Control(const Control:TControl);
begin
    if Assigned(Control) and (Control is TPageControl)
    then _NODE_GET_(Control,_tFuckUp_node_);
end;

// вызов РОДИТЕЛЬСКОГО события (возможно много ненужных проверок)
procedure tFuckUP_TPageControl_onDblCLK._do_EVENT_(const Control:TControl; const TheMessage:Cardinal);
begin
    if Assigned(Control) and (Control is TPageControl) then begin
        {$ifDef _debugLOG_}
        DEBUG(self.ClassName+addr2txt(self),'_do_EVENT_: '+Control.ClassName+addr2txt(Control));
        {$endIf}
        if Assigned(_m_EVENT_) then begin
           _m_EVENT_(TPageControl(Control),TheMessage);
        end;
    end
    else begin
        {$ifDef _debugLOG_}
        if Assigned(Control)
        then DEBUG(self.ClassName+addr2txt(self),'_do_EVENT_: WRONG! Control('+Control.ClassName+addr2txt(Control)+') is NOT TPageControl')
        else DEBUG(self.ClassName+addr2txt(self),'_do_EVENT_: WRONG! Control=NIL');
        {$endIf}
    end;
end;

end.

