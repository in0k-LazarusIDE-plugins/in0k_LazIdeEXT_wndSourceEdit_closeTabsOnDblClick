unit in0k_LazarusIdePLG__wndSourceEdit_closeTabsOnDblClick;

{$mode objfpc}{$H+}

interface

{$include in0k_LazarusIdeSRC__Settings.inc}

uses {$ifDef in0k_LazarusIdeEXT__DEBUG}
      in0k_lazarusIdeSRC__wndDEBUG,
      sysutils,
     {$endIf}
  in0k_lazarusIdeSRC__TMPLT_4SourceWindow,
  src_fuckUp_NoteBOOK,
  //----
  IDECommands,
  MenuIntf,
  LazMsgDialogs,
  //----
  ExtendedNotebook,
  Controls, ComCtrls, contnrs,
  LCLType, LCLProc, UITypes,
  Menus, Forms, Classes, LMessages;

type

 tIn0k_LazIdePLG__wndSourceEdit_closeTabsOnDblClick=class(tIn0k_lazIdeSRC__TMPLT_4SourceWindow)
  protected
   _ideMenuItem_closeSINGLE_:TIDEMenuItem;
    procedure _ideMenuItem_closeSINGLE_reFIND_;
  protected
   _ideMenuItem_closeINVERT_:TIDEMenuItem;
    procedure _ideMenuItem_closeINVERT_reFIND_;
  protected
    procedure _ideMenuItem_reFIND_;
  protected
   _fucUp_:tFuckUP_TPageControl_onDblCLK;
  protected
    function  _srcNoteBook_TST_(const sender:TControl):boolean;
    function  _srcNoteBook_FND_(const sender:TCustomForm):TControl;
  protected
  protected
    procedure _close_SINGLE_(const Control:TPageControl);
    procedure _close_INVERT_(const Control:TPageControl);
    function  _makePageLIST_(const Control:TPageControl; const GoForward:boolean):tList;
    procedure _close_ppPxxx_(const Control:TPageControl);
    procedure _close_xxxPpp_(const Control:TPageControl);
  protected
    procedure _wrkEvent_(const sender:tObject); override;
    procedure _wrkEvent_dblClk(const Control:TPageControl; const Message:Cardinal);
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
   _ideMenuItem_closeSINGLE_:=nil;
   _ideMenuItem_closeINVERT_:=nil;
   _fucUp_:=tFuckUP_TPageControl_onDblCLK.Create;
   _fucUp_.OnMouseDblCLK:=@_wrkEvent_dblClk;
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
var tmp:TControl;
begin
    if NOT ( Assigned(sender) and (sender is TCustomForm) ) then EXIT;
    //---
    tmp:=_srcNoteBook_FND_(TCustomForm(sender));
    if Assigned(tmp) then _fucUp_.Applay4Control(tmp);
    //
   _ideMenuItem_reFIND_;
end;

//------------------------------------------------------------------------------

const //< смело, но оно работает пока
 _c_ideMenuItem_closeSINGLE_name_='Close Page';

procedure tIn0k_LazIdePLG__wndSourceEdit_closeTabsOnDblClick._ideMenuItem_closeSINGLE_reFIND_;
begin
    if NOT Assigned(_ideMenuItem_closeSINGLE_) then begin
        if Assigned(SrcEditMenuSectionPages) then begin
           _ideMenuItem_closeSINGLE_:=SrcEditMenuSectionPages.FindByName(_c_ideMenuItem_closeSINGLE_name_);
            if Assigned(_ideMenuItem_closeSINGLE_) then begin
                {$ifDef _debugLOG_}
                DEBUG(self.ClassName+addr2txt(self),'_ideMenuItem_closeSINGLE_ FIND');
                {$endIf}
                {$ifDef in0k_LazarusIdePLG__wndSourceEdit_closeTabsOnDblClick---reCaptionMenuItems}
               _ideMenuItem_closeSINGLE_.Caption:=_ideMenuItem_closeSINGLE_.Caption+' '+'[Double Left-click]';
                // а так хотелось использовать ShortCutToText(ShortCut(VK_LBUTTON,[ssDouble]));
                // но она не работает так :-(
                {$endIf}
            end;
        end;
    end;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

const //< смело, но оно работает пока
 _c_ideMenuItem_closeINVERT_name_='Close All Other Pages';

procedure tIn0k_LazIdePLG__wndSourceEdit_closeTabsOnDblClick._ideMenuItem_closeINVERT_reFIND_;
begin
    if NOT Assigned(_ideMenuItem_closeINVERT_) then begin
        if Assigned(SrcEditMenuSectionPages) then begin
           _ideMenuItem_closeINVERT_:=SrcEditMenuSectionPages.FindByName(_c_ideMenuItem_closeINVERT_name_);
            if Assigned(_ideMenuItem_closeINVERT_) then begin
                {$ifDef _debugLOG_}
                DEBUG(self.ClassName+addr2txt(self),'_ideMenuItem_closeINVERT_ FIND');
                {$endIf}
                {$ifDef in0k_LazarusIdePLG__wndSourceEdit_closeTabsOnDblClick---reCaptionMenuItems}
               _ideMenuItem_closeINVERT_.Caption:=_ideMenuItem_closeINVERT_.Caption+' '+'[Shift + Double Left-click]';
                // а так хотелось использовать ShortCutToText(ShortCut(VK_LBUTTON,[Shift + ssDouble]));
                // но она не работает так :-(
                {$endIf}
            end;
        end;
    end;
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

procedure tIn0k_LazIdePLG__wndSourceEdit_closeTabsOnDblClick._ideMenuItem_reFIND_;
begin
   _ideMenuItem_closeSINGLE_reFIND_;
   _ideMenuItem_closeINVERT_reFIND_;
end;

//------------------------------------------------------------------------------

{%region --- thread singleIDEMenuItem ----------------------------- /fold}
type
_tWRK_singleIDEMenuItem_=class(TThread)
  private
   _MenuItem_:TIDEMenuItem;
   _TabSheet_:TTabSheet;
    procedure _MenuItem_4_TabSheet_;
  protected
    procedure Execute; override;
  public
    constructor Create(const MenuItem:TIDEMenuItem; const TabSheet:TTabSheet);
  end;

//------------------------------------------------------------------------------

constructor _tWRK_singleIDEMenuItem_.Create(const MenuItem:TIDEMenuItem; const TabSheet:TTabSheet);
begin
    inherited Create(TRUE);
    FreeOnTerminate:=TRUE;
   _MenuItem_:=MenuItem;
   _TabSheet_:=TabSheet;
end;

//------------------------------------------------------------------------------

procedure _tWRK_singleIDEMenuItem_._MenuItem_4_TabSheet_;
begin // тут может произойти ВСЕ что угодно, потому и `try`
    try if Assigned(_MenuItem_) then begin
          {$ifDef _debugLOG_}
          DEBUG(self.ClassName+addr2txt(self),_MenuItem_.ClassName+addr2txt(_MenuItem_)+'.Execute('+addr2txt(_TabSheet_)+')');
          {$endIf}
         _MenuItem_.OnClick(_TabSheet_);
        end {$ifDef _debugLOG_}
        else begin
            DEBUG(self.ClassName+addr2txt(self),'IDEMenuItem NOT found?');
        end {$endIf};
    except
        {$ifDef _debugLOG_}
        on E:Exception do DEBUG(self.ClassName+addr2txt(self),'Exception: '+E.Message);
        {$endIf}
    end;
end;

procedure _tWRK_singleIDEMenuItem_.Execute;
begin
    Synchronize(@_MenuItem_4_TabSheet_);
end;

{%endregion  thread singleIDEMenuItem}

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

// закрыть "АКТИВНУЮ" страницу
procedure tIn0k_LazIdePLG__wndSourceEdit_closeTabsOnDblClick._close_SINGLE_(const Control:TPageControl);
begin
    try
       _tWRK_singleIDEMenuItem_.Create(_ideMenuItem_closeSINGLE_,Control.ActivePage).Start;
    except
        {$ifDef _debugLOG_}
        on E:Exception do DEBUG(self.ClassName+addr2txt(self),'Exception: '+E.Message);
        {$endIf}
    end;
end;

// закрыть ВСЕ кроме "активной"
procedure tIn0k_LazIdePLG__wndSourceEdit_closeTabsOnDblClick._close_INVERT_(const Control:TPageControl);
begin
    try
       _tWRK_singleIDEMenuItem_.Create(_ideMenuItem_closeINVERT_,Control.ActivePage).Start;
    except
        {$ifDef _debugLOG_}
        on E:Exception do DEBUG(self.ClassName+addr2txt(self),'Exception: '+E.Message);
        {$endIf}
    end;
end;

//------------------------------------------------------------------------------

{%region --- thread Close_ListOfPAGEs ----------------------------- /fold}
// !!! ОСОБЕННОСТЬ !!!
//------------------------------------------------------------------------
// ПОДМЕНа LazMsgDialogs.LazQuestionDialog
//------------------------------------------------------------------------
// При обработке, могут выпрыгивать ДИАЛОГИ о сохранении файлов.
// Там присутствует кнопка `mrAbort`. Есть желание её ОБРАБАТЫВАТЬ.
// Поэтому, исходя из СМЕЛОГО предположения, что будут вызываться диалоги
// ТОЛЬКО о сохранении фалов, и подменяем функцию. Ловим в ней ответ,
// и если он `mrAbort`, то ПРЕКРАЩАЕМ работать дальше.
//------------------------------------------------------------------------
type
_tWRK_close_ListOfPAGEs_=class(TThread)
  private
   _originalIDE_LazQuestionDialog_:TLazQuestionDialog;
    function _myLazQuestionDialog_(const aCaption, aMsg: string; DlgType: TMsgDlgType; Buttons: array of const; const HelpKeyword: string = ''):Integer;
  private
    procedure _LazQuestionDialog_rePlace_;
    procedure _LazQuestionDialog_reStore_;
  private
   _lastDialogRESULT_:Integer;
  private
   _MenuItem_:TIDEMenuItem;
   _List_PGs_:TList;
    procedure _MenuItem_4_ListTabSheet_;
  protected
    procedure Execute; override;
  public
    constructor Create(const MenuItem:TIDEMenuItem; const List_PGs:TList);
  end;

//------------------------------------------------------------------------------

constructor _tWRK_close_ListOfPAGEs_.Create(const MenuItem:TIDEMenuItem; const List_PGs:TList);
begin
    inherited Create(TRUE);
    FreeOnTerminate:=TRUE;
   _MenuItem_:=MenuItem;
   _List_PGs_:=List_PGs;
end;

//------------------------------------------------------------------------------

procedure _tWRK_close_ListOfPAGEs_._LazQuestionDialog_rePlace_;
begin
   _originalIDE_LazQuestionDialog_:=LazQuestionDialog;
    LazQuestionDialog:=@_myLazQuestionDialog_;
    {$ifDef _debugLOG_}
    DEBUG(self.ClassName+addr2txt(self),'LazQuestionDialog rePlace '+mthd2txt(@_originalIDE_LazQuestionDialog_)+' -> '+mthd2txt(@LazQuestionDialog));
    {$endIf}
end;

procedure _tWRK_close_ListOfPAGEs_._LazQuestionDialog_reStore_;
begin
    if LazQuestionDialog=@_myLazQuestionDialog_ then begin
        LazQuestionDialog:=_originalIDE_LazQuestionDialog_;
        {$ifDef _debugLOG_}
        DEBUG(self.ClassName+addr2txt(self),'LazQuestionDialog reStore -> '+mthd2txt(@LazQuestionDialog));
        {$endIf}
    end
    {$ifDef _debugLOG_}
    else begin
        DEBUG(self.ClassName+addr2txt(self),'LazQuestionDialog reStore FAIL: '+mthd2txt(@LazQuestionDialog)+' <> _myLazQuestionDialog_');
    end
    {$endIf}
end;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

function _tWRK_close_ListOfPAGEs_._myLazQuestionDialog_(const aCaption, aMsg: string; DlgType: TMsgDlgType; Buttons: array of const; const HelpKeyword: string = ''):Integer;
begin
    result:=_originalIDE_LazQuestionDialog_(aCaption,aMsg,DlgType,Buttons,HelpKeyword);
    {$ifDef _debugLOG_}
    DEBUG(self.ClassName+addr2txt(self),'QuestionDialog.result='+inttostr(result)+' Caption"'+aCaption+'"');
    {$endIf}
   _lastDialogRESULT_:=result;
end;

//------------------------------------------------------------------------------

procedure _tWRK_close_ListOfPAGEs_._MenuItem_4_ListTabSheet_;
var i:integer;
   TS:TTabSheet;
begin
   _LazQuestionDialog_rePlace_;
    //--
    try if Assigned(_MenuItem_) then begin
           _lastDialogRESULT_:=mrOK;
            for i:=0 to _List_PGs_.Count-1 do begin
                TS:=TTabSheet(_List_PGs_.Items[i]);
                {$ifDef _debugLOG_}
                DEBUG(self.ClassName+addr2txt(self),_MenuItem_.ClassName+addr2txt(_MenuItem_)+'.Execute('+addr2txt(TS)+')');
                {$endIf}
               _MenuItem_.OnClick(TS);
                // вот оно как? пользователь отказался от продолжения?
                if _lastDialogRESULT_=mrAbort then BREAK;
            end;
        end {$ifDef _debugLOG_}
        else begin
            DEBUG(self.ClassName+addr2txt(self),'IDEMenuItem NOT found?');
        end {$endIf};
    except
        {$ifDef _debugLOG_}
        on E:Exception do DEBUG(self.ClassName+addr2txt(self),'Exception: '+E.Message);
        {$endIf}
    end;
   _LazQuestionDialog_reStore_;
   _List_PGs_.FREE;
end;

procedure _tWRK_close_ListOfPAGEs_.Execute;
begin
    Synchronize(@_MenuItem_4_ListTabSheet_);
end;

{%endregion  thread Close_ListOfPAGEs}

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

// создаем СПИСОК `TTabSheet`, которые хотим ЗАКРЫТЬ
function tIn0k_LazIdePLG__wndSourceEdit_closeTabsOnDblClick._makePageLIST_(const Control:TPageControl; const GoForward:boolean):tList;
var tmp:TTabSheet;
    tmq:TTabSheet;
    i  :integer;
begin
    try
        result:=TObjectList.Create(false);
        tmp:=Control.ActivePage;
        if GoForward then begin
            for i:=tmp.PageIndex+1 to Control.PageCount-1 do begin
                tmq:=Control.Pages[Control.TabToPageIndex(i)];
                if Assigned(tmq) then result.Add(tmq);
            end;
        end
        else begin
            for i:=tmp.PageIndex-1 downto 0 do begin
                tmq:=Control.Pages[Control.TabToPageIndex(i)];
                if Assigned(tmq) then result.Add(tmq);
            end;
        end;
        {$ifDef _debugLOG_}
        DEBUG(self.ClassName+addr2txt(self),'_makePageLIST_: count '+inttostr(result.Count));
        {$endIf}
    except
        {$ifDef _debugLOG_}
        on E:Exception do DEBUG(self.ClassName+addr2txt(self),'Exception: '+E.Message);
        {$endIf}
    end;
end;

// закрыть все СПРАВА от "активной"
procedure tIn0k_LazIdePLG__wndSourceEdit_closeTabsOnDblClick._close_ppPxxx_(const Control:TPageControl);
var list:TList;
begin
    list:=_makePageLIST_(Control,true); //< СПРАВА от активной
   _tWRK_close_ListOfPAGEs_.Create(_ideMenuItem_closeSINGLE_,list).Start;
end;

// закрыть все СЛЕВА от "активной"
procedure tIn0k_LazIdePLG__wndSourceEdit_closeTabsOnDblClick._close_xxxPpp_(const Control:TPageControl);
var list:TList;
begin
    list:=_makePageLIST_(Control,false); //< СЛЕВА от активной
   _tWRK_close_ListOfPAGEs_.Create(_ideMenuItem_closeSINGLE_,list).Start;
end;

//------------------------------------------------------------------------------

procedure tIn0k_LazIdePLG__wndSourceEdit_closeTabsOnDblClick._wrkEvent_dblClk(const Control:TPageControl; const Message:Cardinal);
var ShiftState:TShiftState;
begin
    try if Message=LM_LBUTTONDBLCLK then begin
            ShiftState:=GetKeyShiftState;
            if ShiftState=[] then _close_SINGLE_(Control)
            else
            if ShiftState=[ssShift] then _close_INVERT_(Control)
            else
            if ShiftState=[ssAlt] then _close_ppPxxx_(Control)
            else
            if ShiftState=[ssCtrl] then _close_xxxPpp_(Control);
        end;
    except
        {$ifDef _debugLOG_}
        on E:Exception do DEBUG(self.ClassName+addr2txt(self),'Exception: '+E.Message);
        {$endIf}
    end;
end;

end.


