object fmProjProps: TfmProjProps
  Left = 364
  Top = 483
  BorderStyle = bsDialog
  Caption = 'Project properties'
  ClientHeight = 325
  ClientWidth = 489
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = TntFormShow
  PixelsPerInch = 96
  TextHeight = 13
  object btnOk: TTntButton
    Left = 200
    Top = 296
    Width = 91
    Height = 23
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object btnCan: TTntButton
    Left = 392
    Top = 296
    Width = 91
    Height = 23
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 3
  end
  object Pages: TTntPageControl
    Left = 8
    Top = 4
    Width = 473
    Height = 285
    ActivePage = TntTabSheet1
    TabOrder = 0
    object TntTabSheet1: TTntTabSheet
      Caption = 'General'
      object Label4: TTntLabel
        Left = 8
        Top = 76
        Width = 74
        Height = 13
        Caption = 'Working folder:'
      end
      object TntLabel1: TTntLabel
        Left = 8
        Top = 116
        Width = 43
        Height = 13
        Caption = 'Main file:'
      end
      object TntLabel3: TTntLabel
        Left = 8
        Top = 4
        Width = 75
        Height = 13
        Caption = 'New document:'
      end
      object Label1: TTntLabel
        Left = 8
        Top = 20
        Width = 47
        Height = 13
        Caption = 'Encoding:'
      end
      object Label2: TTntLabel
        Left = 144
        Top = 20
        Width = 49
        Height = 13
        Caption = 'Line ends:'
      end
      object Label3: TTntLabel
        Left = 280
        Top = 20
        Width = 31
        Height = 13
        Caption = 'Lexer:'
      end
      object TntLabel4: TTntLabel
        Left = 8
        Top = 156
        Width = 61
        Height = 13
        Caption = 'Files sorting:'
      end
      object edWorkDir: TTntEdit
        Left = 8
        Top = 92
        Width = 353
        Height = 21
        TabOrder = 3
      end
      object edMainFN: TTntEdit
        Left = 8
        Top = 132
        Width = 353
        Height = 21
        ParentColor = True
        ReadOnly = True
        TabOrder = 5
      end
      object btnWorkDir: TTntButton
        Left = 368
        Top = 92
        Width = 91
        Height = 23
        Caption = 'Browse...'
        TabOrder = 4
        OnClick = btnWorkDirClick
      end
      object cbEnc: TTntComboBox
        Left = 8
        Top = 36
        Width = 129
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 0
        Items.Strings = (
          'ANSI (Windows)'
          'OEM (DOS)'
          'UTF-8'
          'UTF-8, no BOM'
          'UTF-16'
          'UTF-16 BE')
      end
      object cbEnds: TTntComboBox
        Left = 144
        Top = 36
        Width = 129
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 1
        Items.Strings = (
          'Windows (CR LF)'
          'Unix (LF)'
          'Mac (CR)')
      end
      object cbLexer: TTntComboBox
        Left = 280
        Top = 36
        Width = 177
        Height = 21
        Style = csDropDownList
        DropDownCount = 24
        ItemHeight = 13
        Sorted = True
        TabOrder = 2
      end
      object cbSort: TTntComboBox
        Left = 8
        Top = 172
        Width = 169
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 6
        Items.Strings = (
          'Don'#39't sort'
          'By name'
          'By extension'
          'By date'
          'By size'
          'By date, descending'
          'By size, descending'
          'By full path')
      end
    end
    object TntTabSheet2: TTntTabSheet
      Caption = 'Search folders'
      object TntLabel2: TTntLabel
        Left = 8
        Top = 220
        Width = 441
        Height = 33
        AutoSize = False
        Caption = 
          'These folders are searched in addition to folders specified in t' +
          'he main Options dialog.'
        WordWrap = True
      end
      object edDirs: TTntMemo
        Left = 8
        Top = 8
        Width = 449
        Height = 177
        ScrollBars = ssBoth
        TabOrder = 0
        OnKeyDown = edDirsKeyDown
      end
      object btnDirAdd: TTntButton
        Left = 8
        Top = 192
        Width = 137
        Height = 23
        Caption = 'Add folder...'
        TabOrder = 1
        OnClick = btnDirAddClick
      end
    end
    object TntTabSheet3: TTntTabSheet
      Caption = 'User variables'
      object TntLabel5: TTntLabel
        Left = 8
        Top = 192
        Width = 441
        Height = 33
        AutoSize = False
        Caption = 
          'Enter lines in the form "VarName=some text". These lines will de' +
          'fine variables which can be used in external tools properties as' +
          ' "{VarName}".'
        WordWrap = True
      end
      object edVars: TTntMemo
        Left = 8
        Top = 8
        Width = 449
        Height = 177
        ScrollBars = ssBoth
        TabOrder = 0
        OnKeyDown = edDirsKeyDown
      end
    end
  end
  object btnHelp: TTntButton
    Left = 296
    Top = 296
    Width = 91
    Height = 23
    Caption = 'Help'
    TabOrder = 2
    OnClick = btnHelpClick
  end
  object DKLanguageController1: TDKLanguageController
    Left = 220
    Top = 228
    LangData = {
      0B00666D50726F6A50726F7073010100000001000000070043617074696F6E01
      1A000000050062746E4F6B010100000002000000070043617074696F6E000600
      62746E43616E010100000003000000070043617074696F6E0005005061676573
      00000C00546E7454616253686565743101010000000400000007004361707469
      6F6E0006004C6162656C34010100000005000000070043617074696F6E000900
      546E744C6162656C31010100000006000000070043617074696F6E000900546E
      744C6162656C33010100000007000000070043617074696F6E0006004C616265
      6C31010100000008000000070043617074696F6E0006004C6162656C32010100
      000009000000070043617074696F6E0006004C6162656C3301010000000A0000
      00070043617074696F6E0009006564576F726B4469720000080065644D61696E
      464E00000A0062746E576F726B44697201010000000C00000007004361707469
      6F6E0005006362456E6301010000000D00000005004974656D73000600636245
      6E647301010000000E00000005004974656D7300070063624C6578657200000C
      00546E7454616253686565743201010000000F000000070043617074696F6E00
      0900546E744C6162656C32010100000010000000070043617074696F6E000600
      6564446972730000090062746E44697241646401010000001100000007004361
      7074696F6E000900546E744C6162656C34010100000012000000070043617074
      696F6E0006006362536F727401010000001300000005004974656D73000C0054
      6E74546162536865657433010100000014000000070043617074696F6E000600
      65645661727300000900546E744C6162656C3501010000001500000007004361
      7074696F6E00070062746E48656C70010100000016000000070043617074696F
      6E00}
  end
end
