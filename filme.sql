
drop database filme;
create database Filme;
use filme;

create table tbDisponibilizacao(
	cod_disp int,
    descr varchar(30),
    primary key (cod_disp));
    
    insert into tbDisponibilizacao values (1, 'rede de salas de cinema');
    insert into tbDisponibilizacao values (2, 'repositório');
    
create table tbGenero(
	cod_genero int,
    descr varchar(30),
    primary key (cod_genero));
    
	insert into tbGenero values (1, 'comédia romântica');
    insert into tbGenero values (2, 'suspense');
    insert into tbGenero values (3, 'terror');
	insert into tbGenero values (4, 'aventura');
    insert into tbGenero values (5, 'ação');

create table tbEstudio(
	cod_estudio int,
    nome varchar(50),
    primary key (cod_estudio));
    
    insert into tbEstudio values (1, 'Disney');
    insert into tbEstudio values (2, 'Marvel');
    insert into tbEstudio values (3, 'Warner');
    insert into tbEstudio values (4, 'Pixar');

create table tbFilme(
	cod_filme int,
    nome varchar(50),
    ano_pub int,
    cod_estudio int,
    foreign key (cod_estudio) references tbEstudio (cod_estudio),
    primary key (cod_filme));
    
    insert into tbFilme values (1, 'Harry Potter e a Pedra Filosofal', 2001, 3);
    insert into tbFilme values (2, 'Harry Potter e a câmera secreta', 2002, 3);
    insert into tbFilme values (3, 'Harry Potter e a prisoneiro de Azkaban', 2004, 3);
    insert into tbFilme values (4, 'Harry Potter e o cálice de Fogo', 2005, 3);
    insert into tbFilme values (5, 'Harry Potter e a Ordem da Fênix', 2007, 3);
    insert into tbFilme values (6, 'Harry Potter e a o Príncipe Mestiço', 2009, 3);
    insert into tbFilme values (7, 'Harry Potter e as relíquias da morte parte 1', 2010, 3);
    insert into tbFilme values (8, 'Harry Potter e as relíquias da morte parte 2', 2011, 3);
    insert into tbFilme values (9, 'Animais fantásticos', 2018, 3);
    
create table tbFilme_Genero(
	cod_filme int,
    cod_genero int,
    foreign key (cod_filme) references tbFilme (cod_filme),
    foreign key (cod_genero) references tbGenero (cod_genero),
    primary key (cod_filme, cod_genero));
    
    insert into tbFilme_genero values (1, 1);
    insert into tbFilme_genero values (2, 2);
    insert into tbFilme_genero values (3, 3);
    insert into tbFilme_genero values (4, 4);
    insert into tbFilme_genero values (5, 5);
    insert into tbFilme_genero values (6, 1);
    insert into tbFilme_genero values (7, 2);
    insert into tbFilme_genero values (8, 5);
    insert into tbFilme_genero values (9, 1);
    

create table tbFilme_Disponibilizacao(
	cod_filme int,
    cod_disp int,
    foreign key (cod_filme) references tbFilme (cod_filme),
    foreign key (cod_disp) references tbDisponibilizacao (cod_disp),
    primary key (cod_filme, cod_disp));
    
    insert into tbFilme_Disponibilizacao values (1, 1);
    insert into tbFilme_Disponibilizacao values (1, 2);
    insert into tbFilme_Disponibilizacao values (2, 2);
    insert into tbFilme_Disponibilizacao values (3, 1);
    insert into tbFilme_Disponibilizacao values (4, 2);
    insert into tbFilme_Disponibilizacao values (5, 1);
    insert into tbFilme_Disponibilizacao values (6, 2);
    insert into tbFilme_Disponibilizacao values (7, 1);
    insert into tbFilme_Disponibilizacao values (8, 2);
    insert into tbFilme_Disponibilizacao values (9, 1);
    
create table tbAtor(
	cod_ator int,
    nome varchar(50),
    primary key (cod_ator));
    
    insert into tbAtor values (1, 'Daniel');
    insert into tbAtor values (2, 'Emma Watson');
    insert into tbAtor values (3, 'Ruppert');
    insert into tbAtor values (4, 'Isabela');
    
create table tbDiretor(
	cod_diretor int,
    nome varchar(50),
    primary key (cod_diretor));
    
	insert into tbDiretor values (1, 'Lucas');
    insert into tbDiretor values (2, 'Nathalia');
    insert into tbDiretor values (3, 'Jhonny');
    insert into tbDiretor values (4, 'Alan');
    
create table tbFilme_ator(
	cod_filme int,
    cod_ator int,
    foreign key (cod_filme) references tbFilme (cod_filme),
    foreign key (cod_ator) references tbAtor (cod_ator),
    primary key (cod_filme, cod_ator));
    
    insert into tbFilme_ator values (1, 1);
	insert into tbFilme_ator values (1, 2);
	insert into tbFilme_ator values (1, 3);
    insert into tbFilme_ator values (2, 1);
	insert into tbFilme_ator values (2, 2);
	insert into tbFilme_ator values (2, 3);
    insert into tbFilme_ator values (3, 1);
	insert into tbFilme_ator values (3, 2);
	insert into tbFilme_ator values (3, 3);
    insert into tbFilme_ator values (4, 1);
	insert into tbFilme_ator values (4, 2);
	insert into tbFilme_ator values (4, 3);
    insert into tbFilme_ator values (5, 1);
	insert into tbFilme_ator values (5, 2);
	insert into tbFilme_ator values (5, 3);
    insert into tbFilme_ator values (6, 1);
	insert into tbFilme_ator values (6, 2);
	insert into tbFilme_ator values (6, 3);
    insert into tbFilme_ator values (7, 1);
	insert into tbFilme_ator values (7, 2);
	insert into tbFilme_ator values (7, 3);
    insert into tbFilme_ator values (8, 1);
	insert into tbFilme_ator values (8, 2);
	insert into tbFilme_ator values (8, 3);
    insert into tbFilme_ator values (9, 1);
	insert into tbFilme_ator values (9, 2);
	insert into tbFilme_ator values (9, 3);

create table tbFilme_diretor(
	cod_filme int,
    cod_diretor int,
    foreign key (cod_filme) references tbFilme (cod_filme),
    foreign key (cod_diretor) references tbDiretor (cod_diretor),
    primary key (cod_filme, cod_diretor));
    
    insert into tbFilme_diretor values (1, 1);
    insert into tbFilme_diretor values (2, 2);
    insert into tbFilme_diretor values (3, 3);
    insert into tbFilme_diretor values (4, 4);
    insert into tbFilme_diretor values (5, 1);
    insert into tbFilme_diretor values (6, 2);
    insert into tbFilme_diretor values (7, 3);
    insert into tbFilme_diretor values (8, 4);
    insert into tbFilme_diretor values (9, 1);
    
 
-- a)Qual é o nome dos atores que participaram de filmes lançados em 2018?

	select a.nome as 'Nome de atores'
		from tbAtor a, tbFilme f, tbFilme_ator fa
        where a.cod_ator = fa.cod_ator and fa.cod_filme = f.cod_filme and f.ano_pub = 2018
        order by a.nome;
  
-- b)Quais são os nomes dos diretores dos filmes cadastrados sob o gênero cinematográfico “comedia romântica”?
	
    select distinct d.nome as 'Nome de diretores'
		from tbDiretor d, tbFilme f, tbFilme_diretor fd, tbGenero g, tbFilme_Genero fg
        where d.cod_diretor = fd.cod_diretor and fd.cod_filme = f.cod_filme
			and f.cod_filme = fg.cod_filme and fg.cod_genero = g.cod_genero
            and g.descr = 'comédia romântica'
		order by d.nome;

-- c)Listar o título e o respectivo gênero cinematográfico dos filmes que foram lançados, em 2018, na rede de salas de cinemas e não apenas em “repositórios”.  

	select f.nome as 'Título', g.descr as 'Gênero'
		from tbFilme f, tbGenero g, tbFilme_Genero fg, tbDisponibilizacao disp, tbFilme_disponibilizacao fdisp
        where f.cod_filme = fg.cod_filme and fg.cod_genero = g.cod_genero
			and f.cod_filme = fdisp.cod_filme and fdisp.cod_disp = disp.cod_disp
            and f.ano_pub = 2018
            and disp.descr = 'rede de salas de cinema'
		order by f.nome;
        
-- d)Listar quantos filmes por gênero cinematográfico, foram lançados nos últimos 5 anos.

	select count(*) as 'Número de filmes', g.descr as 'Gênero'
		from tbFilme f, tbGenero g, tbFilme_Genero fg
        where f.cod_filme = fg.cod_filme and fg.cod_genero = g.cod_genero
			and (year(curdate()) - f.ano_pub) < 6
        group by g.cod_genero
		order by count(*);
    
	


