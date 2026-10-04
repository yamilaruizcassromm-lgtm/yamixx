-- Creación de la base de datos
CREATE DATABASE IF NOT EXISTS yamicomid_db;
USE yamicomid_db;

-- Tabla de Usuarios/Clientes
CREATE TABLE IF NOT EXISTS usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    telefono VARCHAR(20),
    direccion TEXT NOT NULL,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabla de Categorías de productos
CREATE TABLE IF NOT EXISTS categorias (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL
);

-- Tabla de Productos (Comidas)
CREATE TABLE IF NOT EXISTS productos (
    id_producto INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    precio DECIMAL(10, 2) NOT NULL,
    imagen_url VARCHAR(255),
    id_categoria INT,
    FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria) ON DELETE SET NULL
);

-- Tabla de Pedidos Realizados
CREATE TABLE IF NOT EXISTS pedidos (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT,
    total DECIMAL(10, 2) NOT NULL,
    estado ENUM('Pendiente', 'En preparación', 'En camino', 'Entregado') DEFAULT 'Pendiente',
    fecha_pedido TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario) ON DELETE CASCADE
);

-- Tabla Intermedia: Detalle de Pedidos
CREATE TABLE IF NOT EXISTS detalle_pedidos (
    id_detalle INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT,
    id_producto INT,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido) ON DELETE CASCADE,
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto) ON DELETE CASCADE
);

-- Insertar Datos Iniciales de Ejemplo
INSERT INTO categorias (nombre) VALUES ('Comida Rápida'), ('Mexican'), ('Saludable');

INSERT INTO productos (nombre, descripcion, precio, imagen_url, id_categoria) VALUES 
('Hamburguesa Clásica', 'Carne de res, queso cheddar, lechuga y tomate.', 8.50, 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=500', 1),
('Pizza Pepperoni', 'Masa artesanal con queso mozzarella y pepperoni.', 12.00, 'https://images.unsplash.com/photo-1513104890138-7c749659a591?w=500', 1),
('Tacos al Pastor', 'Carne marinada con piña y cilantro.', 6.00, 'https://images.unsplash.com/photo-1555939594-58d7cb561ad1?w=500', 2),
('Ensalada César', 'Pollo a la parrilla, crotones y aderezo césar.', 7.50, 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=500', 3);