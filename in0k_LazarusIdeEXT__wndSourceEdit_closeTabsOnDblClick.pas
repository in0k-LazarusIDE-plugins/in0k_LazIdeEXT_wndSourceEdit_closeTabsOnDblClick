{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit in0k_LazarusIdeEXT__wndSourceEdit_closeTabsOnDblClick;

interface

uses
  in0k_LazarusIdeEXT__REGISTER, 
  in0k_LazarusIdePLG__wndSourceEdit_closeTabsOnDblClick, 
  in0k_lazarusIdeSRC__expertCORE, in0k_lazarusIdeSRC__wndDEBUG, 
  in0k_lazarusIdeSRC__TMPLT_4SourceWindow, 
  in0k_lazarusIdeSRC__TMPLT_4SourceEditor, src_fuckUp_NoteBOOK, 
  in0k_lazarusIdeSRC__tControl_fuckUpWndProc, in0k_LazarusIdeSRC__SETTINGs, 
  LazarusPackageIntf;

implementation

procedure Register;
begin
  RegisterUnit('in0k_LazarusIdeEXT__REGISTER', 
    @in0k_LazarusIdeEXT__REGISTER.Register);
end;

initialization
  RegisterPackage('in0k_LazarusIdeEXT__wndSourceEdit_closeTabsOnDblClick', 
    @Register);
end.
