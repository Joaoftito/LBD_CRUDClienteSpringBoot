package br.edu.fateczl.CRUDClienteSpringBoot.model;

import java.time.LocalDate;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Cliente {
	
	private String cpf;
	private String nome;
	private String email;
	private double limiteCredito;
	private LocalDate dataNascimento;

}
