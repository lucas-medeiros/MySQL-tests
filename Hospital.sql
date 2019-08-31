
DROP DATABASE Hospital;
CREATE DATABASE Hospital;
USE Hospital;

create table Convenio(
    codigo_convenio int,
    nome varchar(50),
    primary key (codigo_convenio)
);

-- nova tabela de valor vigente
create table Valor_vigente(
	ano int,
    valor float,
    cod_convenio int,
    primary key (ano, cod_convenio),
	foreign key (cod_convenio) references Convenio (codigo_convenio));

create table tbpais(
	cod_pais int,
    nome varchar(50),
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

create table Doencas_CID(
	cod_doenca char(4),
    descricao varchar(50),
    primary key (cod_doenca)
);

create table Sintoma(
	cod_sintoma int,
    descricao varchar(50),
    primary key (cod_sintoma)
);

create table Doenca_Sintoma(
	cod_doenca char(4),
    cod_sintoma int,
    primary key (cod_doenca, cod_sintoma),
    foreign key (cod_doenca) references Doencas_CID(cod_doenca),
    foreign key (cod_sintoma) references Sintoma(cod_sintoma)
);

create table Paciente(
    numero_paciente int,
    nome varchar(50),
    RG varchar(12),
    CPF char(11),
    cod_end int,
    foreign key (cod_end) references tbendereco(cod_end),
    primary key (numero_paciente)
);

create table Paciente_doencas(
	numero_paciente int,
    codigo_doenca char(4),
    primary key (numero_paciente, codigo_doenca),
    foreign key (numero_paciente) references Paciente(numero_paciente),
    foreign key (codigo_doenca) references Doencas_CID(cod_doenca)
);

create table Medico(
	CRM char(10),
    UF char(2),
    nome varchar(50),
    RG varchar(12),
    CPF char(11),
    cod_end int,
    foreign key (cod_end) references tbendereco(cod_end),
    primary key(CRM, UF)
);

create table Paciente_convenio(
    numero_paciente int,
    codigo_convenio int,
    primary key (numero_paciente, codigo_convenio),
    foreign key (numero_paciente) references Paciente(numero_paciente),
    foreign key (codigo_convenio) references Convenio(codigo_convenio)
);

create table Medico_convenio(
	codigo_convenio int,
    CRM char(10),
    UF char(2),
    primary key (codigo_convenio, CRM, UF),
    foreign key (codigo_convenio) references Convenio(codigo_convenio),
    foreign key (CRM, UF) references Medico(CRM, UF)
);

create table Exames(
	codigo_exame int,
    descricao varchar(50),
    primary key (codigo_exame)
);

create table Medicamento(
	codigo_medicamento int,
    descricao varchar(50),
    cod_medicamento_similar int,
    foreign key (cod_medicamento_similar) references Medicamento(codigo_medicamento),
    primary key(codigo_medicamento)
);

create table Consulta(
    numero_paciente int,
    codigo_convenio int,
    CRM char(10),
    UF char(2),
    data_hora datetime,
    queixas varchar(40),
    primary key (numero_paciente, codigo_convenio, CRM, UF, data_hora),
    foreign key (numero_paciente, codigo_convenio) references Paciente_convenio(numero_paciente, codigo_convenio),
	foreign key (CRM, UF) references Medico(CRM,UF)
);

create table Consulta_diagnostico(
	numero_paciente int,
	codigo_convenio int,
    CRM char(10),
    UF char(2),
    data_hora datetime,
    codigo_diagnostico char(4),
    primary key (numero_paciente, codigo_convenio, CRM, UF, data_hora, codigo_diagnostico),
    foreign key (numero_paciente, codigo_convenio, CRM, UF, data_hora) references Consulta(numero_paciente, codigo_convenio, CRM, UF, data_hora),
    foreign key (codigo_diagnostico) references Doencas_CID(cod_doenca)
);

create table Consulta_exames(
	numero_paciente int,
	codigo_convenio int,
    CRM char(10),
    UF char(2),
    data_hora datetime,
    codigo_exame int,
    resultado varchar(100),
    primary key (numero_paciente, codigo_convenio, CRM, UF, data_hora, codigo_exame),
    foreign key (numero_paciente, codigo_convenio, CRM, UF, data_hora) references Consulta(numero_paciente, codigo_convenio, CRM, UF, data_hora),
    foreign key (codigo_exame) references Exames(codigo_exame)
);

create table Consulta_medicamento(
	numero_paciente int,
	codigo_convenio int,
    CRM char(10),
    UF char(2),
    data_hora datetime,
    codigo_medicamento int,
    primary key (numero_paciente, codigo_convenio, CRM, UF, data_hora, codigo_medicamento),
    foreign key (numero_paciente, codigo_convenio, CRM, UF, data_hora) references Consulta(numero_paciente, codigo_convenio, CRM, UF, data_hora),
    foreign key (codigo_medicamento) references Medicamento (codigo_medicamento)
);


-- Convenio(codigo_convenio, nome, valor, ano);
	insert into Convenio values (1,'Unimed');
	insert into Convenio values (2,'SUS');
    
-- Valor_vigente (ano, valor, cod_convenio);
	insert into valor_vigente values (2018, 650.00, 1);
    insert into valor_vigente values (2017, 550.00, 1);
    insert into valor_vigente values (2018, 100.00, 2);

-- Pais (cod_pais, nome)
	insert into tbpais values (1, 'Brasil'); 
	insert into tbpais values (2, 'Japão');  

-- cidade (cod_cidade, nome, país)
	insert into tbcidade values (1, 'Curitiba', 1);

-- endereco(cod_end, rua, cep, complemento, numero, estado, cidade)
	insert into tbendereco values (1, 'Rua dos Bobos', '01234567', 'Apto 27', 27, 'PR', 1);
	insert into tbendereco values (2, 'Avenida do Além', '12345678', null, 32, 'PR', 1);

-- Doencas_CID(codigo, descricao);
	insert into Doencas_CID values ('A000','diabetes');
	insert into Doencas_CID values ('B000','Dengue');
	insert into Doencas_CID values ('C000','depressão');
    insert into Doencas_CID values ('D000','AIDS');
    insert into Doencas_CID values ('E000','cancêr');
    
-- Sintoma(cod_sintoma, descricao);
	insert into Sintoma values (1, 'febre');
    insert into Sintoma values (2, 'diarreia');
    insert into Sintoma values (3, 'vômito');
    insert into Sintoma values (4, 'dores no corpo');
    insert into Sintoma values (5, 'vermelidão nos olhos');
    insert into Sintoma values (6, 'cansaço');

-- Doenca_Sintoma(cod_doenca, cod_sintoma, descricao);
	insert into Doenca_Sintoma values('A000', 6);
    insert into Doenca_Sintoma values('B000', 1);
    insert into Doenca_Sintoma values('C000', 6);
    insert into Doenca_Sintoma values('D000', 1);
    insert into Doenca_Sintoma values('E000', 3);


-- Paciente(numero_paciente nome, rg, cpf, cod_end);
	insert into Paciente values (1, 'Luke Skywalker', '95260500', '06376186963', 1);
    insert into Paciente values (2, 'Padmé', '95260501', '06376186927', 1);
    insert into Paciente values (3, 'Joao das Couves', '012345678', '01234567891', 2);
    insert into Paciente values (4, 'Obi-wan Kenobi', '95260502', '06376186969', 1);
    insert into Paciente values (5, 'Yoda', '95260503', '06376186924', 1);
	insert into Paciente values (6, 'Han Solo', '95260543', '06376186939', 1);

-- Paciente_doencas(numero_paciente, codigo_doenca));
	insert into Paciente_doencas values (1, 'C000');
	insert into Paciente_doencas values (3, 'B000');
	insert into Paciente_doencas values (2, 'E000');
	insert into Paciente_doencas values (2, 'D000');
	insert into Paciente_doencas values (3, 'A000');
	insert into Paciente_doencas values (4, 'E000');
	insert into Paciente_doencas values (5, 'B000');
	insert into Paciente_doencas values (6, 'A000');

-- Medico(crm, uf, nome, rg, cpf, cod_end);
	insert into Medico values ('012345789', 'PR', 'Nathalia', '0123456789', '06376186920', 1);
    insert into Medico values ('112345789', 'PR', 'Giuliano', '1123456789', '06376186921', 2);
    insert into Medico values ('212345789', 'SP', 'Giovanna', '2123456789', '06376186921', 2);
    insert into Medico values ('312345789', 'PR', 'Louise', '3123456789', '06376186922', 1);
    insert into Medico values ('412345789', 'PR', 'Flávia', '4123456789', '06376186923', 1);
    insert into Medico values ('512345789', 'PR', 'Maria Silveira', '5123456789', '06376186925', 2);
    
-- Paciente_convenio(numero_paciente, cod_convenio);
	insert into Paciente_convenio values (1, 1);
	insert into Paciente_convenio values (2, 2);
	insert into Paciente_convenio values (3, 1);
	insert into Paciente_convenio values (4, 2);
	insert into Paciente_convenio values (5, 1);
    insert into Paciente_convenio values (6, 2);

-- Medico_convenio(codigo_convenio, CRM, UF);
	insert into Medico_convenio values (1, '012345789','PR');
    insert into Medico_convenio values (2, '112345789','PR');
    insert into Medico_convenio values (1, '212345789','SP');
    insert into Medico_convenio values (2, '312345789','PR');
    insert into Medico_convenio values (1, '412345789','PR');
    insert into Medico_convenio values (2, '512345789','PR');

-- Exames(codigo_exame, descricao);
	insert into Exames values (1,'Exame de sangue');
	insert into Exames values (2,'Ressonância Magnética');
	insert into Exames values (3,'Endoscopia');
	insert into Exames values (4,'Faringoscopia');
    insert into Exames values (5,'Tomografia');
    insert into Exames values (6,'Raio X');

-- Medicamento(codigo_medicamento, descricao, codigo_medicamento_similar);
	insert into Medicamento values (1,'Racutan', null);
	insert into Medicamento values (2,'Aspirina', null);
	insert into Medicamento values (3,'Tylenol', null);
	insert into Medicamento values (4,'Racutan Genérico', 1);
	insert into Medicamento values (5,'Kaloba', null);
	insert into Medicamento values (6,'Descongex', 3);
    insert into Medicamento values (7,'Engov', 2);
    insert into Medicamento values (8,'Racutan Genérico 2', 1);

-- Consulta(numero_paciente, codigo_convenio, CRM, UF, data_hora, queixas);
	insert into Consulta values (1, 1, '012345789', 'PR', '2018-10-12 17:50:00','dores no corpo');
    insert into Consulta values (2, 2, '112345789', 'PR', '2017-03-06 12:40:00','dor de cabeça');
    insert into Consulta values (3, 1, '212345789', 'SP', '1998-12-27 05:50:00','dor de barriga');
    insert into Consulta values (4, 2, '312345789', 'PR', '2018-05-13 22:10:00','tosse');
    insert into Consulta values (5, 1, '412345789', 'PR', '2013-10-10 02:15:00','sangramento nazal');
    insert into Consulta values (6, 2, '512345789', 'PR', '2018-10-07 23:53:17','tonturas');
    insert into Consulta values (1, 1, '512345789', 'PR', '2018-11-11 23:23:17','enjoo');
	insert into Consulta values (3, 1, '212345789', 'SP', '2018-12-27 05:50:00','dor de barriga');
     
-- Consulta_diagnostico(numero_paciente, codigo_convenio, CRM, UF,  data_hora,  codigo_diagnostico);
	insert into Consulta_Diagnostico values (1, 1, '012345789', 'PR', '2018-10-12 17:50:00', 'A000');
	insert into Consulta_Diagnostico values (2, 2, '112345789', 'PR', '2017-03-06 12:40:00', 'B000');
    insert into Consulta_Diagnostico values (3, 1, '212345789', 'SP', '1998-12-27 05:50:00', 'B000');
    insert into Consulta_Diagnostico values (4, 2, '312345789', 'PR', '2018-05-13 22:10:00', 'C000');
    insert into Consulta_Diagnostico values (5, 1, '412345789', 'PR', '2013-10-10 02:15:00', 'D000');
    insert into Consulta_Diagnostico values (6, 2, '512345789', 'PR', '2018-10-07 23:53:17', 'E000');
    
-- Consulta_exames(numero_paciente, codigo_convenio int, CRM, UF, data_hora, codigo_exame,  resultado);
	insert into Consulta_Exames values (1, 1, '012345789', 'PR', '2018-10-12 17:50:00', 1, 'resultado 1');
	insert into Consulta_Exames values (2, 2, '112345789', 'PR', '2017-03-06 12:40:00', 2, 'resultado 2');
    insert into Consulta_Exames values (3, 1, '212345789', 'SP', '1998-12-27 05:50:00', 3, 'resultado 3');
    insert into Consulta_Exames values (4, 2, '312345789', 'PR', '2018-05-13 22:10:00', 4, 'resultado 4');
    insert into Consulta_Exames values (5, 1, '412345789', 'PR', '2013-10-10 02:15:00', 5, 'resultado 5');
    insert into Consulta_Exames values (6, 2, '512345789', 'PR', '2018-10-07 23:53:17', 6, 'resultado 6');

-- Consulta_medicamento(numero_paciente, codigo_convenio, CRM, UF, data_hora, codigo_medicamento);
	insert into Consulta_Medicamento values (1, 1, '012345789', 'PR', '2018-10-12 17:50:00', 1);
	insert into Consulta_Medicamento values (2, 2, '112345789', 'PR', '2017-03-06 12:40:00', 2);
    insert into Consulta_Medicamento values (3, 1, '212345789', 'SP', '1998-12-27 05:50:00', 3);
    insert into Consulta_Medicamento values (4, 2, '312345789', 'PR', '2018-05-13 22:10:00', 4);
    insert into Consulta_Medicamento values (5, 1, '412345789', 'PR', '2013-10-10 02:15:00', 5);
    insert into Consulta_Medicamento values (6, 2, '512345789', 'PR', '2018-10-07 23:53:17', 6);
    insert into Consulta_Medicamento values (3, 1, '212345789', 'SP', '2018-12-27 05:50:00', 1);
    insert into Consulta_Medicamento values (3, 1, '212345789', 'SP', '2018-12-27 05:50:00', 2);


/*Propor informacoes a serem extraidas a partir da BD que envolvam pelo menos

quatro situacoes distintas que necessitem o operador da algebra relacional produto cartesiano. 
Construir a respectiva instrução SELECT. 

RECONSTRUIR A INCTRUCAO SELECT REPRESENTADO NESTA SEGUNDA IMPLEMENTACAO COM O OPERADOR DA JUNCAO

*/

-- Quantidade de pacientes que possuem convenio Unimed:
	select count(*)
		from Paciente p, Convenio conv, Paciente_Convenio pc
        where p.numero_paciente = pc.numero_paciente
			and conv.codigo_convenio = pc.codigo_convenio
            and conv.nome = 'Unimed';
            
	select count(*)
		from Paciente p
        inner join Paciente_convenio pc on p.numero_paciente = pc.numero_paciente
        inner join Convenio conv on conv.codigo_convenio = pc.codigo_convenio
		where conv.nome = 'Unimed';
            
            
-- Lista dos médicos que atendem pelo SUS:
	select m.nome
		from Medico m, Convenio conv, Medico_convenio mc
        where m.CRM = mc.CRM and m.UF = mc.UF and conv.codigo_convenio = mc.codigo_convenio
			and conv.nome = 'SUS'
		order by m.nome;
        
	select m.nome
		from Medico m
        inner join Medico_convenio mc on m.CRM = mc.CRM and m.UF = mc.UF
        inner join Convenio conv on conv.codigo_convenio = mc.codigo_convenio
        where conv.nome = 'SUS'
        order by m.nome;


-- Pacientes atendidos pela médica Maria Silveira:
	select p.nome
		from Medico m, Paciente p, Consulta c
        where m.CRM = c.CRM and m.UF = c.UF and p.numero_paciente = c.numero_paciente
			and m.nome = 'Maria Silveira'
		order by p.nome;
        
	select p.nome
		from Paciente p
        inner join Consulta c on p.numero_paciente = c.numero_paciente
        inner join Medico m on m.CRM = c.CRM and m.UF = c.UF
        where m.nome = 'Maria Silveira'
		order by p.nome;
        
        
-- Medicamentos indicados para o paciente Joao das Couves em 2018:
	select med.descricao
		from Medicamento med, Paciente p, Consulta c, Consulta_medicamento cm, Medico m
        where p.numero_paciente = c.numero_paciente and m.CRM = c.CRM and m.UF = c.UF
			and c.numero_paciente = cm.numero_paciente and c.CRM = cm.CRM and c.UF = cm.UF
            and c.data_hora = cm.data_hora and med.codigo_medicamento = cm.codigo_medicamento
            and year(c.data_hora) = 2018
            and p.nome = 'Joao das Couves'
		order by med.descricao;
        
	select med.descricao
		from Paciente p
        inner join Consulta c on p.numero_paciente = c.numero_paciente
        inner join Consulta_medicamento cm on c.numero_paciente = cm.numero_paciente 
			and c.CRM = cm.CRM and c.UF = cm.UF and c.data_hora = cm.data_hora
		inner join Medicamento med on med.codigo_medicamento = cm.codigo_medicamento
        where year(c.data_hora) = 2018 and p.nome = 'Joao das Couves'
        order by med.descricao;
        