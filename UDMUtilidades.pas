unit UDMUtilidades;

interface

uses
  SysUtils, Windows, Classes, Dialogs, JvThread, JvComponentBase, JvThreadDialog,
  JvFormPlacement, JvChangeNotify, JvTimer, JvBaseDlg,
  JvBrowseFolder, DateUtils, Forms, ShellApi, Controls;

type
  TDMUtilidades = class(TDataModule)
    ConcatenaOD: TOpenDialog;
    ConcatenaSD: TSaveDialog;
    ConcatenaJvThreadAnimateDialog: TJvThreadAnimateDialog;
    ConcatenaJvThread: TJvThread;
    JvFormStorage1: TJvFormStorage;
    NumerosJvThread: TJvThread;
    NumerosOD: TOpenDialog;
    NumerosSD: TSaveDialog;
    NumerosJvThreadAnimateDialog: TJvThreadAnimateDialog;
    procedure ConcatenaJvThreadExecute(Sender: TObject; Params: Pointer);
    procedure DataModuleCreate(Sender: TObject);
    procedure NumerosJvThreadExecute(Sender: TObject;
      Params: Pointer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DMUtilidades: TDMUtilidades;
  FolderStarted, FolderFinished: Bool;
  FolderTimeLimit: TDateTime;

implementation

{$R *.dfm}

procedure TDMUtilidades.ConcatenaJvThreadExecute(Sender: TObject; Params: Pointer);
var
  FromF, ToF: file;
  NumRead, NumWritten: Integer;
  Buffer: array[1..2048] of Byte;
  i: integer;
begin
  try
    AssignFile(ToF, ConcatenaSD.FileName);
    Rewrite(ToF, 1) ;

    ConcatenaOD.InitialDir:=ExtractFilePath(ConcatenaOD.FileName);
    ConcatenaSD.InitialDir:=ExtractFilePath(ConcatenaSD.FileName);
    JvFormStorage1.SaveFormPlacement;

    for i := 0 to (ConcatenaOD.Files.Count - 1) do
    begin
      AssignFile(FromF, ConcatenaOD.Files.Strings[i]) ;
      Reset(FromF, 1) ;
      repeat
        BlockRead(FromF, Buffer, SizeOf(Buffer), NumRead);
        BlockWrite(ToF, Buffer, NumRead, NumWritten);
      until (NumRead = 0) or (NumWritten <> NumRead);
      CloseFile(FromF);
    end;
    CloseFile(ToF);

    ConcatenaJvThread.SynchMessageDlg('Concatenação concluída com sucesso', mtinformation, [mbok], 0);
  except
    on e:exception do ConcatenaJvThread.SynchMessageDlg('ERRO : ' + E.Message, mterror, [mbok], 0);
  end;
end;


procedure TDMUtilidades.DataModuleCreate(Sender: TObject);
begin
  JvFormStorage1.RestoreFormPlacement;
end;

procedure TDMUtilidades.NumerosJvThreadExecute(Sender: TObject;
  Params: Pointer);
var
  FromF, ToF: file;
  NumRead, NumWritten: Integer;
  Buffer: Byte;
begin
  try
    AssignFile(ToF, NumerosSD.FileName);
    Rewrite(ToF, 1) ;
    AssignFile(FromF, NumerosOD.FileName);
    Reset(FromF, 1) ;

    NumRead:=0; NumWritten:=0;
    NumerosOD.InitialDir:=ExtractFilePath(NumerosOD.FileName);
    NumerosSD.InitialDir:=ExtractFilePath(NumerosSD.FileName);
    JvFormStorage1.SaveFormPlacement;

    repeat
      BlockRead(FromF, Buffer, SizeOf(Buffer), NumRead);
        if ( ((Buffer>=48) and (Buffer<=57)) or (Buffer=10) or (Buffer=13)) then
          BlockWrite(ToF, Buffer, NumRead, NumWritten)
          else begin NumWritten:=1; end;
     until (NumRead = 0) or (NumWritten <> NumRead) ;

    CloseFile(FromF);
    CloseFile(ToF);

    NumerosJvThread.SynchMessageDlg('Filtraem concluída com sucesso', mtinformation, [mbok], 0);
  except
    on e:exception do NumerosJvThread.SynchMessageDlg('ERRO : ' + E.Message, mterror, [mbok], 0);
  end;
end;

end.
