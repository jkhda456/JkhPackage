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

unit JkhFakeIME;

interface

uses
  Windows, Messages, SysUtils, Classes, IMM, StrUtils,
  {$if CompilerVersion <= 15}
  Forms, Controls;
  {$elseif CompilerVersion > 16}
  Vcl.Forms, Vcl.Controls;
  {$ifend}


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
    //Debug := IntToStr(Len);
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
