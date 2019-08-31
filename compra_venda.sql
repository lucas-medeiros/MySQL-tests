 


create database atividade_compra_venda;

use atividade_compra_venda;

create table tbvendedor(
	cod_vendedor int,
    nome varchar(100),
    telefone varchar(15),
    senha varchar(30),
	primary key (cod_vendedor));
    
create table tbcliente(
	cod_cliente int,
    nome varchar(100),
    telefone varchar(15),
    endereco varchar(100),
	primary key (cod_cliente));
    
create table tbprateleira(
	num_prateleira int,
    localizacao varchar(100),
	primary key (num_prateleira));
    
create table tbvenda(
	cod_venda int,
    notafiscal int,
    data_venda date,
    cod_vendedor int,
    cod_cliente int,
	primary key (cod_venda),
    foreign key (cod_vendedor) references tbvendedor(cod_vendedor),
    foreign key (cod_cliente) references tbcliente(cod_cliente));
    
create table tbproduto(
	num_produto int,
    codigobarras varchar(15),
    descricao varchar(100),
    num_prateleira int,
	primary key (num_produto),
    foreign key (num_prateleira) references tbprateleira(num_prateleira));
    
    create table tbvenda_produto(
    num_produto int,
    cod_venda int,
	primary key (cod_venda, num_produto),
    foreign key (num_produto) references tbproduto(num_produto),
    foreign key (cod_venda) references tbvenda(cod_venda));
    
    insert into  tbvendedor (cod_vendedor, nome, telefone, senha) VALUES (1, 'Lucas', '998390804', '123');
    insert into  tbvendedor (cod_vendedor, nome, telefone, senha) VALUES (2, 'Isabela', '998390804', '123');
    insert into  tbvendedor (cod_vendedor, nome, telefone, senha) VALUES (3, 'Heuko', '998390804', '123');
    
    insert into  tbcliente (cod_cliente, nome, telefone, endereco) VALUES (1, 'Luiz', '998390804', 'Rua dos bobos nº0');
	insert into  tbcliente (cod_cliente, nome, telefone, endereco) VALUES (2, 'Leandro', '998390804', 'Rua dos bobos nº0');
	insert into  tbcliente (cod_cliente, nome, telefone, endereco) VALUES (3, 'Osni', '998390804', 'Rua dos bobos nº0');
    
    insert into  tbprateleira (num_prateleira, localizacao) VALUES (1, 'corredor 1');
    insert into  tbprateleira (num_prateleira, localizacao) VALUES (2, 'corredor 2');
    insert into  tbprateleira (num_prateleira, localizacao) VALUES (3, 'corredor 3');
    
    insert into  tbvenda (cod_venda, notafiscal, data_venda, cod_vendedor, cod_cliente) VALUES (1, 1, '2018-05-27', 1, 3);
	insert into  tbvenda (cod_venda, notafiscal, data_venda, cod_vendedor, cod_cliente) VALUES (5, 5, '2018-05-13', 1, 3);
    insert into  tbvenda (cod_venda, notafiscal, data_venda, cod_vendedor, cod_cliente) VALUES (2, 2, '2018-05-12', 2, 2);
    insert into  tbvenda (cod_venda, notafiscal, data_venda, cod_vendedor, cod_cliente) VALUES (3, 3, '2018-09-13', 3, 1);
    insert into  tbvenda (cod_venda, notafiscal, data_venda, cod_vendedor, cod_cliente) VALUES (4, 4, '2017-05-13', 2, 3);
    
    insert into  tbproduto(num_produto, codigobarras, descricao, num_prateleira) VALUES (1, '012345600', 'pão', 1);
    insert into  tbproduto(num_produto, codigobarras, descricao, num_prateleira) VALUES (2, '012345670', 'batata', 2);
    insert into  tbproduto(num_produto, codigobarras, descricao, num_prateleira) VALUES (3, '012345678', 'arroz', 3);
    
    insert into  tbvenda_produto(num_produto, cod_venda) VALUES (1, 1);
    insert into  tbvenda_produto(num_produto, cod_venda) VALUES (2, 2);
    insert into  tbvenda_produto(num_produto, cod_venda) VALUES (3, 3);
    
    -- Atividade 1 de selecao:
    
    select cod_venda, count(*)
    from tbvenda
    order by cod_venda;
    
    select cod_venda, count(*)
    from tbvenda
    where month(data_venda) = 5 and year(data_venda) = 2018
    order by cod_venda;
    
    select month(data_venda), count(*)
    from tbvenda
    where year(data_venda) = 2017
    group by month(data_venda)
    order by count(*) desc
    limit 1;
    
    -- Atividade 2 de selecao: dia 25/09/2018
	-- cliente q mais comprou em 2018:
    select c.nome, count(*)
    from tbcliente c, tbvenda v
    where (c.cod_cliente = v.cod_cliente) AND (year(v.data_venda) = 2018)
    group by c.nome
    order by count(*) desc
    limit 1;
    
    -- nome do vendedor  menos vendeu em 2018:
    select vend.nome, count(*)
    from tbvendedor vend, tbvenda v
    where (vend.cod_vendedor = v.cod_vendedor) AND (year(v.data_venda) = 2018)
    group by vend.nome
    order by count(*)
    limit 1;
    
    --  qual e a descricao (nome) do produto mais vendido em maio de 2018?
    select p.descricao, count(*)
    from tbproduto p, tbvenda_produto vp, tbvenda v
    where (p.num_produto = vp.num_produto) and (vp.cod_venda = v.cod_venda) 
		and (month(v.data_venda) = 5) and year(v.data_venda) = 2018
	group by p.descricao
    order by count(*) desc
    limit 1;
    
    