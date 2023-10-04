unit JkhSystemPopupRestore;

// 태스크 바에 버튼을 모두 살려보자
//
// TJkhSystemPopupRestore - v 1.1
// 삽질한 사람 : 정기홍
//
// 2008년 11월 27일 퇴근하다 말고 끄적거림
// 델마당 게시물에 설명 다해놨으니 문의, 질문 일체 안 받음

interface

uses
  SysUtils, Classes, Forms, Windows, Messages;

type
  TJkhSystemPopupRestore = class(TComponent)
  private
    FWindowHandle: HWND;
    procedure CreateMenuList;
  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
  end;

procedure Register;

implementation

const
  BufferSize = 100;
var
  FParent: TForm;
  pOldWndProc: Integer;
  hSysMenu: HMENU;

procedure Register;
begin
  RegisterComponents('NS', [TJkhSystemPopupRestore]);
end;

function GetWindowsState: TWindowState;
var
  Placement: TWindowPlacement;
begin
  // 볼랜드의 버그 코드를 약간 고쳐서 그대로 썼음
  Placement.length := SizeOf(TWindowPlacement);
  GetWindowPlacement(FParent.Handle, @Placement);
  case Placement.showCmd of
    SW_SHOWMINIMIZED: Result := wsMinimized;
    SW_SHOWMAXIMIZED: Result := wsMaximized;
  else
    If IsIconic(Application.Handle) Then
       Result := wsMinimized
    Else
       Result := wsNormal;
  end;
end;

procedure UpdateMenuList;
var
  hSysMenu :HMENU;
  MaxVar,
  LoopVar: Integer;
  TempRecord: TMENUITEMINFO;
  Buffer: array[0..BufferSize] of Char;
  CurWindowsState: TWindowState;
begin
  // 메뉴 업데이트만 하는 함수
  hSysMenu  := GetSystemMenu(Application.Handle, FALSE);
  MaxVar := GetMenuItemCount(hSysMenu);
  CurWindowsState := GetWindowsState;

  For LoopVar := 0 to MaxVar-1 do
  Begin
     TempRecord.cbSize := SizeOf(TMenuItemInfo);
     TempRecord.fMask := MIIM_STATE+MIIM_ID;
     TempRecord.dwTypeData := Buffer;
     TempRecord.cch := SizeOf(Buffer);

     GetMenuItemInfo(hSysMenu, LoopVar, True, TempRecord);

     // 일일이 수작업으로 설정해두지 않으면 제대로 돌아가지 않는다는게 슬프다!!
     Case TempRecord.wID of
        SC_RESTORE:
           If CurWindowsState = wsNormal Then
              TempRecord.fState := MFS_DISABLED
           Else
              TempRecord.fState := MFS_ENABLED;
        SC_MOVE,
        SC_SIZE:
           If CurWindowsState = wsNormal Then
              TempRecord.fState := MFS_ENABLED
           Else
              TempRecord.fState := MFS_DISABLED;
        SC_MINIMIZE:
           If CurWindowsState = wsMinimized Then
              TempRecord.fState := MFS_DISABLED
           Else
              TempRecord.fState := Integer(Not (biMinimize in FParent.BorderIcons)) * 3;
        SC_MAXIMIZE:
           If CurWindowsState = wsMaximized Then
              TempRecord.fState := MFS_DISABLED
           Else
              TempRecord.fState := Integer(Not (biMaximize in FParent.BorderIcons)) * 3;
     End;
     // FParent.
     TempRecord.fMask := MIIM_STATE;

     SetMenuItemInfo(hSysMenu, LoopVar, True, TempRecord);
  End;
end;

function  NewWndProc(hWin:HWND;uMsg,wPar,lPar:DWORD)  :DWORD; stdcall;
begin
  Case uMsg of

  WM_INITMENUPOPUP:
    UpdateMenuList;

  WM_SYSCOMMAND:
  Begin
     // 이건... 뭐하는 삽질인고
     case wPar of
        SC_RESTORE:
        Begin
           If GetWindowsState = wsMaximized Then
           Begin
              if Assigned(Application.MainForm) then
                 Application.MainForm.Perform(uMsg,wPar,lPar);
           End;
        End;

        SC_MAXIMIZE,
        SC_MINIMIZE,
        SC_MOVE,SC_SIZE :
        begin
           Result := 0;

           if Assigned(Application.MainForm) then
              Application.MainForm.Perform(uMsg,wPar,lPar);

           EXIT;
        end;
     end;
  End;

  End;

  Result := CallWindowProc(Pointer(pOldWndProc),hWin,uMsg,wPar,lPar);
end;

{ TJkhSystemPopupRestore }

constructor TJkhSystemPopupRestore.Create(AOwner: TComponent);
begin
  inherited;

  FParent := Nil;

  if csDesigning in ComponentState then Exit;

  If AOwner is TForm Then
     FParent := AOwner as TForm;

  pOldWndProc := GetWindowLong(Application.Handle,GWL_WNDPROC);
  SetWindowLong(Application.Handle,GWL_WNDPROC,Integer(@NewWndProc));

  CreateMenuList;

  SetWindowLong(Application.Handle,GWL_STYLE,GetWindowLong(Application.Handle,GWL_STYLE) or WS_MINIMIZEBOX or WS_MAXIMIZEBOX or WS_THICKFRAME);
end;

procedure TJkhSystemPopupRestore.CreateMenuList;
var
  hFormMenu,
  hSysMenu :HMENU;
  MaxVar,
  LoopVar: Integer;
  TempRecord: TMENUITEMINFO;
  Buffer: array[0..BufferSize] of Char;
  CurLine: String;

  // 부실 함수지만 대충 쓸꺼니깐...
  function FindSystemMenu(FindText: String): Boolean;
  var
    iSchLoop: Integer;
    iMenuItemInfo: TMenuItemInfo;
    iMenuName: array[0..BufferSize] of Char;
  begin
    Result := False;

    For iSchLoop := 0 to GetMenuItemCount(hSysMenu) -1 do
    Begin
       iMenuItemInfo.cbSize := SizeOf(TMenuItemInfo);
       iMenuItemInfo.fMask := MIIM_TYPE;
       iMenuItemInfo.dwTypeData := iMenuName;
       iMenuItemInfo.cch := BufferSize;
       GetMenuItemInfo(hSysMenu, iSchLoop, True, iMenuItemInfo);

       If Copy(iMenuName,0,iMenuItemInfo.cch) = FindText Then
       Begin
          Result := True;
          Break;
       End;
    End;
  end;
begin
  hFormMenu  := GetSystemMenu(FParent.Handle, FALSE);
  hSysMenu  := GetSystemMenu(Application.Handle, FALSE);

  MaxVar := GetMenuItemCount(hFormMenu);

  For LoopVar := 0 to MaxVar-1 do
  Begin
     TempRecord.cbSize := SizeOf(TMenuItemInfo);
     TempRecord.fMask := MIIM_TYPE + MIIM_ID;
     TempRecord.dwTypeData := Buffer;
     TempRecord.cch := SizeOf(Buffer) ;

     GetMenuItemInfo(hFormMenu, LoopVar, True, TempRecord);
     CurLine := Copy(Buffer, 0, TempRecord.cch);
     If FindSystemMenu(CurLine) Then Continue;
     If Trim(CurLine) = '' Then Continue;

     InsertMenuItem(hSysMenu, LoopVar, True, TempRecord);

     TempRecord.cbSize := SizeOf(TMenuItemInfo);
     TempRecord.fMask := MIIM_BITMAP;
     TempRecord.dwTypeData := Buffer;
     TempRecord.cch := SizeOf(Buffer) ;

     GetMenuItemInfo(hFormMenu, LoopVar, True, TempRecord);
     SetMenuItemInfo(hSysMenu, LoopVar, True, TempRecord);
  End;
end;

destructor TJkhSystemPopupRestore.Destroy;
begin
  inherited;
end;

end.
