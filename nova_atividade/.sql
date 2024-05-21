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
    foreign key (produto_id) references Produto(id),
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

INSERT INTO Compra (data_compra, produto_id, cliente_id, cod_vendedor) VALUES
('2024-05-15', 1, '12345678901', 101),
('2024-05-20', 2, '98765432109', 102),
('2024-05-18', 3, '45678901203', 103);