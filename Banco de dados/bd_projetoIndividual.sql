CREATE DATABASE beethoven;
USE beethoven;

CREATE TABLE usuario(
	id_usuario INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    senha VARCHAR(70) NOT NULL,
    dt_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE pontos (
    id_Pontos INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT NOT NULL,
    pontuacao_total INT,
    nivel_maximo_alcancado INT,
    ultima_atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (usuario_id) REFERENCES usuario(id_usuario) ON DELETE CASCADE
);

CREATE TABLE tentativas (
    id_tentativa INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT NOT NULL,
    dt_jogo DATETIME DEFAULT CURRENT_TIMESTAMP,
    tempo_segundos INT,
    acertos INT,
    erros INT,
    pontuacao INT,
    FOREIGN KEY (usuario_id) REFERENCES usuario(id_usuario) ON DELETE CASCADE
);

CREATE TABLE respostas (
  id_resposta INT AUTO_INCREMENT PRIMARY KEY,
  id_tentativa INT NOT NULL,
  numero_pergunta INT NOT NULL,
  correta BOOLEAN NOT NULL,
  FOREIGN KEY (id_tentativa) REFERENCES tentativas(id_tentativa)
);

CREATE TABLE estatisticas_gerais (
    id_estatistica INT PRIMARY KEY AUTO_INCREMENT,
    nome_estatistica VARCHAR(100) NOT NULL,
    valor VARCHAR(255) NOT NULL,
    ultima_atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);


-- INSERTS
INSERT INTO usuario (nome, email, senha) VALUES
('João Silva', 'joao.silva@email.com', 'senha1234'),
('Maria Souza', 'maria.souza@email.com', 'minhasenha'),
('Carlos Pereira', 'carlos.pereira@email.com', 'abc123456'),
('Ana Lima', 'ana.lima@email.com', 'senhaSegura2025');





select * from tentativas;

-- média de acertos do usuário
SELECT AVG(acertos) AS media_acertos
FROM tentativas
WHERE usuario_id = 1;

-- média de erros do usuário
SELECT AVG(erros) AS media_erros
FROM tentativas
WHERE usuario_id = 1;

-- media geral de acertos
SELECT AVG(acertos) FROM (
  SELECT COUNT(*) AS acertos
  FROM respostas
  WHERE correta = 1
  GROUP BY id_tentativa
) AS sub;

-- pergunta mais errada
SELECT numero_pergunta, COUNT(*) AS erros
FROM respostas
WHERE correta = 0
GROUP BY numero_pergunta
ORDER BY erros DESC
LIMIT 1;