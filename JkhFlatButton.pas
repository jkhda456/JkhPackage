{
�� ������Ʈ�� BSD ���̼����� ������ �ֽ��ϴ�.


�� BSD ���̼������� ���� ������ �����۱� �����ڿ� �⿩�ڡ� ������ �����ǿ����� �⿩�ڷΡ� �ؼ��ȴ�. ���̼��� ���ø��� ������ ����:

Copyright (c) 2012, Jung K. H / StyleNS / StyleNS.net
All rights reserved.

������ ���ǵ��� ������Ű�� ��, �ҽ� ���İ� ���̳ʸ� ������ ���� ������� ����� ���� ���ο� ������� ���ȴ�. 

�ҽ� �ڵ��� ������� ���� ���۱� ǥ�ÿ� ���� ������ ���ǵ�, �׸��� �Ʒ��� ���� ���� ������ �����ؾ� �Ѵ�. 

 

���̳ʸ� �������� ����� �� ���� ���� ���۱� ǥ�ÿ� ���� ������ ���ǵ� �׸��� �Ʒ��� ���� ���� ������ ������ �� �����Ǵ�
���� �� ��Ÿ �ڷῡ �����ؾ� �Ѵ�. 

 

������ �������� �㰡�� ���� �ʴ� ��, StyleNS�� �̸��̳� �⿩���� �̸��� �� ����Ʈ����� ������ ��ǰ�� �����ϰų� ȫ���ϴµ� 
���Ǿ�� �� �ȴ�. 

���۱��ڿ� �⿩�ڴ� �� ����Ʈ��� ���ִ� �״���ǡ� ���·� �����ϸ�, ��ǰ�� ���γ� Ư���� ������ ���� ���ռ��� ���� ������ 
������ ������ ��� ������ ������ ������̳� ���������� �������� �ʴ´�.  ���� ���ɼ��� ������ �˰� �־��� �ϴ���, ���۱��ڳ� 
�⿩�ڴ� ��� ��쿡�� �� ����Ʈ������ ������� ���Ͽ� �߻���, �������̰ų� �������� ����, ������̰ų� ����� ����, Ư���ϰų� 
�Ϲ����� ���ؿ� ���Ͽ�, �� �߻��� �����̳� å�ӷ�, ����̳� ������å���̳� �ҹ�����(���� ���� ����)�� ���� ���� å���� ���� �ʴ´�. 
�̷��� ������ ��ü ��ȭ�� �뿪�� ���� �� ���뼺�̳� ������, ������ �ս�, �׸��� ���� ���� ���� �����ϳ� �̿� ���ѵ����� �ʴ´�.
}

unit JkhFlatButton;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, Graphics, Buttons, Forms;

type
  TJkhButtonLayout = (blBottomLeft, blBottomMiddle, blMiddleRight, blImageOnly, blLeftImageWithHint, blLeftImageWithDropdown);

  TJkhFlatButton = class(TGraphicControl)
  private
    FDown: Boolean;
    FFlat: Boolean;
    FDragging: Boolean;
    FMouseInControl: Boolean;
    FTransparent: Boolean;
    FSpacing: Integer;
    FMargin: Integer;
    FImage: TPicture;
    FLayout: TJkhButtonLayout;
    FIsCanDown: Boolean;
    FHotTrackColor: TColor;
    FDownColor: TColor;
    FButtonColor: TColor;
    FOutLineColor: TColor;
    FOnInMouse: TNotifyEvent;
    FOnOutMouse: TNotifyEvent;
    FDataPointer: Pointer;
    FDisabledFontColor: TColor;
    FIsDoClick: Boolean;
    FCancel: Boolean;
    FDefault: Boolean;
    FHandle: THandle;
    FDisabledImage: TPicture;
    FFocusEnabled: Boolean;
    FFocused: Boolean;
    FAutoResizeText: Boolean;
    FImageSizeLimit: Integer;
    FDropdownImage: TPicture;
    FDisabledDropdownImage: TPicture;

    procedure SetDown(const Value: Boolean);
    procedure SetFlat(const Value: Boolean);
    procedure SetMargin(const Value: Integer);
    procedure SetSpacing(const Value: Integer);
    procedure SetTransparent(const Value: Boolean);
    procedure SetImage(const Value: TPicture);
    procedure SetLayout(const Value: TJkhButtonLayout);
    procedure SetButtonColor(const Value: TColor);
    procedure SetDownColor(const Value: TColor);
    procedure SetHotTrackColor(const Value: TColor);
    procedure SetOutLineColor(const Value: TColor);

    procedure WMLButtonDblClk(var Message: TWMLButtonDown); message WM_LBUTTONDBLCLK;
    procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED;
    procedure CMButtonPressed(var Message: TMessage); message CM_BUTTONPRESSED;
    procedure CMDialogChar(var Message: TCMDialogChar); message CM_DIALOGCHAR;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure CMTextChanged(var Message: TMessage); message CM_TEXTCHANGED;
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;

    procedure CMDialogKey(var Message: TCMDialogKey); message CM_DIALOGKEY;
    procedure CNCommand(var Message: TWMCommand); message CN_COMMAND;

    procedure SetDefault(const Value: Boolean);
    function GetHandle: THandle;
    procedure SetDisabledImage(const Value: TPicture);
    procedure SetFocused(const Value: Boolean);
    procedure SetAutoResizeText(const Value: Boolean);
    procedure SetImageSizeLimit(const Value: Integer);
    procedure SetDropdownImage(const Value: TPicture);
    procedure SetDisabledDropdownImage(const Value: TPicture);
  protected
    FState: TButtonState;
    FDropdownClicked: Boolean;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure Paint; override;
    property MouseInControl: Boolean read FMouseInControl;

    procedure WndProc(var Message : TMessage); virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Click; override;

    function HandleAllocated : Boolean;
    procedure HandleNeeded;
    property Handle: THandle read GetHandle;

    // �ٿ뵵�� ���� �ְ� ������ �����͸� �����صξ���.
    property DataPointer: Pointer read FDataPointer write FDataPointer;
  published
    property Image: TPicture read FImage write SetImage;
    property DisabledImage: TPicture read FDisabledImage write SetDisabledImage;
    property DropdownImage: TPicture read FDropdownImage write SetDropdownImage;
    property DisabledDropdownImage: TPicture read FDisabledDropdownImage write SetDisabledDropdownImage;

    property ImageSizeLimit: Integer read FImageSizeLimit write SetImageSizeLimit;

    property AutoResizeText: Boolean read FAutoResizeText write SetAutoResizeText default True; 
    property Focused: Boolean read FFocused write SetFocused default False; 
    property Layout: TJkhButtonLayout read FLayout write SetLayout default blBottomLeft;
    property Anchors;
    property Constraints;
    property IsCanDown: Boolean read FIsCanDown write FIsCanDown;
    property Down: Boolean read FDown write SetDown default False;
    property Caption;
    property Enabled;
    property Flat: Boolean read FFlat write SetFlat default False;
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

    property DisabledFontColor: TColor read FDisabledFontColor write FDisabledFontColor;
    property OutLineColor: TColor read FOutLineColor write SetOutLineColor;
    property ButtonColor: TColor read FButtonColor write SetButtonColor;
    property HotTrackColor: TColor read FHotTrackColor write SetHotTrackColor;
    property DownColor: TColor read FDownColor write SetDownColor;

    property Cancel: Boolean read FCancel write FCancel default False;
    property Default: Boolean read FDefault write SetDefault default False;

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
  RegisterComponents('NS', [TJkhFlatButton]);
end;

{ TJkhFlatButton }

procedure TJkhFlatButton.Click;
begin
  If FIsDoClick Then Exit;

  FIsDoClick := True;
  Try
    inherited;
  Finally
    FIsDoClick := False;
  End;
end;

procedure TJkhFlatButton.CMButtonPressed(var Message: TMessage);
begin
  inherited;
  FState := bsDown;
  FDown := True;
  Repaint;
end;

procedure TJkhFlatButton.CMDialogChar(var Message: TCMDialogChar);
begin

end;

procedure TJkhFlatButton.CMDialogKey(var Message: TCMDialogKey);
begin
  with Message do
    if  ( Enabled and
      ((CharCode = VK_RETURN) and FDefault) or ((CharCode = VK_ESCAPE) and FCancel))
      and
      (KeyDataToShiftState(Message.KeyData) = []) {and CanFocus} then
    begin
      Click;
      Result := 1;
    end else
      inherited;
end;

procedure TJkhFlatButton.CMEnabledChanged(var Message: TMessage);
begin
  Invalidate;
end;

procedure TJkhFlatButton.CMFontChanged(var Message: TMessage);
begin
  Invalidate;
end;

procedure TJkhFlatButton.CMMouseEnter(var Message: TMessage);
begin
  inherited;
  If Enabled Then
     FState := bsUp;
     
  Repaint;

  If Assigned(FOnInMouse) Then FOnInMouse(Self);
end;

procedure TJkhFlatButton.CMMouseLeave(var Message: TMessage);
begin
  inherited;
  FState := bsExclusive;
  Repaint;

  If Assigned(FOnOutMouse) Then FOnOutMouse(Self);
end;

procedure TJkhFlatButton.CMTextChanged(var Message: TMessage);
begin
  Invalidate;
end;

procedure TJkhFlatButton.CNCommand(var Message: TWMCommand);
begin
  if Message.NotifyCode = BN_CLICKED then Click;
  // if Message.NotifyCode = BN_KILLFOCUS Then MessageBox(0, 'aa', '', 0);
end;

constructor TJkhFlatButton.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle - [csOpaque];
  SetBounds(0, 0, 23, 22);
  ControlStyle := [csCaptureMouse, csDoubleClicks];
  ParentFont := True;
  Color := clBtnFace;
  FDragging := False;
  FSpacing := 4;
  FMargin := 0;
  FLayout := blBottomLeft;
  FState := bsExclusive;
  FTransparent := True;
  FImage := TPicture.Create;
  FDisabledImage := TPicture.Create;
  FDropdownImage := TPicture.Create;
  FDisabledDropdownImage := TPicture.Create;
  FHotTrackColor := $00f7e6cd;
  FDownColor := $00f0d6b1;
  FButtonColor := clWhite;
  FOutLineColor := $00ababab;
  FDisabledFontColor := clDefault;
  FIsDoClick := False;
  FHandle := 0;
  FFocused := False;
  FImageSizeLimit := 0;
end;

destructor TJkhFlatButton.Destroy;
begin
  FImage.Free;
  FDisabledImage.Free;
  FDropdownImage.Free;
  FDisabledDropdownImage.Free;
  if HandleAllocated then DeAllocateHWND( FHandle );

  inherited;
end;

function TJkhFlatButton.GetHandle: THandle;
begin
  HandleNeeded;
  Result := FHandle;
end;

function TJkhFlatButton.HandleAllocated: Boolean;
begin
  Result := ( FHandle <> 0 );
end;

procedure TJkhFlatButton.HandleNeeded;
begin
  if not HandleAllocated then FHandle := AllocateHWND ( WndProc );
end;

procedure TJkhFlatButton.MouseDown(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited MouseDown(Button, Shift, X, Y);
  FDropdownClicked := False;

  if (Button = mbLeft) and Enabled then
  begin
    if not FDown then
    begin
      FState := bsDown;

      If Layout = blLeftImageWithDropdown Then
      Begin
        If Assigned(DropdownImage.Graphic) Then
           FDropdownClicked := (X > Width-DropdownImage.Width-2);
      End;

      Invalidate;
    end;
    FDragging := True;
  end;
end;

procedure TJkhFlatButton.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  inherited;
end;

procedure TJkhFlatButton.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
var
  DoClick: Boolean;
  PositionInfo: TPoint;
begin
  inherited MouseUp(Button, Shift, X, Y);
  if FDragging then
  begin
    FDragging := False;
    DoClick := (X >= 0) and (X < ClientWidth) and (Y >= 0) and (Y <= ClientHeight);

    { Redraw face in-case mouse is captured }
    FState := bsUp;
    FMouseInControl := False;
    if DoClick and not (FState in [bsExclusive, bsDown]) then
       Invalidate;

    if DoClick then
    Begin
       If Layout = blLeftImageWithDropdown Then
       Begin
         If Assigned(DropdownImage.Graphic) Then
            If FDropdownClicked and (X > Width-DropdownImage.Width-2) Then
            Begin
               PositionInfo := Point(0, Height);
               PositionInfo := Self.ClientToScreen(PositionInfo);
               Self.PopupMenu.Popup(PositionInfo.X, PositionInfo.Y);
               Exit;
            End;
       End;

       Click;
    End;
    // UpdateTracking;
  end;
end;

procedure TJkhFlatButton.Paint;
const
  DotMargin = 2;
var
  TextBaseSize: TSize;
  TextBaseHeight,
  TextBaseWidth,
  Cx, Cy: Integer;
  GuardRect,
  DrawRect: TRect;
  MonoImage: TBitmap;
  AutoResizeLoop: Integer;

  LImageHeight,
  LImageWidth: Integer;
begin
  inherited;

  LImageHeight := 0;
  LImageWidth := 0;

  If Assigned(Image.Graphic) Then
  Begin
     LImageHeight := Image.Height;
     LImageWidth := Image.Width;

     If FImageSizeLimit > 0 Then
     Begin
        LImageHeight := FImageSizeLimit;
        LImageWidth := FImageSizeLimit;
     End;
  End;

  Canvas.Font := Self.Font;

  Canvas.Brush.Style := bsSolid;
  Canvas.Pen.Style := psSolid;

  // �ٿ� �� ��ư�̸� �ٿ� ���� �����ϰ�, �װ� �ƴϸ� ��ư���� �����Ѵ�.
  If Down Then
     Canvas.Brush.Color := DownColor
  Else
     Canvas.Brush.Color := ButtonColor;

  // ���� ���� ��Ŀ���� ���� ���¸� ��Ŀ�� �÷��� �������ش�.
  Case FState of
     bsUp: Canvas.Brush.Color := HotTrackColor;
     bsDown: Canvas.Brush.Color := DownColor;
  End;

  // �ϴ� Flat�� �ƴϸ� �ܰ��� ���� �׸���.
  If Flat Then
     Canvas.Pen.Color := OutLineColor
  Else
     Canvas.Pen.Color := Canvas.Brush.Color;

  If Transparent and (Not Down) and (FState = bsExclusive) Then
     Canvas.Brush.Style := bsClear;

  Canvas.Rectangle(0, 0, Width, Height);
  If Flat Then
     GuardRect := Rect(1, 1, Width-1, Height-1)
  Else
     GuardRect := Rect(0, 0, Width, Height);

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

  // �̹����� Caption�� ������ �׸���. �� ������ ��ġ �ľ��� ����.
  Case Layout of
     blBottomLeft: // �ϴ� ���ʿ� ĸ���� ��´�.
     Begin
        If Assigned(Image.Graphic) Then
        Begin
           Cx := (Width div 2) - (LImageWidth div 2);
           Cy := ((Height - TextBaseHeight) div 2) - (LImageHeight div 2);

           DrawRect.Left := Cx;
           DrawRect.Top := Cy;
           DrawRect.Right := Cx + LImageWidth;
           DrawRect.Bottom := Cy + LImageHeight;
           If Not Enabled and Assigned(DisabledImage.Graphic) Then
              Canvas.StretchDraw(DrawRect, DisabledImage.Graphic)
           Else
              Canvas.StretchDraw(DrawRect, Image.Graphic);

           DrawRect.Top := DrawRect.Bottom+Margin;
           DrawRect.Bottom := Height-1;
        End
        Else
        Begin
           DrawRect.Left := (Width div 2) - (TextBaseWidth div 2);
           DrawRect.Top := (Height div 2) - (TextBaseHeight div 2);
           DrawRect.Right := DrawRect.Left + TextBaseWidth;
           DrawRect.Bottom := DrawRect.Top + TextBaseHeight;
        End;

        Canvas.TextRect(DrawRect, DrawRect.Left, DrawRect.Top, Caption);
     End;

     blBottomMiddle: // �ϴ� �߾ӿ� ĸ���� ��´�.
     Begin
        // ������ ���ڰ� ū ��Ȳ�̶�� �ڵ����� ũ�⸦ �����Ѵ�.
        Cx := 4;
        If TextBaseWidth + Cx >= Width Then
        Begin
           For AutoResizeLoop := 1 to 3 do
           Begin
              Canvas.Font.Size := Canvas.Font.Size - 1;

              TextBaseSize := Canvas.TextExtent(Caption);
              TextBaseHeight := Margin + TextBaseSize.cy;
              TextBaseWidth := TextBaseSize.cx;

              If TextBaseWidth <= 0 Then TextBaseWidth := 1;
              If TextBaseWidth+Cx < Width Then Break;
           End;
        End;

        If Assigned(Image.Graphic) Then
        Begin
           Cx := (Width div 2) - (LImageWidth div 2);
           Cy := ((Height - TextBaseHeight) div 2) - (LImageHeight div 2);

           DrawRect.Left := Cx;
           DrawRect.Top := Cy;
           DrawRect.Right := Cx + LImageWidth;
           DrawRect.Bottom := Cy + LImageHeight;
           If Not Enabled and Assigned(DisabledImage.Graphic) Then
              Canvas.StretchDraw(DrawRect, DisabledImage.Graphic)
           Else
              Canvas.StretchDraw(DrawRect, Image.Graphic);

           DrawRect.Left := (Width div 2) - (TextBaseWidth div 2)-1;
           DrawRect.Top := DrawRect.Bottom+Margin;
           DrawRect.Bottom := Height-1;
           DrawRect.Right := DrawRect.Left + TextBaseWidth;
        End
        Else
        Begin
           DrawRect.Left := (Width div 2) - (TextBaseWidth div 2);
           DrawRect.Top := (Height div 2) - (TextBaseHeight div 2);
           DrawRect.Right := DrawRect.Left + TextBaseWidth;
           DrawRect.Bottom := DrawRect.Top + TextBaseHeight;
        End;

        GuardRect.Top := DrawRect.Top;
        GuardRect.Bottom := DrawRect.Bottom;

        Canvas.TextRect(GuardRect, DrawRect.Left, DrawRect.Top, Caption);
     End;

     blMiddleRight: // ���߾� �����ʿ� ĸ���� ��´�.
     Begin
        Cx := 4;
        If Assigned(Image.Graphic) Then
           Cx := Cx + LImageWidth;

        // ������ ���ڰ� ū ��Ȳ�̶�� �ڵ����� ũ�⸦ �����Ѵ�.
        If TextBaseWidth + Cx >= Width Then
        Begin
           For AutoResizeLoop := 1 to 3 do
           Begin
              Canvas.Font.Size := Canvas.Font.Size - 1;

              TextBaseSize := Canvas.TextExtent(Caption);
              TextBaseHeight := Margin + TextBaseSize.cy;
              TextBaseWidth := TextBaseSize.cx;

              If TextBaseWidth <= 0 Then TextBaseWidth := 1;
              If TextBaseWidth+Cx < Width Then Break;
           End;
        End;

        If Assigned(Image.Graphic) Then
        Begin
           Cx := ((Width - TextBaseWidth - Margin) div 2) - (LImageWidth div 2);
           Cy := (Height div 2) - (LImageHeight div 2);

           DrawRect.Left := Cx;
           DrawRect.Top := Cy;
           DrawRect.Right := Cx + LImageWidth;
           DrawRect.Bottom := Cy + LImageHeight;
           If Not Enabled and Assigned(DisabledImage.Graphic) Then
              Canvas.StretchDraw(DrawRect, DisabledImage.Graphic)
           Else
              Canvas.StretchDraw(DrawRect, Image.Graphic);

           DrawRect.Left := DrawRect.Right + Margin-1;
           DrawRect.Top := (Height div 2) - (TextBaseHeight div 2)+1;
           DrawRect.Right := DrawRect.Left + TextBaseWidth;
           DrawRect.Bottom := DrawRect.Top + TextBaseHeight;
        End
        Else
        Begin
           DrawRect.Left := (Width div 2) - (TextBaseWidth div 2);
           DrawRect.Top := (Height div 2) - (TextBaseHeight div 2);
           DrawRect.Right := DrawRect.Left + TextBaseWidth;
           DrawRect.Bottom := DrawRect.Top + TextBaseHeight;
        End;

        GuardRect.Left := DrawRect.Left;
        If GuardRect.Left <= 0 Then GuardRect.Left := 1;

        Canvas.TextRect(GuardRect, DrawRect.Left, DrawRect.Top, Caption);
     End;

     blImageOnly: // �̹����� ��´�.
     Begin
        If Not Assigned(Image.Graphic) Then Exit;

        Cx := ((Width - Margin) div 2) - (LImageWidth div 2);
        Cy := (Height div 2) - (LImageHeight div 2);

        DrawRect.Left := Cx;
        DrawRect.Top := Cy;
        DrawRect.Right := Cx + LImageWidth;
        DrawRect.Bottom := Cy + LImageHeight;
        If Not Enabled and Assigned(DisabledImage.Graphic) Then
           Canvas.StretchDraw(DrawRect, DisabledImage.Graphic)
        Else
           Canvas.StretchDraw(DrawRect, Image.Graphic);
     End;

     blLeftImageWithHint:
     begin
        If Assigned(Image.Graphic) Then
        Begin
           Cx := Spacing;
           Cy := Spacing;

           DrawRect.Left := Cx;
           DrawRect.Top := Cy;
           DrawRect.Right := Cx + LImageWidth;
           DrawRect.Bottom := Cy + LImageHeight;
           If Not Enabled and Assigned(DisabledImage.Graphic) Then
              Canvas.StretchDraw(DrawRect, DisabledImage.Graphic)
           Else
              Canvas.StretchDraw(DrawRect, Image.Graphic);

           DrawRect.Left := DrawRect.Right + Margin;
           DrawRect.Right := DrawRect.Left + TextBaseWidth;
           DrawRect.Bottom := DrawRect.Top + TextBaseHeight;
        End
        Else
        Begin
           DrawRect.Left := Spacing;
           DrawRect.Top := Spacing;
           DrawRect.Right := DrawRect.Left + TextBaseWidth;
           DrawRect.Bottom := DrawRect.Top + TextBaseHeight;
        End;

        GuardRect.Top := DrawRect.Top;
        GuardRect.Bottom := DrawRect.Bottom;
        GuardRect.Left := DrawRect.Left;
        If GuardRect.Left <= 0 Then GuardRect.Left := 1;

        Canvas.Font.Style := [fsBold];
        Canvas.TextRect(GuardRect, DrawRect.Left, DrawRect.Top, Caption);

        TextBaseHeight := DrawRect.Bottom;
        TextBaseSize := Canvas.TextExtent(Hint);

        DrawRect.Top := TextBaseHeight;
        DrawRect.Right := DrawRect.Left + TextBaseSize.cx;
        DrawRect.Bottom := DrawRect.Top + TextBaseSize.cy;
        GuardRect.Top := DrawRect.Top;
        GuardRect.Bottom := DrawRect.Bottom;
        Canvas.Font.Style := [];
        Canvas.TextRect(GuardRect, DrawRect.Left, DrawRect.Top, Hint);
     End;

     blLeftImageWithDropdown:
     Begin
        If Assigned(DropdownImage.Graphic) Then
        Begin
           GuardRect.Right := GuardRect.Right-DropdownImage.Width-2;
           DrawRect := Rect(Width-DropdownImage.Width-2, 0, Width-1, Height);

           Canvas.MoveTo(DrawRect.Left, DrawRect.Top);
           Canvas.LineTo(DrawRect.Left, DrawRect.Bottom);

           Canvas.Draw(DrawRect.Left+1, (DrawRect.Bottom div 2)-(DropdownImage.Height div 2)+1, DropdownImage.Graphic);
        End;

        If Assigned(Image.Graphic) Then
        Begin
           Cx := Spacing;
           Cy := Spacing;

           DrawRect.Left := Cx;
           DrawRect.Top := Cy;
           DrawRect.Right := Cx + LImageWidth;
           DrawRect.Bottom := Cy + LImageHeight;
           If Not Enabled and Assigned(DisabledImage.Graphic) Then
              Canvas.StretchDraw(DrawRect, DisabledImage.Graphic)
           Else
              Canvas.StretchDraw(DrawRect, Image.Graphic);

           DrawRect.Left := DrawRect.Right + Margin;
           DrawRect.Top := (Height div 2) - (TextBaseHeight div 2)+1;
           DrawRect.Right := DrawRect.Left + TextBaseWidth;
           DrawRect.Bottom := DrawRect.Top + TextBaseHeight;
        End
        Else
        Begin
           DrawRect.Left := Spacing;
           DrawRect.Top := Spacing;
           DrawRect.Right := DrawRect.Left + TextBaseWidth;
           DrawRect.Bottom := DrawRect.Top + TextBaseHeight;
        End;

        GuardRect.Left := DrawRect.Left;
        If GuardRect.Left <= 0 Then GuardRect.Left := 1;

        Canvas.TextRect(GuardRect, DrawRect.Left, DrawRect.Top, Caption);
     End;
  End;

  If Focused Then
  Begin
     // �������.
     Canvas.Brush.Style := bsClear;
     // Canvas.Pen.Color := clWhite;
     Canvas.Pen.Style := psDot;
     Canvas.Rectangle(DotMargin, DotMargin, Width-DotMargin, Height-DotMargin);
  End;
end;

procedure TJkhFlatButton.SetAutoResizeText(const Value: Boolean);
begin
  FAutoResizeText := Value;
  Invalidate;
end;

procedure TJkhFlatButton.SetButtonColor(const Value: TColor);
begin
  FButtonColor := Value;
  Invalidate;
end;

procedure TJkhFlatButton.SetDefault(const Value: Boolean);
var
  Form: TCustomForm;
begin
  FDefault := Value;
  if HandleAllocated then
  begin
    Form := GetParentForm(Self);
    if Form <> nil then
      Form.Perform(CM_FOCUSCHANGED, 0, Longint(Form.ActiveControl));
  end;
end;

procedure TJkhFlatButton.SetDisabledDropdownImage(const Value: TPicture);
begin
  FDisabledDropdownImage.Assign( Value );
  Invalidate;
end;

procedure TJkhFlatButton.SetDisabledImage(const Value: TPicture);
begin
  FDisabledImage.Assign( Value );
  Invalidate;
end;

procedure TJkhFlatButton.SetDown(const Value: Boolean);
begin
  FDown := Value;
  Invalidate;
end;

procedure TJkhFlatButton.SetDownColor(const Value: TColor);
begin
  FDownColor := Value;
  Invalidate;
end;

procedure TJkhFlatButton.SetDropdownImage(const Value: TPicture);
begin
  FDropdownImage.Assign(Value);
  Invalidate;
end;

procedure TJkhFlatButton.SetFlat(const Value: Boolean);
begin
  FFlat := Value;
  Invalidate;
end;

procedure TJkhFlatButton.SetFocused(const Value: Boolean);
begin
  FFocused := Value;
  Invalidate;
end;

procedure TJkhFlatButton.SetHotTrackColor(const Value: TColor);
begin
  FHotTrackColor := Value;
  Invalidate;
end;

procedure TJkhFlatButton.SetImage(const Value: TPicture);
begin
  FImage.Assign( Value );
  Invalidate;
end;

procedure TJkhFlatButton.SetImageSizeLimit(const Value: Integer);
begin
  FImageSizeLimit := Value;
  Invalidate;
end;

procedure TJkhFlatButton.SetLayout(const Value: TJkhButtonLayout);
begin
  FLayout := Value;
  Invalidate;
end;

procedure TJkhFlatButton.SetMargin(const Value: Integer);
begin
  FMargin := Value;
  Invalidate;
end;

procedure TJkhFlatButton.SetOutLineColor(const Value: TColor);
begin
  FOutLineColor := Value;
  Invalidate;
end;

procedure TJkhFlatButton.SetSpacing(const Value: Integer);
begin
  FSpacing := Value;
  Invalidate;
end;

procedure TJkhFlatButton.SetTransparent(const Value: Boolean);
begin
  FTransparent := Value;
  Invalidate;
end;

procedure TJkhFlatButton.WMLButtonDblClk(var Message: TWMLButtonDown);
begin
  inherited;
  if FState = bsDown then DblClick;
end;

procedure TJkhFlatButton.WndProc(var Message: TMessage);
begin

{  case Message.Msg of
     WM_SETFOCUS, WM_NCACTIVATE:
     begin
        // SetFocused(True);
        Dispatch( Message );
        // inherited WndProc(Message);
     end;
     WM_KILLFOCUS:
     Begin
        SetFocused(False);
        Dispatch( Message );
     End;
  Else
     inherited WndProc(Message);
  End;
}
  Dispatch( Message );

end;

end.


