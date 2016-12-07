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

unit JkhListBox;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, StdCtrls, Types,
  Graphics;

type
  TProcessStringEvent = procedure(var S: string) of object;

  TJkhListBox = class(TCustomListBox)
  private
    FOnParseDrawItem: TProcessStringEvent;
    FValueFont: TFont;
    FValueEditBox: TEdit;

    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;

    procedure CNMeasureItem(var Message: TWMMeasureItem); message CN_MEASUREITEM;
    procedure SetValueFont(const Value: TFont);
  protected
    procedure DrawItem(Index: Integer; Rect: TRect;
      State: TOwnerDrawState); override;
    procedure Click; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property ValueFont: TFont read FValueFont write SetValueFont;

    property Style;
    property AutoComplete;
    property Align;
    property Anchors;
    property BevelEdges;
    property BevelInner;
    property BevelKind default bkNone;
    property BevelOuter;
    property BiDiMode;
    property BorderStyle;
    property Color;
    property Columns;
    property Constraints;
    property Ctl3D;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property ExtendedSelect;
    property Font;
    property ImeMode;
    property ImeName;
    property IntegralHeight;
    property ItemHeight;
    property Items;
    property MultiSelect;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ScrollWidth;
    property ShowHint;
    property Sorted;
    property TabOrder;
    property TabStop;
    property TabWidth;
    property Visible;

    property OnParseDrawItem: TProcessStringEvent read FOnParseDrawItem write FOnParseDrawItem; 

    property OnClick;
    property OnContextPopup;
    property OnData;
    property OnDataFind;
    property OnDataObject;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnDrawItem;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMeasureItem;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDock;
    property OnStartDrag;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('NS', [TJkhListBox]);
end;

{ TJkhListBox }

procedure TJkhListBox.Click;
var
  WorkRect: TRect;
begin
  FValueEditBox.Visible := False;

  inherited;

  FValueEditBox.Parent := Self;
//  FValueEditBox.Visible := True;

  WorkRect := Self.ItemRect(ItemIndex);
  FValueEditBox.BoundsRect := WorkRect;

end;

procedure TJkhListBox.CNMeasureItem(var Message: TWMMeasureItem);
var
  ItemHeightValue: Integer;
begin
  ItemHeightValue := ItemHeight;
  with Message.MeasureItemStruct^ do
  begin
    itemHeight := Self.ItemHeight;
    MeasureItem(itemID, ItemHeightValue);
  end;
end;

constructor TJkhListBox.Create(AOwner: TComponent);
begin
  inherited;

  FValueEditBox := TEdit.Create(Self);
  FValueEditBox.Visible := False;
  FValueFont := TFont.Create;
end;

destructor TJkhListBox.Destroy;
begin
  FValueFont.Free;
  FValueEditBox.Free;

  inherited;
end;

procedure TJkhListBox.DrawItem(Index: Integer; Rect: TRect;
  State: TOwnerDrawState);
var
  ParsePoint: Integer;
  Flags: Longint;
  Data: String;
  Title, Value: String;
  Checked1, Checked2: Boolean;
begin
  if Assigned(OnDrawItem) then
    OnDrawItem(Self, Index, Rect, State)
  else
  begin
    Canvas.FillRect(Rect);
    if Index < Count then
    begin
      Flags := DrawTextBiDiModeFlags(DT_SINGLELINE or DT_VCENTER or DT_NOPREFIX);
      if not UseRightToLeftAlignment then
        Inc(Rect.Left, 2)
      else
        Dec(Rect.Right, 2);
      Data := '';
      if (Style in [lbVirtual, lbVirtualOwnerDraw]) then
        Data := DoGetData(Index)
      else
        Data := Items[Index];

      If Assigned(FOnParseDrawItem) Then
         FOnParseDrawItem(Data);

      Title := Data;
      Value := Data;

      // Rect.Top := Rect.Top - 12;
      //DrawText(Canvas.Handle, PChar(Title), Length(Title), Rect, Flags);
      Canvas.Font.Style := Canvas.Font.Style + [fsBold];
      Canvas.TextRect(Rect, 0, Rect.Top, Title);
      Canvas.Font.Style := Canvas.Font.Style - [fsBold];
      Canvas.TextOut(0, Rect.Top + Canvas.TextHeight(Name), Value);

      {
      ParsePoint := Pos('=', Data);
      If ParsePoint > 0 Then
      Begin
         Name := Copy(Data, 1, ParsePoint-1);
         Value := Copy(Data, ParsePoint+1, Length(Data)-ParsePoint);

         Canvas.Brush.Style := bsClear;
         Rect.Top := Rect.Top + Canvas.TextHeight(Name) + 10;
         DrawText(Canvas.Handle, PChar(Value), Length(Value), Rect, Flags);
      End
      Else
      Begin
         DrawText(Canvas.Handle, PChar(Data), Length(Data), Rect, Flags);
      End;
      }
    end;
  end;
end;

procedure TJkhListBox.SetValueFont(const Value: TFont);
begin
  FValueFont.Assign(Value);
end;

procedure TJkhListBox.WMPaint(var Message: TWMPaint);
begin
  Inherited;

  If FValueEditBox.Visible Then
     FValueEditBox.SetFocus;
end;

end.
