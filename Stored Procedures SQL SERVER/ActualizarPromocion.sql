CREATE OR ALTER PROCEDURE ActualizarPromocion(
@PromocionKey int, @nombre_promocion varchar(255), @descripcion varchar(255), 
@tipo_promocion varchar(32), @cantidad_descuento decimal(10,2), @cupon varchar(255))
AS
BEGIN
	update DimPromocion set nombre_promocion=@nombre_promocion,
	descripcion=@descripcion, tipo_promocion=@tipo_promocion,
	cantidad_descuento=@cantidad_descuento, cupon=@cupon where PromocionKey=@PromocionKey
END