create database atividade_banco;

use atividade_banco;

create table tbpais(
	cod_pais int,
    nome varchar(30),
	primary key (cod_pais));

create table tbcidade(
	cod_cidade int,
    nome varchar(50),
    cod_pais int,
    primary key (cod_cidade),
    foreign key (cod_pais) references tbpais(cod_pais));
    

create table tbendereco(
	cod_end int,
	rua varchar(50),
    CEP char(8),
    complemento varchar(15),
    num int,
    estado char(2),
    cod_cidade int,
    primary key (cod_end),
    foreign key (cod_cidade) references tbcidade(cod_cidade));
    
	
create table tbbanco(
	cod_banco int,
    nome varchar(15),
    cod_end int,
    foreign key (cod_end) references tbendereco(cod_end),
    primary key (cod_banco));
    
create table tbagencia(
	num_agencia int,
    cod_end int,
    cod_banco int,
    foreign key (cod_banco) references tbbanco(cod_banco),
    foreign key (cod_end) references tbendereco(cod_end),
    primary key (num_agencia));

create table tbconta(
	num_conta int,
    saldo float,
    tipo varchar(15),
    num_agencia int,
    foreign key (num_agencia) references tbagencia(num_agencia),
    primary key (num_conta));
    
create table tbemprestimo(
	num_emp int,
    valor float,
    tipo varchar(15),
    num_agencia int,
    foreign key (num_agencia) references tbagencia(num_agencia),
    primary key (num_emp));
    
create table tbcliente(
	SSN int,
    nome varchar(50),
    telefone varchar(15),
    cod_end int,
    foreign key (cod_end) references tbendereco(cod_end),
    primary key (SSN));
    
create table tbconta_cliente(
	num_conta int,
    SSN_cliente int,
    foreign key (num_conta) references tbconta(num_conta),
    foreign key (SSN_cliente) references tbcliente(SSN),
    primary key (num_conta, SSN_cliente));
    
create table tbemp_cliente(
	num_emp int,
    SSN_cliente int,
    foreign key (num_emp) references tbemprestimo(num_emp),
    foreign key (SSN_cliente) references tbcliente(SSN),
    primary key (num_emp, SSN_cliente));
    
	insert into tbpais values (1, 'Brasil'); 
	insert into tbpais values (2, 'Japão');  

	insert into tbcidade values (1, 'Curitiba', 1);

	insert into tbendereco values (1, 'Rua dos Bobos', '01234567', 'Apto 27', 27, 'PR', 1);
	insert into tbendereco values (2, 'Avenida do Além', '12345678', null, 32, 'PR', 1);
		
	insert into tbbanco values (1, 'Banco do Brasil', 1);
	insert into tbbanco values (2, 'Bradesco', 1);
	insert into tbbanco values (3, 'Santander', 2);

	insert into tbagencia values (1, 1, 1);
	insert into tbagencia values (2, 1, 2);
	insert into tbagencia values (3, 2, 3);
	insert into tbagencia values (4, 2, 2);

	insert into tbconta values (0, 500.00, 'poupança', 2);
	insert into tbconta values (1, 1500.00, 'poupança', 2);
	insert into tbconta values (2, 250.00, 'conta-corrente', 4);
	insert into tbconta values (3, 3.00, 'conta fácil', 1);
	insert into tbconta values (4, 15.00, 'conta estudante', 3);
    insert into tbconta values (5, 32.00, 'conta-corrente', 1);

	insert into tbemprestimo values (0, 15.00, 'pra compra pão', 1);
	insert into tbemprestimo values (1, 2500.00, 'consignado', 2);
	insert into tbemprestimo values (2, 55000.00, 'a prazo', 2);
	insert into tbemprestimo values (3, 27.00, 'cheque especial', 3);

	insert into tbcliente values (1, 'Joao das Couves', '998390804', 1);
	insert into tbcliente values (2, 'Lucas', '998390804', 1);
	insert into tbcliente values (3, 'Isabela', '998390804', 1);

	insert into tbconta_cliente values (0, 1);
	insert into tbconta_cliente values (1, 1);
	insert into tbconta_cliente values (2, 2);
	insert into tbconta_cliente values (3, 3);
	insert into tbconta_cliente values (4, 2);

	insert into tbemp_cliente values (0, 1);
	insert into tbemp_cliente values (1, 2);
	insert into tbemp_cliente values (2, 3);
    insert into tbemp_cliente values (3, 2);


	-- identificar o número de contas por agencia
	select a.num_agencia, count(*)
		from tbagencia a, tbconta c
		where a.num_agencia = c.num_agencia
		group by a.num_agencia
		order by count(*) desc ;
        
        
	-- identificar o montante de empréstimos por cliente:
    select sum(emp.valor), cliente.nome
		from tbemprestimo emp, tbcliente cliente, tbemp_cliente emp_cliente
        where emp.num_emp = emp_cliente.num_emp and emp_cliente.SSN_cliente = cliente.SSN
        group by cliente.nome
        order by sum(emp.valor) desc ;
