object DMUtilidades: TDMUtilidades
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 411
  Width = 804
  object ConcatenaOD: TOpenDialog
    Filter = 'Todos arquivos|*.*'
    InitialDir = 'C:\'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofAllowMultiSelect, ofEnableSizing]
    Title = 'Selecione os arquivos a concatenar ...'
    Left = 64
    Top = 8
  end
  object ConcatenaSD: TSaveDialog
    Filter = 'Todos arquivos|*.*'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Title = 'Salvar arquivos concatenados em ...'
    Left = 64
    Top = 64
  end
  object ConcatenaJvThreadAnimateDialog: TJvThreadAnimateDialog
    DialogOptions.FormStyle = fsNormal
    DialogOptions.ShowDialog = True
    DialogOptions.CancelButtonCaption = 'Cancelar'
    DialogOptions.Caption = 'Concatenando arquivos'
    DialogOptions.InfoText = 'Aguarde o processo de concatena'#231#227'o dos arquivos.'
    DialogOptions.InfoTextAlignment = taCenter
    DialogOptions.CommonAVI = aviCopyFiles
    Left = 224
    Top = 64
  end
  object ConcatenaJvThread: TJvThread
    Exclusive = True
    RunOnCreate = True
    FreeOnTerminate = True
    ThreadDialog = ConcatenaJvThreadAnimateDialog
    OnExecute = ConcatenaJvThreadExecute
    Left = 224
    Top = 8
  end
  object JvFormStorage1: TJvFormStorage
    AppStoragePath = 'DMConcatena\'
    Options = []
    StoredProps.Strings = (
      'ConcatenaOD.FileName'
      'ConcatenaOD.InitialDir'
      'ConcatenaOD.Title'
      'ConcatenaSD.FileName'
      'ConcatenaSD.InitialDir'
      'ConcatenaSD.Title'
      'NumerosOD.FileName'
      'NumerosOD.InitialDir'
      'NumerosOD.Title'
      'NumerosSD.InitialDir'
      'NumerosSD.FileName'
      'NumerosSD.Title')
    StoredValues = <>
    Left = 592
    Top = 8
  end
  object NumerosJvThread: TJvThread
    Exclusive = True
    RunOnCreate = True
    FreeOnTerminate = True
    ThreadDialog = NumerosJvThreadAnimateDialog
    OnExecute = NumerosJvThreadExecute
    Left = 224
    Top = 152
  end
  object NumerosOD: TOpenDialog
    Filter = 'Todos os arquivos (*.*)|*.*'
    InitialDir = 'C:\'
    Title = 'Selecione o arquivo '#224' filtrar'
    Left = 64
    Top = 152
  end
  object NumerosSD: TSaveDialog
    Filter = 'Todos os arquivos (*.*)|*.*'
    InitialDir = 'C:\'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Title = 'Salvar arquivo filtrado em ...'
    Left = 64
    Top = 208
  end
  object NumerosJvThreadAnimateDialog: TJvThreadAnimateDialog
    DialogOptions.FormStyle = fsNormal
    DialogOptions.ShowDialog = True
    DialogOptions.CancelButtonCaption = 'Cancelar'
    DialogOptions.Caption = 'Filtrando n'#250'meros no arquivo'
    DialogOptions.InfoText = 'Aguarde o processo de filtragem'
    DialogOptions.InfoTextAlignment = taCenter
    DialogOptions.CommonAVI = aviFindFile
    Left = 224
    Top = 208
  end
end
