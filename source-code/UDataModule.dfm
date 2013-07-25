object HangmanDataModule: THangmanDataModule
  OldCreateOrder = False
  Left = 300
  Top = 314
  Height = 572
  Width = 613
  object HangmanADOConnection: TADOConnection
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=C:\Student\Term 2 D' +
      'elphi Projects\GUI Hangman\Prototype 3\Database\HangmanDatabase.' +
      'mdb;Persist Security Info=False'
    LoginPrompt = False
    Mode = cmShareDenyNone
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 80
    Top = 40
  end
  object PlayersADOTable: TADOTable
    Connection = HangmanADOConnection
    CursorType = ctStatic
    TableName = 'Players'
    Left = 216
    Top = 40
    object PlayersADOTablePlayerLogin: TWideStringField
      FieldName = 'PlayerLogin'
      Size = 50
    end
    object PlayersADOTablePlayerFirstName: TWideStringField
      FieldName = 'PlayerFirstName'
      Size = 50
    end
    object PlayersADOTablePlayerLastName: TWideStringField
      FieldName = 'PlayerLastName'
      Size = 50
    end
    object PlayersADOTablePlayerDateTimeRegistered: TDateTimeField
      FieldName = 'PlayerDateTimeRegistered'
    end
  end
  object GamesADOTable: TADOTable
    Connection = HangmanADOConnection
    CursorType = ctStatic
    IndexFieldNames = 'GamePlayerLogin'
    MasterFields = 'PlayerLogin'
    MasterSource = PlayersDataSource
    TableName = 'Games'
    Left = 216
    Top = 112
  end
  object PlayersDataSource: TDataSource
    DataSet = PlayersADOTable
    Left = 352
    Top = 40
  end
  object GamesDataSource: TDataSource
    DataSet = GamesADOTable
    Left = 352
    Top = 112
  end
  object CalcPlayerGamesPlayed: TADOStoredProc
    Connection = HangmanADOConnection
    ProcedureName = 'CalcPlayerGamesPlayed'
    Parameters = <
      item
        Name = 'PlayerLogin'
        DataType = ftString
        Size = -1
        Value = Null
      end
      item
        Name = 'GameDifficultyLevel'
        DataType = ftString
        Size = -1
        Value = Null
      end>
    Prepared = True
    Left = 216
    Top = 192
    object CalcPlayerGamesPlayedPlayerLogin: TWideStringField
      FieldName = 'PlayerLogin'
      Size = 50
    end
    object CalcPlayerGamesPlayedGameDifficultyLevel: TWideStringField
      FieldName = 'GameDifficultyLevel'
    end
    object CalcPlayerGamesPlayedCountOfGameDateTimeCompleted: TIntegerField
      FieldName = 'CountOfGameDateTimeCompleted'
    end
  end
  object CalcPlayerAverageScore: TADOStoredProc
    Connection = HangmanADOConnection
    ProcedureName = 'CalcPlayerAverageScore'
    Parameters = <
      item
        Name = 'PlayerLogin'
        DataType = ftString
        Size = -1
        Value = Null
      end
      item
        Name = 'GameDifficultyLevel'
        DataType = ftString
        Size = -1
        Value = Null
      end>
    Prepared = True
    Left = 216
    Top = 272
  end
  object CalcPlayerBestScore: TADOStoredProc
    Connection = HangmanADOConnection
    ProcedureName = 'CalcPlayerBestScore'
    Parameters = <
      item
        Name = 'PlayerLogin'
        DataType = ftString
        Size = -1
        Value = Null
      end
      item
        Name = 'GameDifficultyLevel'
        DataType = ftString
        Size = -1
        Value = Null
      end>
    Prepared = True
    Left = 216
    Top = 352
  end
  object CalcAllGamesPlayed: TADOStoredProc
    Connection = HangmanADOConnection
    ProcedureName = 'CalcAllGamesPlayed'
    Parameters = <
      item
        Name = 'GameDifficultyLevel'
        DataType = ftString
        Size = -1
        Value = Null
      end>
    Prepared = True
    Left = 352
    Top = 192
  end
  object CalcAllAverageScore: TADOStoredProc
    Connection = HangmanADOConnection
    ProcedureName = 'CalcAllAverageScore'
    Parameters = <
      item
        Name = 'GameDifficultyLevel'
        DataType = ftString
        Size = -1
        Value = Null
      end>
    Prepared = True
    Left = 352
    Top = 272
  end
  object CalcChampionDetails: TADOStoredProc
    Connection = HangmanADOConnection
    ProcedureName = 'CalcChampionDetails'
    Parameters = <
      item
        Name = 'GameDifficultyLevel'
        DataType = ftString
        Size = -1
        Value = Null
      end>
    Prepared = True
    Left = 352
    Top = 352
  end
end
