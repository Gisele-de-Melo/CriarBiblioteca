//------------------------------------------------------------------------------------------------------------
//********* Sobre ************
//Autor: Gisele de Melo
//Esse código foi desenvolvido com o intuito de aprendizado para o blog codedelphi.com, portanto não me
//responsabilizo pelo uso do mesmo.
//
//********* About ************
//Author: Gisele de Melo
//This code was developed for learning purposes for the codedelphi.com blog, therefore I am not responsible for
//its use.
//------------------------------------------------------------------------------------------------------------

unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

type
  TAddNumbersFunc = function(A, B: Integer): Integer; stdcall;

procedure TForm1.Button1Click(Sender: TObject);
var
  MyMathLibHandle: THandle;
  AddNumbers: TAddNumbersFunc;
  Sum: Integer;

begin
  // Carregar a biblioteca DLL
  MyMathLibHandle := LoadLibrary('MyMathLibrary.dll');
  if MyMathLibHandle <> 0 then
  begin
    try
      // Obter o endereço da função AddNumbers
      @AddNumbers := GetProcAddress(MyMathLibHandle, 'AddNumbers');
      if Assigned(AddNumbers) then
      begin
        // Chamar a função AddNumbers
        Sum := AddNumbers(10, 20);
        Label1.Caption := 'A soma de 10 e 20 é: ' + IntToStr(Sum);
      end
      else
        Label1.Caption := 'Função AddNumbers não encontrada.';
    finally
      // Liberar a biblioteca DLL
      FreeLibrary(MyMathLibHandle);
    end;
  end
  else
    Label1.Caption := 'Falha ao carregar MyMathLibrary.dll';
end;

end.
