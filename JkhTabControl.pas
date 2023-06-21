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

unit JkhTabControl;

{
   JKH's NS Control - v1.0
}

interface

uses
  Windows, Messages, SysUtils, Classes, CommCtrl,
  {$if CompilerVersion <= 15}
  Forms, ComCtrls, ExtCtrls, Controls, StdCtrls, Types, Graphics;
  {$elseif CompilerVersion > 16}
  Vcl.Forms, Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.Controls, Vcl.StdCtrls, Vcl.Graphics, System.Types;
  {$ifend}

//  Windows, Messages, Graphics, Forms, CommCtrl,
//  SysUtils, Classes, Controls, ComCtrls, ExtCtrls;

type
  TJkhTabControl = class;

  TJkhTabSheet = class(TCustomControl)
  private
    FCaption: TCaption;
    FCaptionImage: TPicture;
    FTabControl: TJkhTabControl;
    FTabPosition: Integer;
    FOnSelected: TNotifyEvent;
    FTabVisible: Boolean;

    procedure CMShowingChanged(var Message: TMessage); message CM_SHOWINGCHANGED;

    function GetColor: TColor;
    procedure SetCaption(const Value: TCaption);
    procedure SetCaptionImage(const Value: TPicture);
    procedure SetColor(const Value: TColor);
    procedure SetTabControl(const Value: TJkhTabControl);
    procedure SetTabIndex(const Value: Integer);
    function GetTabIndex: Integer;
    procedure SetTabVisible(const Value: Boolean);
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure Paint; override;
    procedure ReadState(Reader: TReader); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure DoSelected;
  published
    Property TabIndex: Integer read GetTabIndex write SetTabIndex;
    Property TabPosition: Integer read FTabPosition write FTabPosition;
    Property TabControl: TJkhTabControl read FTabControl write SetTabControl;
    property Caption: TCaption read FCaption write SetCaption;
    property CaptionImage: TPicture read FCaptionImage write SetCaptionImage;
    property Color: TColor read GetColor write SetColor;

    property TabVisible: Boolean read FTabVisible write SetTabVisible;
    property Visible stored False;

    property Font;
    property ParentFont;

    property OnSelected: TNotifyEvent read FOnSelected write FOnSelected;

    property OnContextPopup;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseWheel;
    property OnResize;
    property OnStartDrag;
  end;

  TJkhTabControl = class(TCustomTabControl)
  private
    FHighlightIndex: Integer;
    FSelectCandidate: Integer;
    FPages: TList;
    FTabIndex: Integer;
    FLogoImage: TPicture;
    FGutterWidth: Integer;
    FTabSpan: Integer;
    FLogoLeft: Integer;
    FLogoTop: Integer;
    FTabLeft: Integer;
    FLogoSpan: Integer;
    FActivePage: TJkhTabSheet;
    FTabItemHeight: Integer;
    FTabItemInnerLeftSpan: Integer;
    FGutterEnabled: Boolean;
    FGutterColor: TColor;
    FSelectColor: TColor;
    FHighlightColor: TColor;
    FOutLineMode: Boolean;
    FOnLogoClick: TNotifyEvent;
    FGutterLineColor: TColor;
    FTabPosition: TTabPosition;
    FTabItemWidth: Integer;
    FTabClickEnabled: Boolean;
    FOnChange: TNotifyEvent;

    procedure EraseBkGnd(var Message: TMessage); message WM_EraseBkGnd;
    procedure CMDesignHitTest(var Message: TCMDesignHitTest); message CM_DESIGNHITTEST;
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;

    //procedure CMDockNotification(var Message: TCMDockNotification); message CM_DOCKNOTIFICATION;
    procedure SetLogoImage(const Value: TPicture);
    procedure SetTabIndex(const Value: Integer);
    procedure SetGutterWidth(const Value: Integer);
    procedure SetLogoLeft(const Value: Integer);
    procedure SetLogoSpan(const Value: Integer);
    procedure SetLogoTop(const Value: Integer);
    procedure SetTabLeft(const Value: Integer);
    procedure SetTabSpan(const Value: Integer);
    function GetTabCount: Integer;
    procedure SetActivePage(const Value: TJkhTabSheet);
    procedure SetTabItemHeight(const Value: Integer);
    procedure SetTabItemWidth(const Value: Integer);
    procedure SetTabItemInnerLeftSpan(const Value: Integer);
    procedure SetGutterEnabled(const Value: Boolean);
    procedure SetGutterColor(const Value: TColor);
    procedure SetSelectColor(const Value: TColor);
    procedure SetHighlightColor(const Value: TColor);
    procedure SetOutLineMode(const Value: Boolean);
    procedure SetGutterLineColor(const Value: TColor);
  protected
    procedure WndProc(var Message: TMessage); override;
    procedure WMPaint(var Msg: TWMPaint); message WM_PAINT;
    procedure PaintAll(Canvas: TCanvas);

    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function GetPageFromParent(Client: TControl): TJkhTabSheet;
    procedure NextPage;
    procedure PrevPage;
    function InsertPage(ATabSheet: TJkhTabSheet): Integer;
    procedure RemovePage(ATabSheet: TJkhTabSheet);

    function FindItemIndexAtPoint(X, Y: Integer): Integer;

    property TabCount: Integer read GetTabCount;
    property TabIndex: Integer read FTabIndex write SetTabIndex;
  published
    property Align;
    property Anchors;
    property Constraints;
    property Enabled;
    property Font;
    property ParentFont;
    property DockSite;
    property TabOrder;
    property TabStop;
    property Visible;

    property TabWidth;
    property TabHeight;
    property TabPosition;

    // 이쪽보다는 TabIndex 쪽이 중요하다.
    property ActivePage: TJkhTabSheet read FActivePage write SetActivePage;
    property OutLineMode: Boolean read FOutLineMode write SetOutLineMode;

    property LogoImage: TPicture read FLogoImage write SetLogoImage;
    // property SplitImage: TPicture read FSplitImage write SetSplitImage;
    // 탭 자체에 스플릿을 설정하도록 하고 여기서 자체 스플릿은 구현하지 않는다.

    property LogoLeft: Integer read FLogoLeft write SetLogoLeft;
    property LogoTop: Integer read FLogoTop write SetLogoTop;
    property LogoSpan: Integer read FLogoSpan write SetLogoSpan;

    property TabLeft: Integer read FTabLeft write SetTabLeft;
    property TabSpan: Integer read FTabSpan write SetTabSpan; // 간격
    property TabItemWidth: Integer read FTabItemWidth write SetTabItemWidth;
    property TabItemHeight: Integer read FTabItemHeight write SetTabItemHeight;
    property TabItemInnerLeftSpan: Integer read FTabItemInnerLeftSpan write SetTabItemInnerLeftSpan;
    property TabClickEnabled: Boolean read FTabClickEnabled write FTabClickEnabled;

    property GutterWidth: Integer read FGutterWidth write SetGutterWidth;
    property GutterEnabled: Boolean read FGutterEnabled write SetGutterEnabled;
    property GutterColor: TColor read FGutterColor write SetGutterColor;
    property GutterLineColor: TColor read FGutterLineColor write SetGutterLineColor;

    property SelectColor: TColor read FSelectColor write SetSelectColor;
    property HighlightColor: TColor read FHighlightColor write SetHighlightColor;

    // 이벤트
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnResize;

    property OnLogoClick: TNotifyEvent read FOnLogoClick write FOnLogoClick;

    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('NS', [TJkhTabControl]);
  RegisterClass(TJkhTabSheet);
end;


{ TJkhTabSheet }

procedure TJkhTabSheet.CMShowingChanged(var Message: TMessage);
begin
  inherited;

  if (csDesigning in ComponentState) and Visible and (FTabControl <> Nil) then
  Begin

     FTabControl.ActivePage := Self;
     //MessageBox(0 ,'', PChar(IntToStr(FTabControl.TabIndex)), 0);
  End;
end;

constructor TJkhTabSheet.Create(AOwner: TComponent);
begin
  inherited;
  FTabControl := Nil;

  Align := alClient;
  ControlStyle := ControlStyle + [csAcceptsControls, csNoDesignVisible];
  Visible := False;
  Color := clWhite;

  FTabVisible := True;
  FCaptionImage := TPicture.Create;
end;

procedure TJkhTabSheet.CreateParams(var Params: TCreateParams);
begin
  inherited;
  with Params.WindowClass do
     style := style and not (CS_HREDRAW or CS_VREDRAW);
end;

destructor TJkhTabSheet.Destroy;
begin
  // 이쪽이 TabControl 보다 먼저 Free 되어 있을것이기 때문에.
  If (FTabControl <> Nil) and (not (csDestroying in ComponentState)) Then
     FTabControl.RemovePage(Self);
  FCaptionImage.Free;

  inherited Destroy;
end;

procedure TJkhTabSheet.DoSelected;
begin
  If Assigned(FOnSelected) then FOnSelected(Self);
end;

function TJkhTabSheet.GetColor: TColor;
begin
  Result:= inherited Color;
end;

function TJkhTabSheet.GetTabIndex: Integer;
begin
  If Assigned(FTabControl) Then
     Result := FTabControl.FPages.IndexOf(Self);
end;

procedure TJkhTabSheet.Paint;
begin
  inherited;
end;

procedure TJkhTabSheet.ReadState(Reader: TReader);
begin
  inherited ReadState(Reader);
  if Reader.Parent is TJkhTabControl then
     TabControl := TJkhTabControl(Reader.Parent);
end;

procedure TJkhTabSheet.SetCaption(const Value: TCaption);
begin
  FCaption := Value;
end;

procedure TJkhTabSheet.SetCaptionImage(const Value: TPicture);
begin
  FCaptionImage.Assign( Value );
end;

procedure TJkhTabSheet.SetColor(const Value: TColor);
begin
  inherited Color := Value;

  if TabControl <> nil then
  begin
     TabControl.Invalidate;
  end;
end;

procedure TJkhTabSheet.SetTabControl(const Value: TJkhTabControl);
begin
  If FTabControl = Value Then Exit;
  if (csDestroying in ComponentState) then Exit;

  // 굳이 Parent 를 쓰더라도 이건 꼭 써야 한다.
  FTabControl := Value;
  If FTabControl <> Nil Then
  Begin
     FTabControl.RemovePage(Self);

     // 이미 액티브 페이지로 되어 있으면 설정도 하지 말자 추가 되니깐..
     If FTabControl.ActivePage = Self Then Exit;
     FTabControl.InsertPage(Self);
     // 이건 Tab 처리가 없어서 역순이 되니깐 이렇게 보정한다.
     TabIndex := 0; 

     If FTabControl.ActivePage = Nil Then
        FTabControl.TabIndex := 0;
  End;
end;

procedure TJkhTabSheet.SetTabIndex(const Value: Integer);
begin
  //
end;

procedure TJkhTabSheet.SetTabVisible(const Value: Boolean);
begin
  FTabVisible := Value;
  If Assigned(FTabControl) Then FTabControl.Invalidate;
end;

{ TJkhTabControl }

procedure TJkhTabControl.CMDesignHitTest(var Message: TCMDesignHitTest);
var
  HitIndex: Integer;
  HitTestInfo: TTCHitTestInfo;
begin
  HitTestInfo.pt := SmallPointToPoint(Message.Pos);
  HitIndex := SendMessage(Handle, TCM_HITTEST, 0, Longint(@HitTestInfo));

  // 탭 반응하게 하기 위함.
  if (HitIndex >= 0) and (HitIndex <> TabIndex) then Message.Result := 1;
end;

procedure TJkhTabControl.CMMouseEnter(var Message: TMessage);
begin
  FHighlightIndex := -1;
end;

procedure TJkhTabControl.CMMouseLeave(var Message: TMessage);
begin
  FHighlightIndex := -1;
  Invalidate;
end;

constructor TJkhTabControl.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  ControlStyle := [csDoubleClicks, csOpaque];
  BorderWidth := 0;
  // TabPosition := tpLeft;
  // TabWidth := Height;
  TabWidth := 700; // 나중에 리사이즈 해야 될거다. 귀찮아서 걍 둠
  Ctl3D := False;

  FTabItemWidth := 120;
  FOutLineMode := False;
  FHighlightIndex := -1;
  FGutterColor := $00C95E33;
  FSelectColor := $00CE7856;
  FHighlightColor := $00a74e2a; // $00a74e2a
  FGutterLineColor := $00E8BAA7;
  FTabIndex := -1;
  FActivePage := Nil;
  FGutterEnabled := True;
  FTabClickEnabled := True;

  FPages := TList.Create;
  FLogoImage := TPicture.Create;

  FGutterWidth := 100;

  OwnerDraw := True;
end;

destructor TJkhTabControl.Destroy;
begin
  FPages.Free;
  FPages := Nil;
  FLogoImage.Free;

  inherited;
end;

procedure TJkhTabControl.EraseBkGnd(var Message: TMessage);
begin
  Message.Result := 1;
end;

function TJkhTabControl.FindItemIndexAtPoint(X, Y: Integer): Integer;
var
  LoopVar, TopPos, LeftPos, ItemHeight: Integer;
  ItemCaption: String;
  ItemImage: TGraphic;

  function CheckInRect(X1, Y1, X2, Y2: Integer): Boolean;
  begin
    If (X > X1) and (X < X2) and (Y > Y1) and (Y < Y2) Then
       Result := True
    Else
       Result := False;
  end;
begin
  Result := -1;

  // 먼저 로고 영역인지 체크하고
  If CheckInRect(LogoLeft, LogoTop, LogoLeft+LogoImage.Width, LogoTop+LogoImage.Height) Then
     Result := -2;

  Case TabPosition of
     tpLeft:
     Begin
        TopPos := LogoTop+LogoImage.Height+LogoSpan;
        LeftPos := 0;
     End;
     tpTop:
     Begin
        TopPos := LogoTop;
        LeftPos := LogoLeft+LogoImage.Width+LogoSpan;
     End;
  End;

  // 아니면 이제 순서대로 메뉴를 누른건지 확인한다.
  For LoopVar := 0 to FPages.Count-1 do
  Begin
     If Not TJkhTabSheet(FPages[LoopVar]).TabVisible Then Continue;

     ItemImage := TJkhTabSheet(FPages[LoopVar]).FCaptionImage.Graphic;
     ItemCaption := TJkhTabSheet(FPages[LoopVar]).Caption;
     If Assigned(ItemImage) Then
        ItemHeight := ItemImage.Height
     Else
        ItemHeight := Canvas.TextHeight('1');

     If TabItemHeight > ItemHeight Then
        ItemHeight := TabItemHeight;

     Case TabPosition of
        tpLeft:
        Begin
           If (ItemCaption <> '-') and CheckInRect(TabLeft, TopPos, GutterWidth, TopPos+ItemHeight) Then
           Begin
              Result := LoopVar;
              Exit;
           End;

           TopPos := TopPos + ItemHeight + TabSpan;
        End;
        tpTop:
        Begin
           If (ItemCaption <> '-') and CheckInRect(LeftPos, TopPos, LeftPos+TabItemWidth, GutterWidth) Then
           Begin
              Result := LoopVar;
              Exit;
           End;

           LeftPos := LeftPos + TabItemWidth;
        End;
     End;
  End;
end;

function TJkhTabControl.GetPageFromParent(
  Client: TControl): TJkhTabSheet;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to FPages.Count - 1 do
  begin
    if (Client = FPages[I]) then
    begin
      Result := FPages[I];
      Exit;
    end;
  end;
end;

function TJkhTabControl.GetTabCount: Integer;
begin
  Result := FPages.Count;
end;

function TJkhTabControl.InsertPage(ATabSheet: TJkhTabSheet): Integer;
var
  InsertPos, MyPos,
  LoopVar: Integer;
begin
  Result := -1;
  InsertPos := 0;
  MyPos := ATabSheet.FTabPosition;

  For LoopVar := 0 To FPages.Count-1 do
  Begin
     If TJkhTabSheet(FPages[LoopVar]).TabPosition <= MyPos Then Inc(InsertPos);

     If FPages[LoopVar] = ATabSheet Then
     Begin
        Result := LoopVar;
        Exit;
     End;
  End;

  // Result :=
  FPages.Insert(InsertPos, ATabSheet);
  Result := InsertPos;

  // 결국 탭을 없애는건 그냥 이렇게 하는 수 밖에 없다.
  If FGutterEnabled Then
     If Tabs.Count <= 0 Then Tabs.Add('');
  //FPages.Move(Result, 0);
  //Result := 0;
end;

procedure TJkhTabControl.MouseDown(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited;

  if (csDesigning in ComponentState) then
    Exit;

  If Not FTabClickEnabled Then Exit;

  If ssLeft in Shift Then
     FSelectCandidate := FindItemIndexAtPoint(X, Y);
end;

procedure TJkhTabControl.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  NewIndex: Integer;
begin
  inherited;

  If Not FTabClickEnabled Then Exit;

  NewIndex := FindItemIndexAtPoint(X, Y);
  If (NewIndex <> FHighlightIndex) and
     (NewIndex >= 0)            Then
  Begin
     FHighlightIndex := NewIndex;
     Invalidate;
  End;
end;

procedure TJkhTabControl.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
var
  CurrentItem: Integer;
begin
  inherited;

  if (csDesigning in ComponentState) then
    Exit;

  CurrentItem := -1;
  If Not (ssLeft in Shift) Then
  Begin
     If FSelectCandidate = -1 Then Exit;

     CurrentItem := FindItemIndexAtPoint(X, Y);

     If FSelectCandidate = CurrentItem Then
     Begin
        If FSelectCandidate = -2 Then
        Begin
           If Assigned(OnLogoClick) Then
              OnLogoClick(Self);
        End
        Else
           TabIndex := FSelectCandidate;
     End;
  End;

  FSelectCandidate := -1;
end;

procedure TJkhTabControl.NextPage;
begin
  TabIndex := TabIndex + 1;
end;

procedure TJkhTabControl.PaintAll(Canvas: TCanvas);
const
  BaseColor = clWhite;
  // SelectColor = $00CE7856;
  // HighlightColor = $00CC6B45; // 456bcc
  // GutterLineColor = $00E8BAA7; // a7bae8
var
  Rect: TRect;
  ItemImage: TGraphic;
  ItemCaption: String;
  ItemHeight, ItemDrawHeight, ItemDrawY,
  DrawGutterWidth,
  MenuStartX, MenuStartY: Integer;

  procedure DrawLeftGutter;
  var
    LoopVar: Integer;
  begin
    If DrawGutterWidth <= 0 Then
    Begin
       Exit;
    End;

    Canvas.Brush.Color := GutterColor;
    Rect.Left := 0;
    Rect.Top := 0;
    Rect.Right := DrawGutterWidth;
    Rect.Bottom := Height;
    Canvas.FillRect(Rect);

    Canvas.Brush.Color := GutterLineColor;
    Rect.Left := DrawGutterWidth-1;
    Rect.Top := 0;
    Rect.Right := DrawGutterWidth;
    Rect.Bottom := Height;
    Canvas.FillRect(Rect);

    If FOutLineMode Then Exit;

    // 다음으로 로고를 그린다.
    If (LogoImage <> Nil) and Assigned(LogoImage.Graphic) Then
    Begin
       Rect.Left := LogoLeft;
       Rect.Top := logoTop;
       Rect.Right := LogoLeft + LogoImage.Width;
       Rect.Bottom := LogoTop + LogoImage.Height;
       Canvas.StretchDraw(Rect, LogoImage.Graphic);

       MenuStartY := Rect.Bottom + LogoSpan;
    End
    Else
    Begin
       MenuStartY := LogoSpan;
    End;

    MenuStartX := TabLeft;

    Canvas.Brush.Color := clNone;
    Canvas.Brush.Style := bsClear;

    // 메뉴를 그린다.
    For LoopVar := 0 to FPages.Count-1 do
    Begin
       If Not TJkhTabSheet(FPages[LoopVar]).TabVisible Then Continue;

       ItemCaption := TJkhTabSheet(FPages[LoopVar]).Caption; //
       ItemImage := TJkhTabSheet(FPages[LoopVar]).FCaptionImage.Graphic;
       ItemDrawHeight := TabItemHeight;
       If Assigned(ItemImage) Then
       Begin
          ItemHeight := ItemImage.Height
       End
       Else
       Begin
          ItemHeight := Canvas.TextHeight(ItemCaption);
       End;

       If ItemHeight <= 0 Then ItemHeight := 1;
       If ItemHeight > TabItemHeight Then
          ItemDrawHeight := ItemHeight;
       ItemDrawY := 0;
       If ItemDrawHeight > 0 Then
          ItemDrawY := (ItemDrawHeight Div 2)-(ItemHeight Div 2);

       // 선택된 아이템 처리
       If LoopVar = TabIndex Then
       Begin
          Canvas.Brush.Color := SelectColor;
          Rect.Left := MenuStartX;
          Rect.Top := MenuStartY;
          Rect.Right := DrawGutterWidth-1;
          Rect.Bottom := MenuStartY+ItemDrawHeight;
          Canvas.FillRect(Rect);
          Canvas.Brush.Color := clNone;
          Canvas.Brush.Style := bsClear;
       End
       Else
       Begin
          If LoopVar = FHighlightIndex Then
          Begin
             Canvas.Brush.Color := HighlightColor;
             Rect.Left := MenuStartX;
             Rect.Top := MenuStartY;
             Rect.Right := DrawGutterWidth-1;
             Rect.Bottom := MenuStartY+ItemDrawHeight;
             Canvas.FillRect(Rect);
             Canvas.Brush.Color := clNone;
             Canvas.Brush.Style := bsClear;
          End;
       End;

       If Assigned(ItemImage) Then
       Begin
          Rect.Left := MenuStartX+TabItemInnerLeftSpan;
          Rect.Top := MenuStartY+ItemDrawY;
          Rect.Right := Rect.Left + ItemImage.Width;
          Rect.Bottom := Rect.Top + ItemImage.Height;
          Canvas.StretchDraw(Rect, ItemImage);
       End
       Else
       Begin
          Canvas.TextOut(MenuStartX+TabItemInnerLeftSpan, MenuStartY+ItemDrawY, ItemCaption);
       End;
       MenuStartY := MenuStartY + ItemDrawHeight + TabSpan;
    End;
  end;

  procedure DrawTopGutter;
  var
    LoopVar: Integer;
    ItemDrawWidth: Integer;
  begin
    If DrawGutterWidth <= 0 Then Exit;

    Canvas.Brush.Color := GutterColor;
    Rect.Left := 0;
    Rect.Top := 0;
    Rect.Right := Width;
    Rect.Bottom := DrawGutterWidth;
    Canvas.FillRect(Rect);

    Canvas.Brush.Color := GutterLineColor;
    Rect.Left := 0;
    Rect.Top := DrawGutterWidth-1;
    Rect.Right := Width;
    Rect.Bottom := DrawGutterWidth;
    Canvas.FillRect(Rect);

    If FOutLineMode Then Exit;

    MenuStartX := LogoLeft;
    MenuStartY := LogoTop;

    // 다음으로 로고를 그린다.
    If (LogoImage <> Nil) and Assigned(LogoImage.Graphic) Then
    Begin
       Rect.Left := LogoLeft;
       Rect.Top := logoTop;
       Rect.Right := LogoLeft + LogoImage.Width;
       Rect.Bottom := LogoTop + LogoImage.Height;
       Canvas.StretchDraw(Rect, LogoImage.Graphic);

       MenuStartX := Rect.Right + LogoSpan;
    End
    Else
    Begin
       MenuStartX := LogoSpan;
    End;

    Canvas.Brush.Color := clNone;
    Canvas.Brush.Style := bsClear;

    // 메뉴를 그린다.
    For LoopVar := 0 to FPages.Count-1 do
    Begin
       If Not TJkhTabSheet(FPages[LoopVar]).TabVisible Then Continue;

       ItemCaption := TJkhTabSheet(FPages[LoopVar]).Caption; //
       ItemImage := TJkhTabSheet(FPages[LoopVar]).FCaptionImage.Graphic;
       ItemDrawHeight := TabItemHeight;
       ItemDrawWidth := TabItemWidth;
       If Assigned(ItemImage) Then
       Begin
          ItemHeight := ItemImage.Height
       End
       Else
       Begin
          ItemHeight := Canvas.TextHeight(ItemCaption);
       End;

       If ItemHeight <= 0 Then ItemHeight := 1;
       If ItemHeight > TabItemHeight Then
          ItemDrawHeight := ItemHeight;
       ItemDrawY := 0;
       If ItemDrawHeight > 0 Then
          ItemDrawY := (ItemDrawHeight Div 2)-(ItemHeight Div 2);

       // 선택된 아이템 처리
       If LoopVar = TabIndex Then
       Begin
          Canvas.Brush.Color := SelectColor;
          Rect.Left := MenuStartX;
          Rect.Top := MenuStartY;
          Rect.Right := MenuStartX+TabItemWidth;
          Rect.Bottom := DrawGutterWidth-1;
          Canvas.FillRect(Rect);
          Canvas.Brush.Color := clNone;
          Canvas.Brush.Style := bsClear;
       End
       Else
       Begin
          If LoopVar = FHighlightIndex Then
          Begin
             Canvas.Brush.Color := HighlightColor;
             Rect.Left := MenuStartX;
             Rect.Top := MenuStartY;
             Rect.Right := MenuStartX+TabItemWidth;
             Rect.Bottom := DrawGutterWidth-1;
             Canvas.FillRect(Rect);
             Canvas.Brush.Color := clNone;
             Canvas.Brush.Style := bsClear;
          End;
       End;

       If Assigned(ItemImage) Then
       Begin
          Rect.Left := MenuStartX+TabItemInnerLeftSpan;
          Rect.Top := MenuStartY+ItemDrawY;
          Rect.Right := Rect.Left + ItemImage.Width;
          Rect.Bottom := Rect.Top + ItemImage.Height;
          Canvas.StretchDraw(Rect, ItemImage);
       End
       Else
       Begin
          Canvas.TextOut(MenuStartX+TabItemInnerLeftSpan, MenuStartY+ItemDrawY, ItemCaption);
       End;
       MenuStartX := MenuStartX + ItemDrawWidth + TabSpan;
    End;
  end;
begin
  //DoubleBuffered := True;

  Canvas.Font.Assign(Font);
  ItemHeight := 0;
  ItemDrawHeight := 0;
  ItemDrawY := 0;
  DrawGutterWidth := 0;
  MenuStartX := 0;
  MenuStartY := 0;

  DrawGutterWidth := GutterWidth;
  If Not GutterEnabled Then DrawGutterWidth := 0;

  // 일단 바탕을 그리고
  Canvas.Pen.Color := BaseColor;
  Canvas.Pen.Width := 8;
  Canvas.Brush.Color := clNone;
  Canvas.Brush.Style := bsClear;

  Case TabPosition of
     tpLeft:
     Begin
        Rect.Left := DrawGutterWidth;
        Rect.Top := 0;
        Rect.Right := Width;
        Rect.Bottom := Height;
     End;
     tpTop:
     Begin
        Rect.Left := 0;
        Rect.Top := DrawGutterWidth+2;
        Rect.Right := Width;
        Rect.Bottom := Height;
     End;
  End;

  If TabIndex = -1 Then
  Begin
     Canvas.Brush.Style := bsSolid;
     Canvas.FillRect(Rect);
  End
  Else
     Canvas.Rectangle(Rect);

  // 다음으로 Gutter를 그린다.
  Case TabPosition of
     tpLeft: DrawLeftGutter;
     tpTop:  DrawTopGutter;
  End;
end;

procedure TJkhTabControl.PrevPage;
begin
  TabIndex := TabIndex - 1;
end;

procedure TJkhTabControl.RemovePage(ATabSheet: TJkhTabSheet);
var
  LoopVar: Integer;
begin
  FActivePage := Nil;
  If FPages = Nil Then Exit;

  For LoopVar := FPages.Count-1 DownTo 0 do
  Begin
    If ATabSheet = FPages[LoopVar] Then
       FPages.Delete(LoopVar);
  End;

  TabIndex := -1;
end;

procedure TJkhTabControl.SetActivePage(const Value: TJkhTabSheet);
begin
  FActivePage := Nil;
  TabIndex := FPages.IndexOf(Value);
end;

procedure TJkhTabControl.SetGutterColor(const Value: TColor);
begin
  FGutterColor := Value;
  Invalidate;
end;

procedure TJkhTabControl.SetGutterEnabled(const Value: Boolean);
begin
  If FGutterEnabled = Value Then Exit;

  FGutterEnabled := Value;
  If FGutterEnabled Then
  Begin
     TabHeight := FGutterWidth;
     Tabs.Add('');
  End
  Else
  Begin
     TabHeight := 0;
     Tabs.Clear;
  End;

  Invalidate;
end;

procedure TJkhTabControl.SetGutterLineColor(const Value: TColor);
begin
  FGutterLineColor := Value;
  Invalidate;
end;

procedure TJkhTabControl.SetGutterWidth(const Value: Integer);
begin
  FGutterWidth := Value;
  // Left 모드니깐
  TabHeight := Value
  //Invalidate;
end;

procedure TJkhTabControl.SetHighlightColor(const Value: TColor);
begin
  FHighlightColor := Value;
  Invalidate;
end;

procedure TJkhTabControl.SetLogoImage(const Value: TPicture);
begin
  FLogoImage.Assign(Value);
  Invalidate;
end;

procedure TJkhTabControl.SetLogoLeft(const Value: Integer);
begin
  FLogoLeft := Value;
  Invalidate;
end;

procedure TJkhTabControl.SetLogoSpan(const Value: Integer);
begin
  FLogoSpan := Value;
  Invalidate;
end;

procedure TJkhTabControl.SetLogoTop(const Value: Integer);
begin
  FLogoTop := Value;
  Invalidate;
end;

procedure TJkhTabControl.SetOutLineMode(const Value: Boolean);
begin
  FOutLineMode := Value;
  Invalidate;
end;

procedure TJkhTabControl.SetSelectColor(const Value: TColor);
begin
  FSelectColor := Value;
  Invalidate;
end;

procedure TJkhTabControl.SetTabIndex(const Value: Integer);
var
  LoopVar: Integer;
begin
  // 이걸 해두면 Zyroid 에서는 다음탭 문제가 있다.
  // 따라서 SetTabIndex 시에는 동일 탭이 다시 선택되더라도 탭 인덱스를 갱신한다.
  // 또 히든 상태에서 동작하지 않는 문제도 회피하기 위해서 그냥 매번 갱신.
  // If FTabIndex = Value Then Exit;
  FTabIndex := -1;
  FActivePage := Nil;
  If Value = -1 Then Exit;

  For LoopVar := 0 to FPages.Count -1 do
  Begin
     // If TJkhTabSheet(FPages[LoopVar]).TabIndex = Value Then
     If LoopVar = Value Then
     Begin
        FTabIndex := Value;
        FActivePage := FPages[Value];
        FActivePage.Visible := True;
        FActivePage.SelectFirst;
        FActivePage.BringToFront;

        if not (csLoading in ComponentState) Then
        begin
           If Assigned(FOnChange) Then
              FOnChange(Self);
           If Assigned(FActivePage.FOnSelected) Then
              FActivePage.FOnSelected(Self);
        end;
     End
     Else
     Begin
        TJkhTabSheet(FPages[LoopVar]).Visible := False;
     End;
  End;

  Invalidate;
end;

procedure TJkhTabControl.SetTabItemHeight(const Value: Integer);
begin
  FTabItemHeight := Value;
  Invalidate;
end;

procedure TJkhTabControl.SetTabItemInnerLeftSpan(const Value: Integer);
begin
  FTabItemInnerLeftSpan := Value;
  Invalidate;
end;

procedure TJkhTabControl.SetTabItemWidth(const Value: Integer);
begin
  FTabItemWidth := Value;
  Invalidate;
end;

procedure TJkhTabControl.SetTabLeft(const Value: Integer);
begin
  FTabLeft := Value;
  Invalidate;
end;

procedure TJkhTabControl.SetTabSpan(const Value: Integer);
begin
  FTabSpan := Value;
  Invalidate;
end;

procedure TJkhTabControl.WMPaint(var Msg: TWMPaint);
var
  DC, MemDC: HDC;
  MemBitmap, OldBitmap: HBITMAP;
  PS: TPaintStruct;
  R: TRect;
  ARgn: HRGN;
  PaintHandle: TCanvas;
begin
  if (Msg.DC <> 0) then
    PaintHandler(Msg)
  else
  begin
    DC := GetDC(0);
    MemBitmap := CreateCompatibleBitmap(DC, ClientRect.Right, ClientRect.Bottom);
    ReleaseDC(0, DC);
    MemDC := CreateCompatibleDC(0);
    OldBitmap := SelectObject(MemDC, MemBitmap);
    try
      DC := BeginPaint(Handle, PS);
      GetClipBox(DC, R);
      if IsRectEmpty(R) then
        R := ClientRect
      else
      begin
        InflateRect(R, 1, 1);
      end;
      with R do
        ARgn := CreateRectRgn(Left, Top, right, Bottom);
      SelectClipRgn(MemDC, ARgn);
      Perform(WM_ERASEBKGND, MemDC, MemDC);
      Msg.DC := MemDC;

      WMPaint(Msg);
      PaintHandle := TCanvas.Create;
      Try
         PaintHandle.Handle := MemDC;
         PaintAll(PaintHandle);
      Finally
         PaintHandle.Free;
      End;

      SelectClipRgn(MemDC, 0);
      DeleteObject(ARgn);
      Msg.DC := 0;
      with R do
        BitBlt(DC, Left, Top, Right, Bottom, MemDC, Left, Top, SRCCOPY);
      EndPaint(Handle, PS);
    finally
      SelectObject(MemDC, OldBitmap);
      DeleteDC(MemDC);
      DeleteObject(MemBitmap);
    end;
  end;
end;

procedure TJkhTabControl.WndProc(var Message: TMessage);
begin
  {If (Message.Msg = WM_PAINT) then
  Begin
     //Message.Result := 1;

     //Inherited;
     // PaintAll(Canvas);
  End
  Else}
     inherited;

end;

end.
