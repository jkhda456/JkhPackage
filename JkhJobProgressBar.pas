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

unit JkhJobProgressBar;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, Graphics, Types, PngImage;

type
  TJkhJobItem = class(TCollectionItem)
  private
    FJobName: String;
    FJobComment: String;
    FTimeValue: Longword;
    FItemIcon: TPicture;
    FJobData: String;
    FVisible: Boolean;
    
    procedure SetItemIcon(const Value: TPicture); // 이거 나중에 바꿔야 할지도 모름..
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;

    property JobName: String read FJobName write FJobName;
    property JobComment: String read FJobComment write FJobComment;
    property JobData: String read FJobData write FJobData;
    property TimeValue: Longword read FTimeValue write FTimeValue;
    property Visible: Boolean read FVisible write FVisible; 

    property ItemIcon: TPicture read FItemIcon write SetItemIcon;
  end;

  TJkhJobItemsList = class(TCollection)
  private
    FDesc: String;
    function GetItem(Index: Integer): TJkhJobItem;
    procedure SetItem(Index: Integer; const Value: TJkhJobItem);
  protected
  public
    constructor Create;

    function Add: TJkhJobItem;
    function Insert(Index: Integer): TJkhJobItem;

    function LoadFromFile(const AFileName: String): Integer;
    function SaveAsFile(const AFileName: String): Integer;

    // 기타 설명이나 자료를 담기위한 프로퍼티
    property Desc: String read FDesc write FDesc;

    property Items[Index: Integer]: TJkhJobItem read GetItem write SetItem;
  end;

  TJkhJobProgressBar = class(TCustomControl)
  private
    FMargin: Integer;
    FLineColor: TColor;
    FBottomSpace: Integer;
    FDefaultItemIcon: TPicture;
    FProgressItemIcon: TPicture;
    FJobItems: TJkhJobItemsList;
    FProgressIndex: Integer;
    FFinishedColor: TColor;
    FFinishedItemIcon: TPicture;
    FScreenLogPixels: Integer;
    FPopupXPt: Integer;
    FSkipPaintDuplicateItem: Boolean;

    procedure DoDrawText(var ARect: TRect; AText: String; AFontSize: Integer);

    procedure SetMargin(const Value: Integer);
    procedure SetLineColor(const Value: TColor);
    procedure SetBottomSpace(const Value: Integer);
    procedure SetDefaultItemIcon(const Value: TPicture);
    procedure SetProgressItemIcon(const Value: TPicture);
    procedure SetJobItems(const Value: TJkhJobItemsList);
    procedure SetProgressIndex(const Value: Integer);
    procedure SetFinishedColor(const Value: TColor);
    procedure SetFinishedItemIcon(const Value: TPicture);
    procedure SetSkipPaintDuplicateItem(const Value: Boolean);
  protected
    procedure Paint; override;
    procedure Resize; override;

    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Color;
    property Font;
    property ParentFont;
    property Anchors;
    property Align;
    property PopupMenu;

    property SkipPaintDuplicateItem: Boolean read FSkipPaintDuplicateItem write SetSkipPaintDuplicateItem;

    property Margin: Integer read FMargin write SetMargin;
    property BottomSpace: Integer read FBottomSpace write SetBottomSpace;
    property LineColor: TColor read FLineColor write SetLineColor;
    property FinishedColor: TColor read FFinishedColor write SetFinishedColor;
    property DefaultItemIcon: TPicture read FDefaultItemIcon write SetDefaultItemIcon;
    property FinishedItemIcon: TPicture read FFinishedItemIcon write SetFinishedItemIcon;
    property ProgressItemIcon: TPicture read FProgressItemIcon write SetProgressItemIcon;

    // 진행상태를 표시합니다.
    property ProgressIndex: Integer read FProgressIndex write SetProgressIndex;

    property JobItems: TJkhJobItemsList read FJobItems write SetJobItems;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('NS', [TJkhJobProgressBar]);
end;

{ TJkhJobItem }

constructor TJkhJobItem.Create(Collection: TCollection);
begin
  inherited;

  FVisible := True;  
  FItemIcon := TPicture.Create;
end;

destructor TJkhJobItem.Destroy;
begin
  FItemIcon.Free;

  inherited;
end;

procedure TJkhJobItem.SetItemIcon(const Value: TPicture);
begin
  FItemIcon.Assign( Value );
end;

{ TJkhJobItemsList }

function TJkhJobItemsList.Add: TJkhJobItem;
begin
  Result := (Inherited Add) as TJkhJobItem;
end;

constructor TJkhJobItemsList.Create;
begin
  Inherited Create(TJkhJobItem);
  FDesc := '';
end;

function TJkhJobItemsList.GetItem(Index: Integer): TJkhJobItem;
begin
  Result := (Inherited GetItem(Index)) as TJkhJobItem;
end;

function TJkhJobItemsList.Insert(Index: Integer): TJkhJobItem;
begin
  Result := (Inherited Insert(Index)) as TJkhJobItem;
end;

function TJkhJobItemsList.LoadFromFile(const AFileName: String): Integer;
var
  LoopVar: Integer;
  ItemCount: Integer;
  SubValue: Integer;

  LName, LValue: String;
  Reader: TFileStream;
  EndFlag: Boolean;

  procedure ReadValue(var AName, AValue: String);
  var
    SizeVar: Longword;
  begin
    If EndFlag Then Exit;

    Reader.Read(SizeVar, 4);
    SetLength(AName, SizeVar);
    Reader.Read(AName[1], SizeVar);

    Reader.Read(SizeVar, 4);
    SetLength(AValue, SizeVar);
    Reader.Read(AValue[1], SizeVar);

    If Reader.Position >= Reader.Size Then
       EndFlag := True;
  end;
begin
  EndFlag := False;
  If Not FileExists(AFileName) Then Exit; 

  Reader := TFileStream.Create(AFileName, fmOpenRead or fmShareDenyNone);
  Try
     Reader.Position := 0;

     ReadValue(LName, LValue);
     If (LName <> 'VER') or (LValue <> 'JobR1') Then Exit;

     If EndFlag Then Exit;

     While Not EndFlag do
     Begin
        ReadValue(LName, LValue);
        TryStrToInt(LValue, ItemCount);
        
        If (LName = 'OBJ') and (LValue <> '') Then
           With Add do
           Begin
              For LoopVar := 1 to ItemCount do
              Begin
                 If EndFlag Then Exit;

                 ReadValue(LName, LValue);
                 If LName = 'JobName' Then
                    JobName := LValue
                 Else If LName = 'JobComment' Then
                    JobComment := LValue
                 Else If LName = 'JobData' Then
                    JobData := LValue
                 Else If LName = 'TimeValue' Then
                 Begin
                    TryStrToInt(LValue, SubValue);
                    TimeValue := SubValue;
                 End;
              End;
           End
        Else If (LName = 'INF') Then
           Desc := LValue;
     End;

  Finally
     Reader.Free;
  End;
end;

function TJkhJobItemsList.SaveAsFile(const AFileName: String): Integer;
var
  LoopVar: Integer;
  SizeVar: Longword;
  Writer: TFileStream;

  procedure WriteValue(AName, AValue: String);
  var
    SizeVar: Longword;
  begin
    SizeVar := Length(AName);
    Writer.Write(SizeVar, 4);
    Writer.Write(AName[1], SizeVar);

    SizeVar := Length(AValue);
    Writer.Write(SizeVar, 4);
    Writer.Write(AValue[1], SizeVar);
  end;
begin
  Writer := TFileStream.Create(AFileName, fmCreate);
  Try
     WriteValue('VER', 'JobR1');

     WriteValue('INF', Desc);

     // Writer
     For LoopVar := 0 to Count-1 do
     Begin
        //
        WriteValue('OBJ', '4'); // 하위 프로퍼티의 갯수를 써놓아야 한다.
        With Items[LoopVar] Do
        Begin
           WriteValue('JobName', JobName);
           WriteValue('JobComment', JobComment);
           WriteValue('JobData', JobData);
           WriteValue('TimeValue', IntToStr(TimeValue));
        End;
     End;
  Finally
     Writer.Free;
  End;
end;

procedure TJkhJobItemsList.SetItem(Index: Integer;
  const Value: TJkhJobItem);
begin
  Inherited SetItem(Index, Value);
end;

{ TJkhJobProgressBar }

constructor TJkhJobProgressBar.Create(AOwner: TComponent);
var
  DC: HDC;
begin
  inherited;

  FLineColor := $00ababab;
  FFinishedColor := $00CC6B45;
  FMargin := 10;
  FBottomSpace := 10;

  FDefaultItemIcon := TPicture.Create;
  FFinishedItemIcon := TPicture.Create;
  FProgressItemIcon := TPicture.Create;

  FJobItems := TJkhJobItemsList.Create;

  DC := GetDC(0);
  FScreenLogPixels := GetDeviceCaps(DC, LOGPIXELSY);
  ReleaseDC(0,DC);

  Self.DoubleBuffered := True;
end;

destructor TJkhJobProgressBar.Destroy;
begin
  FDefaultItemIcon.Free;
  FFinishedItemIcon.Free;
  FProgressItemIcon.Free;

  FJobItems.Free;
  
  inherited;
end;

procedure TJkhJobProgressBar.Paint;
var
  BottomPt: Integer;
  CurrentSelectedPt,
  DrawRect: TRect;
  SizeCalHarp: Integer;

  LoopVar: Integer;

  MaxTime: Longword;
  StartX, EndX, FullWidth: Integer;
  DrawPtX: Integer;
  DrawObj: TGraphic;
  TextDrawedX: Integer;
  DrawFontHeight, DrawFontWidth, DrawFontWidthHarf: Integer;

  PrevCaption: String;
begin
  inherited;

  TextDrawedX := 0;
  // Canvas.TextOut(1, 1, ' test ');
  BottomPt := Height-FMargin-FBottomSpace;
  StartX := 1+FMargin;
  EndX := Width-FMargin;
  FullWidth := EndX - StartX;
  TextDrawedX := 0;

  Canvas.Font.Assign(Font);
  DrawFontHeight := Canvas.TextHeight('a가');

  Canvas.Pen.Color := FLineColor;
  Canvas.MoveTo(StartX, BottomPt);
  Canvas.LineTo(EndX, BottomPt);
  Canvas.MoveTo(StartX, BottomPt-3);
  Canvas.LineTo(StartX, BottomPt+4);
  Canvas.MoveTo(EndX, BottomPt-3);
  Canvas.LineTo(EndX, BottomPt+4);

  MaxTime := 0;
  If JobItems.Count > 0 Then
     MaxTime := JobItems.Items[JobItems.Count-1].TimeValue;

  // FullWidth : MaxTime = X : Time
  // (FullWidth * Time) / MaxTime
  // 시간이 이모양이면 그릴 필요도 없다.
  If MaxTime <= 0 Then Exit;

  PrevCaption := '';

  CurrentSelectedPt := Rect(-1, -1, -1, -1);

  For LoopVar := 0 to JobItems.Count-1 do
  With JobItems.Items[LoopVar] do
  Begin
     //
     DrawPtX := Round( (TimeValue * FullWidth) / MaxTime ) + StartX;
     DrawObj := Nil;

     If Not Visible Then Continue;

     If Assigned(ItemIcon.Graphic) Then
        DrawObj := ItemIcon.Graphic
     Else If Assigned(FDefaultItemIcon.Graphic) Then
        DrawObj := FDefaultItemIcon.Graphic;

     If DrawObj <> Nil Then
     Begin
        SizeCalHarp := DrawObj.Width Div 2;
        DrawRect := Rect(DrawPtX-SizeCalHarp, BottomPt-SizeCalHarp, DrawPtX+SizeCalHarp, BottomPt+SizeCalHarp);

        If (ProgressIndex = LoopVar) and Assigned(FFinishedItemIcon.Graphic) Then
           DrawObj := FFinishedItemIcon.Graphic;

        Canvas.StretchDraw(DrawRect, DrawObj);
     End;

     // 여기서 줄을 그으면 이미지에 줄이 그일거다.
     If ProgressIndex = LoopVar Then
     Begin
        If Assigned(FProgressItemIcon.Graphic) Then
        Begin
           SizeCalHarp := FProgressItemIcon.Width div 2;
           // DrawPtX := FPopupXPt;

           DrawFontWidth := Canvas.TextWidth(JobName);
           DrawFontWidthHarf := (DrawFontWidth div 2);
           If TextDrawedX < DrawPtX-DrawFontWidthHarf Then
           Begin
              Canvas.TextOut( DrawPtX-DrawFontWidthHarf, DrawRect.Top+DrawFontHeight, JobName);
              TextDrawedX := TextDrawedX+DrawFontWidth;
           End;


           DrawRect := Rect(DrawPtX-SizeCalHarp, BottomPt-SizeCalHarp-SizeCalHarp-3, DrawPtX + SizeCalHarp, BottomPt+SizeCalHarp-SizeCalHarp-3);
           CurrentSelectedPt := DrawRect;
           // Canvas.StretchDraw(DrawRect, FProgressItemIcon.Graphic);

           {
           // 아이콘 옆에 그리는 방식인데 별로 안좋은듯.
           If (FullWidth-DrawRect.Left + FProgressItemIcon.Width) > 100 Then
           Begin
              Canvas.TextOut(DrawRect.Left + FProgressItemIcon.Width, DrawRect.Top + (DrawFontHeight Div 2), JobName);
              //Canvas.TextOut(DrawRect.Left + FProgressItemIcon.Width, DrawRect.Top+DrawFontHeight, JobComment);
           End
           Else
           Begin
              DrawFontWidth := Canvas.TextWidth(JobName);
              Canvas.TextOut(DrawRect.Left - DrawFontWidth, DrawRect.Top + (DrawFontHeight Div 2), JobName);
              //DrawFontWidth := Canvas.TextWidth(JobComment);
              //Canvas.TextOut(DrawRect.Left - DrawFontWidth, DrawRect.Top+DrawFontHeight, JobComment);
           End;
           }
        End;
     End
     Else
     Begin
        If FSkipPaintDuplicateItem and (PrevCaption = JobName) and (LoopVar < JobItems.Count-1) Then Continue;

        DrawFontWidth := Canvas.TextWidth(JobName);
        DrawFontWidthHarf := (DrawFontWidth div 2);
        If TextDrawedX < DrawPtX-DrawFontWidthHarf Then
        Begin
           Canvas.TextOut( DrawPtX-DrawFontWidthHarf, DrawRect.Top-DrawFontHeight, JobName);
           TextDrawedX := TextDrawedX+DrawFontWidth;
        End;

        PrevCaption := JobName;
     End;
  End;

  If CurrentSelectedPt.Left <> -1 Then
  Begin
     Canvas.StretchDraw(CurrentSelectedPt, FProgressItemIcon.Graphic);
  End;

  // 테스트용 코드.
  {
  If Assigned(FDefaultItemIcon.Graphic) Then
  Begin
     SizeCalHarp := FDefaultItemIcon.Width Div 2;
     DrawRect := Rect(1+FMargin-SizeCalHarp, BottomPt-SizeCalHarp, 1+FMargin+SizeCalHarp, BottomPt+SizeCalHarp);
     Canvas.StretchDraw(DrawRect, FDefaultItemIcon.Graphic);
  End;

  If Assigned(FProgressItemIcon.Graphic) Then
  Begin
     SizeCalHarp := FProgressItemIcon.Width;
     DrawRect := Rect(13+FMargin-SizeCalHarp, BottomPt-SizeCalHarp-4, 13+FMargin, BottomPt-4);
     Canvas.StretchDraw(DrawRect, FProgressItemIcon.Graphic);
  End;
  }
end;

procedure TJkhJobProgressBar.Resize;
begin
  inherited;

end;

procedure TJkhJobProgressBar.SetBottomSpace(const Value: Integer);
begin
  FBottomSpace := Value;
  Invalidate;
end;

procedure TJkhJobProgressBar.SetDefaultItemIcon(const Value: TPicture);
begin
  FDefaultItemIcon.Assign( Value );
  Invalidate;
end;

procedure TJkhJobProgressBar.SetFinishedColor(const Value: TColor);
begin
  FFinishedColor := Value;
  Invalidate;
end;

procedure TJkhJobProgressBar.SetFinishedItemIcon(const Value: TPicture);
begin
  FFinishedItemIcon.Assign( Value );
end;

procedure TJkhJobProgressBar.SetJobItems(const Value: TJkhJobItemsList);
begin
  FJobItems.Assign( Value );
end;

procedure TJkhJobProgressBar.SetLineColor(const Value: TColor);
begin
  FLineColor := Value;
  Invalidate;
end;

procedure TJkhJobProgressBar.SetMargin(const Value: Integer);
begin
  FMargin := Value;
  Invalidate;
end;

procedure TJkhJobProgressBar.SetProgressItemIcon(const Value: TPicture);
begin
  FProgressItemIcon.Assign( Value );
  Invalidate;
end;

procedure TJkhJobProgressBar.SetProgressIndex(const Value: Integer);
begin
  // 넘어갈순 없다.
  If Value >= JobItems.Count Then Exit;

  FProgressIndex := Value;
  Invalidate;
end;

procedure TJkhJobProgressBar.DoDrawText(var ARect: TRect; AText: String; AFontSize: Integer);
begin

end;

procedure TJkhJobProgressBar.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  inherited;

  // FPopupXPt := X;
  // Repaint;
end;

procedure TJkhJobProgressBar.SetSkipPaintDuplicateItem(
  const Value: Boolean);
begin
  FSkipPaintDuplicateItem := Value;
  Invalidate;
end;

end.
