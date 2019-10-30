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

unit JkhBevel;

interface

uses
  SysUtils, Classes,
  {$if CompilerVersion <= 15}
  Controls, ExtCtrls, Graphics, Types;
  {$elseif CompilerVersion > 16}
  Vcl.Controls, Vcl.ExtCtrls, Vcl.Graphics, System.Types;
  {$ifend}

type
  TJkhBevel = class(TGraphicControl)
  private
    FShape: TBevelShape;
    FSpan: Integer;
    procedure SetShape(Value: TBevelShape);
    procedure SetSpan(const Value: Integer);
  protected
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property Span: Integer read FSpan write SetSpan;
    property Color;
    property Align;
    property Anchors;
    property Constraints;
    property ParentShowHint;
    property Shape: TBevelShape read FShape write SetShape default bsBox;
    property ShowHint;
    property Visible;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('NS', [TJkhBevel]);
end;

{ TJkhBevel }

constructor TJkhBevel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csReplicatable];
  FShape := bsBox;
  Width := 50;
  Height := 50;
end;

procedure TJkhBevel.SetShape(Value: TBevelShape);
begin
  if Value <> FShape then
  begin
    FShape := Value;
    Invalidate;
  end;
end;

procedure TJkhBevel.Paint;
const
  XorColor = $00FFD8CE;
var
  Color1: TColor;
  Temp: TColor;

  procedure BevelRect(const R: TRect);
  begin
    with Canvas do
    begin
      Pen.Color := Color1;
      PolyLine([Point(R.Left, R.Bottom), Point(R.Left, R.Top),
        Point(R.Right, R.Top)]);
      PolyLine([Point(R.Right, R.Top), Point(R.Right, R.Bottom),
        Point(R.Left, R.Bottom)]);
    end;
  end;

  procedure BevelLine(C: TColor; X1, Y1, X2, Y2: Integer);
  begin
    with Canvas do
    begin
      Pen.Color := C;
      MoveTo(X1, Y1);
      LineTo(X2, Y2);
    end;
  end;

begin
  with Canvas do
  begin
    if (csDesigning in ComponentState) then
    begin
      if (FShape = bsSpacer) then
      begin
        Pen.Style := psSolid;
        //Pen.Mode := pmXor;
        Pen.Color := Color;
        Brush.Style := bsSolid;
        Brush.Color := Color;
        Rectangle(0, 0, ClientWidth, ClientHeight);
        Exit;
      end
      else
      begin
        Pen.Style := psSolid;
        Pen.Mode  := pmCopy;
        Pen.Color := clBlack;
        Brush.Style := bsSolid;
      end;
    end;

    Pen.Width := 1;
    Color1 := Color;

    case FShape of
      bsBox: BevelRect(Rect(0, 0, Width - 1, Height - 1));
      bsSpacer:
        begin
          Brush.Color := Color;
          Rectangle(0, 0, ClientWidth, ClientHeight);
        end;
      bsFrame:
        begin
          Temp := Color1;
          BevelRect(Rect(1, 1, Width - 1, Height - 1));
          //BevelRect(Rect(0, 0, Width - 2, Height - 2));
        end;
      bsTopLine:
        begin
          BevelLine(Color1, Span, 0, Width-Span, 0);
          //BevelLine(Color1, 0, 1, Width, 1);
        end;
      bsBottomLine:
        begin
          BevelLine(Color1, Span, Height - 2, Width-Span, Height - 2);
          //BevelLine(Color1, 0, Height - 1, Width, Height - 1);
        end;
      bsLeftLine:
        begin
          BevelLine(Color1, Span, 0, Span, Height);
          //BevelLine(Color1, 1, 0, 1, Height);
        end;
      bsRightLine:
        begin
          BevelLine(Color1, Width - 2+Span, 0, Width - 2+Span, Height);
          //BevelLine(Color1, Width - 1, 0, Width - 1, Height);
        end;
    end;
  end;
end;

procedure TJkhBevel.SetSpan(const Value: Integer);
begin
  FSpan := Value;
  Invalidate;
end;

end.
