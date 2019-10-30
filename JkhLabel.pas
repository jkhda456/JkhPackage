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

unit JkhLabel;

interface

uses
  Windows, SysUtils, Classes,
  {$if CompilerVersion <= 15}
  Controls, StdCtrls, Types, Graphics;
  {$elseif CompilerVersion > 16}
  Vcl.Controls, Vcl.StdCtrls, Vcl.Graphics, System.Types;
  {$ifend}

type
  TJkhFontWeight = (fwDONTCARE, fwTHIN, fwEXTRALIGHT, fwLIGHT, fwNORMAL,
                    fwMEDIUM, fwSEMIBOLD, fwBOLD, fwEXTRABOLD, fwHEAVY);

  TJkhLabel = class(TCustomLabel)
  private
    FFontWeightValue: Integer;
    FFontSize: Integer;
    FFontFace: String;
    FFontColor: TColor;
    FScreenLogPixels: Integer;
    FFontWeight: TJkhFontWeight;
    procedure SetFontColor(const Value: TColor);
    procedure SetFontFace(const Value: String);
    procedure SetFontSize(const Value: Integer);
    procedure SetFontWeight(const Value: TJkhFontWeight);
    { Private declarations }
  protected
    procedure DoDrawText(var Rect: TRect; Flags: Longint); override;
    procedure AdjustBounds; override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property FontSize: Integer read FFontSize write SetFontSize;
    property FontWeight: TJkhFontWeight read FFontWeight write SetFontWeight;
    property FontFace: string read FFontFace write SetFontFace;
    property FontColor: TColor read FFontColor write SetFontColor;

    property Align;
    property Alignment;
    property Anchors;
    property AutoSize;
    property BiDiMode;
    property Caption;
    property Color nodefault;
    property Constraints;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property FocusControl;
    property Font;
    property ParentBiDiMode;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowAccelChar;
    property ShowHint;
    property Transparent;
    property Layout;
    property Visible;
    property WordWrap;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnStartDock;
    property OnStartDrag;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('NS', [TJkhLabel]);
end;

{ TJkhLabel }

procedure TJkhLabel.AdjustBounds;
const
  WordWraps: array[Boolean] of Word = (0, DT_WORDBREAK);
var
  DC: HDC;
  X: Integer;
  Rect: TRect;
  AAlignment: TAlignment;
begin
  if not (csReading in ComponentState) and AutoSize then
  begin
    Rect := ClientRect;
    DC := GetDC(0);
    Canvas.Handle := DC;
    DoDrawText(Rect, (DT_EXPANDTABS or DT_CALCRECT) or WordWraps[WordWrap]);
    Canvas.Handle := 0;
    ReleaseDC(0, DC);
    X := Left;
    AAlignment := Alignment;
    if UseRightToLeftAlignment then ChangeBiDiModeAlignment(AAlignment);
    if AAlignment = taRightJustify then Inc(X, Width - Rect.Right);
    SetBounds(X, Top, Rect.Right, Rect.Bottom+2);
  end;
end;

constructor TJkhLabel.Create(AOwner: TComponent);
var
  DC: HDC;
begin
  inherited;

  DC := GetDC(0);
  FScreenLogPixels := GetDeviceCaps(DC, LOGPIXELSY);
  ReleaseDC(0,DC);

  FFontWeight := fwNORMAL;
  FFontSize := 8;
  FFontFace := 'Gulim';
  FFontColor := clBlack;
end;

procedure TJkhLabel.DoDrawText(var Rect: TRect; Flags: Integer);
var
  Text: string;
  lf: LOGFONT;
begin
  Text := GetLabelText;
  if (Flags and DT_CALCRECT <> 0) and ((Text = '') or ShowAccelChar and
    (Text[1] = '&') and (Text[2] = #0)) then Text := Text + ' ';
  if not ShowAccelChar then Flags := Flags or DT_NOPREFIX;
  Flags := DrawTextBiDiModeFlags(Flags);
  //Canvas.Font := Font;

  FillChar(lf, SizeOf(lf), Byte(0));
  lf.lfHeight := -MulDiv(FFontSize, FScreenLogPixels, 72);
  lf.lfWidth := 0;
  lf.lfWeight := FFontWeightValue;
  lf.lfQuality := ANTIALIASED_QUALITY;
  lf.lfCharSet := HANGEUL_CHARSET;
  StrCopy(lf.lfFaceName, PChar(FFontFace));
  Canvas.Font.Handle := CreateFontIndirect(lf);
  Canvas.Font.Color := FFontColor;

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

procedure TJkhLabel.SetFontColor(const Value: TColor);
begin
  FFontColor := Value;
  Invalidate;
end;

procedure TJkhLabel.SetFontFace(const Value: String);
begin
  FFontFace := Value;
  AdjustBounds;
end;

procedure TJkhLabel.SetFontSize(const Value: Integer);
begin
  FFontSize := Value;
  AdjustBounds;
end;

procedure TJkhLabel.SetFontWeight(const Value: TJkhFontWeight);
begin
  If Value = FFontWeight Then Exit;

  FFontWeight := Value;
  Case Value of
     fwDONTCARE:   FFontWeightValue := FW_DONTCARE;
     fwTHIN:       FFontWeightValue := FW_THIN;
     fwEXTRALIGHT: FFontWeightValue := FW_EXTRALIGHT;
     fwLIGHT:      FFontWeightValue := FW_LIGHT;
     fwNORMAL:     FFontWeightValue := FW_NORMAL;
     fwMEDIUM:     FFontWeightValue := FW_MEDIUM;
     fwSEMIBOLD:   FFontWeightValue := FW_SEMIBOLD;
     fwBOLD:       FFontWeightValue := FW_BOLD;
     fwEXTRABOLD:  FFontWeightValue := FW_EXTRABOLD;
     fwHEAVY:      FFontWeightValue := FW_HEAVY;
  End;

  AdjustBounds;
  Repaint;
end;

end.
