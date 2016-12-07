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

unit JkhTabListBar;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, Graphics, Types;

type
  TTabNotifyEvent = procedure(Sender: TObject; Index: Integer) of object;

  TJkhTabListBar = class(TCustomControl)
  private
    FTabList: TStringList;
    FTabIndex: Integer;
    FTabWidth: Integer;
    FBGColor: TColor;
    FSelectCandidateIndex: Integer;
    FCloseCandidateIndex: Integer;
    FSelectTabColor: TColor;
    FFocusTabColor: TColor;
    FTabTextLeft: Integer;
    FTabTextTop: Integer;
    FFocusCloseIndex: Integer;
    FCloseButton: TPicture;
    FHighlightIndex: Integer;
    FShowSlideButton: Boolean;
    FTabScrollLeft: Integer;
    FSlideButtonWidth: Integer;
    FOnChanged: TNotifyEvent;
    FMoveRightButton: TPicture;
    FMoveLeftButton: TPicture;
    FTabDeleted: TTabNotifyEvent;
    FOnIndexChanged: TTabNotifyEvent;
    FOnBeforeTabDelete: TTabNotifyEvent;
    FShowCloseButton: Boolean;
    FUseUTF8: Boolean;
    FPrevButtonState: TShiftState;

    function GetItemIndex(X: Integer): Integer;
    function GetItemButtonIndex(X, Y: Integer): Integer;

    procedure TabListChanged(Sender: TObject);
    procedure UpdateTabScroll;
    procedure UpdateTabSlideButton;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;

    procedure SetTabIndex(const Value: Integer);
    procedure SetTabWidth(const Value: Integer);
    procedure SetBGColor(const Value: TColor);
    procedure SetSelectTabColor(const Value: TColor);
    procedure SetTabList(const Value: TStringList);
    procedure SetCloseButton(const Value: TPicture);
    procedure SetHighlightIndex(const Value: Integer);
    procedure SetShowSlideButton(const Value: Boolean);
    procedure SetTabScrollLeft(Value: Integer);
    procedure SetMoveLeftButton(const Value: TPicture);
    procedure SetMoveRightButton(const Value: TPicture);
    procedure SetShowCloseButton(const Value: Boolean);
  protected
    procedure Paint; override;
    procedure Resize; override;

    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;

    procedure DoOnChanged;
    procedure DoOnIndexChanged(Index: Integer);
    procedure DoOnBeforeTabDelete(Index: Integer);
    procedure DoOnTabDeleted(Index: Integer);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure AddNewTab(Name, Value: String; DoEvent: Boolean = false);
    procedure CloseTab(AIndex: Integer);
  published
    property Font;
    property ParentFont;
    property Anchors;

    // 유니코드를 지원하지 않으므로 주의.
    property UseUTF8: Boolean read FUseUTF8 write FUseUTF8;

    property TabList: TStringList read FTabList write SetTabList;
    property TabIndex: Integer read FTabIndex write SetTabIndex;
    property TabWidth: Integer read FTabWidth write SetTabWidth;
    property TabTextTop: Integer read FTabTextTop write FTabTextTop;
    property TabTextLeft: Integer read FTabTextLeft write FTabTextLeft;

    property CloseButton: TPicture read FCloseButton write SetCloseButton;
    property MoveLeftButton: TPicture read FMoveLeftButton write SetMoveLeftButton;
    property MoveRightButton: TPicture read FMoveRightButton write SetMoveRightButton;

    property BGColor: TColor read FBGColor write SetBGColor;
    property SelectTabColor: TColor read FSelectTabColor write SetSelectTabColor;
    property FocusTabColor: TColor read FFocusTabColor write FFocusTabColor;
    property ShowCloseButton: Boolean read FShowCloseButton write SetShowCloseButton;

    property Align;
    property PopupMenu;

    property OnChanged: TNotifyEvent read FOnChanged write FOnChanged;
    property OnIndexChanged: TTabNotifyEvent read FOnIndexChanged write FOnIndexChanged;
    property OnBeforeTabDelete: TTabNotifyEvent read FOnBeforeTabDelete write FOnBeforeTabDelete;
    property OnTabDeleted: TTabNotifyEvent read FTabDeleted write FTabDeleted;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('NS', [TJkhTabListBar]);
end;

{ TJkhTabListBar }

procedure TJkhTabListBar.AddNewTab(Name, Value: String; DoEvent: Boolean);
var
  AddTarget: String;
  TargetIndex: Integer;
begin
  AddTarget := Name+'='+Value;
  TargetIndex := FTabList.IndexOf(AddTarget);
  If TargetIndex >= 0 Then
     FTabIndex := TargetIndex
  Else
  Begin
     FTabList.Add(AddTarget);
     FTabIndex := FTabList.Count-1;
  End;

  UpdateTabScroll;
  Invalidate;

  If DoEvent Then DoOnIndexChanged(FTabIndex);
end;

procedure TJkhTabListBar.CloseTab(AIndex: Integer);
begin
  If Not FShowCloseButton Then Exit;

  DoOnBeforeTabDelete(AIndex);
  TabList.Delete(AIndex);
  If AIndex >= TabList.Count Then
     TabIndex := TabList.Count-1;
  DoOnTabDeleted(AIndex);
end;

procedure TJkhTabListBar.CMMouseLeave(var Message: TMessage);
begin
  SetHighlightIndex(-1);
end;

constructor TJkhTabListBar.Create(AOwner: TComponent);
begin
  inherited;

  FShowCloseButton := True;
  FBGColor := clWhite;
  FTabWidth := 150;
  FTabTextTop := 6;
  FTabTextLeft := 3;
  FTabIndex := 0;
  FHighlightIndex := -1;
  FSelectTabColor := $00CC7A00;
  FFocusTabColor := $00EA971C;
  FShowSlideButton := False;
  FTabScrollLeft := 0;
  FOnChanged := Nil;
  FSlideButtonWidth := 32;
  FFocusCloseIndex := -1;
  FCloseCandidateIndex := -1;

  FTabList := TStringList.Create;
  FTabList.OnChange := TabListChanged;
  FCloseButton := TPicture.Create;
  FMoveLeftButton := TPicture.Create;
  FMoveRightButton := TPicture.Create;

  DoubleBuffered := True;
end;

destructor TJkhTabListBar.Destroy;
begin
  FTabList.Free;
  FCloseButton.Free;
  FMoveLeftButton.Free;
  FMoveRightButton.Free;
  
  inherited;
end;

procedure TJkhTabListBar.DoOnBeforeTabDelete(Index: Integer);
begin
  If Not Assigned(FOnBeforeTabDelete) Then Exit;
  OnBeforeTabDelete(Self, Index);
end;

procedure TJkhTabListBar.DoOnChanged;
begin
  If Not Assigned(FOnChanged) Then Exit;
  FOnChanged(Self);
end;

procedure TJkhTabListBar.DoOnIndexChanged(Index: Integer);
begin
  If Not Assigned(OnIndexChanged) Then Exit;
  FOnIndexChanged(Self, Index);
end;

procedure TJkhTabListBar.DoOnTabDeleted(Index: Integer);
begin
  If Not Assigned(FTabDeleted) Then Exit;
  FTabDeleted(Self, Index);
end;

function TJkhTabListBar.GetItemButtonIndex(X, Y: Integer): Integer;
var
  LoopVar,
  LeftPoint,
  ButtonX: Integer;
begin
  LeftPoint := -FTabScrollLeft;
  Result := -1;

  If FShowSlideButton Then
  Begin
     If X > Width-FSlideButtonWidth Then
        Exit;
  End;

  For LoopVar := 0 to FTabList.Count-1 do
  Begin
     If LeftPoint+FTabWidth < 0 Then
     Begin
        Inc(LeftPoint, FTabWidth);
        Continue;
     End;

     If (LeftPoint < X) and (LeftPoint+FTabWidth > X) Then
     Begin
        ButtonX := LeftPoint+FTabWidth-CloseButton.Width-FTabTextLeft-2;
        If (X > ButtonX) and (X < ButtonX+CloseButton.Width) and
           (Y > FTabTextTop) and (Y < FTabTextTop+CloseButton.Height) Then
        Begin
           Result := LoopVar;
           Break;
        End;
     End;

     Inc(LeftPoint, FTabWidth);
  End;

end;

function TJkhTabListBar.GetItemIndex(X: Integer): Integer;
var
  LoopVar,
  LeftPoint: Integer;
begin
  LeftPoint := -FTabScrollLeft;
  Result := -1;

  If FShowSlideButton Then
  Begin
     If X > Width-FSlideButtonWidth Then
     Begin
        Result := -2;
        If X > Width-(FSlideButtonWidth div 2) Then
           Result := -3;

        Exit;
     End;
  End;

  For LoopVar := 0 to FTabList.Count-1 do
  Begin
     If LeftPoint+FTabWidth < 0 Then
     Begin
        Inc(LeftPoint, FTabWidth);
        Continue;
     End;

     If (LeftPoint < X) and (LeftPoint+FTabWidth > X) Then
     Begin
        Result := LoopVar;
        Break;
     End;

     Inc(LeftPoint, FTabWidth);
  End;
end;

procedure TJkhTabListBar.MouseDown(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  SelectItemIndex: Integer;
begin
  FPrevButtonState := Shift;
  FSelectCandidateIndex := -1;
  FCloseCandidateIndex := -1;

  If TabList.Count <= 0 Then Exit;

  If ssLeft In Shift Then
  Begin
     FSelectCandidateIndex := GetItemIndex(X);
     //If FShowSlideButton Then
     If FShowCloseButton Then
        FCloseCandidateIndex := GetItemButtonIndex(X, Y);

     If FCloseCandidateIndex >= 0 Then FSelectCandidateIndex := -1;
  End
  Else If ssMiddle In Shift Then
  Begin
     FSelectCandidateIndex := GetItemIndex(X);
     //If FShowSlideButton Then
     If FShowCloseButton Then
        FCloseCandidateIndex := FSelectCandidateIndex;
  End;
end;

procedure TJkhTabListBar.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  lFucusIndex, lFocustButtonIndex: Integer;
  UpdatFlag: Boolean;
begin
  UpdatFlag := False;
  lFocustButtonIndex := GetItemButtonIndex(X, Y);
  lFucusIndex := GetItemIndex(X);

  If (FFocusCloseIndex <> lFocustButtonIndex) or (FHighlightIndex <> lFucusIndex) Then
     UpdatFlag := True;

  FFocusCloseIndex := lFocustButtonIndex;
  FHighlightIndex := lFucusIndex;

  If UpdatFlag Then Invalidate;
end;

procedure TJkhTabListBar.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
var
  SelectItemIndex: Integer;
begin
  If (Not (ssLeft In Shift)) and (ssLeft In FPrevButtonState) Then
  Begin
     SelectItemIndex := GetItemIndex(X);
     If FSelectCandidateIndex = SelectItemIndex Then
     Begin
        If SelectItemIndex > -1 Then
           TabIndex := FSelectCandidateIndex
        Else If SelectItemIndex = -2 Then
           SetTabScrollLeft( FTabScrollLeft - FTabWidth )
        Else If SelectItemIndex = -3 Then
           SetTabScrollLeft( FTabScrollLeft + FTabWidth );
     End;

     // 변수 재활용.
     SelectItemIndex := GetItemButtonIndex(X, Y);
     If (SelectItemIndex >= 0) and (FCloseCandidateIndex = SelectItemIndex) Then
        CloseTab(SelectItemIndex);
  End
  Else
  If (Not (ssMiddle In Shift)) and (ssMiddle In FPrevButtonState) Then
  Begin
     SelectItemIndex := GetItemIndex(X);
     If (SelectItemIndex >= 0) and (FCloseCandidateIndex = SelectItemIndex) Then
        CloseTab(SelectItemIndex);
  End;

  FCloseCandidateIndex := -1;
  FSelectCandidateIndex := -1;
  FPrevButtonState := [];
end;

procedure TJkhTabListBar.Paint;
var
  LoopVar,
  LeftPoint: Integer;
  TextOutRect: TRect;
  PaintText: WideString;

  procedure DrawCloseButton(Index: Integer);
  var
    ButtonX: Integer;
    PrevColor: TColor;
  begin
     If Not FShowCloseButton Then Exit;
     If Not Assigned(FCloseButton.Graphic) Then Exit;

     ButtonX := LeftPoint+FTabWidth-CloseButton.Width-FTabTextLeft-2;

     If FFocusCloseIndex = Index Then
     Begin
        PrevColor := Canvas.Brush.Color;
        Canvas.Brush.Color := FSelectTabColor;
        Canvas.FillRect(Rect(ButtonX, FTabTextTop, ButtonX+CloseButton.Width, FTabTextTop+CloseButton.Height));
        Canvas.Brush.Color := PrevColor;
     End;

     Canvas.Draw(ButtonX, FTabTextTop, FCloseButton.Graphic);
  end;
begin
  inherited;

  Canvas.Font.Assign(Font);
  If Assigned(FCloseButton.Graphic) Then
     FCloseButton.Graphic.Transparent := True;

  Canvas.Brush.Color := BGColor;
  Canvas.FillRect(Rect(0, 0, Width, Height));

  Canvas.Brush.Color := FSelectTabColor;
  Canvas.FillRect(Rect(0, Height-2, Width, Height));

  LeftPoint := -FTabScrollLeft;

  For LoopVar := 0 to FTabList.Count-1 do
  Begin
     If LeftPoint+FTabWidth < 0 Then
     Begin
        Inc(LeftPoint, FTabWidth);
        Continue;
     End;

     If LeftPoint > Width Then
        Break;

     If TabIndex = LoopVar Then
     Begin
        Canvas.Brush.Color := FSelectTabColor;
        Canvas.Font.Color := clWhite;
        Canvas.FillRect(Rect(LeftPoint, 0, LeftPoint+FTabWidth, Height-2));

        DrawCloseButton(LoopVar);
     End
     Else
     Begin
        If FHighlightIndex = LoopVar Then
        Begin
           Canvas.Brush.Color := FFocusTabColor;
           Canvas.Font.Color := clWhite;
           Canvas.FillRect(Rect(LeftPoint, 0, LeftPoint+FTabWidth, Height-2));

           DrawCloseButton(LoopVar);
        End
        Else
        Begin
           Canvas.Brush.Color := clWhite;
           Canvas.Font.Color := clBlack;
        End;
     End;

     TextOutRect := Rect(LeftPoint+FTabTextLeft, FTabTextTop, LeftPoint+FTabTextLeft+FTabWidth-20, Height-2);
     If FUseUTF8 Then
     Begin
        PaintText := UTF8Decode(FTabList.Names[LoopVar]);
        // Canvas.TextRectW(TextOutRect, TextOutRect.Left, TextOutRect.Top, FTabList.Names[LoopVar]);
        DrawTextW(Canvas.Handle, PWideChar(PaintText), Length(PaintText), TextOutRect, 0);
     End
     Else
        Canvas.TextRect(TextOutRect, TextOutRect.Left, TextOutRect.Top, FTabList.Names[LoopVar]);
     // Canvas.TextOut(LeftPoint+FTabTextLeft, FTabTextTop, FTabList.Names[LoopVar]);
     Inc(LeftPoint, FTabWidth);
  End;

  If FShowSlideButton Then
  Begin
     Canvas.Brush.Color := BGColor;
     Canvas.FillRect(Rect(Width-FSlideButtonWidth, 0, Width, Height-2));
     If Assigned(FMoveLeftButton.Graphic) Then
        Canvas.Draw(Width-29, FTabTextTop, FMoveLeftButton.Graphic);
     If Assigned(FMoveRightButton.Graphic) Then
        Canvas.Draw(Width-15, FTabTextTop, FMoveRightButton.Graphic);
  End;
end;

procedure TJkhTabListBar.Resize;
begin
  UpdateTabSlideButton;

  inherited;
end;

procedure TJkhTabListBar.SetBGColor(const Value: TColor);
begin
  FBGColor := Value;
  Invalidate;
end;

procedure TJkhTabListBar.SetCloseButton(const Value: TPicture);
begin
  FCloseButton.Assign( Value );
end;

procedure TJkhTabListBar.SetHighlightIndex(const Value: Integer);
begin
  If FHighlightIndex = Value then Exit;

  FHighlightIndex := Value;
  Invalidate;
end;

procedure TJkhTabListBar.SetMoveLeftButton(const Value: TPicture);
begin
  FMoveLeftButton.Assign( Value );
end;

procedure TJkhTabListBar.SetMoveRightButton(const Value: TPicture);
begin
  FMoveRightButton.Assign( Value );
end;

procedure TJkhTabListBar.SetSelectTabColor(const Value: TColor);
begin
  FSelectTabColor := Value;
end;

procedure TJkhTabListBar.SetShowCloseButton(const Value: Boolean);
begin
  If FShowCloseButton = Value Then Exit;

  FShowCloseButton := Value;
  Invalidate;
end;

procedure TJkhTabListBar.SetShowSlideButton(const Value: Boolean);
begin
  If FShowSlideButton = Value Then Exit;

  FShowSlideButton := Value;
  Invalidate;
end;

procedure TJkhTabListBar.SetTabIndex(const Value: Integer);
begin
  If FTabIndex = Value Then Exit;
  FTabIndex := Value;

  If FTabIndex <= 0 Then FTabIndex := 0;
  If FTabList.Count <= 0 Then FTabIndex := -1;
  If FTabIndex >= FTabList.Count Then FTabIndex := FTabList.Count-1;

  UpdateTabScroll;
  
  Invalidate;
  DoOnIndexChanged(FTabIndex);
end;

procedure TJkhTabListBar.SetTabList(const Value: TStringList);
begin
  FTabList.Assign( Value );
end;

procedure TJkhTabListBar.SetTabScrollLeft(Value: Integer);
begin
  If FTabScrollLeft = Value Then Exit;

  If Value < 0 Then Value := 0;
  If Value > (FTabList.Count-1)*FTabWidth Then Value := (FTabList.Count-1)*FTabWidth;

  FTabScrollLeft := Value;
  Invalidate;
end;

procedure TJkhTabListBar.SetTabWidth(const Value: Integer);
begin
  FTabWidth := Value;
  Invalidate;
end;

procedure TJkhTabListBar.TabListChanged(Sender: TObject);
begin
  UpdateTabSlideButton;

  If FTabList.Count <= TabIndex Then
     TabIndex := -1;

  Invalidate;
  DoOnChanged;
end;

procedure TJkhTabListBar.UpdateTabScroll;
var
  MaxWidth,
  MaxRight: Integer;
begin
  // 오른쪽으로 튀어나가는거 처리.
  MaxWidth := Width;
  If FShowSlideButton Then MaxWidth := MaxWidth - FSlideButtonWidth;
  MaxRight := ((FTabIndex+1)*FTabWidth)-FTabScrollLeft;
  If MaxRight > MaxWidth Then
     FTabScrollLeft := FTabScrollLeft + (MaxRight - MaxWidth);

  MaxRight := (FTabIndex*FTabWidth)-FTabScrollLeft;
  If MaxRight < 0 Then
     FTabScrollLeft := FTabScrollLeft + MaxRight;

  //If -(TabList.Count*FTabWidth) < FTabScrollLeft Then
  //   FTabScrollLeft := -(TabList.Count*FTabWidth);
  If FTabScrollLeft < 0 Then FTabScrollLeft := 0;
end;

procedure TJkhTabListBar.UpdateTabSlideButton;
var
  CheckOk: Boolean;
  LoopVar,
  LeftPoint: Integer;
begin
  LeftPoint := 0;
  CheckOk := False;

  For LoopVar := 0 to FTabList.Count-1 do
  Begin
     Inc(LeftPoint, FTabWidth);
     If LeftPoint > Width Then
     Begin
        CheckOk := True;
        Break;
     End;
  End;

  FShowSlideButton := CheckOk;
end;

end.
