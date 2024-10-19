

CREATE DATABASE NanoDW
go

USE NanoDW
go


CREATE TABLE DimProducto(
    ProductoKey int not null primary key identity(1,1),
    ProductoID int not null,							-- magento.catalog_product_flat_1.entity_id
	producto varchar(255) not null,						-- magento.catalog_product_flat_1.name
	categoria varchar(255) not null,					-- magento.catalog_category_flat_store_1.name
    sku varchar(64) not null,							-- magento.catalog_product_flat_1.sku
    tipo_producto varchar(32) not null,					-- magento.catalog_product_flat_1.type_id
    precio decimal(10,2) not null,						-- magento.catalog_product_flat_1.price
    peso decimal(10,2) not null,						-- magento.catalog_product_flat_1.weight
	FechaActualizacion datetime not null default getdate(),
	Activo bit not null default 1
)
go

CREATE TABLE DimCliente(
    ClienteKey int not null primary key identity(1,1), 
    ClienteID int not null,								-- magento.customer_grid_flat.entity_id
    nombre_completo varchar(100) not null,				-- magento.customer_grid_flat.name
    email varchar(255) not null,                        -- magento.customer_grid_flat.email
    genero varchar(15) not null,						-- magento.customer_grid_flat.gender
    telefono varchar(255) not null,						-- magento.customer_address_entity.telephone
    departamento varchar(255) not null,					-- magento.customer_address_entity.region
    municipio varchar(255) not null,					-- magento.customer_address_entity.city
    direccion varchar(100) not null,					-- magento.customer_address_entity.street
	FechaActualizacion datetime not null default getdate(),
	Activo bit not null default 1
)
go

CREATE TABLE DimPromocion(
    PromocionKey int not null primary key identity(1,1),
    PromocionID int not null,							-- magento.salesrule.rule_id
    nombre_promocion varchar(255) not null,				-- magento.salesrule.name
	descripcion varchar(255) not null,					-- magento.salesrule.description
    tipo_promocion varchar(32) not null,				-- magento.salesrule.simple_action
	cantidad_descuento decimal(10,2) not null,			-- magento.salesrule.discount_amount
	cupon varchar(255) not null							-- magento.salesrule_coupon.code
)
go

CREATE TABLE DimFecha(
    FechaKey int not null primary key,
    fecha datetime not null,
	nombre_dia varchar(9) not null,
	nombre_mes varchar(12),
    dia tinyint not null,
    semana tinyint not null,
    mes tinyint not null,
    trimestre tinyint not null,
    anio smallint not null
)
go

CREATE TABLE DimOrden(
    OrdenKey int not null primary key identity(1,1),
    OrdenID int not null,								-- magento.sales_invoice_grid.order_id
    codigo_orden varchar(50) not null,					-- magento.sales_invoice_grid.increment_id
	subtotal_orden decimal(10,2) not null,				-- magento.sales_invoice_grid.subtotal
	envio decimal(10,2) not null,						-- magento.sales_invoice_grid.shipping_and_handling
    total_orden decimal(10,2) not null,					-- magento.sales_invoice_grid.base_grand_total
    estado_orden varchar(25) not null,					-- magento.sales_invoice_grid.state
    metodo_pago varchar(128) not null,					-- magento.sales_invoice_grid.payment_method
    direccion_facturacion varchar(255) not null,		-- magento.sales_invoice_grid.billing_address
    direccion_envio varchar(255) not null,				-- magento.sales_invoice_grid.shipping_address
    tipo_envio varchar(255),							-- magento.sales_invoice_grid.shipping_information
	FechaActualizacion datetime not null default getdate(),
	Activo bit not null default 1
)
go

CREATE TABLE FactVentas(
    ClienteKey int not null foreign key references DimCliente(ClienteKey),
	ProductoKey int not null foreign key references DimProducto(ProductoKey),
	PromocionKey int not null foreign key references DimPromocion(PromocionKey),
	OrdenKey int not null foreign key references DimOrden(OrdenKey),
	FechaOrdenKey int not null foreign key references DimFecha(FechaKey),
	FechaEnvioKey int not null foreign key references DimFecha(FechaKey),
	cantidad int not null,
    precio_unitario_regular decimal(10,2) not null default (0),
    precio_extendido decimal(10,2) not null default (0),
	cantidad_descuento decimal(10,2) not null default (0),
    precio_venta_final decimal(10,2) not null default (0),
)
go

CREATE TABLE Parametros(
	idParametro int primary key identity(1,1),
	NombreParametro varchar(25) not null,
	ValorParametro varchar(100) not null
)


