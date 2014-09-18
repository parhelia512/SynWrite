unit unSetupOvr;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  TntForms,
  Dialogs, StdCtrls, TntStdCtrls, DKLang, Spin;

type
  TfmSetupOvr = class(TTntForm)
    ListLex: TTntListBox;
    Label1: TTntLabel;
    edTabStops: TTntEdit;
    LabelTabStop: TTntLabel;
    LabelTabMode: TTntLabel;
    edText: TEdit;
    cbOvr: TTntCheckBox;
    DKLanguageController1: TDKLanguageController;
    LabelWrap: TTntLabel;
    LabelMargin: TTntLabel;
    edMargin: TSpinEdit;
    LabelSp: TTntLabel;
    edSpacing: TSpinEdit;
    LabelOptFill: TTntLabel;
    edWordChars: TTntEdit;
    LabelWordChars: TTntLabel;
    LabelBlanks: TTntLabel;
    LabelTextShow: TLabel;
    cbAutoCase: TTntCheckBox;
    LabelHelpAutoCase: TTntLabel;
    LabelIndent: TTntLabel;
    edIndent: TSpinEdit;
    chkTabStops: TTntCheckBox;
    chkTabMode: TTntCheckBox;
    chkWrap: TTntCheckBox;
    chkOptFill: TTntCheckBox;
    chkKeepBlanks: TTntCheckBox;
    chkIndent: TTntCheckBox;
    chkMargin: TTntCheckBox;
    chkSpacing: TTntCheckBox;
    edTabMode: TTntComboBox;
    edWrap: TTntComboBox;
    edOptFill: TTntComboBox;
    edKeepBlanks: TTntComboBox;
    procedure cbOvrClick(Sender: TObject);
    procedure ListLexClick(Sender: TObject);
    procedure TntFormShow(Sender: TObject);
    procedure TntFormCreate(Sender: TObject);
    procedure edTabStopsChange(Sender: TObject);
    procedure LabelTextShowClick(Sender: TObject);
    procedure LabelHelpAutoCaseClick(Sender: TObject);
    procedure chkTabStopsClick(Sender: TObject);
  private
    { Private declarations }
    FUpdLock: boolean;
  public
    { Public declarations }
    FString: string;
    FDefTabStop: string;
    FDefTabMode,
    FDefIndent,
    FDefMargin,
    FDefSpacing,
    FDefOptFill: integer;
    procedure UpdateString;
  end;

implementation

uses
  StrUtils,
  ATxSProc,
  unProcHelp;

{$R *.dfm}

procedure TfmSetupOvr.cbOvrClick(Sender: TObject);
var
  en: boolean;
begin
  en:= cbOvr.Checked;
  edTabStops.Enabled:= en;
  edTabMode.Enabled:= en;
  edWrap.Enabled:= en;
  edIndent.Enabled:= en;
  edMargin.Enabled:= en;
  edSpacing.Enabled:= en;
  edOptFill.Enabled:= en;
  edWordChars.Enabled:= en;
  edKeepBlanks.Enabled:= en;
  cbAutoCase.Enabled:= en;
  LabelTabStop.Enabled:= en;
  LabelTabMode.Enabled:= en;
  LabelWrap.Enabled:= en;
  LabelMargin.Enabled:= en;
  LabelIndent.Enabled:= en;
  LabelOptFill.Enabled:= en;
  LabelSp.Enabled:= en;
  LabelWordChars.Enabled:= en;
  LabelBlanks.Enabled:= en;

  chkTabStops.Enabled:= en;
  chkTabMode.Enabled:= en;
  chkWrap.Enabled:= en;
  chkOptFill.Enabled:= en;
  chkKeepBlanks.Enabled:= en;
  chkIndent.Enabled:= en;
  chkMargin.Enabled:= en;
  chkSpacing.Enabled:= en;

  if not en then
  begin
    if ListLex.ItemIndex>=0 then
      SSetLexerOverride(en, FString, ListLex.Items[ListLex.ItemIndex], '', '', '', '', '', '', '', '', '', '');
    edTabStops.Text:= FDefTabStop;
    edTabMode.ItemIndex:= FDefTabMode;
    edWrap.ItemIndex:= 0;
    edIndent.Value:= FDefIndent;
    edMargin.Value:= FDefMargin;
    edSpacing.Value:= FDefSpacing;
    edOptFill.ItemIndex:= 0;
    edWordChars.Text:= '';
    edText.Text:= FString;
  end;
end;

procedure TfmSetupOvr.ListLexClick(Sender: TObject);
var
  Ovr: boolean;
  ATabStops, ATabMode, AWrap, AMargin, ASpacing, AOptFill,
  AOptWordChars, AKeepBlanks, ACaseCorrect, AIndent: string;
begin
  if ListLex.ItemIndex>=0 then
  begin
    Ovr:= SGetLexerOverride(FString, ListLex.Items[ListLex.ItemIndex],
      ATabStops, ATabMode, AWrap, AMargin, ASpacing, AOptFill,
      AOptWordChars, AKeepBlanks, ACaseCorrect, AIndent);
    cbOvr.Enabled:= true;
  end
  else
  begin
    Ovr:= false;
    cbOvr.Enabled:= false;
  end;

  FUpdLock:= true;
  cbOvr.Checked:= Ovr;
  if Ovr then
  begin
    chkTabStops.Checked:= ATabStops<>'';
    chkTabMode.Checked:= ATabMode<>'';
    chkWrap.Checked:= AWrap<>'';
    chkOptFill.Checked:= AOptFill<>'';
    chkKeepBlanks.Checked:= AKeepBlanks<>'';
    chkIndent.Checked:= AIndent<>'';
    chkMargin.Checked:= AMargin<>'';
    chkSpacing.Checked:= ASpacing<>'';

    edTabStops.Text:= ATabStops;
    edTabMode.ItemIndex:= StrToIntDef(ATabMode, FDefTabMode);
    edWrap.ItemIndex:= StrToIntDef(AWrap, 0);
    edIndent.Value:= StrToIntDef(AIndent, FDefIndent);
    edMargin.Value:= StrToIntDef(AMargin, FDefMargin);
    edSpacing.Value:= StrToIntDef(ASpacing, FDefSpacing);
    edOptFill.ItemIndex:= StrToIntDef(AOptFill, 0);
    edKeepBlanks.ItemIndex:= StrToIntDef(AKeepBlanks, 0);
    edWordChars.Text:= AOptWordChars;
    cbAutoCase.Checked:= Bool(StrToIntDef(ACaseCorrect, 0));
  end
  else
  begin
    chkTabStops.Checked:= false;
    chkTabMode.Checked:= false;
    chkWrap.Checked:= false;
    chkOptFill.Checked:= false;
    chkKeepBlanks.Checked:= false;
    chkIndent.Checked:= false;
    chkMargin.Checked:= false;
    chkSpacing.Checked:= false;

    edTabStops.Text:= FDefTabStop;
    edTabMode.ItemIndex:= FDefTabMode;
    edWrap.ItemIndex:= 0;
    edIndent.Value:= FDefIndent;
    edMargin.Value:= FDefMargin;
    edSpacing.Value:= FDefSpacing;
    edOptFill.ItemIndex:= 0;
    edKeepBlanks.ItemIndex:= 0;
    edWordChars.Text:= '';
    cbAutoCase.Checked:= false;
  end;

  FUpdLock:= false;
  cbOvrClick(Self);
end;

procedure TfmSetupOvr.TntFormShow(Sender: TObject);
begin
  edTabStops.Text:= FDefTabStop;
  edTabMode.ItemIndex:= FDefTabMode;
  edWrap.ItemIndex:= 0;
  edIndent.Value:= FDefIndent;
  edMargin.Value:= FDefMargin;
  edSpacing.Value:= FDefSpacing;
  edOptFill.ItemIndex:= 0;
  edWordChars.Text:= '';
  edText.Text:= FString;
  ListLex.ItemIndex:= 0;
  ListLexClick(Self);
end;

procedure TfmSetupOvr.TntFormCreate(Sender: TObject);
begin
//
end;

procedure TfmSetupOvr.edTabStopsChange(Sender: TObject);
begin
  UpdateString;
end;  

procedure TfmSetupOvr.UpdateString;
var
  S: Widestring;
begin
  if FUpdLock then Exit;
  if cbOvr.Checked then
    if ListLex.ItemIndex>=0 then
    begin
      //don't allow to enter ',' or ';' into edit fields
      if (Pos(',', edWordChars.Text)>0) or
        (Pos(';', edWordChars.Text)>0) then
      begin
        MessageBeep(mb_iconwarning);
        S:= edWordChars.Text;
        SReplaceAllW(S, ',', '');
        SReplaceAllW(S, ';', '');
        edWordChars.Text:= S;
      end;

      SSetLexerOverride(true, FString,
        ListLex.Items[ListLex.ItemIndex],
        {Op1}IfThen(chkTabStops.Checked, edTabStops.Text),
        {Op2}IfThen(chkTabMode.Checked, IntToStr(edTabMode.ItemIndex)),
        {Op3}IfThen(chkWrap.Checked, IntToStr(edWrap.ItemIndex)),
        {Op4}IfThen(chkMargin.Checked, IntToStr(edMargin.Value)),
        {Op5}IfThen(chkSpacing.Checked, IntToStr(edSpacing.Value)),
        {Op6}IfThen(chkOptFill.Checked, IntToStr(edOptFill.ItemIndex)),
        {Op7}edWordChars.Text,
        {Op8}IfThen(chkKeepBlanks.Checked, IntToStr(edKeepBlanks.ItemIndex)),
        {Op9}IfThen(cbAutoCase.Checked, IntToStr(Ord(cbAutoCase.Checked))),
        {Op10}IfThen(chkIndent.Checked, IntToStr(edIndent.Value))
        );
      edText.Text:= FString;
    end;
end;

procedure TfmSetupOvr.LabelTextShowClick(Sender: TObject);
begin
  with edText do
    Visible:= not Visible; 
end;

procedure TfmSetupOvr.LabelHelpAutoCaseClick(Sender: TObject);
begin
  SynHelpTopic(helpAutoCase, Handle);
end;

procedure TfmSetupOvr.chkTabStopsClick(Sender: TObject);
begin
  UpdateString;
end;

end.
