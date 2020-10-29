function dadosUsuario()
	Dim WshNetwork
	Set WshNetwork = WScript.CreateObject("WScript.Network")
	dadosUsuario = Array(WshNetwork.UserName, WshNetwork.ComputerName)
end function

function criarArquivo(localpasta, nomearquivo, status)
	Set objFSO = CreateObject("Scripting.FileSystemObject")
	if objFSO.FolderExists(localpasta) then
	Set objTxtResult = objFSO.OpenTextFile (localpasta & nomearquivo, 2, true)
		objTxtResult.WriteLine(dadosUsuario()(0))
		objTxtResult.WriteLine(dadosUsuario()(1))
		objTxtResult.WriteLine(status)
		objTxtResult.close
		Set objFSO = Nothing
		Set objTxtResult = Nothing
		criarArquivo = true
	else
		criarArquivo = false
	end if
end function

function lerArquivo(localpasta, nomearquivo)
	Set objFSO = CreateObject("Scripting.FileSystemObject")
	if objFSO.FolderExists(localpasta) then
		set objTxtResult = objFSO.OpenTextFile (localpasta & nomearquivo, 1, true)
		numerolinha = 0
		Do Until objTxtResult.AtEndOfStream
			if numerolinha = 0 then
				usuariolocal = objTxtResult.ReadLine
			elseif numerolinha = 1 then
				nomedamaquina = objTxtResult.ReadLine
			elseif numerolinha = 2 then
				status = objTxtResult.ReadLine
			end if
			numerolinha = numerolinha + 1
		loop
		Set objFSO = Nothing
		Set objTxtResult = Nothing
		lerArquivo = Array(usuariolocal, nomedamaquina, status)
	else
		lerArquivo = Array("NaoLocalizado", "NaoLocalizado", "Desconhecido")
	end if
	
end function

'On Error Resume Next

dim localizacaoarquivo
Set pasta = CreateObject("Scripting.FileSystemObject")

'Local da pasta onde o log sera salvo

localizacaoarquivo = "COLOQUE O CAMINHO AQUI"

	if WScript.Arguments(0) = "logon" then
		call criarArquivo(localizacaoarquivo, dadosUsuario()(0), "logon")
		do while true
			if lerArquivo(localizacaoarquivo, dadosUsuario()(0))(1) = "NaoLocalizado" or lerArquivo(localizacaoarquivo, dadosUsuario()(0))(2) = "logout" or lerArquivo(localizacaoarquivo, dadosUsuario()(0))(2) = "" then
				call criarArquivo(localizacaoarquivo, dadosUsuario()(0), "logon")
			elseif lerArquivo(localizacaoarquivo, dadosUsuario()(0))(1) <> dadosUsuario()(1) and lerArquivo(localizacaoarquivo, dadosUsuario()(0))(2) = "logon" then
				dim oShell
				Set oShell = CreateObject("WScript.Shell")
				retorno = oShell.Run("cmd /c shutdown -l -f", 0, false)
				exit do
			end if
			WScript.Sleep 120000
		loop
	elseif WScript.Arguments(0) = "logout" then
		call criarArquivo(localizacaoarquivo, dadosUsuario()(0), "logout")
	end if

WScript.quit