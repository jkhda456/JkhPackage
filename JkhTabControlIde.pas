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

unit JkhTabControlIde;

interface

uses
  Classes, JkhTabControl, Comctrls, Windows, Forms, TypInfo, ExtCtrls, 
  Controls, DesignIntf, DesignEditors, ContNrs;

type
  TJkhTabControlEditor = class(TDefaultEditor)
  protected
  public
    function GetVerb(Index: Integer):string; override;
    function GetVerbCount: Integer; override;
    procedure ExecuteVerb(Index: Integer); override;
  end;

{  TJkhTabSheetEditor = class(TDefaultEditor)
  protected
  public
    function GetVerb(Index: Integer):string; override;
    function GetVerbCount: Integer; override;
    procedure ExecuteVerb(Index: Integer); override;
  end;
}

procedure Register;

implementation

uses
  SysUtils;

procedure Register;
begin
  RegisterComponentEditor(TJkhTabControl,TJkhTabControlEditor);
end;

procedure TJkhTabControlEditor.ExecuteVerb(Index: integer);
var
  page : TJkhTabSheet;
begin
  inherited;
  case Index of
  0:
    begin
      TCustomTabControl(Component).ControlStyle := TCustomTabControl(Component).ControlStyle + [csAcceptsControls];
      page := TJkhTabSheet(Designer.CreateComponent(TJkhTabSheet,Component,23,0,100,100));

      page.parent := TJkhTabcontrol(component);
      page.Caption := page.name;
      page.TabControl := TJkhTabcontrol(Component);
      TJkhTabcontrol(Component).InsertPage(page);
      //TJkhTabcontrol(Component).ActivePage:= page;
      with TJkhTabControl(Component) do
          Update;

      (Component as TCustomTabControl).Invalidate;
      TCustomTabControl(Component).ControlStyle := TCustomTabControl(Component).ControlStyle - [csAcceptsControls];
    end;
  1: TJkhTabControl(Component).NextPage;
  2: TJkhTabControl(Component).PrevPage;
  end;
end;

function TJkhTabControlEditor.GetVerb(Index: Integer): string;
begin
  case Index of
  0: Result := 'New Page';
  1: Result := 'Previous Page';
  2: Result := 'Next Page';
  end;
end;

function TJkhTabControlEditor.GetVerbCount: Integer;
begin
  Result := 3;
end;

end.
