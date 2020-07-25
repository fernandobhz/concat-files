program Concatena;

uses
  Forms,
  SysUtils,
  UDMUtilidades in 'UDMUtilidades.pas' {DMUtilidades: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TDMUtilidades, DMUtilidades);
  try
    DMUtilidades:=TDMUtilidades.Create(nil);
    with DMUtilidades do
      if ((ConcatenaOD.Execute) and (ConcatenaSD.Execute)) then
          ConcatenaJvThread.ExecuteWithDialog(nil);
  finally
    freeandnil(DMUtilidades);
  end;
end.
