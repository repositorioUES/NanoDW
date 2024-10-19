CREATE or ALTER PROCEDURE ActualizarOrden(
@OrdenKey int, @OrdenID int, @codigo_orden varchar(50), @subtotal_orden decimal(10,2), @envio decimal(10,2), 
@total_orden decimal(10,2), @estado_orden varchar(25), @metodo_pago varchar(128), @direccion_facturacion varchar(255), 
@direccion_envio varchar(255), @tipo_envio varchar(255))
AS
BEGIN
	if not exists 
	(select * from DimOrden where OrdenID=@OrdenID and
	codigo_orden=@codigo_orden and subtotal_orden=@subtotal_orden
	and envio=@envio and total_orden=@total_orden and estado_orden=@estado_orden
	and metodo_pago=@metodo_pago and direccion_facturacion=@direccion_facturacion 
	and direccion_envio=@direccion_envio and tipo_envio=@tipo_envio and Activo=1)

		BEGIN
		--Deshabilitar el registro anterior
		update DimOrden set FechaActualizacion=getdate(),
		Activo=0 where OrdenKey=@OrdenKey

		--Crear el nuevo registro
		insert into DimOrden(OrdenID, codigo_orden, subtotal_orden, envio, total_orden, estado_orden, 
		metodo_pago, direccion_facturacion, direccion_envio, tipo_envio)
		values(@OrdenID, @codigo_orden, @subtotal_orden, @envio, @total_orden, @estado_orden, 
		@metodo_pago, @direccion_facturacion, @direccion_envio, @tipo_envio)
		END
END