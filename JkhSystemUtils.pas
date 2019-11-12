{
본 컴포넌트는 BSD 라이센스를 따르고 있습니다.


원 BSD 라이선스에서 보증 부인의 “저작권 소유자와 기여자” 구문은 “평의원”과 기여자로” 해석된다. 라이선스 템플릿은 다음과 같다:

Copyright (c) 2012, Jung K. H / StyleNS / StyleNS.net
All rights reserved.

다음의 조건들을 충족시키는 한, 소스 형식과 바이너리 형식을 통한 재배포와 사용은 수정 여부에 관계없이 허용된다. 

소스 코드의 재배포는 위의 저작권 표시와 여기 나열된 조건들, 그리고 아래의 보증 부인 고지를 포함해야 한다. 

 

바이너리 형식으로 재배포 할 때는 위의 저작권 표시와 여기 나열된 조건들 그리고 아래의 보증 부인 고지를 배포할 때 제공되는
문서 및 기타 자료에 포함해야 한다. 

 

사전에 서면으로 허가를 받지 않는 한, StyleNS의 이름이나 기여자의 이름이 본 소프트웨어에서 추출한 제품을 보증하거나 홍보하는데 
사용되어서는 안 된다. 

저작권자와 기여자는 이 소프트웨어를 “있는 그대로의” 상태로 제공하며, 상품성 여부나 특정한 목적에 대한 적합성에 대한 묵시적 
보증을 포함한 어떠한 형태의 보증도 명시적이나 묵시적으로 제공되지 않는다.  손해 가능성을 사전에 알고 있었다 하더라도, 저작권자나 
기여자는 어떠한 경우에도 이 소프트웨어의 사용으로 인하여 발생한, 직접적이거나 간접적인 손해, 우발적이거나 결과적 손해, 특수하거나 
일반적인 손해에 대하여, 그 발생의 원인이나 책임론, 계약이나 무과실책임이나 불법행위(과실 등을 포함)와 관계 없이 책임을 지지 않는다. 
이러한 조건은 대체 재화나 용역의 구입 및 유용성이나 데이터, 이익의 손실, 그리고 영업 방해 등을 포함하나 이에 국한되지는 않는다.
}

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
