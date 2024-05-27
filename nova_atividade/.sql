use atividade_sala;

create table Produto (
    id int auto_increment primary key not null,
    nome varchar(255) not null,
    tipo varchar(50),
    preco decimal(10, 2) not null
    
);
create table Cliente (
    cpf varchar(11) primary key not null,
    nome varchar(100) not null,
    telefone varchar(20) not null,
    endereco varchar(255) not null,
    renda decimal(10, 2)
);
create table Promocao (
    id int auto_increment primary key not null,
    produto_id int not null,
    cliente_id varchar(11) not null,
    fim_desconto date not null,
    desconto decimal(5, 2) not null,
    foreign key (produto_id) references Produto(id),
    foreign key (cliente_id) references Cliente(cpf)
    on update cascade
    on delete restrict
);

create table Compra (
    id int auto_increment primary key not null,
    data_compra date not null,
    produto_id int not null,
    cliente_id varchar(11) not null,
    cod_vendedor int not null,
    quantidade int not null default 1,
    constraint `fk_product_id_compra`
    foreign key (produto_id) references Produto(id),
    constraint `fk_client_id_compra`
    foreign key (cliente_id) references Cliente(cpf)
    on update cascade
    on delete restrict
);

INSERT INTO Produto (nome, tipo, preco) VALUES
('Camiseta branca', 'Camiseta', 25.99),
('Calça jeans', 'Calça', 49.99),
('Vestido floral', 'Vestido', 39.99);

INSERT INTO Cliente (cpf, nome, telefone, endereco, renda) VALUES
('12345678901', 'John Kennedy', '(61) 98765-4321', 'Rua das Flores, 123', 2500.00),
('98765432109', 'Caio Vinicius', '(61) 98765-1234', 'Av. Principal, 456', 3000.00),
('45678901203', 'Eduardo', '(61) 98765-5678', 'Rua das Árvores, 789', 2000.00);

INSERT INTO Promocao (produto_id, cliente_id, fim_desconto, desconto) VALUES
(1, '12345678901', '2024-06-01', 10.00),
(2, '98765432109', '2024-05-20', 10.00);

INSERT INTO Compra (data_compra, produto_id, cliente_id, cod_vendedor, quantidade) VALUES
('2024-05-15', 1, '12345678901', 101, 2),
('2024-05-20', 2, '98765432109', 102, 3),
('2024-05-18', 3, '45678901203', 103, 4);

select * from Promocao;

create view Cliente_vendedor as
select nome, telefone from cliente;

create view Produto_vendedor as
select * from produto;

create view Compra_vendedor as
select * from Compra;

create view carrinho_Compra as
select 
    c.nome as cliente_nome, 
    c.telefone, 
    p.nome as produto_nome, 
    cp.cod_vendedor, 
    cp.quantidade,
(
p.preco *
	case
		when cp.data_compra <= pr.fim_desconto then (1 - pr.desconto / 100)
		else 1
	end
)as preco_final
from 
    cliente c
inner join 
    compra cp on c.cpf = cp.cliente_id
inner join 
    produto p on cp.produto_id = p.id
left join 
    promocao pr on pr.produto_id = p.id and cp.data_compra <= pr.fim_desconto;

select * from carrinho_compra;
create view preco_atual as
select p.id, p.nome, p.tipo, 
    (p.preco * 
        case
            when now() <= pr.fim_desconto then (1 - pr.desconto / 100)
            else 1
        end
    ) as preco_final
from produto p
left join promocao pr on p.id = pr.produto_id;

select * from preco_atual;
create user 'gerente'@'localhost' identified by 'password';
grant all on atividade_sala.* to 'gerente'@'localhost';

create user 'supervisor'@'localhost' identified by 'password';
grant select on atividade_sala.* to 'supervisor'@'localhost';

create user 'vendedor'@'localhost' identified by 'password';
grant select on atividade_sala.promocao to 'vendedor'@'localhost';
grant select on atividade_sala.Produto_vendedor to 'vendedor'@'localhost';
grant select on atividade_sala.Cliente_vendedor to 'vendedor'@'localhost';
grant select on atividade_sala.Compra_vendedor to 'vendedor'@'localhost';
grant select on atividade_sala.carrinho_Compra to 'vendedor'@'localhost';
grant select on atividade_sala.preco_atual to 'vendedor'@'localhost';