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