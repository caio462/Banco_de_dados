USE MERCADO;

CREATE TABLE Funcionario (
    Codigo int primary key auto_increment,
    CPF varchar(11) unique not null,
    Nome varchar(200) not null,
    DataNascimento date not null,
    RG varchar(10) not null,
    Telefone varchar(15) unique not null,
    Endereco varchar(255) not null,
    Salario DECIMAL(7) not null
);

CREATE TABLE Setor (
    Id_Setor int primary key,
    Nome varchar(200) not null,
    CodigoFuncionario int,
    Valor int,
    constraint fk_CodigoFuncionario
    foreign key (CodigoFuncionario)
    references Funcionario(Codigo)
    on update cascade
    on delete restrict
);

CREATE TABLE Categoria (
    Id_categoria int primary key auto_increment,
    Nome varchar(255) not null
);

CREATE TABLE Fornecedor (
    Id_Fornecedor int primary key auto_increment,
    nome varchar(255)
);

CREATE TABLE Compra (
    CompraID int primary key,
    DataCompra date,
    FornecedorID int,
    ValorTotal decimal(10, 2),
    foreign key (FornecedorID)
    references Fornecedor(Id_Fornecedor)
);


CREATE TABLE Produto (
    Id_Produto int primary key,
    Nome varchar(255) not null,
    Valor int not null,
    Codigo_Fornecedor int,
    Codigo_Categoria int,
    constraint fk_CodigoCategoria
    foreign key (Codigo_Categoria)
    references Categoria(Id_Categoria)
    on update cascade
    on delete restrict,
    constraint fk_CodigoFornecedor
    foreign key (Codigo_Fornecedor)
    references Fornecedor(Id_Fornecedor)
    on update cascade
    on delete restrict
);


CREATE TABLE Cliente (
    CPF varchar(11) primary key
);

CREATE TABLE Venda (
    Id_venda int primary key,
    DataRetirada date not null,
    QuantidadeItem int not null,
    Faturamento int not null,
    CodigoVendaFuncionario int,
    Codigo_SaVenda int,
    Id_Cliente varchar(11),
    constraint fk_VendaFuncionario
    foreign key (CodigoVendaFuncionario)
    references Funcionario(Codigo)
    on update cascade
    on delete restrict,
    constraint fk_Id_Produto
    foreign key (Codigo_SaVenda)
    references Produto(Id_Produto)
    on update cascade
    on delete restrict,
    constraint fk_IdCliente
    foreign key (Id_Cliente)
    references Cliente(CPF)
    on update cascade
    on delete restrict
);


CREATE TABLE Estoque (
    Id_Estoque int primary key,
    Id_Produto int not null,
    Quantidade int not null,
    Validade date not null,
    constraint fk_Produto
    foreign key (Id_Produto)
    references Produto(Id_Produto)
    on update cascade
    on delete restrict
);

CREATE TABLE Despesas (
    valor int not null,
    tipo varchar(160),
    Id_Estoque int,
    constraint fk_DesEstoque
    foreign key (Id_Estoque)
    references Estoque(Id_Estoque)
    on update cascade
    on delete restrict
);