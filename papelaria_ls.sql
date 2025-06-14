-- Criação do banco de dados
CREATE DATABASE papelaria_ls;
USE papelaria_ls;

-- Tabela de Produtos
CREATE TABLE produtos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    preco DECIMAL(10, 2) NOT NULL,
    estoque INT NOT NULL DEFAULT 0,
    categoria VARCHAR(50) NOT NULL,
    imagem VARCHAR(255),
    data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ativo BOOLEAN DEFAULT TRUE
);

-- Tabela de Clientes
CREATE TABLE clientes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    telefone VARCHAR(20),
    endereco TEXT,
    data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ativo BOOLEAN DEFAULT TRUE
);

-- Tabela de Pedidos
CREATE TABLE pedidos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT NOT NULL,
    data_pedido TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status ENUM('pendente', 'processando', 'enviado', 'entregue', 'cancelado') DEFAULT 'pendente',
    total DECIMAL(10, 2) NOT NULL,
    forma_pagamento VARCHAR(50),
    endereco_entrega TEXT,
    FOREIGN KEY (cliente_id) REFERENCES clientes(id)
);

-- Tabela de Itens do Pedido
CREATE TABLE itens_pedido (
    id INT AUTO_INCREMENT PRIMARY KEY,
    pedido_id INT NOT NULL,
    produto_id INT NOT NULL,
    quantidade INT NOT NULL,
    preco_unitario DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (pedido_id) REFERENCES pedidos(id),
    FOREIGN KEY (produto_id) REFERENCES produtos(id)
);

-- Inserção de dados de exemplo

-- Produtos
INSERT INTO produtos (nome, descricao, preco, estoque, categoria, imagem) VALUES
('Caderno Espiral 96 Folhas', 'Caderno espiral com 96 folhas, capa dura, formato A5', 12.90, 50, 'Materiais Escolares', 'caderno.jpg'),
('Caneta Esferográfica Azul', 'Pack com 10 canetas esferográficas azuis, ponta média', 19.90, 100, 'Escritório', 'caneta.jpg'),
('Marca-texto Pastel 6 Cores', 'Conjunto com 6 marca-textos em cores pastéis', 32.90, 30, 'Papelaria Criativa', 'marcatexto.jpg');

-- Clientes
INSERT INTO clientes (nome, email, telefone, endereco) VALUES
('João Silva', 'joao.silva@email.com', '(11) 99999-9999', 'Rua das Flores, 123 - São Paulo/SP'),
('Maria Oliveira', 'maria.oliveira@email.com', '(21) 98888-8888', 'Avenida Brasil, 456 - Rio de Janeiro/RJ'),
('Carlos Souza', 'carlos.souza@email.com', '(31) 97777-7777', 'Rua das Palmeiras, 789 - Belo Horizonte/MG');

-- Pedidos
INSERT INTO pedidos (cliente_id, status, total, forma_pagamento, endereco_entrega) VALUES
(1, 'entregue', 45.70, 'cartao', 'Rua das Flores, 123 - São Paulo/SP'),
(2, 'enviado', 32.90, 'pix', 'Avenida Brasil, 456 - Rio de Janeiro/RJ'),
(3, 'pendente', 19.90, 'boleto', 'Rua das Palmeiras, 789 - Belo Horizonte/MG');

-- Itens dos Pedidos
INSERT INTO itens_pedido (pedido_id, produto_id, quantidade, preco_unitario) VALUES
(1, 1, 2, 12.90),
(1, 2, 1, 19.90),
(2, 3, 1, 32.90),
(3, 2, 1, 19.90);