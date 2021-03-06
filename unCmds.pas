unit unCmds;

interface

uses
  ATSyntMemo;

function IsCmdEditing(Cmd: integer): boolean;

const
  sm_CaretsRemoveLeaveFirst  = ATSyntMemo.smCaretsRemoveLeaveFirst;
  sm_CaretsRemoveLeaveLast   = ATSyntMemo.smCaretsRemoveLeaveLast;
  sm_CaretsFromSelLeft       = ATSyntMemo.smCaretsFromSelLeft;
  sm_CaretsFromSelRight      = ATSyntMemo.smCaretsFromSelRight;
  sm_CaretsFromSelClear      = ATSyntMemo.smCaretsFromSelClear;
  sm_CaretsFromMarksLeft     = ATSyntMemo.smCaretsFromMarksLeft;
  sm_CaretsFromMarksRight    = ATSyntMemo.smCaretsFromMarksRight;
  sm_CaretsFromMarksClear    = ATSyntMemo.smCaretsFromMarksClear;
  sm_CaretsExtendUpLine      = ATSyntMemo.smCaretsUpLine;
  sm_CaretsExtendDownLine    = ATSyntMemo.smCaretsDownLine;
  sm_CaretsExtendUpPage      = ATSyntMemo.smCaretsUpPage;
  sm_CaretsExtendDownPage    = ATSyntMemo.smCaretsDownPage;
  sm_CaretsExtendUpEnd       = ATSyntMemo.smCaretsUpToEnd;
  sm_CaretsExtendDownEnd     = ATSyntMemo.smCaretsDownToEnd;

const
  sm_CopyAsHtml = 309;
  sm_CopyAsRtf = 310;

  sm_ReplaceInFiles = 617;
  sm_ReplaceInProject = 618;
  sm_ListerFindDialog = 620;
  sm_ListerFindNext = 621;
  sm_ListerFindPrev = 622;
  sm_PrinterSetup = 634;
  sm_AutoComplete = 670;

  sm_FileNew = 700;
  sm_FileOpen = 701;
  sm_FileSave = 702;
  sm_FileExportRtf = 704;
  sm_FileExportHtml = 705;
  sm_FileSaveAs = 706;
  sm_FileReopen = 707;

  sm_OptSetup = 709;
  sm_OptSetupLexer = 710;
  sm_OptSetupLexerLib = 711;
  sm_OptReadOnly = 712;
  sm_OptShowOutputPanel = 713;
  sm_OptShowLeftPanel = 715;
  sm_ZoomOut = 716;
  sm_ZoomIn = 717;
  sm_ZoomOriginal = 718;
  sm_OptShowRightPanel = 719;

  sm_CopyAppend = 720;
  sm_CutAppend = 721;
  sm_FileSaveSessionAs = 722;
  sm_FileOpenSession = 723;
  sm_FileAddSession = 724;
  sm_CopyLine = 725;
  sm_CutLine = 726;
  sm_FileSaveSession = 727;
  sm_FileCloseSession = 728;

  sm_OptRuler = 729;
  sm_OptWrap = 730;
  sm_OptLineNums = 731;
  sm_OptFolding = 732;
  sm_OptNonPrint = 733;
  sm_ToggleFocusTree = 734;
  sm_ToggleFocusClip = 735;
  sm_ToggleFocusOutput = 739;

  sm_FileNewWindow = 740;
  sm_FileClose = 741;
  sm_FileCloseAll = 742;
  sm_FileCloseOthers = 743;
  sm_FileSaveAll = 744;
  sm_FileExit = 745;
  sm_FileCloseAndDelete = 746;
  sm_FileMoveToOtherView = 747;

  sm_CopyFilename = 752;
  sm_CopyFullPath = 753;
  sm_CopyDirPath = 754;
  sm_ToggleFocusFindRes = 755;
  sm_ToggleFocusGroups = 756;
  sm_ToggleFocusValidate = 757;
  sm_ToggleFocusMap = 758;
  sm_ToggleFocusProj = 759;
  sm_ToggleFocusTabs = 760;

  sm_TreeParent = 765;
  sm_TreeNextBrother = 766;
  sm_TreePrevBrother = 767;
  sm_ToggleSlaveView = 768;
  sm_ToggleFocusMasterSlave = 769;
  sm_SplitViewsVertHorz = 770;
  sm_SplitSlaveVertHorz = 771;
  sm_GotoBookmarkDialog = 772;
  sm_ToggleFocusClips = 776;
  sm_IndentLike1st = 780;
  sm_PasteNoCursorChange = 783;
  sm_CancelSelection = 786;
  sm_ExtendSelByLine = 788;
  sm_CollapseParent = 790;
  sm_CollapseWithNested = 791;
  sm_FindCommand = 792;
  sm_PasteToColumn1 = 793;
  sm_CommandsList = 794;
  sm_ScrollToSel = 795;
  sm_ProjectList = 796;
  sm_ToggleShowGroup2 = 798;
  sm_PasteAsColumnBlock = 799;
  sm_ToggleShowMicromap = 800;

  //free
  sm_Menu_EncodingsConvert = 809;
  sm_Menu_EncodingsChange = 810;
  sm_Menu_Lexers = 811;
  sm_Menu_LineEnds = 812;

  sm_ClearFilesHistory = 813;
  sm_QuickSearch = 814;
  sm_GotoNextFindResult = 817;
  sm_GotoPrevFindResult = 818;
  sm_ToggleSyncEditing = 819;
  sm_ShowFullScreen = 820;
  sm_SyncScrollHorz = 821;
  sm_SyncScrollVert = 822;
  sm_ShowOnTop = 823;
  sm_FillBlockDialog = 824;
  sm_JoinLines = 828;
  sm_SplitLines = 829;

  sm_OpenBrowserFirefox = 830;
  sm_OpenBrowserIE = 831;
  sm_OpenBrowserChrome = 832;
  sm_OpenBrowserSafari = 833;
  sm_OpenCurrentFolder = 834;
  sm_MacrosDialog = 839;

  sm_BookmarksClear = 841;
  sm_BookmarksToggle = 842;
  sm_BookmarksNext = 843;
  sm_BookmarksPrev = 844;
  sm_BookmarksCopy = 845;
  sm_BookmarksCut = 846;
  sm_BookmarksDelete = 847;
  sm_BookmarksDeleteUnmarked = 848;
  sm_BookmarksPaste = 849;
  sm_BookmarksInverse = 850;

  sm_ConvertSpacesToTabsLeading = 852;
  sm_TrimLeading = 857;
  sm_TrimTrailing = 858;
  sm_TrimAll = 859;
  sm_RemoveDupSpaces = 860;
  sm_ConvertTabsToSpaces = 861;
  sm_ConvertSpacesToTabsAll = 862;
  sm_FindClipboardNext = 863;
  sm_FindClipboardPrev = 864;
  sm_RepeatLastCommand = 865;
  sm_MarkersClear = 866;
  sm_TreeNextNode = 867;
  sm_TreePrevNode = 868;
  sm_GotoNextBlank = 870;
  sm_GotoPrevBlank = 871;
  sm_SelectParagraph = 872;

  sm_SelectToWordEnd = 873;
  sm_JumpToWordEnd = 874;
  sm_FindNextAndExtendSel = 875;
  sm_FindPrevAndExtendSel = 876;
  sm_JumpToLastMarker = 877;
  sm_OpenCurrentFile = 878;
  sm_SelectToken = 879;
  sm_GotoSelectionStartEnd = 881;
  sm_ReplaceFromClip = 882; //not used
  sm_ReplaceFromClipAll = 883;
  sm_RereadOutputPanel = 884;
  sm_NumericConverterDialog = 889;
  sm_SelectionExtend = 893;
  sm_SelectionShrink = 894;
  sm_DeleteToFileBegin = 896;
  sm_DeleteToFileEnd = 897;

  sm_MacroRepeat = 900;
  sm_Macro1 = 901;
  sm_Macro2 = 902;
  sm_Macro3 = 903;
  sm_Macro4 = 904;
  sm_Macro5 = 905;
  sm_Macro6 = 906;
  sm_Macro7 = 907;
  sm_Macro8 = 908;
  sm_Macro9 = 909;
  //sm_Macro10..30: below

  sm_Tab0 = 910;
  sm_Tab1 = 911;
  sm_Tab2 = 912;
  sm_Tab3 = 913;
  sm_Tab4 = 914;
  sm_Tab5 = 915;
  sm_Tab6 = 916;
  sm_Tab7 = 917;
  sm_Tab8 = 918;
  sm_Tab9 = 919;

  sm_Split2080 = 920;
  sm_Split3070 = 921;
  sm_Split4060 = 922;
  sm_Split5050 = 923;
  sm_Split6040 = 924;
  sm_Split7030 = 925;
  sm_Split8020 = 926;
  sm_SplitLeft = 927;
  sm_SplitRight = 928;

  sm_TabRt0 = 930;
  sm_TabRt1 = 931;
  sm_TabRt2 = 932;
  sm_TabRt3 = 933;
  sm_TabRt4 = 934;
  sm_TabRt5 = 935;
  sm_TabRt6 = 936;
  sm_TabRt7 = 937;
  sm_TabRt8 = 938;
  sm_TabRt9 = 939;

  sm_Macro10 = 940;
  sm_Macro11 = 941;
  sm_Macro12 = 942;
  sm_Macro13 = 943;
  sm_Macro14 = 944;
  sm_Macro15 = 945;
  sm_Macro16 = 946;
  sm_Macro17 = 947;
  sm_Macro18 = 948;
  sm_Macro19 = 949;
  sm_Macro20 = 950;
  sm_Macro21 = 951;
  sm_Macro22 = 952;
  sm_Macro23 = 953;
  sm_Macro24 = 954;
  sm_Macro25 = 955;
  sm_Macro26 = 956;
  sm_Macro27 = 957;
  sm_Macro28 = 958;
  sm_Macro29 = 959;
  sm_Macro30 = 960;
  {
  sm_Macro31 = 961;
  sm_Macro32 = 962;
  sm_Macro33 = 963;
  sm_Macro34 = 964;
  sm_Macro35 = 965;
  sm_Macro36 = 966;
  sm_Macro37 = 967;
  sm_Macro38 = 968;
  sm_Macro39 = 969;
  sm_Macro40 = 970;
  }

  sm_FoldLevel2 = 982;
  sm_FoldLevel3 = 983;
  sm_FoldLevel4 = 984;
  sm_FoldLevel5 = 985;
  sm_FoldLevel6 = 986;
  sm_FoldLevel7 = 987;
  sm_FoldLevel8 = 988;
  sm_FoldLevel9 = 989;
  //free

  sm_OptNonPrintOff = 1002;
  sm_OptNonPrintSpaces = 1003;
  sm_OptNonPrintEol = 1004;
  sm_OptNonPrintBoth = 1005;
  sm_OptNonPrintEolDetails = 1006;

  sm_HideMenuItemsDialog = 1007;
  sm_RestoreStylesDialog = 1008;
  sm_ExternalToolsDialog = 1009;
  sm_EditSynPluginsIni = 1011;
  sm_EditSynIni = 1012;
  sm_OpenBySelection = 1013;
  //free for options categories

  sm_CopySearchMarks = 1020;
  sm_OpenProject = 1021;
  sm_AddFileToProject = 1022;
  sm_NewProject = 1024;
  sm_PasteAndSelect = 1025;
  sm_InsertBlankLineAbove = 1026;
  sm_InsertBlankLineBelow = 1027;
  sm_OpenCmdPrompt = 1028;
  sm_CopyCurrentURL = 1029;
  sm_OpenCurrentURL = 1030;
  sm_FindId = 1031;
  sm_AddRecentColorCode = 1032;
  sm_SaveFolding = 1033;
  sm_LoadFolding = 1034;
  sm_OpenLastClosedFile = 1035;
  sm_SelectTokenNoQuotes = 1038;
  sm_AddFilesToProject = 1039;
  sm_ScrollCurrentLineToTop = 1040;
  sm_ScrollCurrentLineToBottom = 1041;
  sm_ScrollCurrentLineToMiddle = 1042;
  sm_SaveProject = 1043;
  sm_ToggleFocusConsole = 1044;
  sm_NewSnippetDialog = 1046;
  sm_SnippetsDialog = 1047;
  sm_HelpFileContents = 1048;
  sm_ResetPythonPlugins = 1049;
  sm_GotoNextTab = 1050;
  sm_GotoPrevTab = 1051;
  sm_GotoNextOutputResult = 1052;
  sm_GotoPrevOutputResult = 1053;
  sm_GotoNextSearchOrOutputResult = 1054;
  sm_GotoPrevSearchOrOutputResult = 1055;
  sm_ToggleShowFoldersOnTabs = 1056;
  sm_InsertUnicodeHexDialog = 1057;
  sm_UpdateProject = 1058;
  sm_FileCloseOthersAllGroups = 1059;
  sm_MoveCurrentTabToNextGroup = 1060;
  sm_MoveCurrentTabToPrevGroup = 1061;
  sm_ToggleFocusBookmarks = 1062;
  sm_PrintNowAll = 1063;
  sm_PrintNowSelection = 1064;
  sm_GotoNextModifiedLine = 1065;
  sm_GotoPrevModifiedLine = 1066;
  sm_GotoNextModifiedOrSavedLine = 1067;
  sm_GotoPrevModifiedOrSavedLine = 1068;
  sm_OpenEntireFolder = 1069;

  sm_SentenceCaseBlock = 1070;
  sm_RandomCaseBlock = 1071;
  sm_RestartProgram = 1072;
  //free

  //Tree commands
  sm_TreeCollapseAll = 1090;
  sm_TreeExpandAll = 1091;

  sm_TreeLevel2 = 1092;
  sm_TreeLevel3 = 1093;
  sm_TreeLevel4 = 1094;
  sm_TreeLevel5 = 1095;
  sm_TreeLevel6 = 1096;
  sm_TreeLevel7 = 1097;
  sm_TreeLevel8 = 1098;
  sm_TreeLevel9 = 1099;

  //Tab colors
  sm_TabColorDefault = 1100;
  sm_TabColor1 = 1101;
  sm_TabColor2 = 1102;
  sm_TabColor3 = 1103;
  sm_TabColor4 = 1104;
  sm_TabColor5 = 1105;
  sm_TabColor6 = 1106;
  sm_TabColor7 = 1107;
  sm_TabColor8 = 1108;
  sm_TabColor9 = 1109;
  sm_TabColor10 = 1110;
  sm_TabColorCustom = 1111;

  //Options dialog tabs
  sm_OptionsTab_ProgramOpt = 1115;
  sm_OptionsTab_Colors = 1116;
  sm_OptionsTab_Fonts = 1117;
  sm_OptionsTab_Tabs = 1118;
  sm_OptionsTab_EditorView = 1119;
  sm_OptionsTab_EditorSelect = 1120;
  sm_OptionsTab_EditorCarets = 1121;
  sm_OptionsTab_EditorOverrides = 1122;
  sm_OptionsTab_Keys = 1123;
  sm_OptionsTab_FormatsReload = 1124;
  sm_OptionsTab_Search = 1125;
  sm_OptionsTab_TreeMap = 1126;
  sm_OptionsTab_History = 1127;
  sm_OptionsTab_SessionsProject = 1128;
  sm_OptionsTab_AutoComplete = 1129;
  sm_OptionsTab_AutoSave = 1130;
  sm_OptionsTab_Paths = 1132;
  //free 1133;
  //free 1134;
  sm_OptionsTab_EditorUndo = 1135;
  sm_OptionsTab_EditorInsertFmt = 1136;
  sm_OptionsTab_NewOpen = 1137;

  //Addons manager
  sm_AddonsManager_Install = 1150;
  sm_AddonsManager_Remove = 1151;
  sm_AddonsManager_Edit = 1152;
  sm_AddonsManager_Update = 1153;
  sm_AddonsManager_SaveAll = 1154;
  sm_AddonsManager_Config = 1155;

  sm_EncodingChange_Ansi = 1200;
  sm_EncodingChange_Oem = 1201;
  sm_EncodingChange_Utf8Bom = 1202;
  sm_EncodingChange_Utf8NoBom = 1203;
  sm_EncodingChange_Utf16LE = 1204;
  sm_EncodingChange_Utf16BE = 1205;

  sm_EncodingConvert_Ansi = 1210;
  sm_EncodingConvert_Oem = 1211;
  sm_EncodingConvert_Utf8Bom = 1212;
  sm_EncodingConvert_Utf8NoBom = 1213;
  sm_EncodingConvert_Utf16LE = 1214;
  sm_EncodingConvert_Utf16BE = 1215;
  //end of list

implementation

uses
  Windows, ecCmdConst;

function IsCmdEditing(Cmd: integer): boolean;
begin
  case Cmd of
    smCopy,
    smCut,
    smPaste,
    smClearSelection,

    smDeleteLastChar,
    smDeleteChar,
    smDeleteWord,
    smDeleteLastWord,
    smDeleteBOL,
    smDeleteEOL,
    smDeleteLine,
    smClearAll,

    smLineBreak,
    smInsertLine,
    smChar,
    smString,
    smLineBreakSoft,
    smBlockIndent,
    smBlockUnindent,
    smTab,
    smTabChar,

    smUpperCase,
    smLowerCase,
    smToggleCase,
    smTitleCase,
    smUpperCaseBlock,
    smLowerCaseBlock,
    smToggleCaseBlock,
    smTitleCaseBlock,
    sm_SentenceCaseBlock,
    sm_RandomCaseBlock,

    smInsertMode,
    smOverwriteMode,
    smToggleMode,
    smMarkSelStart,
    smMarkSelEnd,

    smChangeRangeSide,

    smMoveLinesUp,
    smMoveLinesDown,
    smDuplicateLine,
    
    sm_PasteToColumn1,
    sm_PasteNoCursorChange,
    sm_PasteAsColumnBlock,
    sm_PasteAndSelect,

    smCopyPasteFileEnd,
    smCopyPasteFileStart,
    smCutPasteFileEnd,
    smCutPasteFileStart,
    smCopyPasteAbove,
    smCopyPasteBelow,

    sm_GotoNextBlank,
    sm_GotoPrevBlank,
    sm_SelectParagraph,
    sm_SelectToWordEnd,
    sm_JumpToWordEnd

      : Result:= true;
    else
      Result:= false;
  end;
end;

end.
