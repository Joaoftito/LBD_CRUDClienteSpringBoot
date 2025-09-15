<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-LN+7fdVzj6u52u30Kp6M/trliBMCMKTyK833zpbD+pXdCLuTusPj697FH4R/5mcr" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js" integrity="sha384-ndDqU0Gzau9qJ1lfW4pNLlhNTkCfHzAVBReH9diLvGRem5+R9g2FzA8ZGN954O5Q" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<title>Cadastro Cliente</title>
</head>
<body>
	<br />
	<div class="conteiner" align="center">
		<h1>Cadastro Cliente</h1>
		<br />
		<form action="cliente" method="post">
			<table>
				<tr>
					<td colspan="3">
						<input type="number" min="1" step="1"
						id="cpf" name="cpf" placeholder="CPF"
						value='<c:out value="${cliente.cpf}"/>'
						class="input-group input-group-lg" >
					</td>
					<td colspan="1">
						<input type="submit"
						id="botao" name="botao" value="Buscar"
						class="btn btn-dark">
					</td>				
				</tr>		
				<tr>
					<td colspan="4">
						<input type="text" 
						id="nome" name="nome" placeholder="Nome"
						value='<c:out value="${cliente.nome}"/>'
						class="input-group input-group-lg">
					</td>
				</tr>
				<tr>
					<td colspan="4">
						<input type="text" 
						id="email" name="email" placeholder="E-mail"
						value='<c:out value="${cliente.email}"/>'
						class="input-group input-group-lg">
					</td>
				</tr>
				<tr>
					<td colspan="3">
						<input type="number"
						id="limiteCredito" name="limiteCredito" step="0.01" placeholder="Limite de Crédito"
						value='<c:out value="${cliente.limiteCredito}"/>'
						class="input-group input-group-lg" >
					</td>
				</tr>
				<tr>
					<td colspan="4">
						<input type="date" 
						id="dataNascimento" name="dataNascimento"
						value='<c:out value="${cliente.dataNascimento}"/>'
						class="input-group input-group-lg">
					</td>
				</tr>
				<tr>
					<td>
						<input type="submit"
						id="botao" name="botao" value="Inserir"
						class="btn btn-dark">
					</td>								
					<td>
						<input type="submit"
						id="botao" name="botao" value="Atualizar"
						class="btn btn-dark">
					</td>								
					<td>
						<input type="submit"
						id="botao" name="botao" value="Excluir"
						class="btn btn-dark">
					</td>								
					<td>
						<input type="submit"
						id="botao" name="botao" value="Listar"
						class="btn btn-dark">
					</td>								
				</tr>
			</table>
		</form>
	</div>
	<br />
	<div class="conteiner" align="center">
		<c:if test="${not empty saida}">
			<h2 style="color: blue;"><c:out value="${saida}" /></h2>
		</c:if>
	</div>
	<div class="conteiner" align="center">
		<c:if test="${not empty erro}">
			<h2 style="color: red;"><c:out value="${erro}" /></h2>
		</c:if>
	</div>
	<div class="conteiner" align="center">
		<c:if test="${not empty clientes}">
			<table class="table table-dark table-striped">
				<thead>
					<tr>
						<th>CPF</th>
						<th>Nome</th>
						<th>E-mail</th>
						<th>Limite de Crédito</th>
						<th>Data de nascimento</th>
						<th></th>
						<th></th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="c" items="${clientes}">
						<tr>
							<td>${c.cpf}</td>
							<td>${c.nome}</td>
							<td>${c.email}</td>
							<td>${c.limiteCredito}</td>
							<td>${c.dataNascimento}</td>
							<td><a href="${pageContext.request.contextPath}/cliente?acao=editar&cpf=${c.cpf}">EDITAR</a></td>
							<td><a href="${pageContext.request.contextPath}/cliente?acao=excluir&cpf=${c.cpf}">EXCLUIR</a></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</c:if>
	</div>
</body>
</html>