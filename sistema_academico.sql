create database sistema_academico;

use sistema_academico;

create table tbescola(
	cod_escola int,
    nome varchar (50),
    primary key (cod_escola));

create table tbcurso(
	cod_curso int,
    descricao varchar(50),
    cod_escola int,
    primary key (cod_curso),
    foreign key (cod_escola) references tbescola(cod_escola));
    
create table tbaluno (
	cod_aluno int,
    nome varchar(50),
    cod_curso int,
    primary key (cod_aluno),
    foreign key (cod_curso) references tbcurso(cod_curso));
    
create table tbdisciplina (
	cod_disciplina int,
    nome varchar(50),
    ch int,
    primary key (cod_disciplina));
    
create table tbobrigatoria (
	cod_curso int,
    cod_disciplina int,
    primary key (cod_curso, cod_disciplina),
    foreign key (cod_curso) references tbcurso(cod_curso),
    foreign key (cod_disciplina) references tbdisciplina(cod_disciplina));
    
    
create table tboptativa (
	cod_curso int,
    cod_disciplina int,
    primary key (cod_curso, cod_disciplina),
    foreign key (cod_curso) references tbcurso(cod_curso),
    foreign key (cod_disciplina) references tbdisciplina(cod_disciplina));
    
create table tbmatricula (
	cod_aluno int,
    cod_disciplina int,
    data_matricula date,
    turno varchar(15),
    index (data_matricula),
    primary key (cod_aluno, cod_disciplina, data_matricula),
    foreign key (cod_aluno) references tbaluno(cod_aluno),
    foreign key (cod_disciplina) references tbdisciplina(cod_disciplina));
    
create table tbhistorico (
	cod_aluno int,
    cod_disciplina int,
    data_matricula date,
    data_aula date,
    presenca boolean,
    primary key (cod_aluno, cod_disciplina, data_matricula, data_aula),
    foreign key (cod_aluno) references tbmatricula(cod_aluno),
    foreign key (cod_disciplina) references tbmatricula(cod_disciplina),
	foreign key (data_matricula) references tbmatricula(data_matricula));
    
    
    insert into tbescola values (1, 'PUCPR');
    insert into tbescola values (2, 'Escola Nossa Senhora Medianeira');
    
    insert into tbcurso values (1, 'Engenharia de Computação', 1);
    insert into tbcurso values (2, 'Psicologia', 1);
    insert into tbcurso values (3, 'Medicina', 1);
    
    insert into tbaluno values (1, 'Lucas' , 1);
    insert into tbaluno values (2, 'Isabela', 1);
    insert into tbaluno values (3, 'Joao das Couves', 1);
    
    insert into tbdisciplina values (1, 'Banco de dados', 80);
    insert into tbdisciplina values (2, 'Sistemas Operacionais', 80);
    insert into tbdisciplina values (3, 'Eletrônica 1', 80);
    insert into tbdisciplina values (4, 'Culinária 1', 60);
    
    insert into tbobrigatoria values (1, 1);
    insert into tbobrigatoria values (1, 2);
    insert into tbobrigatoria values (1, 3);
    insert into tboptativa values (1, 4);
    
    insert into tbmatricula values (1, 1, '2016-02-01', 'matutino');
    insert into tbmatricula values (1, 2, '2018-06-01', 'matutino');
    insert into tbmatricula values (2, 1, '2016-01-27', 'matutino');
    insert into tbmatricula values (3, 3, '2018-05-10', 'noturno');
    
    insert into tbhistorico values (3, 3, '2018-05-10', '2018-10-27', false);
    
    insert into tbhistorico values (3, 3, '2018-05-10', '2018-10-28', false);
    insert into tbhistorico values (3, 3, '2018-05-10', '2018-10-29', true);
    insert into tbhistorico values (3, 3, '2018-05-10', '2018-10-30', false);
    insert into tbhistorico values (3, 3, '2018-05-10', '2018-11-01', true);
    insert into tbhistorico values (3, 3, '2018-05-10', '2018-11-02', true);
    insert into tbhistorico values (3, 3, '2018-05-10', '2018-11-03', false);
    insert into tbhistorico values (3, 3, '2018-05-10', '2018-11-04', true);
    insert into tbhistorico values (3, 3, '2018-05-10', '2018-11-05', false);
    insert into tbhistorico values (3, 3, '2018-05-10', '2018-11-06', false);
    
    
    -- Listar os estudantes matriculados em uma determinada disciplina (por exemplo 'Banco de dados'):
    select a.nome
		from tbaluno a, tbdisciplina d, tbmatricula m
		where a.cod_aluno = m.cod_aluno and d.cod_disciplina = m.cod_disciplina
			and d.nome = 'Banco de dados'
		order by a.nome;
    
    
    -- Contar o número de faltas do estudante Joao das Couves:
    select count(*)
		from tbaluno a, tbmatricula m, tbdisciplina d, tbhistorico h
        where a.cod_aluno = m.cod_aluno and d.cod_disciplina = m.cod_disciplina
			and m.cod_aluno = h.cod_aluno and m.cod_disciplina = h.cod_disciplina
            and m.data_matricula = h.data_matricula
            and a.nome = 'Joao das Couves'
            and h.presenca = false;
    
    