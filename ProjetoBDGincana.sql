DROP DATABASE Gincana;
CREATE DATABASE Gincana;
USE Gincana;

create table tbPais(
	cod_pais int,
    nome varchar(50),
	primary key (cod_pais));

create table tbCidade(
	cod_cidade int,
    nome varchar(50),
    cod_pais int,
    primary key (cod_cidade),
    foreign key (cod_pais) references tbpais(cod_pais));
    
create table tbEndereco(
	cod_end int,
	rua varchar(50),
    CEP char(8),
    complemento varchar(15),
    num int,
    estado char(2),
    cod_cidade int,
    primary key (cod_end),
    foreign key (cod_cidade) references tbcidade(cod_cidade));
    
create table tbEmpresa(
	CNPJ char(14),
    nome varchar(50),
    primary key (CNPJ));
 
 create table tbProva(
	cod_prova int,
    points int,
    nome varchar(50),
    descr varchar(150),
    lugar int,
    primary key (cod_prova),
	foreign key (lugar) references tbEndereco(cod_end));

create table tbGenero(
	cod_genero int,
    genero varchar(15),
    primary key (cod_genero));

create table tbTipo(
	cod_tipo int,
    tipo varchar(15),
    primary key (cod_tipo));
    
create table tbPessoa(
	matricula char(12),
    nome varchar(20),
    sobrenome varchar(50),
    data_nascimento date,
    cod_genero int,
    cod_tipo int,
	primary key (matricula),
    foreign key (cod_genero) references tbGenero(cod_genero),
	foreign key (cod_tipo) references tbTipo(cod_tipo));
    
create table tbEdicao(
	ano int,
    tema varchar(50),
    data_inicio date,
    data_fim date, 
    matricula_coordenador char(12),
    primary key (ano),
    foreign key (matricula_coordenador) references tbPessoa(matricula));
    
create table tbPatrocina(
	CNPJ char(14),
    ano int,
    verba float,
    primary key (CNPJ, ano),
    foreign key (CNPJ) references tbEmpresa(CNPJ),
	foreign key (ano) references tbEdicao(ano));
    
create table tbEdicao_Prova(
	ano int,
	cod_prova int,
    data_hora datetime,
    primary key (ano, cod_prova),
    foreign key (ano) references tbEdicao(ano),
    foreign key (cod_prova) references tbProva(cod_prova));
    
create table tbInscrever(
	ano int,
	matricula char(12),
    primary key (ano, matricula),
    foreign key (ano) references tbEdicao(ano),
    foreign key (matricula) references tbPessoa(matricula));
    
create table tbPessoa_Prova(
	ano int,
	matricula char(12),
    cod_prova int, 
    tempo time,
	primary key (ano, matricula, cod_prova),
    foreign key (ano, matricula) references tbInscrever(ano, matricula),
	foreign key (cod_prova) references tbProva(cod_prova));
    
create table tbEmail(
	email varchar(50),
	matricula char(12),
    primary key (email, matricula),
	foreign key (matricula) references tbPessoa(matricula));

create table tbTelefone(
	DDD char(2),
	telefone char(9),
	matricula char(12),
    primary key (DDD, telefone, matricula),
	foreign key (matricula) references tbPessoa(matricula));
    
create table tbEsporte(
	cod_esporte int,
    descr varchar(30),
    primary key (cod_esporte));
    
create table tbPessoa_Esporte(
	matricula char(12),
    cod_esporte int,
    primary key (matricula, cod_esporte),
    foreign key (matricula) references tbPessoa(matricula),
    foreign key (cod_esporte) references tbEsporte(cod_esporte));
        
    
 -- Populando:
 
 -- Pais (cod_pais, nome)
	insert into tbPais values (1, 'Brasil'); 
	insert into tbPais values (2, 'Japão');  

-- cidade (cod_cidade, nome, país)
	insert into tbCidade values (1, 'Curitiba', 1);
    insert into tbCidade values (2, 'Tokyo', 2);
	insert into tbCidade values (3, 'Rio de Janeiro', 1);
    insert into tbCidade values (4, 'Osaka', 2);
    
-- endereco(cod_end, rua, cep, complemento, numero, estado, cidade)
	insert into tbEndereco values (1, 'Rua dos Bobos', '01234567', 'Apto 27', 27, 'PR', 1);
	insert into tbEndereco values (2, 'Avenida do Além', '12345678', null, 32, 'PR', 1);
    insert into tbEndereco values (3, 'Rua Coronel Assumpção', '23456789', null, 330, 'PR', 1);
    insert into tbEndereco values (4, 'Akihabara', '34567891', null, 666, 'JP', 2);

 -- tbEmpresa(CNPJ, nome)
	insert into tbEmpresa values ('01234567891011', 'Nintendo');
    insert into tbEmpresa values ('11234567891011', 'Playstation');
    insert into tbEmpresa values ('21234567891011', 'Microsoft');
    insert into tbEmpresa values ('31234567891011', 'Epic Games');
    insert into tbEmpresa values ('41234567891011', 'Positivo');
    insert into tbEmpresa values ('51234567891011', 'ASUS');
    insert into tbEmpresa values ('61234567891011', 'Samsumg');
    
 -- tbProva(cod_prova, points, nome, descr, lugar)
	insert into tbProva values (1, 10, 'salto em distância', 
			'competidor deve correr por uma pista e saltar o mais longe possível', 1);
	insert into tbProva values (2, 10, 'salto em altura', 
			'competidor deve saltar sobre uma barra', 1);
	insert into tbProva values (3, 10, 'corrida 100m rasos', 
			'competidor deve correr por uma pista de 100 metros', 1);
	insert into tbProva values (4, 10, 'maratona', 
			'competidor deve correr por um percurso de 42,195 km', 4);
	insert into tbProva values (5, 10, 'tiro ao alvo', 
			'competidor deve tentar acertar um alvo com um arco e flecha', 2);
	insert into tbProva values (6, 10, 'arremesso de peso', 
			'competidor deve lançar uma esfera metálica o mais longe possível', 2);
	insert into tbProva values (7, 10, 'corrida com obstáculos', 
			'competidor deve correr por um percurso de 200m com obstáculos ', 1);
	insert into tbProva values (8, 10, 'caça ao tesouro',
			'competidor deve procurar por um tesouro escondido usando as dicas fornecidas', 4);
	insert into tbProva values (9, 10, 'battle royale',
			'competidor deve derrotar 10 inimigos em combate corpo-a-corpo no menor período de tempo', 4);
            
 -- tbGenero(cod_genero, genero)
	insert into tbGenero values (1, 'feminino');
    insert into tbGenero values (2, 'masculino');
    insert into tbGenero values (3, 'outro');
    
 -- tbTipo(cod_tipo, tipo)
	insert into tbTipo values (1, 'colaborador');
    insert into tbTipo values (2, 'estudante');
    
 -- tbPessoa(matricula, nome, sobrenome, data_nascimento, cod_genero, cod_tipo)
	insert into tbPessoa values ('012345678910', 'Lucas', 'Medeiros', '1998-12-27', 2, 2);
    insert into tbPessoa values ('112345678910', 'Isabela', 'Dambiski', '1998-03-06', 1, 2);
    insert into tbPessoa values ('212345678910', 'Flavio', 'Kintopp', '1998-01-01', 2, 2);
    insert into tbPessoa values ('312345678910', 'Bruno', 'Trevisan', '1998-12-14', 2, 2);
    insert into tbPessoa values ('412345678910', 'Matheus', 'Lemos', '1998-12-27', 2, 2);
    insert into tbPessoa values ('512345678910', 'Matheus', 'Heuko', '1998-07-13', 2, 2);
    insert into tbPessoa values ('612345678910', 'Nathalia', 'Gorte', '1998-03-28', 1, 2);
    insert into tbPessoa values ('712345678910', 'Flavia', 'Freitag', '1998-06-30', 1, 2);
    insert into tbPessoa values ('812345678910', 'Ivan', 'Chueiri', '1933-02-28', 2, 1);
    insert into tbPessoa values ('912345678910', 'Louise', 'Durante', '1998-10-01', 1, 2);
    insert into tbPessoa values ('022345678910', 'Giuliana', 'Kerne', '1998-09-19', 1, 2);
    insert into tbPessoa values ('032345678910', 'Joao', 'Cepeda', '1998-12-03', 2, 2);
    insert into tbPessoa values ('042345678910', 'Beatriz', 'Castro', '1999-09-08', 1, 2);
    insert into tbPessoa values ('052345678910', 'Joao', 'Couves', '1980-05-10', 3, 1);
    insert into tbPessoa values ('062345678910', 'Maria', 'Silveira', '1997-10-20', 3, 1);

 -- tbEdicao(ano, tema, data_inicio, data_fim, matricula_coordenador)
	insert into tbEdicao values (2018, 'meio ambiente', '2018-10-01', '2018-11-15', '012345678910');
    insert into tbEdicao values (2017, 'esportes', '2017-11-01', '2017-11-30', '012345678910');
    insert into tbEdicao values (2016, 'animais', '2016-03-01', '2016-03-30', '112345678910');
    insert into tbEdicao values (2015, 'crianças', '2015-04-01', '2015-04-30', '612345678910');
    insert into tbEdicao values (2014, 'política', '2014-06-01', '2014-06-30', '312345678910');
    insert into tbEdicao values (2013, 'comida', '2013-09-01', '2013-09-30', '042345678910');
    insert into tbEdicao values (2012, 'pokemon', '2012-12-01', '2012-12-30', '112345678910');
    insert into tbEdicao values (2011, 'geek', '2011-10-01', '2011-10-30', '052345678910');
    insert into tbEdicao values (2010, 'educação', '2010-05-01', '2010-05-30', '052345678910');
    
 -- tbPatrocina(CNPJ, ano, verba)
    insert into tbPatrocina values ('01234567891011', 2018, 5000.00);
    insert into tbPatrocina values ('11234567891011', 2017, 250.00);
    insert into tbPatrocina values ('21234567891011', 2016, 1500.25);
    insert into tbPatrocina values ('31234567891011', 2018, 2750.00);
    insert into tbPatrocina values ('41234567891011', 2015, 600.00);
    insert into tbPatrocina values ('51234567891011', 2014, 950.33);
    insert into tbPatrocina values ('61234567891011', 2013, 592.34);
    insert into tbPatrocina values ('61234567891011', 2018, 35.00);
    
 -- tbEdicao_Prova(ano, cod_prova, data_hora)
    insert into tbEdicao_Prova values (2018, 1, '2018-10-5 17:50:00');
    insert into tbEdicao_Prova values (2018, 2, '2018-10-6 7:50:00');
    insert into tbEdicao_Prova values (2018, 3, '2018-10-7 12:30:00');
    insert into tbEdicao_Prova values (2018, 4, '2018-10-8 13:20:00');
    insert into tbEdicao_Prova values (2018, 5, '2018-10-14 23:00:00');
    insert into tbEdicao_Prova values (2018, 6, '2018-10-15 18:15:00');
    insert into tbEdicao_Prova values (2018, 7, '2018-10-9 14:50:00');
    insert into tbEdicao_Prova values (2018, 8, '2018-10-10 6:50:00');
    insert into tbEdicao_Prova values (2018, 9, '2018-10-29 00:01:00');
    insert into tbEdicao_Prova values (2017, 1, '2017-11-5 17:50:00');
    insert into tbEdicao_Prova values (2017, 2, '2017-11-6 7:50:00');
    insert into tbEdicao_Prova values (2017, 3, '2017-11-7 12:30:00');
    insert into tbEdicao_Prova values (2017, 4, '2017-11-8 13:20:00');
    insert into tbEdicao_Prova values (2017, 5, '2017-11-14 23:00:00');
    insert into tbEdicao_Prova values (2017, 6, '2017-11-15 18:15:00');
    insert into tbEdicao_Prova values (2017, 7, '2017-11-9 14:50:00');
    insert into tbEdicao_Prova values (2017, 8, '2017-11-10 6:50:00');
    insert into tbEdicao_Prova values (2016, 1, '2016-03-5 17:50:00');
    insert into tbEdicao_Prova values (2016, 2, '2016-03-6 7:50:00');
    insert into tbEdicao_Prova values (2016, 3, '2016-03-7 12:30:00');
    insert into tbEdicao_Prova values (2016, 4, '2016-03-8 13:20:00');
    insert into tbEdicao_Prova values (2016, 5, '2016-03-14 23:00:00');
    insert into tbEdicao_Prova values (2016, 6, '2016-03-15 18:15:00');
    insert into tbEdicao_Prova values (2016, 7, '2016-03-9 14:50:00');
    insert into tbEdicao_Prova values (2016, 8, '2016-03-10 6:50:00');
    
 -- tbInscrever(ano, matricula)
    insert into tbInscrever values (2018, '012345678910');
    insert into tbInscrever values (2017, '012345678910');
    insert into tbInscrever values (2016, '012345678910');
    insert into tbInscrever values (2015, '012345678910');
    insert into tbInscrever values (2018, '112345678910');
    insert into tbInscrever values (2017, '112345678910');
    insert into tbInscrever values (2018, '212345678910');
    insert into tbInscrever values (2017, '312345678910');
    insert into tbInscrever values (2016, '412345678910');
    insert into tbInscrever values (2018, '512345678910');
	insert into tbInscrever values (2013, '512345678910');
    insert into tbInscrever values (2012, '612345678910');
    insert into tbInscrever values (2014, '712345678910');
    insert into tbInscrever values (2015, '712345678910');
    insert into tbInscrever values (2016, '712345678910');
    insert into tbInscrever values (2018, '912345678910');
    insert into tbInscrever values (2015, '912345678910');
    insert into tbInscrever values (2012, '022345678910');
    insert into tbInscrever values (2013, '032345678910');
    insert into tbInscrever values (2014, '032345678910');
    insert into tbInscrever values (2018, '042345678910');
    insert into tbInscrever values (2018, '052345678910');
    insert into tbInscrever values (2018, '062345678910');
    insert into tbInscrever values (2012, '062345678910');
    insert into tbInscrever values (2014, '062345678910');
    insert into tbInscrever values (2013, '012345678910');
    insert into tbInscrever values (2011, '112345678910');
    insert into tbInscrever values (2010, '012345678910');
    insert into tbInscrever values (2010, '112345678910');
    
 -- tbPessoa_Prova(matricula, cod_prova, tempo)
    insert into tbPessoa_Prova values (2018, '012345678910', 1, '00:05:39');
    insert into tbPessoa_Prova values (2017, '012345678910', 1, '00:07:42');
    insert into tbPessoa_Prova values (2016, '012345678910', 1, '00:20:26');
    insert into tbPessoa_Prova values (2015, '012345678910', 2, '01:02:03');
    insert into tbPessoa_Prova values (2018, '112345678910', 2, '03:24:21');
    insert into tbPessoa_Prova values (2017, '112345678910', 2, '00:58:06');
    insert into tbPessoa_Prova values (2018, '212345678910', 3, '00:46:56');
    insert into tbPessoa_Prova values (2017, '312345678910', 3, '00:15:23');
    insert into tbPessoa_Prova values (2016, '412345678910', 4, '00:05:39');
    insert into tbPessoa_Prova values (2018, '512345678910', 4, '00:05:39');
	insert into tbPessoa_Prova values (2013, '512345678910', 4, '00:20:26');
    insert into tbPessoa_Prova values (2012, '612345678910', 5, '00:17:00');
    insert into tbPessoa_Prova values (2014, '712345678910', 5, '00:23:42');
    insert into tbPessoa_Prova values (2015, '712345678910', 5, '00:20:26');
    insert into tbPessoa_Prova values (2016, '712345678910', 6, '00:00:58');
    insert into tbPessoa_Prova values (2018, '912345678910', 6, '00:00:42');
    insert into tbPessoa_Prova values (2015, '912345678910', 6, '00:01:13');
    insert into tbPessoa_Prova values (2012, '022345678910', 7, '00:03:58');
    insert into tbPessoa_Prova values (2013, '032345678910', 7, '00:09:42');
    insert into tbPessoa_Prova values (2014, '032345678910', 7, '00:01:13');
    insert into tbPessoa_Prova values (2018, '042345678910', 8, '05:03:54');
    insert into tbPessoa_Prova values (2018, '052345678910', 8, '04:47:42');
    insert into tbPessoa_Prova values (2018, '062345678910', 8, '10:01:29');
    insert into tbPessoa_Prova values (2012, '062345678910', 9, '00:25:13');
    insert into tbPessoa_Prova values (2014, '062345678910', 9, '00:14:42');
    insert into tbPessoa_Prova values (2013, '012345678910', 9, '01:15:00');
    insert into tbPessoa_Prova values (2011, '112345678910', 9, '00:01:01');

 -- tbEmail(email, matricula)
	insert into tbEmail values('lucascarmed@gmail.com', '012345678910');
    insert into tbEmail values('zedlucas98@gmail.com', '012345678910');
    insert into tbEmail values('isa.dambiski@gmail.com', '112345678910');
    insert into tbEmail values('bjtrevisan@gmail.com', '312345678910');
    insert into tbEmail values('flavio.kintopp@gmail.com', '212345678910');
    insert into tbEmail values('flafreitag@gmail.com', '712345678910');
    insert into tbEmail values('bibiafeliche@gmail.com', '042345678910');
    insert into tbEmail values('bia.castro99@gmail.com', '042345678910');
    insert into tbEmail values('kernegiu@gmail.com', '022345678910');
    insert into tbEmail values('miney@gmail.com', '912345678910');
    insert into tbEmail values('lou.durante@gmail.com', '912345678910');
    insert into tbEmail values('nathy_gorte@gmail.com', '612345678910');
    
 -- tbTelefone(DDD, telefone, matricula)
    insert into tbTelefone values('41', '998390804', '012345678910');
    insert into tbTelefone values('41', '999754745', '012345678910');
    insert into tbTelefone values('41', '992360845', '112345678910');
    insert into tbTelefone values('41', '993546823', '312345678910');
    insert into tbTelefone values('41', '997865231', '212345678910');
    insert into tbTelefone values('41', '995621203', '712345678910');
    insert into tbTelefone values('41', '998794233', '042345678910');
    insert into tbTelefone values('41', '995654784', '042345678910');
    insert into tbTelefone values('41', '985623154', '022345678910');
    insert into tbTelefone values('41', '986514527', '912345678910');
    insert into tbTelefone values('41', '124545724', '912345678910');
    insert into tbTelefone values('41', '635263146', '612345678910');
    
 -- tbEsporte(cod_esporte, nome)
	insert into tbEsporte values(1, 'basquete');
    insert into tbEsporte values(2, 'futebol');
    insert into tbEsporte values(3, 'hipismo');
    insert into tbEsporte values(4, 'escalada');
    insert into tbEsporte values(5, 'tênis');
    insert into tbEsporte values(6, 'handebol');
    insert into tbEsporte values(7, 'polo aquático');
    insert into tbEsporte values(8, 'natação');
    insert into tbEsporte values(9, 'tênis de mesa');
    insert into tbEsporte values(10, 'atletismo');
    insert into tbEsporte values(11, 'volei');
    insert into tbEsporte values(12, 'xadrez');
    insert into tbEsporte values(13, 'e-sports');
    insert into tbEsporte values(14, 'boliche');
    insert into tbEsporte values(15, 'poker');
    insert into tbEsporte values(16, 'surf');
    insert into tbEsporte values(17, 'skate');
    
 -- tbPessoa_Esporte(matricula, cod_esporte)
	insert into tbPessoa_Esporte values ('012345678910', 1);
    insert into tbPessoa_Esporte values ('012345678910', 2);
    insert into tbPessoa_Esporte values ('012345678910', 13);
    insert into tbPessoa_Esporte values ('012345678910', 15);
    insert into tbPessoa_Esporte values ('112345678910', 1);
    insert into tbPessoa_Esporte values ('112345678910', 3);
    insert into tbPessoa_Esporte values ('212345678910', 2);
    insert into tbPessoa_Esporte values ('312345678910', 16);
    insert into tbPessoa_Esporte values ('412345678910', 4);
    insert into tbPessoa_Esporte values ('512345678910', 13);
	insert into tbPessoa_Esporte values ('512345678910', 15);
    insert into tbPessoa_Esporte values ('612345678910', 4);
    insert into tbPessoa_Esporte values ('712345678910', 10);
    insert into tbPessoa_Esporte values ('712345678910', 11);
    insert into tbPessoa_Esporte values ('712345678910', 6);
    insert into tbPessoa_Esporte values ('912345678910', 10);
    insert into tbPessoa_Esporte values ('912345678910', 8);
    insert into tbPessoa_Esporte values ('022345678910', 9);
    insert into tbPessoa_Esporte values ('032345678910', 1);
    insert into tbPessoa_Esporte values ('032345678910', 2);
    insert into tbPessoa_Esporte values ('042345678910', 13);
    insert into tbPessoa_Esporte values ('052345678910', 4);
    insert into tbPessoa_Esporte values ('062345678910', 3);
    insert into tbPessoa_Esporte values ('062345678910', 4);
    


    
 -- Selects:
 
 -- Edição com o maior número de participantes inscritos
	Select e.ano as 'Edição', count(*) as 'Número de participantes'
		from tbEdicao e, tbInscrever i, tbPessoa p
		where e.ano = i.ano and i.matricula = p.matricula
		group by e.ano
		order by count(*) desc
		limit 1;
    
 -- Número médio de participantes inscritos
	Select (count(*) / (select count(*) from tbEdicao e)) as 'Número médio de participantes'
		from tbEdicao e, tbInscrever i, tbPessoa p
        where e.ano = i.ano and i.tbinscrevermatricula = p.matricula;
   
 -- Tema da Edição que teve menor número de pessoas inscritas
	Select e.ano as 'Edição', e.tema as 'Tema'
		from tbEdicao e, tbInscrever i, tbPessoa p
		where e.ano = i.ano and i.matricula = p.matricula
        group by e.ano
        order by count(*) asc
        limit 1;

 -- Considerando todas as edições, quantos participantes coordenaram por mais de um ano
	Select count(*) 
		from (Select p.nome as 'Nome'
		from tbEdicao e, tbPessoa p
		where e.matricula_coordenador = p.matricula
        group by p.matricula
        having count(*) > 1
		order by p.nome) resultado;
        
 -- Listar os participantes que coordenaram por mais de um ano
	Select p.nome as 'Nome'
		from tbEdicao e, tbPessoa p
		where e.matricula_coordenador = p.matricula
        group by p.matricula
        having count(*) > 1
		order by p.nome;
        
 -- Qual foi a prova e a respectiva edição, que foi realizada em menor tempo; 
	Select prova.nome as 'Prova', e.ano as 'Edição', pp.tempo as 'Tempo'
		from tbEdicao e, tbProva prova, tbInscrever i, tbPessoa_prova pp, tbPessoa p
        where p.matricula = i.matricula and i.ano = e.ano
			and i.matricula = pp.matricula and i.ano = pp.ano and prova.cod_prova = pp.cod_prova
        group by prova.cod_prova
        order by pp.tempo asc
        limit 1;
        
 -- Quais foram as edições que a Maria Silveira, nascida em 20 de outubro de 1997, participou;
	Select e.ano as 'Edição'
		from tbEdicao e, tbInscrever i, tbPessoa p
		where e.ano = i.ano and i.matricula = p.matricula
			and p.nome = 'Maria' and p.sobrenome = 'Silveira' and p.data_nascimento = '1997-10-20';
            
 -- Em quantas edições o Joao Couves, nascido em 10 de maio de 1980, coordenou a edição;
    Select count(*) as 'Número de vezes que coordenou'
		from tbEdicao e, tbPessoa p
		where e.matricula_coordenador = p.matricula
			and p.nome = 'Joao' and p.sobrenome = 'Couves' and p.data_nascimento = '1980-05-10';
            
 -- Quantos participantes relatam gostar de escaladas;
	Select count(*) as 'Número de participantes'
		from tbPessoa p, tbEsporte esporte, tbPessoa_Esporte pe
        where p.matricula = pe.matricula and pe.cod_esporte = esporte.cod_esporte
			and esporte.descr = 'escalada';
            
 -- Listar a contribuição financeira de cada empresa patrocinadora na edição de 2018; 
	Select emp.nome as 'Empresa', patrocinio.verba as 'Contribuição Financeira'
		from tbEmpresa emp, tbEdicao e, tbPatrocina patrocinio
        where emp.CNPJ = patrocinio.CNPJ and patrocinio.ano = e.ano
			and e.ano = 2018
		order by patrocinio.verbtbedicao_provaa desc;
        
 -- Qual a edição com o maior número de provas realizadas;
	Select e.ano as 'Edição', count(*) as 'Número de provas realizadas'
		from tbEdicao e, tbProva prova, tbEdicao_Prova ep
        where e.ano = ep.ano and ep.cod_prova = prova.cod_prova
        group by e.ano
        order by count(*) desc
        limit 1;
	
 -- Média de idade dos participantes para cada edição;     
    Select e.ano as 'Edição', 
			avg(TIMESTAMPDIFF(year, p.data_nascimento, curdate())) as 'Média de idade'
		from tbEdicao e, tbInscrever i, tbPessoa p
		where e.ano = i.ano and i.matricula = p.matricula
        group by e.ano
        order by e.ano desc;
        
 -- Número de mulheres participantes em cada edição;
	Select e.ano as 'Edição', count(*) as 'Número de participantes mulheres'
		from tbEdicao e, tbPessoa p, tbInscrever i, tbGenero g
        where e.ano = i.ano and i.matricula = p.matricula 
			and p.cod_genero = g.cod_genero and g.genero = 'feminino'
		group by e.ano
        order by e.ano desc;
        
 -- Tema e tempo de duração da edição mais longa realizada
	Select e.ano as 'Edição', e.tema as 'Tema', 
			timestampdiff(day, e.data_inicio, e.data_fim) as 'Tempo de duração em dias'
		from tbEdicao e
        group by e.ano
        order by timestampdiff(day, e.data_inicio, e.data_fim) desc
        limit 1;
        

