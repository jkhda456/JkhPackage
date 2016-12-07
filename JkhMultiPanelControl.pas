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

unit JkhMultiPanelControl;

interface

uses
  Messages, SysUtils, Classes, Controls, Graphics;

type
  TJkhMultiPanelControl = class(TCustomControl)
  private
    FCaption: TCaption;
    FBackgroundColor: TColor;
    FBorderColor: TColor;
    FCaptionLeft: Integer;
    FCaptionTop: Integer;
    FOnMouseLeave: TNotifyEvent;
    FOnMouseEnter: TNotifyEvent;
    FCaptionVisible: Boolean;

    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;

    procedure SetBackgroundColor(const Value: TColor);
    procedure SetBorderColor(const Value: TColor);
    procedure SetCaption(const Value: TCaption);
    procedure SetCaptionLeft(const Value: Integer);
    procedure SetCaptionTop(const Value: Integer);
    procedure SetCaptionVisible(const Value: Boolean);
  protected
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property BorderColor: TColor read FBorderColor write SetBorderColor;
    property BackgroundColor: TColor read FBackgroundColor write SetBackgroundColor;

    property CaptionLeft: Integer read FCaptionLeft write SetCaptionLeft;
    property CaptionTop: Integer read FCaptionTop write SetCaptionTop;
    property Caption: TCaption read FCaption write SetCaption;
    property CaptionVisible: Boolean read FCaptionVisible write SetCaptionVisible;

    property Align;
    property Anchors;
    property Visible;
    property Font;
    property ParentFont;

    property OnMouseEnter: TNotifyEvent read FOnMouseEnter write FOnMouseEnter;
    property OnMouseLeave: TNotifyEvent read FOnMouseLeave write FOnMouseLeave;

    property OnClick;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('NS', [TJkhMultiPanelControl]);
end;

{ TJkhMultiPanelControl }

procedure TJkhMultiPanelControl.CMMouseEnter(var Message: TMessage);
begin
  If Assigned(FOnMouseEnter) Then FOnMouseEnter(Self);
end;

procedure TJkhMultiPanelControl.CMMouseLeave(var Message: TMessage);
begin
  If Assigned(FOnMouseLeave) Then FOnMouseLeave(Self);
end;

constructor TJkhMultiPanelControl.Create(AOwner: TComponent);
begin
  inherited;

  FBorderColor := clSilver;
  FBackgroundColor := clWhite;
  FCaption := '';
  FCaptionLeft := 0;
  FCaptionTop := 0;
end;

destructor TJkhMultiPanelControl.Destroy;
begin

  inherited;
end;

procedure TJkhMultiPanelControl.Paint;
begin
  // Canvas.TextOut(1, 1, 'hihi');
  inherited;

  Canvas.Brush.Color := FBackgroundColor;
  Canvas.Pen.Color := FBorderColor;
  Canvas.Rectangle(Rect(0, 0, Width, Height));
  // Canvas.FillRect(Rect(1, 1, Width, Height));

  If FCaptionVisible Then
  Begin
     Canvas.Font.Assign( Font );
     Canvas.TextRect(Rect(1, 1, Width-1, Height-1), CaptionLeft, CaptionTop, Caption);
  End;
end;

procedure TJkhMultiPanelControl.SetBackgroundColor(const Value: TColor);
begin
  FBackgroundColor := Value;
  Invalidate;
end;

procedure TJkhMultiPanelControl.SetBorderColor(const Value: TColor);
begin
  FBorderColor := Value;
  Invalidate;
end;

procedure TJkhMultiPanelControl.SetCaption(const Value: TCaption);
begin
  FCaption := Value;
  Invalidate;
end;

procedure TJkhMultiPanelControl.SetCaptionLeft(const Value: Integer);
begin
  FCaptionLeft := Value;
  Invalidate;
end;

procedure TJkhMultiPanelControl.SetCaptionTop(const Value: Integer);
begin
  FCaptionTop := Value;
  Invalidate;
end;

procedure TJkhMultiPanelControl.SetCaptionVisible(const Value: Boolean);
begin
  FCaptionVisible := Value;
  Invalidate;
end;

end.
