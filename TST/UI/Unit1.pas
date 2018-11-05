unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  messages, LMessages,
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ComCtrls,
  StdCtrls;

type

  { TForm1 }

 TmyPageControl=class(TPageControl)
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
    Memo1: TMemo;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    procedure FormCreate(Sender: TObject);
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
    s:='MouseDown';
    if (ssDouble in Shift)
    then s:=s+' '+'ssDouble';
    //
    memo1.Lines.Add(s);
end;

procedure TForm1.myPageControl_onClick(Sender: TObject);
begin
    memo1.Lines.Add('myPageControl_onClick');
end;

procedure TmyPageControl.WMLButtonDBLCLK(var Message: TLMLButtonDblClk); //message LM_LBUTTONDBLCLK;
begin
    inherited;
    Form1.memo1.Lines.Add('WMLButtonDBLCLK');
end;

procedure TForm1.myPageControl_OnDblClick(Sender: TObject);
begin
    Form1.memo1.Lines.Add('myPageControl_OnDblClick');
end;

procedure TmyPageControl.WMNCLButtonDblClk(var Message: TMessage);// message LM_NCLBUTTONDBLCLK;
begin
    inherited;
    Form1.memo1.Lines.Add('WMNCLButtonDblClk');
end;

var l:boolean;

procedure TmyPageControl.WndProc(var TheMessage: TLMessage);
var i:integer;
begin
    if TheMessage.msg=LM_LBUTTONDOWN then begin
       i:=TabIndex;
       inherited;
       l:=i=TabIndex;
    end
    else
    if (TheMessage.msg=LM_LButtonDBLCLK)and l then begin
       Form1.memo1.Lines.Add('WndProc LM_LButtonDBLCLK');
       if l then Form1.memo1.Lines.Add('WndProc true');
       inherited
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
    //myPageControl.ControlStyle:=myPageControl.ControlStyle+[csDoubleClicks];

    //
    myPageControl.OnClick:=@myPageControl_onClick;
    myPageControl.OnDblClick:=@myPageControl_OnDblClick;
    myPageControl.OnMouseDown:=@PageControl1MouseDown;
    // myPageControl.MouseDown();
end;

end.

