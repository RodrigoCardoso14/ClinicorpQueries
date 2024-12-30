object Form4: TForm4
  Left = 0
  Top = 0
  Caption = 'Form4'
  ClientHeight = 359
  ClientWidth = 647
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object FDConnection1: TFDConnection
    Params.Strings = (
      
        'Database=rds-clinicorp.cv0qm40u0ygk.us-east-1.rds.amazonaws.com:' +
        ':clinicorp'
      'DriverID=MySQL'
      'User_Name=UserTekCare'
      'Password=Ma#0bqpZkp$HOE!g3aq')
    LoginPrompt = False
    Left = 216
    Top = 104
  end
  object FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink
    Left = 320
    Top = 184
  end
end
