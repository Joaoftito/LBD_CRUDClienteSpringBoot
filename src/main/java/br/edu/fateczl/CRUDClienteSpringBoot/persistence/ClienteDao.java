package br.edu.fateczl.CRUDClienteSpringBoot.persistence;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import br.edu.fateczl.CRUDClienteSpringBoot.model.Cliente;

@Repository
public class ClienteDao implements ICrud<Cliente> {
	
	@Autowired
	private GenericDao gDao;
	
	@Override
	public Cliente buscar(Cliente cliente) throws SQLException, ClassNotFoundException {
		Connection c = gDao.getConnection();
		String sql = "SELECT cpf, nome, email, limiteCredito, dataNascimento FROM cliente WHERE cpf = ?";
		PreparedStatement ps = c.prepareStatement(sql);
		ps.setString(1,cliente.getCpf());
		ResultSet rs = ps.executeQuery();
		if (rs.next()) {
			cliente.setCpf(rs.getString("cpf"));
			cliente.setNome(rs.getString("nome"));
			cliente.setEmail(rs.getString("email"));
			cliente.setLimiteCredito(rs.getDouble("limiteCredito"));
			cliente.setDataNascimento(LocalDate.parse(rs.getString("dataNascimento")));
		}
		rs.close();
		ps.close();
		return cliente;
	}
	
	@Override
	public List<Cliente> listar() throws SQLException, ClassNotFoundException {
		List<Cliente> clientes = new ArrayList<>();
		Connection c = gDao.getConnection();
		String sql = "SELECT cpf, nome, email, limiteCredito, dataNascimento FROM cliente";
		PreparedStatement ps = c.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		while (rs.next()) {
			Cliente cliente = new Cliente();
			cliente.setCpf(rs.getString("cpf"));
			cliente.setNome(rs.getString("nome"));
			cliente.setEmail(rs.getString("email"));
			cliente.setLimiteCredito(rs.getDouble("limiteCredito"));
			cliente.setDataNascimento(LocalDate.parse(rs.getString("dataNascimento")));
			
			clientes.add(cliente);
		}
		rs.close();
		ps.close();
		return clientes;
	}
	
	@Override
	public String inserir(Cliente cliente) throws SQLException, ClassNotFoundException {
		Connection c = gDao.getConnection();
		String sql = "{CALL sp_inserir(?,?,?,?,?,?)}";
		CallableStatement cs = c.prepareCall(sql);
		cs.setString(1, cliente.getCpf());
		cs.setString(2, cliente.getNome());
		cs.setString(3, cliente.getEmail());
		cs.setDouble(4, cliente.getLimiteCredito());
		cs.setString(5, cliente.getDataNascimento().toString());

		cs.registerOutParameter(6, Types.VARCHAR);
		cs.execute();
		
		String saida = cs.getString(6);
		cs.close();
		
		return saida;
	}

	@Override
	public String atualizar(Cliente cliente) throws SQLException, ClassNotFoundException {
		Connection c = gDao.getConnection();
		String sql = "{CALL sp_atualizar(?,?,?,?,?,?)}";
		CallableStatement cs = c.prepareCall(sql);
		cs.setString(1, cliente.getCpf());
		cs.setString(2, cliente.getNome());
		cs.setString(3, cliente.getEmail());
		cs.setDouble(4, cliente.getLimiteCredito());
		cs.setString(5, cliente.getDataNascimento().toString());
		cs.registerOutParameter(6, Types.VARCHAR);
		cs.execute();
		
		String saida = cs.getString(6);
		cs.close();
		
		return saida;

	}

	@Override
	public String excluir(Cliente cliente) throws SQLException, ClassNotFoundException {
		Connection c = gDao.getConnection();
		String sql = "{CALL sp_excluir(?,?)}";
		CallableStatement cs = c.prepareCall(sql);
		cs.setString(1, cliente.getCpf());
		cs.registerOutParameter(2, Types.VARCHAR);
		cs.execute();		
		String saida = cs.getString(2);
		
		cs.close();
		
		return saida;
	}

}
