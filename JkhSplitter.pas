unit JkhSplitter;

interface

uses
  Windows, SysUtils, Classes, Controls, ExtCtrls, Graphics;

type
  TJkhSplitter = class(TSplitter)
  private
    FEndMargin: Integer;
    FStartMargin: Integer;
    FStartMarginColor: TColor;
    FEndMarginColor: TColor;
    procedure SetEndMargin(const Value: Integer);
    procedure SetStartMargin(const Value: Integer);
    procedure SetEndMarginColor(const Value: TColor);
    procedure SetStartMarginColor(const Value: TColor);
    { Private declarations }
  protected
    procedure Paint; override;
  public
    { Public declarations }
  published
    property StartMargin: Integer read FStartMargin write SetStartMargin;
    property EndMargin: Integer read FEndMargin write SetEndMargin;

    property StartMarginColor: TColor read FStartMarginColor write SetStartMarginColor;
    property EndMarginColor: TColor read FEndMarginColor write SetEndMarginColor;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('NS', [TJkhSplitter]);
end;

{ TJkhSplitter }

procedure TJkhSplitter.Paint;
const
  XorColor = $00FFD8CE;
var
  FrameBrush: HBRUSH;
  R: TRect;
begin
  R := ClientRect;
  Canvas.Brush.Color := Color;
  Canvas.FillRect(ClientRect);
  // 난 이건 지원안할거다.
  if Beveled then
  begin
    if Align in [alLeft, alRight] then
      InflateRect(R, -1, 2) else
      InflateRect(R, 2, -1);
    OffsetRect(R, 1, 1);
    FrameBrush := CreateSolidBrush(ColorToRGB(clBtnHighlight));
    FrameRect(Canvas.Handle, R, FrameBrush);
    DeleteObject(FrameBrush);
    OffsetRect(R, -2, -2);
    FrameBrush := CreateSolidBrush(ColorToRGB(clBtnShadow));
    FrameRect(Canvas.Handle, R, FrameBrush);
    DeleteObject(FrameBrush);
  end
  else
  begin
    case Align of
      alLeft,
      alRight:
        begin
          if StartMargin > 0 then
          begin
             R := ClientRect;
             R.Right := StartMargin;
             Canvas.Brush.Color := StartMarginColor;
             Canvas.FillRect(R);
          end;
          if EndMargin > 0 then
          begin
             R := ClientRect;
             R.Left := R.Right - EndMargin;
             Canvas.Brush.Color := EndMarginColor;
             Canvas.FillRect(R);
          end;
        end;
      alTop,
      alBottom:
        begin
          if StartMargin > 0 then
          begin
             R := ClientRect;
             R.Bottom := StartMargin;
             Canvas.Brush.Color := StartMarginColor;
             Canvas.FillRect(R);
          end;
          if EndMargin > 0 then
          begin
             R := ClientRect;
             R.Top := R.Bottom - EndMargin;
             Canvas.Brush.Color := EndMarginColor;
             Canvas.FillRect(R);
          end;
        end;
    end;
  end;

  if csDesigning in ComponentState then
    { Draw outline }
    with Canvas do
    begin
      Pen.Style := psDot;
      Pen.Mode := pmXor;
      Pen.Color := XorColor;
      Brush.Style := bsClear;
      Rectangle(0, 0, ClientWidth, ClientHeight);
    end;
  if Assigned(OnPaint) then OnPaint(Self);
end;

procedure TJkhSplitter.SetEndMargin(const Value: Integer);
begin
  If FEndMargin = Value Then Exit;
  FEndMargin := Value;

  Invalidate;
end;

procedure TJkhSplitter.SetEndMarginColor(const Value: TColor);
begin
  If FEndMarginColor = Value Then Exit;
  FEndMarginColor := Value;

  Invalidate;
end;

procedure TJkhSplitter.SetStartMargin(const Value: Integer);
begin
  If FStartMargin = Value Then Exit;
  FStartMargin := Value;

  Invalidate;
end;

procedure TJkhSplitter.SetStartMarginColor(const Value: TColor);
begin
  If FStartMarginColor = Value Then Exit;
  FStartMarginColor := Value;

  Invalidate;
end;

end.
