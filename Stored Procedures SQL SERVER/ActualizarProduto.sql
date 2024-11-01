USE [NanoDW]
GO
/****** Object:  StoredProcedure [dbo].[ActualizarProducto]    Script Date: 28/10/2024 21:43:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER   PROCEDURE [dbo].[ActualizarProducto](
@ProductoKey int, @ProductoID int, @producto varchar(255),
@sku varchar(64), @tipo_producto varchar(32), @precio decimal(10,2), @peso decimal(10,2))
AS
BEGIN

	if not exists 
	(select * from DimProducto where ProductoID=@ProductoID and
	producto=@producto 
	and sku=@sku and tipo_producto=@tipo_producto and precio=@precio
	and peso=@peso and Activo=1)

		BEGIN
		--Deshabilitar el registro anterior
		update DimProducto set FechaActualizacion=getdate(),
		Activo=0 where ProductoKey=@ProductoKey

		--Crear el nuevo registro
		insert into DimProducto(ProductoID, producto, sku, tipo_producto, precio, peso )
		values(@ProductoID, @producto, @sku, @tipo_producto, @precio, @peso)
		END
END