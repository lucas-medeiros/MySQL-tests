create database atividade_escola;

use atividade_escola;

create table tbpessoa(
	rg_pessoa varchar(15),
    telefone_pessoa varchar(15),
    nome_pessoa varchar(50),
    primary key (rg_pessoa));
    
create table tbescola(
	cod_escola int,
    nome_escola varchar(50),
    cidade_escola varchar(100),
    primary key (cod_escola));

create table tbprofessor(
	rg_professor varchar(15),
	matricula_professor int,
    CPF_professor varchar(11),
    escolaridade varchar(30),
    escola_trabalha int,
    escola_dirige int,
	foreign key (rg_professor) references tbpessoa(rg_pessoa),
    foreign key (escola_trabalha) references tbescola(cod_escola),
    foreign key (escola_dirige) references tbescola(cod_escola),
    primary key (rg_professor));
    
    
create table tbdisciplina(
	cod_disciplina int,
    nome_disciplina varchar(50),
    primary key (cod_disciplina));
    
create table tbturma(
	cod_turma int,
    nome_turma varchar(50),
    primary key (cod_turma));
    
create table tbaluno(
	rg_aluno varchar(15),
    representa varchar(15),
    representado varchar(15),
	matricula_aluno varchar(15),
    cod_turma int,
    data_nasc date,
    foreign key (rg_aluno) references tbpessoa(rg_pessoa),
    foreign key (representa) references tbaluno(rg_aluno),
    foreign key (representado) references tbaluno(rg_aluno),
    foreign key (cod_turma) references tbturma(cod_turma),
    primary key (rg_aluno));
    
    
create table tbcontato(
	rg_aluno varchar(15),
	nome_contato varchar(50),
    fone_turma varchar(15),
    foreign key (rg_aluno) references tbaluno(rg_aluno),
    primary key (rg_aluno));
    
create table tbministra(
	cod_disciplina int,
    rg_professor varchar(15),
    cod_turma int,
    ano int,
    foreign key (cod_disciplina) references tbdisciplina(cod_disciplina),
	foreign key (rg_professor) references tbprofessor(rg_professor),
    foreign key (cod_turma) references tbturma(cod_turma),
    primary key (cod_disciplina, rg_professor, cod_turma, ano));
    
	insert into tbpessoa VALUES ('01234', '998390804', 'Lucas');
	insert into tbpessoa VALUES ('012345', '998390804', 'Isabela');
    insert into tbpessoa VALUES ('012341', '998390804', 'Ivan');
    insert into tbescola VALUES (1, 'Colégio Medianeira', 'Curitiba');
    insert into tbprofessor VALUES ('012341', '012341', '012341', 'doutor', 1, 1);
    insert into tbdisciplina VALUES (1, 'Banco de dados');
    insert into tbdisciplina VALUES (2, 'Cálculo 1');
    insert into tbdisciplina VALUES (3, 'Sistemas Operacionais');
    insert into tbdisciplina VALUES (4, 'Matemática');
    insert into tbturma VALUES (1, 'Turma A');
    insert into tbaluno VALUES ('01234', '01234', '01234', '01234', 1, '1998-12-27');
    insert into tbaluno VALUES ('012345', null, '01234', '012345', 1, '1998-03-06');
    insert into tbministra VALUES (1, '012341', 1, 2018);
    insert into tbministra VALUES (2, '012341', 1, 2018);
    insert into tbministra VALUES (3, '012341', 1, 2018);
    insert into tbministra VALUES (4, '012341', 1, 2018);
    
    insert into tbturma VALUES (2, 'ESPECIAL');
    insert into tbpessoa VALUES ('0123456', '998390804', 'Joao das Couves');
    insert into tbpessoa VALUES ('0123457', '998390804', 'Maria');
	insert into tbaluno VALUES ('0123456', null, null, '0123456', 2, '1999-07-08');
    insert into tbaluno VALUES ('0123457', null, null, '0123457', 2, '1999-10-10');
    
    insert into tbcontato VALUES ('0123456', 'Joao das Couves Contato', '998390804');
    
    -- Atividade de selecao
    -- 1. qual foram os nomes do professores que ministraram a disciplina de Matematica em 2018?
	select pessoa.nome_pessoa
    from  tbpessoa pessoa, tbprofessor prof, tbdisciplina disc, tbministra mini
    where prof.rg_professor = pessoa.rg_pessoa and mini.cod_disciplina = disc.cod_disciplina 
		and mini.rg_professor = prof.rg_professor 
        and mini.ano = 2018
        and disc.cod_disciplina = 4
    group by pessoa.nome_pessoa;
    
    
	-- 2. quantos estudantes tem a turma ESPECIAL ?
	select count(*)
    from  tbaluno a, tbpessoa pessoa, tbturma t
    where a.rg_aluno = pessoa.rg_pessoa and a.cod_turma = t.cod_turma
		and t.cod_turma = 2
    order by count(*) desc
    limit 1;

	-- 3. qual e o nome de contato e telefone do aluno joao das coves?
    select c.nome_contato, c.fone_turma
    from  tbpessoa pessoa, tbaluno a, tbcontato c
    where a.rg_aluno = pessoa.rg_pessoa and c.rg_aluno = a.rg_aluno and c.rg_aluno = a.rg_aluno 
		and c.rg_aluno = '0123456';
        
	
    
    