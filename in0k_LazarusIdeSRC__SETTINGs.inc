//------------------------------------------------------------------------------
//      Compilation settings of the component
//      Настройки компиляции компонента
//------------------------------------------------------------------------------


//--- # DEBUG ------------------------------------------------------------------
//  Позволяет просматривать лог событий в отдельном IDE окне
//  `View` -> `IDE Internals` -> `[debugLOG]..$(PkgName)..`
{$define in0k_LazarusIdeEXT__DEBUG}



{$ifDef in0k_LazarusIdeEXT__DEBUG}
    {.$define in0k_lazarusIdeSRC__tControl_fuckUpWndProc--DEBUG}
{$endIf}
