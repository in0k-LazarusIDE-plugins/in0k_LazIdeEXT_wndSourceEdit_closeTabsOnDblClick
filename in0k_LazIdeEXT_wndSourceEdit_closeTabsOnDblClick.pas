{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit in0k_LazIdeEXT_wndSourceEdit_closeTabsOnDblClick;

{$warn 5023 off : no warning about unused units}
interface

uses
  in0k_LazarusIdeEXT_Register, 
  in0k_LazIdeEXT_wndSourceEdit_closeTabsOnDblClick_MAIN, LazarusPackageIntf;

implementation

procedure Register;
begin
  RegisterUnit('in0k_LazarusIdeEXT_Register', 
    @in0k_LazarusIdeEXT_Register.Register);
end;

initialization
  RegisterPackage('in0k_LazIdeEXT_wndSourceEdit_closeTabsOnDblClick', @Register
    );
end.
