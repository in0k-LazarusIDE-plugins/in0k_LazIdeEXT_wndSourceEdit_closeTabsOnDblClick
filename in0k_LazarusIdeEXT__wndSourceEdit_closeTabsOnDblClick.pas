{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit in0k_LazarusIdeEXT__wndSourceEdit_closeTabsOnDblClick;

{$warn 5023 off : no warning about unused units}
interface

uses
  in0k_LazarusIdeEXT__REGISTER, 
  in0k_LazarusIdePLG__wndSourceEdit_closeTabsOnDblClick, 
  in0k_lazarusIdeSRC__expertCORE, in0k_lazarusIdeSRC__wndDEBUG, 
  in0k_lazarusIdeSRC__TMPLT_4SourceWindow, 
  in0k_lazarusIdeSRC__TMPLT_4SourceEditor, 
  in0k_lazarusIdeSRC__tControls_fuckUpWndProc, src_fuckUp_NoteBOOK, 
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
