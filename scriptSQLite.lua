-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here
local sqlite3 = require("sqlite3")
local caminho = system.pathForFile("dados.db",system.DocumentsDirectory)
local banco = sqlite3.open(caminho)

local tabela = [[CREATE TABLE IF NOT EXISTS tabelaExemplo (id INTEGER PRIMARY KEY autoincrement, nome NOT NULL, cpf NOT NULL);]]
banco:exec(tabela)

local insertQuery = [[INSERT INTO tabelaExemplo VALUES (NULL, "Sebastiana Raimunda das Graças","000.000.000-00");]]
banco:exec(insertQuery)

local clientes = {
    {
        nome = "zefinha",
        cpf = "111.111.111-11"
    },
    {
        nome = "zé das coxinhas",
        cpf = "222.222.222-22"
    }
}

for i = 1, #clientes do
    local query = [[INSERT INTO tabelaExemplo VALUES (NULL, "]] .. clientes[i].nome .. [[","]] .. clientes[i].cpf .. [[");]]
    banco:exec(query)
end 

local query = [[UPDATE tabelaExemplo SET nome = "Rabiola" WHERE id = 2;]]
banco:exec(query)

local deletarUm = [[DELETE FROM tabelaExemplo WHERE id = 1;]]
banco:exec(deletarUm)

local clientesResgatados = {}

for linha in banco:nrows("SELECT * FROM tabelaExemplo") do 
    print("Cliente: ", linha.id)

    clientesResgatados[#clientesResgatados+1] = 
    {
        nome = linha.nome,
        cpf = linha.cpf
    }
end

if (banco and banco:isopen()) then 
    banco:close()
end
