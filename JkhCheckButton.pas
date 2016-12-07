unit JkhCheckButton;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, Graphics, Buttons;

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

