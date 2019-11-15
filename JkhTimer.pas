unit JkhTimer;

interface

uses
  Windows, Messages, Classes, ExtCtrls, Forms, Consts;

type
  // TTimer clone
  // for modify UpdateTimer method.
  TJkhTimer = class(TComponent)
  private
    FInterval: Cardinal;
    FWindowHandle: HWND;
    FOnTimer: TNotifyEvent;
    FEnabled: Boolean;
    procedure SetEnabled(Value: Boolean);
    procedure SetInterval(Value: Cardinal);
    procedure SetOnTimer(Value: TNotifyEvent);
    procedure WndProc(var Msg: TMessage);
  protected
    procedure UpdateTimer; virtual;
    procedure Timer; dynamic;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Enabled: Boolean read FEnabled write SetEnabled default True;
    property Interval: Cardinal read FInterval write SetInterval default 1000;
    property OnTimer: TNotifyEvent read FOnTimer write SetOnTimer;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('NS', [TJkhTimer]);
end;

constructor TJkhTimer.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FEnabled := True;
  FInterval := 1000;
{$IFDEF MSWINDOWS}   
  FWindowHandle := Classes.AllocateHWnd(WndProc);
{$ENDIF}
{$IFDEF LINUX}   
  FWindowHandle := WinUtils.AllocateHWnd(WndProc);
{$ENDIF}   
end;

destructor TJkhTimer.Destroy;
begin
  FEnabled := False;
  UpdateTimer;
{$IFDEF MSWINDOWS}   
  Classes.DeallocateHWnd(FWindowHandle);
{$ENDIF}
{$IFDEF LINUX}
  WinUtils.DeallocateHWnd(FWindowHandle);
{$ENDIF}   
  inherited Destroy;
end;

procedure TJkhTimer.WndProc(var Msg: TMessage);
begin
  with Msg do
    if Msg = WM_TIMER then
      try
        Timer;
      except
        Application.HandleException(Self);
      end
    else
      Result := DefWindowProc(FWindowHandle, Msg, wParam, lParam);
end;

procedure TJkhTimer.UpdateTimer;
begin
  KillTimer(FWindowHandle, 1);
  if (FInterval <> 0) and FEnabled and Assigned(FOnTimer) then
    if SetTimer(FWindowHandle, 1, FInterval, nil) = 0 then
      raise EOutOfResources.Create(SNoTimers);
end;

procedure TJkhTimer.SetEnabled(Value: Boolean);
begin
  FEnabled := Value;
  UpdateTimer;
end;

procedure TJkhTimer.SetInterval(Value: Cardinal);
begin
  FInterval := Value;
  UpdateTimer;
end;

procedure TJkhTimer.SetOnTimer(Value: TNotifyEvent);
begin
  FOnTimer := Value;
  UpdateTimer;
end;

procedure TJkhTimer.Timer;
begin
  if Assigned(FOnTimer) then FOnTimer(Self);
end;

end.
