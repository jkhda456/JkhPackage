unit JkhBevel;

interface

uses
  SysUtils, Classes, Controls, ExtCtrls, Graphics, Types;

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
