unit JkhSystemUtils;

interface

uses
  Windows, SysUtils, Classes, MultiMon;

type
  PROCESS_DPI_AWARENESS = (
     PROCESS_DPI_UNAWARE,
     PROCESS_SYSTEM_DPI_AWARE,
     PROCESS_PER_MONITOR_DPI_AWARE
  );
  MONITOR_DPI_TYPE = (
     MDT_EFFECTIVE_DPI,
     MDT_ANGULAR_DPI,
     MDT_RAW_DPI,
     MDT_DEFAULT
  );

  TGetProcessDPIAwareness = function(const hProcess: THandle; var Value: PROCESS_DPI_AWARENESS): HRESULT; stdcall;
  TSetProcessDPIAwareness = function(const Value: PROCESS_DPI_AWARENESS): HRESULT; stdcall;
  TGetDpiForMonitor = function(hMonitor: HMONITOR; dpiType: MONITOR_DPI_TYPE; var dpiX: UINT; var dpiY: UINT): HRESULT; stdcall;

// recommend use JclSysInfo.pas ...
function GetOSVersionInfo(var VersionInfo : TOSVersionInfo): Boolean;
function UsingWinNT: Boolean;
function UsingWin81Upper: Boolean;

function SetProcessDPIAwareness(ALevel: PROCESS_DPI_AWARENESS): Boolean;
function GetCurrentDPI(ATargetHandle: THandle): Integer;

procedure MakeSystemInfoFolder(ATargetFolder, ATargetInfo: String);

const
  DefaultDPI = 96;

implementation

var
  ShCoreLib: THandle = 0;

function LoadShCoreLib: Boolean;
begin
  Result := True;
  If ShCoreLib <> 0 Then Exit;

  ShCoreLib := LoadLibrary('shcore.dll'); // GetModuleHandle('Shcore');
  If ShCoreLib = 0 Then
     Result := False;
end;

procedure FreeShCoreLib;
begin
  If ShCoreLib = 0 Then Exit;
  FreeLibrary(ShCoreLib);
end;

function GetOSVersionInfo(var VersionInfo : TOSVersionInfo): Boolean;
begin
  Result := False;
  FillChar( VersionInfo, SizeOf(VersionInfo), #0 );
  VersionInfo.dwOSVersionInfoSize := SizeOf(VersionInfo);

  if (GetVersionEx( VersionInfo ) = False) then
     Exit;

  Result := True;
end;

function UsingWinNT: Boolean;
var
  myVersionInfo : TOSVersionInfo;
begin
  Result := False;
  If Not GetOSVersionInfo(myVersionInfo) Then Exit;

  If myVersionInfo.dwPlatformId = VER_PLATFORM_WIN32_NT Then
     Result := True;
end;

function UsingWin81Upper: Boolean;
var
  myVersionInfo : TOSVersionInfo;
begin
  Result := False;
  If Not GetOSVersionInfo(myVersionInfo) Then Exit;

  if (myVersionInfo.dwMajorVersion >= 6) and (myVersionInfo.dwMinorVersion >= 3) then
     Result := True;
end;

function SetProcessDPIAwareness(ALevel: PROCESS_DPI_AWARENESS): Boolean;
var
  SetAwareness: TSetProcessDPIAwareness;
begin
  Result := False;

  If Not LoadShCoreLib Then Exit;

  // GetAwareness := TGetProcessDPIAwareness(GetProcAddress(ShCoreLib, 'GetProcessDpiAwareness')); // for after check
  SetAwareness := TSetProcessDPIAwareness(GetProcAddress(ShCoreLib, 'SetProcessDpiAwareness'));
  If Assigned(SetAwareness) Then
  Begin
     SetAwareness(ALevel);
     Result := True;
  End;
end;

function GetCurrentDPI(ATargetHandle: THandle): Integer;
var
  MainDC: HDC;
  CurrentMon: HMONITOR;
  ShCoreLib: THandle;
  GetDpiMon: TGetDpiForMonitor;
  dpiX, dpiY: UINT;
  // virtualWidth, physicalWidth: Integer;
begin
  Result := DefaultDPI;

  {
  // windows 10 not works. it is 6.2 (need OsVersionInfoEx)
  If UsingWin81Upper Then
  Begin
     If Not LoadShCoreLib Then Exit;

     CurrentMon := MonitorFromWindow(ATargetHandle, MONITOR_DEFAULTTONULL);
     If (CurrentMon <> 0) Then
     Begin
        GetDpiMon := GetProcAddress(ShCoreLib, 'GetDpiForMonitor');
        If @GetDpiMon <> nil Then
        Begin
           dpiX := 0;
           dpiY := 0;

           If GetDpiMon(CurrentMon, MDT_EFFECTIVE_DPI, dpiX, dpiY) = S_OK Then
           Begin
              Result := dpiX;
           End;
        End;
     End;
  End
  Else
  }
  Begin
     MainDC := GetDC(0);

     { // not works.
     virtualWidth := GetDeviceCaps(MainDC, HORZRES);
     physicalWidth := GetDeviceCaps(MainDC, DESKTOPHORZRES);
     Result := Round(DefaultDPI * physicalWidth / virtualWidth);
     }

     Result := GetDeviceCaps(MainDC, LOGPIXELSX);

     ReleaseDC(0, MainDC);
  End;
end;

procedure MakeSystemInfoFolder(ATargetFolder, ATargetInfo: String);
var
  PathMakeSystemFolder: function(pszPath: LPSTR): BOOL; stdcall;
  ShlwAPI: HMODULE;
  DesktopFile: TFileStream;
  Buffer: String;
begin
  If ATargetInfo = '' Then Exit;
  If Not DirectoryExists(ATargetFolder) Then Exit;
  If FileExists(ATargetFolder+'Desktop.ini') Then Exit;

  //function PathMakeSystemFolder(pszPath: LPSTR): BOOL; stdcall; external
  //     'shlwapi.dll' name 'PathMakeSystemFolderA';

  ShlwAPI := LoadLibrary('shlwapi.dll');
  If ShlwAPI = 0 Then Exit;
  DesktopFile := TFileStream.Create(ATargetFolder+'Desktop.ini', fmCreate);
  Try
     PathMakeSystemFolder := GetProcAddress(ShlwAPI, 'PathMakeSystemFolderA');
     If @PathMakeSystemFolder = Nil Then Exit;

     PathMakeSystemFolder(PChar(ATargetFolder));

     Buffer := '[{F29F85E0-4FF9-1068-AB91-08002B27B3D9}]'#13#10+
               'Prop2='+ATargetInfo;
     DesktopFile.Write(Buffer[1], Length(Buffer));
  Finally
     DesktopFile.Free;
     FreeLibrary(ShlwAPI);
  End;
end;

initialization
  ;

finalization
  FreeShCoreLib;

end.
