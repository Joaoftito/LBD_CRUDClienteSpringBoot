CREATE DATABASE CRUDCliente
GO
USE CRUDCliente
GO
CREATE TABLE Cliente(
cpf				CHAR(11),
nome			VARCHAR(100),
email			VARCHAR(100),
limiteCredito	DECIMAL(7,2),
dataNascimento	DATE
PRIMARY KEY(cpf)
)
GO
CREATE PROCEDURE sp_verificacao_cpf (@cpf CHAR(11), @valido BIT OUTPUT) AS
DECLARE @i INT = 1
DECLARE @calculo1 INT
DECLARE @calculo2 INT
DECLARE @digito1 INT
DECLARE @digito2 INT

IF @cpf = '00000000000' OR @cpf = '11111111111' OR @cpf = '22222222222' OR @cpf = '33333333333'
   OR @cpf = '44444444444' OR @cpf = '55555555555' OR @cpf = '66666666666' OR @cpf = '77777777777'
   OR @cpf = '88888888888' OR @cpf = '99999999999'
BEGIN
	SET @valido = 0
	RETURN
END

WHILE @i <= 9
BEGIN
	SET @calculo1 = @calculo1 + CAST(SUBSTRING(@cpf, @i, 1) AS INT) * (11 - @i)
    SET @i = @i + 1
END

SET @digito1 = CASE WHEN (@calculo1 * 10) % 11 = 10 
			   THEN 0 
			   ELSE (@calculo1 * 10) % 11 
			   END
SET @i = 1
    
WHILE @i <= 10
BEGIN
	SET @calculo2 = @calculo2 + CAST(SUBSTRING(@cpf, @i, 1) AS INT) * (12 - @i)
    SET @i = @i + 1
END

SET @digito2 = CASE WHEN (@calculo2 * 10) % 11 = 10 
               THEN 0 
			   ELSE (@calculo2 * 10) % 11 
			   END

IF @digito1 = CAST(SUBSTRING(@cpf, 10, 1) AS INT) AND @digito2 = CAST(SUBSTRING(@cpf, 11, 1) AS INT)
BEGIN
	SET @valido = 1
END

ELSE
BEGIN
	SET @valido = 0
END
GO
CREATE PROCEDURE sp_inserir (@cpf CHAR(11), @nome VARCHAR(100), @email VARCHAR(100), @limiteCredito DECIMAL(7,2),
							 @dataNascimento DATE, @saida VARCHAR(100) OUTPUT) AS

DECLARE @valido BIT
EXEC sp_verificacao_cpf @cpf, @valido OUTPUT

IF @valido = 0
BEGIN
	RAISERROR('CPF digitado é inválido, tente novamente.', 16, 1)
    RETURN
END

INSERT INTO Cliente (cpf, nome, email, limiteCredito, dataNascimento) VALUES 
(@cpf, @nome, @email, @limiteCredito, @dataNascimento)

SET @saida = 'Cliente ' + @nome + ' foi adicionado com sucesso!'
GO
CREATE PROCEDURE sp_atualizar (@cpf CHAR(11), @nome VARCHAR(100), @email VARCHAR(100), @limiteCredito DECIMAL(7,2),
							   @dataNascimento DATE, @saida VARCHAR(100) OUTPUT) AS

UPDATE Cliente
SET nome = @nome,
    email = @email,
    limiteCredito = @limiteCredito,
    dataNascimento = @dataNascimento
WHERE cpf = @cpf

SET @saida = 'Cliente ' + @nome + ' foi atualizado com sucesso!'
GO
CREATE PROCEDURE sp_excluir (@cpf CHAR(11), @saida VARCHAR(100) OUTPUT) AS
DELETE FROM Cliente WHERE cpf = @cpf

SET @saida = 'Cliente ' + @cpf + ' foi removido com sucesso!'