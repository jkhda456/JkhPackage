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

unit JkhCheckButton;

interface

uses
  Windows, Messages, SysUtils, Classes,
  {$if CompilerVersion <= 15}
  Controls, ExtCtrls, Graphics, Types;
  {$elseif CompilerVersion > 16}
  Vcl.Controls, Vcl.ExtCtrls, Vcl.Graphics, System.Types;
  {$ifend}

type
  TJkhCheckButton = class(TGraphicControl)
  private
    FDragging: Boolean;
    FMouseInControl: Boolean;
    FTransparent: Boolean;
    FSpacing: Integer;
    FMargin: Integer;
    FUncheckImage: TPicture;
    FHotTrackColor: TColor;
    FDownColor: TColor;
    FButtonColor: TColor;
    FDisabledFontColor: TColor;
    FOnInMouse: TNotifyEvent;
    FOnOutMouse: TNotifyEvent;
    FCheckImage: TPicture;
    FChecked: Boolean;
    FScreenLogPixels: Integer;

    procedure SetMargin(const Value: Integer);
    procedure SetSpacing(const Value: Integer);
    procedure SetTransparent(const Value: Boolean);
    procedure SetUncheckImage(const Value: TPicture);
    procedure SetButtonColor(const Value: TColor);
    procedure SetDownColor(const Value: TColor);
    procedure SetHotTrackColor(const Value: TColor);

    procedure WMLButtonDblClk(var Message: TWMLButtonDown); message WM_LBUTTONDBLCLK;
    procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED;
    procedure CMButtonPressed(var Message: TMessage); message CM_BUTTONPRESSED;
    procedure CMDialogChar(var Message: TCMDialogChar); message CM_DIALOGCHAR;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure CMTextChanged(var Message: TMessage); message CM_TEXTCHANGED;
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure SetCheckImage(const Value: TPicture);
    procedure SetChecked(const Value: Boolean);
  protected
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure Paint; override;
    property MouseInControl: Boolean read FMouseInControl;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Click; override;
  published
    property UncheckImage: TPicture read FUncheckImage write SetUncheckImage;
    property CheckImage: TPicture read FCheckImage write SetCheckImage;
    property Anchors;
    property Constraints;
    property Caption;
    property Enabled;
    property Font;
    property Margin: Integer read FMargin write SetMargin default -1;
    property ParentFont;
    property ParentShowHint;
    property ParentBiDiMode;
    property PopupMenu;
    property ShowHint;
    property Spacing: Integer read FSpacing write SetSpacing default 4;
    property Transparent: Boolean read FTransparent write SetTransparent default True;
    property Visible;
    property Checked: Boolean read FChecked write SetChecked;

    property DisabledFontColor: TColor read FDisabledFontColor write FDisabledFontColor;
    property ButtonColor: TColor read FButtonColor write SetButtonColor;
    property HotTrackColor: TColor read FHotTrackColor write SetHotTrackColor;
    property DownColor: TColor read FDownColor write SetDownColor;

    property OnClick;
    property OnDblClick;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;

    property OnInMouse: TNotifyEvent read FOnInMouse write FOnInMouse;
    property OnOutMouse: TNotifyEvent read FOnOutMouse write FOnOutMouse;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('NS', [TJkhCheckButton]);
end;

{ TJkhFlatButton }

procedure TJkhCheckButton.Click;
begin
  inherited;
  Checked := Not Checked;
end;

procedure TJkhCheckButton.CMButtonPressed(var Message: TMessage);
begin
  inherited;
  Repaint;
end;

procedure TJkhCheckButton.CMDialogChar(var Message: TCMDialogChar);
begin

end;

procedure TJkhCheckButton.CMEnabledChanged(var Message: TMessage);
begin
  Invalidate;
end;

procedure TJkhCheckButton.CMFontChanged(var Message: TMessage);
begin
  Invalidate;
end;

procedure TJkhCheckButton.CMMouseEnter(var Message: TMessage);
begin
  inherited;

  If Assigned(FOnInMouse) Then FOnInMouse(Self);
end;

procedure TJkhCheckButton.CMMouseLeave(var Message: TMessage);
begin
  inherited;

  If Assigned(FOnOutMouse) Then FOnOutMouse(Self);
end;

procedure TJkhCheckButton.CMTextChanged(var Message: TMessage);
begin
  Invalidate;
end;

constructor TJkhCheckButton.Create(AOwner: TComponent);
var
  DC: HDC;
begin
  inherited Create(AOwner);
  SetBounds(0, 0, 23, 22);
  ControlStyle := [csCaptureMouse, csDoubleClicks];
  ParentFont := True;
  Color := clBtnFace;
  FDragging := False;
  FSpacing := 4;
  FMargin := 0;
  FTransparent := True;
  FUncheckImage := TPicture.Create;
  FCheckImage := TPicture.Create;
  FHotTrackColor := $00f7e6cd;
  FDownColor := $00f0d6b1;
  FButtonColor := clWhite;
  FChecked := True;
  FDisabledFontColor := clDefault;

  DC := GetDC(0);
  FScreenLogPixels := GetDeviceCaps(DC, LOGPIXELSY);
  ReleaseDC(0,DC);
end;

destructor TJkhCheckButton.Destroy;
begin
  FUncheckImage.Free;
  FCheckImage.Free;

  inherited;
end;

procedure TJkhCheckButton.MouseDown(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited MouseDown(Button, Shift, X, Y);
  if (Button = mbLeft) and Enabled then
  begin
    FDragging := True;
  end;
end;

procedure TJkhCheckButton.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  inherited;

end;

procedure TJkhCheckButton.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
var
  DoClick: Boolean;
begin
  inherited MouseUp(Button, Shift, X, Y);
  if FDragging then
  begin
    FDragging := False;
    DoClick := (X >= 0) and (X < ClientWidth) and (Y >= 0) and (Y <= ClientHeight);

    { Redraw face in-case mouse is captured }
    if DoClick then Click;
    // UpdateTracking;
  end;
end;

procedure TJkhCheckButton.Paint;
var
  TextBaseSize: TSize;
  TextBaseHeight,
  TextBaseWidth,
  Cx, Cy: Integer;
  Rect: TRect;
  DrawImage: TPicture;

  procedure DoDrawImage(LAlpha: Integer);
  begin
  end;

  procedure DoDrawText;
  var
    Text: string;
    lf: LOGFONT;
    Flags: Integer;
    ShowAccelChar: Boolean;
  begin
    // Rect, Rect.Left, Rect.Top,
    Text := Caption;
    // Flag 지원 안할거다.
    Flags := 0;
    ShowAccelChar := True;
    
    if (Flags and DT_CALCRECT <> 0) and ((Text = '') or ShowAccelChar and
      (Text[1] = '&') and (Text[2] = #0)) then Text := Text + ' ';
    if not ShowAccelChar then Flags := Flags or DT_NOPREFIX;
    Flags := DrawTextBiDiModeFlags(Flags);
    //Canvas.Font := Font;

    FillChar(lf, SizeOf(lf), Byte(0));
    lf.lfHeight := -MulDiv(Font.Size, FScreenLogPixels, 72);
    lf.lfWidth := 0;
    lf.lfWeight := FW_NORMAL;
    lf.lfQuality := ANTIALIASED_QUALITY;
    lf.lfCharSet := HANGEUL_CHARSET;
    StrCopy(lf.lfFaceName, PChar(Font.Name));
    Canvas.Font.Handle := CreateFontIndirect(lf);
    Canvas.Font.Color := Font.Color;

    if not Enabled then
    begin
      OffsetRect(Rect, 1, 1);
      Canvas.Font.Color := clBtnHighlight;
      DrawText(Canvas.Handle, PChar(Text), Length(Text), Rect, Flags);
      OffsetRect(Rect, -1, -1);
      Canvas.Font.Color := clBtnShadow;
      DrawText(Canvas.Handle, PChar(Text), Length(Text), Rect, Flags);
    end
    else
      DrawText(Canvas.Handle, PChar(Text), Length(Text), Rect, Flags);
  end;

begin
  inherited;

  Canvas.Font := Self.Font;

  If Transparent Then
     Canvas.Brush.Style := bsClear;

  TextBaseHeight := Margin;
  If Caption <> '' Then
  Begin
     TextBaseSize := Canvas.TextExtent(Caption);
     TextBaseHeight := TextBaseHeight + TextBaseSize.cy;
     TextBaseWidth := TextBaseSize.cx;

     If TextBaseWidth <= 0 Then TextBaseWidth := 1;

     If Not Enabled Then
        Canvas.Font.Color := FDisabledFontColor
     Else
        Canvas.Font.Color := Font.Color; 
  End;

  DrawImage := Nil;
  If Checked Then
  Begin
     If Assigned(CheckImage) Then DrawImage := CheckImage;
  End
  Else
  Begin
     If Assigned(UncheckImage) Then DrawImage := UncheckImage;
  End;

  // 이미지랑 Caption이 있으면 그린다. 단 그전에 위치 파악을 하자.
  If Assigned(DrawImage.Graphic) Then
  Begin
     //Cx := ((Width - TextBaseWidth - Margin) div 2) - (DrawImage.Width div 2);
     Cx := 1;
     Cy := (Height div 2) - (DrawImage.Height div 2);

     Rect.Left := Cx;
     Rect.Top := Cy;
     Rect.Right := Cx + DrawImage.Width;
     Rect.Bottom := Cy + DrawImage.Height;

     Canvas.StretchDraw(Rect, DrawImage.Graphic);
     // 하지말자. 기찮다.
     //DoDrawImage(150);

     Rect.Left := Rect.Right + Margin-1;
     Rect.Top := (Height div 2) - (TextBaseHeight div 2);
     Rect.Right := Rect.Left + TextBaseWidth;
     Rect.Bottom := Rect.Top + TextBaseHeight;
  End
  Else
  Begin
     Rect.Left := (Width div 2) - (TextBaseWidth div 2);
     Rect.Top := (Height div 2) - (TextBaseHeight div 2);
     Rect.Right := Rect.Left + TextBaseWidth;
     Rect.Bottom := Rect.Top + TextBaseHeight;
  End;

  DoDrawText;
  // Canvas.TextRect(Rect, Rect.Left, Rect.Top, Caption);
end;

procedure TJkhCheckButton.SetButtonColor(const Value: TColor);
begin
  FButtonColor := Value;
  Invalidate;
end;

procedure TJkhCheckButton.SetChecked(const Value: Boolean);
begin
  FChecked := Value;
  Invalidate;
end;

procedure TJkhCheckButton.SetCheckImage(const Value: TPicture);
begin
  FCheckImage.Assign( Value );
  Invalidate;
end;

procedure TJkhCheckButton.SetDownColor(const Value: TColor);
begin
  FDownColor := Value;
  Invalidate;
end;

procedure TJkhCheckButton.SetHotTrackColor(const Value: TColor);
begin
  FHotTrackColor := Value;
  Invalidate;
end;

procedure TJkhCheckButton.SetUncheckImage(const Value: TPicture);
begin
  FUncheckImage.Assign( Value );
  Invalidate;
end;

procedure TJkhCheckButton.SetMargin(const Value: Integer);
begin
  FMargin := Value;
  Invalidate;
end;

procedure TJkhCheckButton.SetSpacing(const Value: Integer);
begin
  FSpacing := Value;
  Invalidate;
end;

procedure TJkhCheckButton.SetTransparent(const Value: Boolean);
begin
  FTransparent := Value;
  Invalidate;
end;

procedure TJkhCheckButton.WMLButtonDblClk(var Message: TWMLButtonDown);
begin
  inherited;
end;

end.

