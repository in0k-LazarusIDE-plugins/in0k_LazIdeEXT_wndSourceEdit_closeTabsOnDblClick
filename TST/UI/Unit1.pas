unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  messages, LMessages, Classes, SysUtils, FileUtil, ExtendedNotebook, Forms,
  Controls, Graphics, Dialogs, ComCtrls, StdCtrls;

type

  { TForm1 }

 TmyPageControl=class(TExtendedNotebook)
  protected
   procedure WMLButtonDBLCLK(var Message: TLMLButtonDblClk); message LM_LBUTTONDBLCLK;
   procedure WMNCLButtonDblClk(var Message: TMessage); message LM_NCLBUTTONDBLCLK;
  protected
   property OnMouseDown;
   property OnDblClick;
  protected
   procedure WndProc(var TheMessage: TLMessage); override;
  end;

  TForm1 = class(TForm)
    ExtendedNotebook1: TExtendedNotebook;
    Memo1: TMemo;
    PageControl1: TExtendedNotebook;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    procedure FormCreate(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure PageControl1Changing(Sender: TObject; var AllowChange: Boolean);
    procedure PageControl1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    myPageControl:TmyPageControl;
    procedure myPageControl_onClick(Sender: TObject);
  public
    procedure myPageControl_OnDblClick(Sender: TObject);
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.PageControl1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var s:string;
begin
   { s:='MouseDown';
    if (ssDouble in Shift)
    then s:=s+' '+'ssDouble ';
    //
    memo1.Lines.Add(s+inttostr(self.PageControl1.ActivePageIndex));  }
end;

procedure TForm1.myPageControl_onClick(Sender: TObject);
begin
    //memo1.Lines.Add('myPageControl_onClick '+inttostr(self.PageControl1.ActivePageIndex));
end;

procedure TmyPageControl.WMLButtonDBLCLK(var Message: TLMLButtonDblClk); //message LM_LBUTTONDBLCLK;
begin
    inherited;
    //Form1.memo1.Lines.Add('WMLButtonDBLCLK '+inttostr(self.ActivePageIndex));
end;

procedure TForm1.myPageControl_OnDblClick(Sender: TObject);
begin
    //Form1.memo1.Lines.Add('myPageControl_OnDblClick '+inttostr(self.PageControl1.ActivePageIndex));
end;

procedure TmyPageControl.WMNCLButtonDblClk(var Message: TMessage);// message LM_NCLBUTTONDBLCLK;
begin
    inherited;
    //Form1.memo1.Lines.Add('WMNCLButtonDblClk '+inttostr(self.ActivePageIndex));
end;

var l:boolean;

procedure TmyPageControl.WndProc(var TheMessage: TLMessage);
var i:integer;
begin
    if TheMessage.msg=LM_LBUTTONDOWN then begin
//       i:=TabIndex;
       Form1.memo1.Lines.Add('WndProc LM_LBUTTONDOWN '+inttostr(self.ActivePageIndex));
       inherited;
//       l:=i=TabIndex;
    end
    else
    if (TheMessage.msg=LM_LButtonDBLCLK){and l} then begin
       //Form1.memo1.Lines.Add('WndProc LM_LButtonDBLCLK');
       //if l then Form1.memo1.Lines.Add('WndProc true');
       Form1.memo1.Lines.Add('WndProc LM_LButtonDBLCLK '+inttostr(self.ActivePageIndex));
       inherited
    end
    else
    if (TheMessage.msg=CN_NOTIFY) then begin
       inherited;
    end
    else inherited;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
    myPageControl:=TmyPageControl.Create(self);
    myPageControl.Parent:=self;
    myPageControl.Align:=alTop;
    myPageControl.AddTabSheet;
    myPageControl.AddTabSheet;
    myPageControl.ControlStyle:=myPageControl.ControlStyle+[csDoubleClicks];
    //
    myPageControl.OnClick:=@myPageControl_onClick;
    myPageControl.OnDblClick:=@myPageControl_OnDblClick;
    myPageControl.OnMouseDown:=@PageControl1MouseDown;
    myPageControl.OnChange:=@PageControl1Change;
    myPageControl.OnChanging:=@PageControl1Changing;
end;

procedure TForm1.PageControl1Change(Sender: TObject);
begin
    Form1.memo1.Lines.Add('PageControl1Change');
end;

procedure TForm1.PageControl1Changing(Sender: TObject; var AllowChange: Boolean);
begin
    Form1.memo1.Lines.Add('PageControl1Changing');
end;

end.

