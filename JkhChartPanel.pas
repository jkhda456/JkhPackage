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

unit JkhChartPanel;

interface

uses
  SysUtils, Classes, Controls, ExtCtrls, Types, Graphics, GDIPAPI;

type
  TJkhChartEnvFlowDirection = (cedVertial, cedHorizontal);
  TJkhChartEnvDivType = (cedDistance, cedCount);
  TJkhChartEnvType = (cetGrid);
  TJkhChartItemAlignPosition = (ciapLeftTop, ciapRightTop, ciapLeftBottom, ciapRightBottom, ciapCenter, ciapCenterTop, ciapCenterBottom, ciapLeftCenter, ciapRightCenter);
  TJkhChartValueDrawType = (cvdNone, cvdLinkedLine);

  TJkhChartValueToTextEvent = procedure(Sender: TObject; CurrentValue: Integer; var OutText: String) of object;

  TJkhChartValue = class(TCollectionItem)
  private
    FColor: TGPColor;
    FPrintValue: Boolean;
    FHint: String;
    FOnValueToText: TJkhChartValueToTextEvent;
    FPrintValueAlign: TJkhChartItemAlignPosition;
    FYValue: Integer;
    FXValue: Integer;
    FFont: TFont;
    FPaintItemRange: Integer;
    FPaintOutLineSize: Integer;
    FOutlineColor: TGPColor;
    procedure SetHint(const Value: String);
    procedure SetPrintValue(const Value: Boolean);
    procedure SetPrintValueAlign(const Value: TJkhChartItemAlignPosition);
    procedure SetXValue(const Value: Integer);
    procedure SetYValue(const Value: Integer);
    procedure SetFont(const Value: TFont);
  protected
    function GetDisplayName: string; override;
  public
    // 현재 그려둘 좌표를 표시합니다.
    CurrentPosition: TPoint;

    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
  published
    property Color: TGPColor read FColor write FColor;
    property OutlineColor: TGPColor read FOutlineColor write FOutlineColor;
    property Font: TFont read FFont write SetFont;
    property Hint: String read FHint write SetHint;

    property PrintValue: Boolean read FPrintValue write SetPrintValue;
    property PrintValueAlignPos: TJkhChartItemAlignPosition read FPrintValueAlign write SetPrintValueAlign;

    property PaintItemRange: Integer read FPaintItemRange write FPaintItemRange;
    property PaintOutLineSize: Integer read FPaintOutLineSize write FPaintOutLineSize;

    property XValue: Integer read FXValue write SetXValue;
    property YValue: Integer read FYValue write SetYValue;

    // 텍스트로 변경하는 함수가 지정되어 있으면 이쪽을 이용한다
    property OnValueToText: TJkhChartValueToTextEvent read FOnValueToText write FOnValueToText;
  end;

  TJkhChartValueList = class(TCollection)
  private
    FCollectionOwner: TPersistent;
  protected
    function GetOwner: TPersistent; override;
    property CollectionOwner: TPersistent read FCollectionOwner write FCollectionOwner;
  public
    constructor Create;
    destructor Destroy;
  published
  end;

  TJkhChartItem = class(TCollectionItem)
  private
    FItemName: String;
    FItemIcon: TPicture;
    FItemValues: TJkhChartValueList;
    FValueDrawType: TJkhChartValueDrawType;
    FValueDrawLineSize: Integer;
    FValueDrawColor: TGPColor;
    procedure SetItemName(const Value: String);
    procedure SetItemIcon(const Value: TPicture);
    procedure SetItemValues(const Value: TJkhChartValueList);
    procedure SetValueDrawType(const Value: TJkhChartValueDrawType);
    procedure SetValueDrawLineSize(const Value: Integer);
    procedure SetValueDrawColor(const Value: DWORD);
  protected
    function GetDisplayName: string; override;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
  published
    property ItemName: String read FItemName write SetItemName;
    property ItemIcon: TPicture read FItemIcon write SetItemIcon;
    property ItemValues: TJkhChartValueList read FItemValues write SetItemValues;

    property ValueDrawType: TJkhChartValueDrawType read FValueDrawType write SetValueDrawType;
    property ValueDrawColor: DWORD read FValueDrawColor write SetValueDrawColor;
    property ValueDrawLineSize: Integer read FValueDrawLineSize write SetValueDrawLineSize;
  end;

  TJkhChartItemList = class(TCollection)
  private
    FCollectionOwner: TPersistent;
  protected
    function GetOwner: TPersistent; override;
    property CollectionOwner: TPersistent read FCollectionOwner write FCollectionOwner;
  public
    constructor Create;
    destructor Destroy;
  end;

  TJkhChartEnvItem = class(TCollectionItem)
  private
    FEnvType: TJkhChartEnvType;
    FItemName: String;
    FDirection: TJkhChartEnvFlowDirection;
    FMaxValue: Integer;
    FDivByValue: Integer;
    FMargin: Integer;
    FMinValue: Integer;
    FDivByType: TJkhChartEnvDivType;
    FColor: TColor;
    FPrintValue: Boolean;
    FOnValueToText: TJkhChartValueToTextEvent;
    FPrintValueAlign: TJkhChartItemAlignPosition;
    FFont: TFont;
    procedure SetEnvType(const Value: TJkhChartEnvType);
    procedure SetItemName(const Value: String);
    procedure SetDirection(const Value: TJkhChartEnvFlowDirection);
    procedure SetDivByType(const Value: TJkhChartEnvDivType);
    procedure SetDivByValue(const Value: Integer);
    procedure SetMargin(const Value: Integer);
    procedure SetMaxValue(const Value: Integer);
    procedure SetMinValue(const Value: Integer);
    procedure SetColor(const Value: TColor);
    procedure SetPrintValue(const Value: Boolean);
    procedure SetPrintValueAlign(const Value: TJkhChartItemAlignPosition);
    procedure SetFont(const Value: TFont);
  protected
    function GetDisplayName: string; override;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
  published
    property ItemName: String read FItemName write SetItemName;

    property Direction: TJkhChartEnvFlowDirection read FDirection write SetDirection;
    // 최초로 그리드 라인 등이 등장할때 얼마의 마진을 두고 등장할 것인지를 결정한다.
    property Margin: Integer read FMargin write SetMargin;
    // 영역을 최대 값으로 쪼갰을때 몇개의 아이템이 들어갈지를 결정한다. 0 이하일때는 쪼개지 않고 간격을 우선순위로 둘것이다.
    property DivByType: TJkhChartEnvDivType read FDivByType write SetDivByType;
    property DivByValue: Integer read FDivByValue write SetDivByValue;

    // 최저값, 최대값은 PrintValue 할때 쓰는 항목이다.
    // 최저값을 결정한다.
    property MinValue: Integer read FMinValue write SetMinValue;
    // 최대값을 결정한다.
    property MaxValue: Integer read FMaxValue write SetMaxValue;

    // 색을 결정한다.
    property Color: TColor read FColor write SetColor;
    property Font: TFont read FFont write SetFont;

    // 환경의 종류를 결정한다.
    property EnvType: TJkhChartEnvType read FEnvType write SetEnvType;

    // 값을 표시해줄려면 이쪽을 켠다. 없으면 값을 안보여줄거다.
    property PrintValue: Boolean read FPrintValue write SetPrintValue;
    property PrintValueAlignPos: TJkhChartItemAlignPosition read FPrintValueAlign write SetPrintValueAlign;

    // 텍스트로 변경하는 함수가 지정되어 있으면 이쪽을 이용한다
    property OnValueToText: TJkhChartValueToTextEvent read FOnValueToText write FOnValueToText;
  end;

  TJkhChartEnvItemList = class(TCollection)
  private
    FCollectionOwner: TPersistent;
  protected
    function GetOwner: TPersistent; override;
    property CollectionOwner: TPersistent read FCollectionOwner write FCollectionOwner;
  public
    constructor Create;
    destructor Destroy;
  published
  end;

  TJkhChartPanel = class(TCustomPanel)
  private
    FChartItem: TJkhChartItemList;
    FChartEnvItem: TJkhChartEnvItemList;
    FDrawLegend: Boolean;
    FLegendSize: Integer;
    FLegendFont: TFont;
    procedure SetChartItem(const Value: TJkhChartItemList);
    procedure SetChartEnvItem(const Value: TJkhChartEnvItemList);
    procedure SetDrawLegend(const Value: Boolean);
    procedure SetLegendSize(const Value: Integer);
    procedure SetLegendFont(const Value: TFont);
  protected
    procedure DrawBackgroud(ALeft, ATop, ARight, ABottom: Integer);
    procedure DrawLegend(ALeft, ATop, ARight, ABottom: Integer);
    procedure DrawValues(ALeft, ATop, ARight, ABottom: Integer);

    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    property DockManager;
  published
    property Align;
    property Alignment;
    property Anchors;
    property AutoSize;
    property BevelInner;
    property BevelOuter;
    property BevelWidth;
    property BiDiMode;
    property BorderWidth;
    property BorderStyle;
    property Caption;
    property Color;
    property Constraints;
    property Ctl3D;
    property UseDockManager default True;
    property DockSite;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property FullRepaint;
    property Font;
    property Locked;
    property ParentBiDiMode;
    property ParentBackground;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop default False;
    property Visible;

    property ChartItem: TJkhChartItemList read FChartItem write SetChartItem;
    property ChartEnvItem: TJkhChartEnvItemList read FChartEnvItem write SetChartEnvItem;

    property EnableDrawLegend: Boolean read FDrawLegend write SetDrawLegend;
    property LegendFont: TFont read FLegendFont write SetLegendFont;     
    property LegendSize: Integer read FLegendSize write SetLegendSize; 

    property OnCanResize;
    property OnClick;
    property OnConstrainedResize;
    property OnContextPopup;
    property OnDockDrop;
    property OnDockOver;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnGetSiteInfo;
    property OnKeyDown;
    property OnKeyUp;
    property OnKeyPress;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnResize;
    property OnStartDock;
    property OnStartDrag;
    property OnUnDock;
  end;

procedure Register;

implementation

uses
  GDIPOBJ;

procedure Register;
begin
  RegisterComponents('NS', [TJkhChartPanel]);
end;

{ TJkhChartValue }

constructor TJkhChartValue.Create(Collection: TCollection);
begin
  inherited;

  FFont := TFont.Create;

  CurrentPosition := Point(-1, -1);

  FPaintItemRange := 8;
  FPaintOutLineSize := 2;

  FColor := 4278190080;
  FOutlineColor := 4294967295;

  FXValue := 0;
  FYValue := 0;
end;

destructor TJkhChartValue.Destroy;
begin
  FFont.Free;
  
  inherited;
end;

function TJkhChartValue.GetDisplayName: string;
begin
  Result := FHint;
end;

procedure TJkhChartValue.SetFont(const Value: TFont);
begin
  FFont.Assign( Value );
end;

procedure TJkhChartValue.SetHint(const Value: String);
begin
  FHint := Value;
end;

procedure TJkhChartValue.SetPrintValue(const Value: Boolean);
begin
  FPrintValue := Value;
end;

procedure TJkhChartValue.SetPrintValueAlign(
  const Value: TJkhChartItemAlignPosition);
begin
  FPrintValueAlign := Value;
end;

procedure TJkhChartValue.SetXValue(const Value: Integer);
begin
  FXValue := Value;
end;

procedure TJkhChartValue.SetYValue(const Value: Integer);
begin
  FYValue := Value;
end;

{ TJkhChartValueList }

constructor TJkhChartValueList.Create;
begin
  inherited Create(TJkhChartValue);
end;

destructor TJkhChartValueList.Destroy;
begin
  inherited
end;

function TJkhChartValueList.GetOwner: TPersistent;
begin
  Result := FCollectionOwner; 
end;

{ TJkhChartItem }

constructor TJkhChartItem.Create(Collection: TCollection);
begin
  inherited;

  FItemName := '';
  FItemIcon := TPicture.Create;

  FItemValues := TJkhChartValueList.Create;
  FItemValues.CollectionOwner := Self;

  FValueDrawType := cvdNone; 
end;

destructor TJkhChartItem.Destroy;
begin
  FItemIcon.Free;

  FItemValues.Free;

  inherited;
end;

function TJkhChartItem.GetDisplayName: string;
begin
  Result := FItemName;
end;

procedure TJkhChartItem.SetItemIcon(const Value: TPicture);
begin
  FItemIcon.Assign( Value );
end;

procedure TJkhChartItem.SetItemName(const Value: String);
begin
  FItemName := Value;
end;

procedure TJkhChartItem.SetItemValues(const Value: TJkhChartValueList);
begin
  FItemValues.Assign( Value );
end;

procedure TJkhChartItem.SetValueDrawColor(const Value: DWORD);
begin
  FValueDrawColor := Value;
end;

procedure TJkhChartItem.SetValueDrawLineSize(const Value: Integer);
begin
  FValueDrawLineSize := Value;
end;

procedure TJkhChartItem.SetValueDrawType(
  const Value: TJkhChartValueDrawType);
begin
  FValueDrawType := Value;
end;

{ TJkhChartItemList }

constructor TJkhChartItemList.Create;
begin
  inherited Create(TJkhChartItem);
end;

destructor TJkhChartItemList.Destroy;
begin
  inherited;
end;

function TJkhChartItemList.GetOwner: TPersistent;
begin
  Result := FCollectionOwner;
end;

{ TJkhChartEnvItem }

constructor TJkhChartEnvItem.Create(Collection: TCollection);
begin
  inherited;

  FFont := TFont.Create;
  FColor := clSilver;
end;

destructor TJkhChartEnvItem.Destroy;
begin
  FFont.Free;

  inherited;
end;

function TJkhChartEnvItem.GetDisplayName: string;
begin
  Result := FItemName
end;

procedure TJkhChartEnvItem.SetColor(const Value: TColor);
begin
  FColor := Value;
end;

procedure TJkhChartEnvItem.SetDirection(
  const Value: TJkhChartEnvFlowDirection);
begin
  FDirection := Value;
end;

procedure TJkhChartEnvItem.SetDivByType(const Value: TJkhChartEnvDivType);
begin
  FDivByType := Value;
end;

procedure TJkhChartEnvItem.SetDivByValue(const Value: Integer);
begin
  FDivByValue := Value;
end;

procedure TJkhChartEnvItem.SetEnvType(const Value: TJkhChartEnvType);
begin
  FEnvType := Value;
end;

procedure TJkhChartEnvItem.SetFont(const Value: TFont);
begin
  FFont.Assign( Value );
end;

procedure TJkhChartEnvItem.SetItemName(const Value: String);
begin
  FItemName := Value;
end;

procedure TJkhChartEnvItem.SetMargin(const Value: Integer);
begin
  FMargin := Value;
end;

procedure TJkhChartEnvItem.SetMaxValue(const Value: Integer);
begin
  FMaxValue := Value;
end;

procedure TJkhChartEnvItem.SetMinValue(const Value: Integer);
begin
  FMinValue := Value;
end;

procedure TJkhChartEnvItem.SetPrintValue(const Value: Boolean);
begin
  FPrintValue := Value;
end;

procedure TJkhChartEnvItem.SetPrintValueAlign(
  const Value: TJkhChartItemAlignPosition);
begin
  FPrintValueAlign := Value;
end;

{ TJkhChartEnvItemList }

constructor TJkhChartEnvItemList.Create;
begin
  inherited Create(TJkhChartEnvItem);
end;

destructor TJkhChartEnvItemList.Destroy;
begin
  inherited;
end;

function TJkhChartEnvItemList.GetOwner: TPersistent;
begin
  Result := FCollectionOwner;
end;

{ TJkhChartPanel }

constructor TJkhChartPanel.Create(AOwner: TComponent);
begin
  inherited;

  FChartItem := TJkhChartItemList.Create;
  FChartItem.CollectionOwner := Self;
  FChartEnvItem := TJkhChartEnvItemList.Create;
  FChartEnvItem.CollectionOwner := Self;

  FDrawLegend := False;
  FLegendSize := 50;
  FLegendFont := TFont.Create;
end;

destructor TJkhChartPanel.Destroy;
begin
  FChartItem.Free;
  FChartEnvItem.Free;

  FLegendFont.Free;

  inherited;
end;

procedure TJkhChartPanel.DrawBackgroud(ALeft, ATop, ARight,
  ABottom: Integer);
var
  LoopVar: Integer;
  CurrentValue: Extended;
  DrawStep,
  DrawLoop: Integer;
  StartPt, EndPt: Integer;
  PrintText: String;
  DrawRect: TRect;
  TextSize: TSize;
begin
  For LoopVar := 0 to FChartEnvItem.Count-1 do
  Begin
     With FChartEnvItem.Items[LoopVar] as TJkhChartEnvItem do
     Begin
        // (FChartEnvItem.Items[LoopVar] as TJkhChartEnvItem)
        Case FEnvType of
           // 현재는 그리드 밖에 없다.
           cetGrid:
           Begin
              If Direction = cedVertial Then
              Begin
                 StartPt := ALeft + Margin;
                 EndPt := ARight - Margin;
              End
              Else
              Begin
                 StartPt := ATop + Margin;
                 EndPt := ABottom - Margin;
              End;

              // 쪼개는 방식이 거리에 따른건지, 아니면 갯수로 쪼갠건지
              Case FDivByType of
                 cedDistance:
                 Begin
                    DrawLoop := StartPt;
                    DrawStep := FDivByValue;
                 End;
                 cedCount:
                 Begin
                    DrawLoop := StartPt;
                    DrawStep := (EndPt - StartPt) div FDivByValue;
                 End;
              End;

              Canvas.Pen.Color := Color;
              Canvas.Font.Assign(Font);

              // 다음엔 Step 으로 만든걸로 실제로 그리면 끝. 다만 스탭이 0보단 절대 작을수 없다
              // 또 Start 가 End보다 작을수도 없다.
              If (DrawStep > 0) and (StartPt < EndPt) Then
                 While DrawLoop <= EndPt do
                 Begin
                    If Direction = cedVertial Then
                       DrawRect := Rect(DrawLoop, ATop, DrawLoop+1, ABottom)
                    Else
                       DrawRect := Rect(ALeft, DrawLoop, ARight, DrawLoop+1);

                    // 그린다.
                    Canvas.Rectangle(DrawRect);
                    // Canvas.MoveTo(DrawRect.Left, DrawRect.Top);
                    // Canvas.LineTo(DrawRect.Right, DrawRect.Bottom);

                    // 다음으로 텍스트를 그린다.
                    If PrintValue Then
                    Begin
                       // EndPt - StartPt : DrawLoop = MaxValue - MinValue : X
                       // DrawLoop 는 반드시 0보단 크니깐 안전.
                       CurrentValue := -1;
                       If (EndPt - StartPt) <= 0 Then
                          PrintText := ''
                       Else
                       Begin
                          CurrentValue := ((((MaxValue-MinValue)*(DrawLoop-StartPt))/(EndPt-StartPt))+MinValue);
                          PrintText := FloatToStr( Round(CurrentValue*10) / 10 );
                       End;
                       // PrintText := IntToStr( Round( (MaxValue - MinValue) * ((EndPt - StartPt) / DrawLoop) ) );

                       // 값 바꾸기 모드가 선언되어 있으면 호출된다.
                       If Assigned(OnValueToText) Then
                          FOnValueToText(Self, Round(CurrentValue), PrintText);
                       TextSize := Canvas.TextExtent(PrintText);

                       Case PrintValueAlignPos of
                          ciapLeftTop:
                             Canvas.TextOut(DrawRect.Left, DrawRect.Top, PrintText);
                          ciapCenterTop:
                             Canvas.TextOut(DrawRect.Left+((DrawRect.Right-DrawRect.Left) div 2)-(TextSize.cx div 2), DrawRect.Top, PrintText);
                          ciapRightTop:
                             Canvas.TextOut(DrawRect.Right-TextSize.cx, DrawRect.Top, PrintText);

                          ciapLeftCenter:
                             Canvas.TextOut(DrawRect.Left, DrawRect.Top+((DrawRect.Bottom-DrawRect.Top) div 2)-(TextSize.cy div 2), PrintText);
                          ciapCenter:
                             Canvas.TextOut(DrawRect.Left+((DrawRect.Right-DrawRect.Left) div 2)-(TextSize.cx div 2), DrawRect.Top+((DrawRect.Bottom-DrawRect.Top) div 2)-(TextSize.cy div 2), PrintText);
                          ciapRightCenter:
                             Canvas.TextOut(DrawRect.Right-TextSize.cx, DrawRect.Top+((DrawRect.Bottom-DrawRect.Top) div 2)-(TextSize.cy div 2), PrintText);

                          ciapLeftBottom:
                             Canvas.TextOut(DrawRect.Left, DrawRect.Bottom-TextSize.cy, PrintText);
                          ciapCenterBottom:
                             Canvas.TextOut(DrawRect.Left+((DrawRect.Right-DrawRect.Left) div 2)-(TextSize.cx div 2), DrawRect.Bottom-TextSize.cy, PrintText);
                          ciapRightBottom:
                             Canvas.TextOut(DrawRect.Right-TextSize.cx, DrawRect.Bottom-TextSize.cy, PrintText);
                       End;
                    End;

                    DrawLoop := DrawLoop + DrawStep;
                 End;

           End;
        End;
     End;
  End;
end;

procedure TJkhChartPanel.DrawLegend(ALeft, ATop, ARight, ABottom: Integer);
const
  IconDrawMargin = 4;
var
  ItemLoop: Integer;
  UseWidth: Integer;
  ItemWidth: Integer;
  IconSize: Integer;
  LeftStart: Integer;
  DestRect,
  ItemRect: TRect;
  TextSize: TSize;
  DrawX, DrawY: Integer;
begin
  UseWidth := Round((ARight - ALeft) * 0.8);
  ItemWidth := UseWidth div FChartItem.Count;
  IconSize := Round(LegendSize * 0.8);

  LeftStart := ALeft + Round( (ARight - ALeft) * 0.1 );
  Canvas.Font.Assign(FLegendFont);

  For ItemLoop := 0 to FChartItem.Count -1 do
  Begin
     // 먼저 아이콘을 그리고
     // 설명을 그린다.
     With (FChartItem.Items[ItemLoop] as TJkhChartItem) do
     Begin
        ItemRect := Rect(LeftStart, ATop, LeftStart+ItemWidth, ABottom);

        // DrawIcon
        DrawX := ItemRect.Left;
        DrawY := ItemRect.Bottom-ItemRect.Top-(IconDrawMargin*2);
        If Assigned(ItemIcon) Then
        Begin
           DestRect := Rect(DrawX+IconDrawMargin, ItemRect.Top+IconDrawMargin, DrawX+IconDrawMargin+DrawY, ItemRect.Top+IconDrawMargin+DrawY);
           Canvas.StretchDraw(DestRect, ItemIcon.Graphic);

           DrawX := DrawX + DrawY + IconDrawMargin;
        End;

        // DrawText
        TextSize := Canvas.TextExtent(FItemName);
        DrawY := ((ItemRect.Bottom-ItemRect.Top) div 2) - (TextSize.cy Div 2);
        Canvas.TextRect(ItemRect, DrawX, DrawY, FItemName);

        LeftStart := LeftStart + ItemWidth;
     End;
  End;
end;

procedure TJkhChartPanel.DrawValues(ALeft, ATop, ARight, ABottom: Integer);
var
  ItemLoop: Integer;
  ItemValueLoop: Integer;
  DrawRect: TRect;
  TextSize: TSize;
  PrevValueObject: TJkhChartValue;
  ValueText: String;

  GDI_Graphics: TGPGraphics;
  GDI_DrawRect: TGPRect;
  GDI_LineCrossPen: TGPPen;
  GDI_DrawItemPen: TGPPen;
  GDI_DrawItemBrush: TGPBrush;

  function ValueToPosition(AValue: Integer; AValueDirection: TJkhChartEnvFlowDirection): Integer;
  var
    LoopVar: Integer;
    StartPt, EndPt: Integer;
  begin
    Result := -1;

    For LoopVar := 0 to ChartEnvItem.Count-1 do
       With ChartEnvItem.Items[LoopVar] as TJkhChartEnvItem do
       Begin
          If FDirection <> AValueDirection Then Continue;

          // Found.
          Case FEnvType of
             cetGrid:
             Begin
                If Direction = cedVertial Then
                Begin
                   StartPt := ALeft + Margin;
                   EndPt := ARight - Margin;
                End
                Else
                Begin
                   StartPt := ATop + Margin;
                   EndPt := ABottom - Margin;
                End;

                // 본격 계산
                // EndPt - StartPt : X = MaxValue - MinValue : AValue
                If MaxValue - MinValue <> 0 Then
                   Result := Round( ( (EndPt - StartPt) * (AValue - MinValue) ) / (MaxValue - MinValue) ) + StartPt;

             End;
          End;

          Exit;
       End;
  end;
begin
  GDI_Graphics := TGPGraphics.Create(Canvas.Handle);
  Try
     GDI_Graphics.SetSmoothingMode(SmoothingModeAntiAlias);

     // Value는 Background 를 참조해서 그려진다.
     // 일단 존재하는 각 항목을 그리고
     For ItemLoop := 0 to FChartItem.Count -1 do
     Begin
        With FChartItem.Items[ItemLoop] as TJkhChartItem do
        Begin
           For ItemValueLoop := 0 to ItemValues.Count -1 do
           Begin
              // 먼저 계산을 한다.
              With ItemValues.Items[ItemValueLoop] as TJkhChartValue do
              Begin
                 CurrentPosition := Point(
                       ValueToPosition(XValue, cedVertial), ValueToPosition(YValue, cedHorizontal)
                    );
                 // Canvas.Font.Assign(FFont);
                 // Canvas.TextOut(CurrentPosition.X, CurrentPosition.Y, IntToStr(XValue) + ' / ' + IntToStr(YValue));
              End;
           End;

           //( FChartItem.Items[ItemLoop] as TJkhChartItem ).FValueDrawType

           Case FValueDrawType of
              cvdLinkedLine:
              Begin
                 GDI_LineCrossPen := TGPPen.Create(FValueDrawColor, FValueDrawLineSize);
                 Try
                    // 다음으로 계산된 좌표를 연결한다.
                    For ItemValueLoop := 1 to ItemValues.Count -1 do
                    Begin
                       // 먼저 계산을 한다.
                       With ItemValues.Items[ItemValueLoop] as TJkhChartValue do
                       Begin
                          PrevValueObject := (ItemValues.Items[ItemValueLoop-1] as TJkhChartValue);
                          GDI_Graphics.DrawLine(GDI_LineCrossPen, PrevValueObject.CurrentPosition.X, PrevValueObject.CurrentPosition.Y, CurrentPosition.X, CurrentPosition.Y);

                          // Canvas.Font.Assign(FFont);
                          // Canvas.TextOut(CurrentPosition.X, CurrentPosition.Y, IntToStr(XValue) + ' / ' + IntToStr(YValue));
                       End;
                    End;
                 Finally
                    GDI_LineCrossPen.Free;
                 End;
              End;
           End;

           For ItemValueLoop := 0 to ItemValues.Count - 1 do
              With ItemValues.Items[ItemValueLoop] as TJkhChartValue do
              Begin
                 GDI_DrawItemPen := TGPPen.Create(FOutlinecolor, FPaintOutLineSize);
                 GDI_DrawItemBrush := TGPSolidBrush.Create(FColor);
                 Try
                    GDI_DrawRect := MakeRect(CurrentPosition.X-(FPaintItemRange div 2)-1, CurrentPosition.Y-(FPaintItemRange div 2)-1, FPaintItemRange, FPaintItemRange);

                    GDI_Graphics.FillEllipse(GDI_DrawItemBrush, GDI_DrawRect);
                    GDI_Graphics.DrawEllipse(GDI_DrawItemPen, GDI_DrawRect);

                    If PrintValue Then
                    Begin
                       ValueText := Hint;

                       // 값 바꾸기 모드가 선언되어 있으면 호출된다.
                       If Assigned(OnValueToText) Then
                          FOnValueToText(Self, ItemValueLoop, ValueText);

                       Canvas.TextOut(CurrentPosition.X, CurrentPosition.Y+(FPaintItemRange div 2)+2, ValueText);
                    End;
                 Finally
                    GDI_DrawItemPen.Free;
                    GDI_DrawItemBrush.Free;
                 End;
              End;
        End;
     End;
  Finally
     GDI_Graphics.Free;
  End;
end;

procedure TJkhChartPanel.Paint;
var
  BackroundRect: TRect;
begin
  inherited;

  If FDrawLegend Then
     BackroundRect := Rect(1, LegendSize, Width-1, Height-1)
  Else
     BackroundRect := Rect(1, 1, Width-1, Height-1);

  // 먼저 바탕화면을 그리고.
  DrawBackgroud(BackroundRect.Left, BackroundRect.Top, BackroundRect.Right, BackroundRect.Bottom);
  // 다음으로 실제 값들을 그리고.
  DrawValues(BackroundRect.Left, BackroundRect.Top, BackroundRect.Right, BackroundRect.Bottom);
  // 마지막으로 범례를 켜놨으면 그린다. 이건 구현할지 말지 고민중..

  If FDrawLegend Then
  Begin
     BackroundRect := Rect(1, 1, Width-1, LegendSize-1);
     DrawLegend(BackroundRect.Left, BackroundRect.Top, BackroundRect.Right, BackroundRect.Bottom);
  End;
end;

procedure TJkhChartPanel.SetChartEnvItem(
  const Value: TJkhChartEnvItemList);
begin
  FChartEnvItem.Assign( Value );
end;

procedure TJkhChartPanel.SetChartItem(const Value: TJkhChartItemList);
begin
  FChartItem.Assign( Value );
end;

procedure TJkhChartPanel.SetDrawLegend(const Value: Boolean);
begin
  FDrawLegend := Value;
  Invalidate;
end;

procedure TJkhChartPanel.SetLegendFont(const Value: TFont);
begin
  FLegendFont.Assign( Value );
  Invalidate;
end;

procedure TJkhChartPanel.SetLegendSize(const Value: Integer);
begin
  FLegendSize := Value;
  Invalidate;
end;

end.
