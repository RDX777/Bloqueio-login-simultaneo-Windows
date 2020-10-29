# Bloqueio-login-simultaneo-Windows
Realiza o logoff de logins de usuarios em mais de uma maquina em um domínio.


Como usar:

Este script podera ser usado em GPO.

cscript LoginSimultaneo.vbs <Parametro>

logon

devera ser executado ao logar na maquina. Exemplo: cscript LoginSimultaneo.vbs logon

logout

devera ser executado ao realizar o logoff na maquina. Exemplo: cscript LoginSimultaneo.vbs logout


Necessario ter uma pasta na rede para serem salvos os logs. E especificado o caminho no scritp este caminho.
