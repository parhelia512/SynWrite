unit ATGroups;

interface

uses
  Classes, Forms, Types, Controls, Graphics,
  ExtCtrls, ATTabs, SpTbxDkPanels;

type
  TATPages = class(TPanel)
  private
    FTabs: TATTabs;
    FOnTabClose: TATTabCloseEvent;
    FOnTabAdd: TNotifyEvent;
    FOnTabEmpty: TNotifyEvent;
    procedure SetOnTabClose(AEvent: TATTabCloseEvent);
    procedure SetOnTabAdd(AEvent: TNotifyEvent);
    procedure TabClick(Sender: TObject);
    procedure TabDrawBefore(Sender: TObject;
      AType: TATTabElemType; ATabIndex: Integer;
      C: TCanvas; const ARect: TRect; var ACanDraw: boolean);
    procedure TabEmpty(Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
    procedure AddTab(AControl: TControl; const ACaption: Widestring);
    property Tabs: TATTabs read FTabs;
    property OnTabClose: TATTabCloseEvent read FOnTabClose write SetOnTabClose;
    property OnTabAdd: TNotifyEvent read FOnTabAdd write SetOnTabAdd;
    property OnTabEmpty: TNotifyEvent read FOnTabEmpty write FOnTabEmpty;
  end;

type
  TATGroupsMode = (
    gmNone,
    gmOne,
    gmTwoHorz,
    gmTwoVert,
    gmThreeHorz,
    gmThreeVert,
    gmFourHorz,
    gmFourVert,
    gmFourGrid
    );

type
  TATGroups = class(TPanel)
  private
    FSplit1, FSplit2, FSplit3: TSpTbxSplitter;
    FPanel1, FPanel2: TPanel;
    FOnPopup: TNotifyEvent;
    FMode: TATGroupsMode;
    FPos1, FPos2, FPos3: Real;
    procedure TabEmpty(Sender: TObject);
    procedure TabPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
    procedure SetMode(Value: TATGroupsMode);
    procedure Split1Moved(Sender: TObject);
    procedure Split2Moved(Sender: TObject);
    procedure Split3Moved(Sender: TObject);
    procedure SaveSplitPos;
    procedure RestoreSplitPos;
  protected
    procedure Resize; override;
  public
    Pages1,
    Pages2,
    Pages3,
    Pages4: TATPages;
    PopupPages: TATPages;
    PopupTabIndex: Integer;
    constructor Create(AOwner: TComponent); override;
    property Mode: TATGroupsMode read FMode write SetMode;
    property OnPopup: TNotifyEvent read FOnPopup write FOnPopup;
  end;

implementation

uses
  SysUtils, Windows, Dialogs,
  SpTbxSkins, SpTbxItem;

function PtInControl(Control: TControl; const Pnt: TPoint): boolean;
begin
  Result:= PtInRect(Control.BoundsRect, Control.ScreenToClient(Pnt));
end;

{ TATPages }

constructor TATPages.Create(AOwner: TComponent);
begin
  inherited;

  Caption:= '';
  BorderStyle:= bsNone;
  BevelInner:= bvNone;
  BevelOuter:= bvNone;

  FTabs:= TATTabs.Create(Self);
  FTabs.Parent:= Self;
  FTabs.Align:= alTop;
  FTabs.OnTabClick:= TabClick;
  FTabs.OnTabDrawBefore:= TabDrawBefore;
  FTabs.OnTabEmpty:= TabEmpty;

  FTabs.TabAngle:= 0;
  FTabs.TabIndentTop:= 1;
  FTabs.TabIndentInter:= 1;
  FTabs.Height:= FTabs.TabHeight+FTabs.TabIndentTop+4;
  FTabs.ColorBg:= clWindow;
end;

procedure TATPages.AddTab(AControl: TControl;
  const ACaption: Widestring);
begin
  FTabs.AddTab(-1, ACaption, AControl);
  AControl.Parent:= Self;
  AControl.Align:= alClient;
  FTabs.TabIndex:= FTabs.TabCount-1;
end;

procedure TATPages.TabClick(Sender: TObject);
var
  i: Integer;
  D: TATTabData;
  Ctl: TWinControl;
begin
  for i:= 0 to FTabs.TabCount-1 do
  begin
    D:= FTabs.GetTabData(i);
    if D<>nil then
    begin
      Ctl:= D.TabObject as TWinControl;
      Ctl.Visible:= i=FTabs.TabIndex;
    end;
  end;

  D:= FTabs.GetTabData(FTabs.TabIndex);
  if D<>nil then
  begin
    Ctl:= D.TabObject as TWinControl;
    if Ctl.Showing then
      if Ctl.CanFocus then
        Ctl.SetFocus;
  end;      
end;

procedure TATPages.SetOnTabClose(AEvent: TATTabCloseEvent);
begin
  FOnTabClose:= AEvent;
  FTabs.OnTabClose:= AEvent;
end;

procedure TATPages.SetOnTabAdd(AEvent: TNotifyEvent);
begin
  FOnTabAdd:= AEvent;
  FTabs.OnTabPlusClick:= AEvent;
end;

procedure TATPages.TabEmpty(Sender: TObject);
begin
  if Assigned(FOnTabEmpty) then
    FOnTabEmpty(Sender);
end;

{ TATGroups }

constructor TATGroups.Create(AOwner: TComponent);
begin
  inherited;

  Caption:= '';
  BorderStyle:= bsNone;
  BevelInner:= bvNone;
  BevelOuter:= bvNone;

  Pages1:= TATPages.Create(Self);
  Pages1.Parent:= Self;
  Pages1.Align:= alLeft;
  Pages1.OnContextPopup:= TabPopup;
  Pages1.OnTabEmpty:= TabEmpty;

  Pages2:= TATPages.Create(Self);
  Pages2.Parent:= Self;
  Pages2.Align:= alLeft;
  Pages2.OnContextPopup:= TabPopup;
  Pages2.OnTabEmpty:= TabEmpty;

  Pages3:= TATPages.Create(Self);
  Pages3.Parent:= Self;
  Pages3.Align:= alLeft;
  Pages3.OnContextPopup:= TabPopup;
  Pages3.OnTabEmpty:= TabEmpty;

  Pages4:= TATPages.Create(Self);
  Pages4.Parent:= Self;
  Pages4.Align:= alLeft;
  Pages4.OnContextPopup:= TabPopup;
  Pages4.OnTabEmpty:= TabEmpty;

  FSplit1:= TSpTbxSplitter.Create(Self);
  FSplit1.Parent:= Self;
  FSplit1.OnMoved:= Split1Moved;

  FSplit2:= TSpTbxSplitter.Create(Self);
  FSplit2.Parent:= Self;
  FSplit2.OnMoved:= Split2Moved;

  FSplit3:= TSpTbxSplitter.Create(Self);
  FSplit3.Parent:= Self;
  FSplit3.OnMoved:= Split3Moved;

  FPanel1:= TPanel.Create(Self);
  FPanel1.Parent:= Self;
  FPanel1.Align:= alTop;
  FPanel1.Caption:= '';
  FPanel1.BorderStyle:= bsNone;
  FPanel1.BevelInner:= bvNone;
  FPanel1.BevelOuter:= bvNone;
  FPanel1.Visible:= false;

  FPanel2:= TPanel.Create(Self);
  FPanel2.Parent:= Self;
  FPanel2.Align:= alClient;
  FPanel2.Caption:= '';
  FPanel2.BorderStyle:= bsNone;
  FPanel2.BevelInner:= bvNone;
  FPanel2.BevelOuter:= bvNone;
  FPanel2.Visible:= false;

  FMode:= gmNone;
end;

procedure TATGroups.SetMode(Value: TATGroupsMode);
begin
  if Value<>FMode then
  begin
    FMode:= Value;

    if FMode=gmFourGrid then
    begin
      FPanel1.Visible:= true;
      FPanel2.Visible:= true;
      Pages1.Parent:= FPanel1;
      Pages2.Parent:= FPanel1;
      Pages3.Parent:= FPanel2;
      Pages4.Parent:= FPanel2;
      FSplit1.Parent:= FPanel1;
      FSplit2.Parent:= FPanel2;
    end
    else
    begin
      FPanel1.Visible:= false;
      FPanel2.Visible:= false;
      Pages1.Parent:= Self;
      Pages2.Parent:= Self;
      Pages3.Parent:= Self;
      Pages4.Parent:= Self;
      FSplit1.Parent:= Self;
      FSplit2.Parent:= Self;
    end;

    case FMode of
      gmOne:
        begin
          Pages2.Visible:= false;
          Pages3.Visible:= false;
          Pages4.Visible:= false;
          FSplit1.Visible:= false;
          FSplit2.Visible:= false;
          FSplit3.Visible:= false;
          Pages1.Align:= alClient;
        end;
      gmTwoHorz:
        begin
          Pages2.Visible:= true;
          Pages3.Visible:= false;
          Pages4.Visible:= false;
          FSplit1.Visible:= true;
          FSplit2.Visible:= false;
          FSplit3.Visible:= false;
          Pages1.Align:= alLeft;
          Pages2.Align:= alClient;
          FSplit1.Align:= alLeft;
          //size
          Pages1.Width:= ClientWidth div 2;
          //pos
          FSplit1.Left:= ClientWidth;
          Pages2.Left:= ClientWidth;
        end;
      gmTwoVert:
        begin
          Pages2.Visible:= true;
          Pages3.Visible:= false;
          Pages4.Visible:= false;
          FSplit1.Visible:= true;
          FSplit2.Visible:= false;
          FSplit3.Visible:= false;
          Pages1.Align:= alTop;
          Pages2.Align:= alClient;
          FSplit1.Align:= alTop;
          //size
          Pages1.Height:= ClientHeight div 2;
          //pos
          FSplit1.Top:= ClientHeight;
          Pages2.Top:= ClientHeight;
        end;
      gmThreeHorz:
        begin
          Pages2.Visible:= true;
          Pages3.Visible:= true;
          Pages4.Visible:= false;
          FSplit1.Visible:= true;
          FSplit2.Visible:= true;
          FSplit3.Visible:= false;
          Pages1.Align:= alLeft;
          Pages2.Align:= alLeft;
          Pages3.Align:= alClient;
          FSplit1.Align:= alLeft;
          FSplit2.Align:= alLeft;
          //size
          Pages1.Width:= ClientWidth div 3;
          Pages2.Width:= ClientWidth div 3;
          //pos
          FSplit1.Left:= ClientWidth;
          Pages2.Left:= ClientWidth;
          FSplit2.Left:= ClientWidth;
          Pages3.Left:= ClientWidth;
        end;
      gmThreeVert:
        begin
          Pages2.Visible:= true;
          Pages3.Visible:= true;
          Pages4.Visible:= false;
          FSplit1.Visible:= true;
          FSplit2.Visible:= true;
          FSplit3.Visible:= false;
          Pages1.Align:= alTop;
          Pages2.Align:= alTop;
          Pages3.Align:= alClient;
          FSplit1.Align:= alTop;
          FSplit2.Align:= alTop;
          //size
          Pages1.Height:= ClientHeight div 3;
          Pages2.Height:= ClientHeight div 3;
          //pos
          FSplit1.Top:= ClientHeight;
          Pages2.Top:= ClientHeight;
          FSplit2.Top:= ClientHeight;
          Pages3.Top:= ClientHeight;
        end;
      gmFourHorz:
        begin
          Pages2.Visible:= true;
          Pages3.Visible:= true;
          Pages4.Visible:= true;
          FSplit1.Visible:= true;
          FSplit2.Visible:= true;
          FSplit3.Visible:= true;
          Pages1.Align:= alLeft;
          Pages2.Align:= alLeft;
          Pages3.Align:= alLeft;
          Pages4.Align:= alClient;
          FSplit1.Align:= alLeft;
          FSplit2.Align:= alLeft;
          FSplit3.Align:= alLeft;
          //size
          Pages1.Width:= ClientWidth div 4;
          Pages2.Width:= ClientWidth div 4;
          Pages3.Width:= ClientWidth div 4;
          //pos
          FSplit1.Left:= ClientWidth;
          Pages2.Left:= ClientWidth;
          FSplit2.Left:= ClientWidth;
          Pages3.Left:= ClientWidth;
          FSplit3.Left:= ClientWidth;
          Pages4.Left:= ClientWidth;
        end;
      gmFourVert:
        begin
          Pages2.Visible:= true;
          Pages3.Visible:= true;
          Pages4.Visible:= true;
          FSplit1.Visible:= true;
          FSplit2.Visible:= true;
          FSplit3.Visible:= true;
          Pages1.Align:= alTop;
          Pages2.Align:= alTop;
          Pages3.Align:= alTop;
          Pages4.Align:= alClient;
          FSplit1.Align:= alTop;
          FSplit2.Align:= alTop;
          FSplit3.Align:= alTop;
          //size
          Pages1.Height:= ClientHeight div 4;
          Pages2.Height:= ClientHeight div 4;
          Pages3.Height:= ClientHeight div 4;
          //pos
          FSplit1.Top:= ClientHeight;
          Pages2.Top:= ClientHeight;
          FSplit2.Top:= ClientHeight;
          Pages3.Top:= ClientHeight;
          FSplit3.Top:= ClientHeight;
          Pages4.Top:= ClientHeight;
        end;
      gmFourGrid:
        begin
          Pages2.Visible:= true;
          Pages3.Visible:= true;
          Pages4.Visible:= true;
          FSplit1.Visible:= true;
          FSplit2.Visible:= true;
          FSplit3.Visible:= true;
          Pages1.Align:= alLeft;
          Pages2.Align:= alClient;
          Pages3.Align:= alLeft;
          Pages4.Align:= alClient;
          FSplit1.Align:= alLeft;
          FSplit2.Align:= alLeft;
          FSplit3.Align:= alTop;
          //size
          Pages1.Width:= ClientWidth div 2;
          Pages3.Width:= ClientWidth div 2;
          FPanel1.Height:= ClientHeight div 2;
          //pos
          FSplit1.Left:= ClientWidth;
          Pages2.Left:= ClientWidth;
          FSplit2.Left:= ClientWidth;
          Pages4.Left:= ClientWidth;
        end;
    end;

    SaveSplitPos;
  end;
end;

procedure TATGroups.Split1Moved(Sender: TObject);
begin
  if FMode=gmFourGrid then
    Pages3.Width:= Pages1.Width;
  SaveSplitPos;
end;

procedure TATGroups.Split2Moved(Sender: TObject);
begin
  if FMode=gmFourGrid then
    Pages1.Width:= Pages3.Width;
  SaveSplitPos;
end;

procedure TATGroups.Split3Moved(Sender: TObject);
begin
  SaveSplitPos;
end;

procedure TATGroups.TabPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
var
  Pnt, PntC: TPoint;
begin
  Pnt:= (Sender as TControl).ClientToScreen(MousePos);

  if PtInControl(Pages1.Tabs, Pnt) then
    PopupPages:= Pages1
  else
  if PtInControl(Pages2.Tabs, Pnt) then
    PopupPages:= Pages2
  else
  if PtInControl(Pages3.Tabs, Pnt) then
    PopupPages:= Pages3
  else
  if PtInControl(Pages4.Tabs, Pnt) then
    PopupPages:= Pages4
  else
  begin
    PopupPages:= nil;
    PopupTabIndex:= -1;
    Exit;
  end;

  PntC:= PopupPages.Tabs.ScreenToClient(Pnt);
  PopupTabIndex:= PopupPages.Tabs.GetTabAt(PntC.X, PntC.Y);

  if Assigned(FOnPopup) then
    FOnPopup(Self);
  Handled:= true;  
end;

procedure TATPages.TabDrawBefore(Sender: TObject;
  AType: TATTabElemType; ATabIndex: Integer;
  C: TCanvas; const ARect: TRect; var ACanDraw: boolean);
begin
  case AType of
    aeBackground:
    begin
      CurrentSkin.PaintBackground(
        C, ARect,
        skncDock, sknsNormal, true{BG}, false{Borders});
      ACanDraw:= false;
    end;
    aeXButton:
    begin
      //if ATabMouseOver then
      //  SpDrawXPToolbarButton(Control.Canvas, R, sknsHotTrack, cpNone);
      SpDrawGlyphPattern(C, ARect, 0{0 is X icon index},
        CurrentSkin.GetTextColor(skncToolbarItem, sknsNormal));
      ACanDraw:= false;
    end;
    aeXButtonOver:
    begin
      SpDrawXPToolbarButton(C,
        Rect(ARect.Left-1, ARect.Top-1, ARect.Right, ARect.Bottom),
        sknsHotTrack, cpNone);
      SpDrawGlyphPattern(C, ARect, 0{0 is X icon index},
        CurrentSkin.GetTextColor(skncToolbarItem, sknsNormal));
      ACanDraw:= false;
    end;
  end;
end;  

procedure TATGroups.SaveSplitPos;
begin
  if ClientWidth<=0 then Exit;
  if ClientHeight<=0 then Exit;

  FPos1:= 0;
  FPos2:= 0;
  FPos3:= 0;

  case FMode of
    gmTwoHorz,
    gmThreeHorz,
    gmFourHorz:
      begin
        FPos1:= Pages1.Width / ClientWidth;
        FPos2:= Pages2.Width / ClientWidth;
        FPos3:= Pages3.Width / ClientWidth;
      end;
    gmTwoVert,
    gmThreeVert,
    gmFourVert:
      begin
        FPos1:= Pages1.Height / ClientHeight;
        FPos2:= Pages2.Height / ClientHeight;
        FPos3:= Pages3.Height / ClientHeight;
      end;
    gmFourGrid:
      begin
        FPos1:= Pages1.Width / ClientWidth;
        FPos2:= Pages3.Width / ClientWidth;
        FPos3:= FPanel1.Height / ClientHeight;
      end;
  end;
end;

procedure TATGroups.RestoreSplitPos;
begin
  if ClientWidth<=0 then Exit;
  if ClientHeight<=0 then Exit;

  case FMode of
    gmTwoHorz,
    gmThreeHorz,
    gmFourHorz:
      begin
        Pages1.Width:= Trunc(FPos1 * ClientWidth);
        Pages2.Width:= Trunc(FPos2 * ClientWidth);
        Pages3.Width:= Trunc(FPos3 * ClientWidth);
      end;
    gmTwoVert,
    gmThreeVert,
    gmFourVert:
      begin
        Pages1.Height:= Trunc(FPos1 * ClientHeight);
        Pages2.Height:= Trunc(FPos2 * ClientHeight);
        Pages3.Height:= Trunc(FPos3 * ClientHeight);
      end;
    gmFourGrid:
      begin
        Pages1.Width:= Trunc(FPos1 * ClientWidth);
        Pages3.Width:= Trunc(FPos2 * ClientWidth);
        FPanel1.Height:= Trunc(FPos3 * ClientHeight);
      end;
  end;
end;

procedure TATGroups.Resize;
begin
  RestoreSplitPos;
end;


procedure TATGroups.TabEmpty(Sender: TObject);
begin
  //if last tab closed on Pages1, add new tab
  //if last tab closed on Pages2..Pages4, activate Pages1
  if Sender=Pages1.Tabs then
  begin
    Pages1.OnTabAdd(Pages1.Tabs);
  end
  else
  begin
    if Pages1.Tabs.TabCount>0 then
      Pages1.Tabs.OnTabClick(nil);
  end;
end;

end.

