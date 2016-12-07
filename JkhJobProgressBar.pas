{
�� ������Ʈ�� BSD ���̼����� ������ �ֽ��ϴ�.


�� BSD ���̼������� ���� ������ �����۱� �����ڿ� �⿩�ڡ� ������ �����ǿ����� �⿩�ڷΡ� �ؼ��ȴ�. ���̼��� ���ø��� ������ ����:

Copyright (c) 2012, Jung K. H / StyleNS / StyleNS.net
All rights reserved.

������ ���ǵ��� ������Ű�� ��, �ҽ� ���İ� ���̳ʸ� ������ ���� ������� ����� ���� ���ο� ������� ���ȴ�. 

�ҽ� �ڵ��� ������� ���� ���۱� ǥ�ÿ� ���� ������ ���ǵ�, �׸��� �Ʒ��� ���� ���� ������ �����ؾ� �Ѵ�. 

 

���̳ʸ� �������� ����� �� ���� ���� ���۱� ǥ�ÿ� ���� ������ ���ǵ� �׸��� �Ʒ��� ���� ���� ������ ������ �� �����Ǵ�
���� �� ��Ÿ �ڷῡ �����ؾ� �Ѵ�. 

 

������ �������� �㰡�� ���� �ʴ� ��, StyleNS�� �̸��̳� �⿩���� �̸��� �� ����Ʈ����� ������ ��ǰ�� �����ϰų� ȫ���ϴµ� 
���Ǿ�� �� �ȴ�. 

���۱��ڿ� �⿩�ڴ� �� ����Ʈ��� ���ִ� �״���ǡ� ���·� �����ϸ�, ��ǰ�� ���γ� Ư���� ������ ���� ���ռ��� ���� ������ 
������ ������ ��� ������ ������ ������̳� ���������� �������� �ʴ´�.  ���� ���ɼ��� ������ �˰� �־��� �ϴ���, ���۱��ڳ� 
�⿩�ڴ� ��� ��쿡�� �� ����Ʈ������ ������� ���Ͽ� �߻���, �������̰ų� �������� ����, ������̰ų� ����� ����, Ư���ϰų� 
�Ϲ����� ���ؿ� ���Ͽ�, �� �߻��� �����̳� å�ӷ�, ����̳� ������å���̳� �ҹ�����(���� ���� ����)�� ���� ���� å���� ���� �ʴ´�. 
�̷��� ������ ��ü ��ȭ�� �뿪�� ���� �� ���뼺�̳� ������, ������ �ս�, �׸��� ���� ���� ���� �����ϳ� �̿� ���ѵ����� �ʴ´�.
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
    
    procedure SetItemIcon(const Value: TPicture); // �̰� ���߿� �ٲ�� ������ ��..
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

    // ��Ÿ �����̳� �ڷḦ ������� ������Ƽ
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

    // ������¸� ǥ���մϴ�.
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
        WriteValue('OBJ', '4'); // ���� ������Ƽ�� ������ ����ƾ� �Ѵ�.
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
  DrawFontHeight := Canvas.TextHeight('a��');

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
  // �ð��� �̸���̸� �׸� �ʿ䵵 ����.
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

     // ���⼭ ���� ������ �̹����� ���� ���ϰŴ�.
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
           // ������ ���� �׸��� ����ε� ���� ��������.
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

  // �׽�Ʈ�� �ڵ�.
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
  // �Ѿ�� ����.
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
