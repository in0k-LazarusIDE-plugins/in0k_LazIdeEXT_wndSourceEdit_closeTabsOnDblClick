//------------------------------------------------------------------------------
//      Compilation settings of the component
//      Настройки компиляции компонента
//------------------------------------------------------------------------------


//--- # DEBUG ------------------------------------------------------------------
//  Позволяет просматривать лог событий в отдельном IDE окне
//  `View` -> `IDE Internals` -> `[debugLOG]..$(PkgName)..`
{$define in0k_LazarusIdeEXT__DEBUG}


{$define in0k_LazarusIdePLG__wndSourceEdit_closeTabsOnDblClick---reCaptionMenuItems}


//disable the default behavior
{$define in0k_LazarusIdeEXT---disableDefaultBehavior}

{$ifDef in0k_LazarusIdeEXT__DEBUG}
    {$define in0k_lazarusIdeSRC__tControl_fuckUpWndProc--DEBUG}
   //   in0k_lazarusIdeSRC__tControls_fuckUpWndProc--DEBUG
{$endIf}
