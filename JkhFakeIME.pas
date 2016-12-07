unit JkhFakeIME;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, Forms, IMM, StrUtils;

type
  TJkhFakeIMENotify = procedure(ASender: TObject; AMessage: PWideChar) of object;

  TJkhFakeIME = class(TCustomControl)
  private
    FFocused: Boolean;
    FParentForm: TCustomForm;
    FOnIMEComplete: TJkhFakeIMENotify;
    FOnIMEComposit: TJkhFakeIMENotify;
  protected
    procedure DoOnIMEComplete(AMessage: PWideChar);
    procedure DoOnIMEComposit(AMessage: PWideChar);
  public
    Constructor Create(AOwner: TComponent); override;
    Destructor Destroy; override;

    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateHandle;

    procedure WndProc(var Message: TMessage); override;

    procedure WMGetDlgCode(var Message: TWMGetDlgCode);   message WM_GETDLGCODE;
    procedure WMSetFocus(var Message: TWMSetFocus);       message WM_SETFOCUS;
    procedure WMKillFocus(var Message: TWMKillFocus);     message WM_KILLFOCUS;

    procedure WMIMEComposition(var Message: TMessage);    message WM_IME_COMPOSITION;
    procedure WMIMEControl(var Message: TMessage);        message WM_IME_CONTROL;
    procedure WMIMENotifyControl(var Message: TMessage);  message WM_IME_NOTIFY;

    property Focused: Boolean read FFocused;
  published
    property OnIMEComplete: TJkhFakeIMENotify read FOnIMEComplete write FOnIMEComplete;
    property OnIMEComposit: TJkhFakeIMENotify read FOnIMEComposit write FOnIMEComposit;
    property OnKeyPress;
    property OnKeyDown;
    property OnKeyUp;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('NS', [TJkhFakeIME]);
end;

{ TJkhFakeIME }

constructor TJkhFakeIME.Create(AOwner: TComponent);
begin
  inherited;

  TabStop := True;
end;

procedure TJkhFakeIME.CreateHandle;
begin
  inherited CreateHandle;
  FParentForm := GetParentForm( Self );
end;

procedure TJkhFakeIME.CreateParams(var Params: TCreateParams);
begin
  inherited;

end;

destructor TJkhFakeIME.Destroy;
begin

  inherited;
end;

procedure TJkhFakeIME.DoOnIMEComplete(AMessage: PWideChar);
begin
  If Not Assigned(FOnIMEComplete) Then Exit;

  FOnIMEComplete(Self, AMessage);
end;

procedure TJkhFakeIME.DoOnIMEComposit(AMessage: PWideChar);
begin
  If Not Assigned(FOnIMEComposit) Then Exit;

  FOnIMEComposit(Self, AMessage);
end;

procedure TJkhFakeIME.WMGetDlgCode(var Message: TWMGetDlgCode);
begin

end;

procedure TJkhFakeIME.WMIMEComposition(var Message: TMessage);
var
  imComp: PWideChar;
  hIGC: HIMC;
  len: Integer;
begin
  hIGC := ImmGetContext(Self.Handle);

  If ( Message.LParam and GCS_RESULTSTR ) = GCS_RESULTSTR Then
  Begin
    DoOnIMEComposit(#0);

    len := ImmGetCompositionStringW( hIGC, GCS_RESULTSTR, nil, 0);
    If len < 0 Then
    Begin
       Exit;
    End;
    imComp := PWideChar( AllocMem( len * 2 ) );
    ImmGetCompositionStringW( hIGC, GCS_RESULTSTR, imComp, Len );

    {$IfDEF Debug}
    Debug := IntToStr(Len);
    {$EndIF}
    If Len <> 0 Then
    Begin
       // ExchageText(CaretX, CaretY, FImePrevCompLen, imComp, False);
       // MEssageBoxW(0, imComp, '', 0);
       DoOnIMEComplete(imComp);
    End;

    ImmReleaseContext( Self.Handle, hIGC);
    FreeMemory( imComp );
  End
  Else If ( Message.LParam and GCS_COMPSTR ) = GCS_COMPSTR Then
  Begin
     len := ImmGetCompositionStringW( hIGC, GCS_COMPSTR, nil, 0);
     If len < 0 Then
     Begin
        ImmReleaseContext( Self.Handle, hIGC);
        Exit;
     End;

     If Len = 0 Then
     Begin
        imComp := #0;
        DoOnIMEComposit(imComp);
        
        ImmReleaseContext( Self.Handle, hIGC );
        Exit;
     End;

     imComp := PWideChar( AllocMem( len * 2 ) );
     ImmGetCompositionStringW( hIGC, GCS_COMPSTR, imComp, Len );

     DoOnIMEComposit(imComp);

     ImmReleaseContext( Self.Handle, hIGC);
     FreeMemory( imComp );
  End;
end;

procedure TJkhFakeIME.WMIMEControl(var Message: TMessage);
begin

end;

procedure TJkhFakeIME.WMIMENotifyControl(var Message: TMessage);
begin

end;

procedure TJkhFakeIME.WMKillFocus(var Message: TWMKillFocus);
begin
  FFocused := False;
end;

procedure TJkhFakeIME.WMSetFocus(var Message: TWMSetFocus);
begin
  FFocused := True;
end;

procedure TJkhFakeIME.WndProc(var Message: TMessage);
var
  PT: TPoint;
begin
  Case Message.Msg of
     // 이곳을 살리면 일윈에서 IME 툴박스가 죽습니다.
     {WM_IME_SETCONTEXT       : With Message Do
                               Begin
                                  LParam := LParam or (not ISC_ShowUiCompositionWindow);
                               End;}
     WM_IME_STARTCOMPOSITION : Begin
                                  Message.Result := 0;
                               End;
     WM_IME_ENDCOMPOSITION   : Begin
                                  Message.Result := 0;
                               End;
     WM_IME_CHAR             : Begin
                               End;
     {WM_IME_KEYLAST          : Begin
                               End;
     WM_IME_SETCONTEXT       : Begin
                               End;
     WM_IME_NOTIFY           : Begin
        // Message.Result := 0;
                               End;
     WM_IME_CONTROL          : Begin
                               End;
     WM_IME_COMPOSITIONFULL  : Begin
                               End;
     WM_IME_SELECT           : Begin
                               End;
     WM_IME_KEYDOWN          : Begin
                               End;
     WM_IME_KEYUP            : Begin
                               End;}
  Else
     Inherited;
  End;
end;

end.
