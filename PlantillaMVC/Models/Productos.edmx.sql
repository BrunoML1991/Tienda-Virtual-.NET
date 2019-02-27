
-- --------------------------------------------------
-- Entity Designer DDL Script for SQL Server 2005, 2008, 2012 and Azure
-- --------------------------------------------------
-- Date Created: 02/26/2019 20:49:09
-- Generated from EDMX file: D:\Trabajos Bruno\MIW\NET\workspace\Teoría y ejemplos\PlantillaMVC\PlantillaMVC\Models\Productos.edmx
-- --------------------------------------------------

SET QUOTED_IDENTIFIER OFF;
GO
USE [TiendaFinal];
GO
IF SCHEMA_ID(N'dbo') IS NULL EXECUTE(N'CREATE SCHEMA [dbo]');
GO

-- --------------------------------------------------
-- Dropping existing FOREIGN KEY constraints
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[FK_ProductoProductosPedidos]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[ProductosPedidos] DROP CONSTRAINT [FK_ProductoProductosPedidos];
GO
IF OBJECT_ID(N'[dbo].[FK_ProductosPedidosPedido_Pedido]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[ProductosPedidosPedido] DROP CONSTRAINT [FK_ProductosPedidosPedido_Pedido];
GO
IF OBJECT_ID(N'[dbo].[FK_ProductosPedidosPedido_ProductosPedidos]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[ProductosPedidosPedido] DROP CONSTRAINT [FK_ProductosPedidosPedido_ProductosPedidos];
GO
IF OBJECT_ID(N'[dbo].[FK_StockProducto]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Stocks] DROP CONSTRAINT [FK_StockProducto];
GO

-- --------------------------------------------------
-- Dropping existing tables
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[Pedidoes]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Pedidoes];
GO
IF OBJECT_ID(N'[dbo].[Productos]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Productos];
GO
IF OBJECT_ID(N'[dbo].[ProductosPedidos]', 'U') IS NOT NULL
    DROP TABLE [dbo].[ProductosPedidos];
GO
IF OBJECT_ID(N'[dbo].[ProductosPedidosPedido]', 'U') IS NOT NULL
    DROP TABLE [dbo].[ProductosPedidosPedido];
GO
IF OBJECT_ID(N'[dbo].[Stocks]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Stocks];
GO

-- --------------------------------------------------
-- Creating all tables
-- --------------------------------------------------

-- Creating table 'Productos'
CREATE TABLE [dbo].[Productos] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [Nombre] nvarchar(50)  NOT NULL,
    [Descrip] nvarchar(max)  NOT NULL,
    [Cantidad] int  NOT NULL,
    [Precio] real  NOT NULL,
    [FotoID] nvarchar(50)  NULL
);
GO

-- Creating table 'Pedidoes'
CREATE TABLE [dbo].[Pedidoes] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [IdUsuario] nvarchar(max)  NOT NULL,
    [Facturas_Id] int  NOT NULL
);
GO

-- Creating table 'ProductosPedidos'
CREATE TABLE [dbo].[ProductosPedidos] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [Cantidad_Productos] int  NOT NULL,
    [Producto_Id] int  NOT NULL
);
GO

-- Creating table 'Stocks'
CREATE TABLE [dbo].[Stocks] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [Reabastecido] bit  NOT NULL,
    [Productoes_Id] int  NOT NULL
);
GO

-- Creating table 'Facturas'
CREATE TABLE [dbo].[Facturas] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [ImporteTotal] real  NOT NULL
);
GO

-- Creating table 'ProductosPedidosPedido'
CREATE TABLE [dbo].[ProductosPedidosPedido] (
    [ProductosPedido_Id] int  NOT NULL,
    [Pedidoes_Id] int  NOT NULL
);
GO

-- --------------------------------------------------
-- Creating all PRIMARY KEY constraints
-- --------------------------------------------------

-- Creating primary key on [Id] in table 'Productos'
ALTER TABLE [dbo].[Productos]
ADD CONSTRAINT [PK_Productos]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'Pedidoes'
ALTER TABLE [dbo].[Pedidoes]
ADD CONSTRAINT [PK_Pedidoes]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'ProductosPedidos'
ALTER TABLE [dbo].[ProductosPedidos]
ADD CONSTRAINT [PK_ProductosPedidos]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'Stocks'
ALTER TABLE [dbo].[Stocks]
ADD CONSTRAINT [PK_Stocks]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'Facturas'
ALTER TABLE [dbo].[Facturas]
ADD CONSTRAINT [PK_Facturas]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [ProductosPedido_Id], [Pedidoes_Id] in table 'ProductosPedidosPedido'
ALTER TABLE [dbo].[ProductosPedidosPedido]
ADD CONSTRAINT [PK_ProductosPedidosPedido]
    PRIMARY KEY CLUSTERED ([ProductosPedido_Id], [Pedidoes_Id] ASC);
GO

-- --------------------------------------------------
-- Creating all FOREIGN KEY constraints
-- --------------------------------------------------

-- Creating foreign key on [Producto_Id] in table 'ProductosPedidos'
ALTER TABLE [dbo].[ProductosPedidos]
ADD CONSTRAINT [FK_ProductoProductosPedidos]
    FOREIGN KEY ([Producto_Id])
    REFERENCES [dbo].[Productos]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_ProductoProductosPedidos'
CREATE INDEX [IX_FK_ProductoProductosPedidos]
ON [dbo].[ProductosPedidos]
    ([Producto_Id]);
GO

-- Creating foreign key on [ProductosPedido_Id] in table 'ProductosPedidosPedido'
ALTER TABLE [dbo].[ProductosPedidosPedido]
ADD CONSTRAINT [FK_ProductosPedidosPedido_ProductosPedidos]
    FOREIGN KEY ([ProductosPedido_Id])
    REFERENCES [dbo].[ProductosPedidos]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating foreign key on [Pedidoes_Id] in table 'ProductosPedidosPedido'
ALTER TABLE [dbo].[ProductosPedidosPedido]
ADD CONSTRAINT [FK_ProductosPedidosPedido_Pedido]
    FOREIGN KEY ([Pedidoes_Id])
    REFERENCES [dbo].[Pedidoes]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_ProductosPedidosPedido_Pedido'
CREATE INDEX [IX_FK_ProductosPedidosPedido_Pedido]
ON [dbo].[ProductosPedidosPedido]
    ([Pedidoes_Id]);
GO

-- Creating foreign key on [Productoes_Id] in table 'Stocks'
ALTER TABLE [dbo].[Stocks]
ADD CONSTRAINT [FK_StockProducto]
    FOREIGN KEY ([Productoes_Id])
    REFERENCES [dbo].[Productos]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_StockProducto'
CREATE INDEX [IX_FK_StockProducto]
ON [dbo].[Stocks]
    ([Productoes_Id]);
GO

-- Creating foreign key on [Facturas_Id] in table 'Pedidoes'
ALTER TABLE [dbo].[Pedidoes]
ADD CONSTRAINT [FK_PedidoFactura]
    FOREIGN KEY ([Facturas_Id])
    REFERENCES [dbo].[Facturas]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_PedidoFactura'
CREATE INDEX [IX_FK_PedidoFactura]
ON [dbo].[Pedidoes]
    ([Facturas_Id]);
GO

-- --------------------------------------------------
-- Script has ended
-- --------------------------------------------------