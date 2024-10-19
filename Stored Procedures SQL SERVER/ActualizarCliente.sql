CREATE or ALTER PROCEDURE ActualizarCliente(
@ClienteKey int, @ClienteID int, @nombre_completo varchar(100), @email varchar(255),
@genero varchar(15), @telefono varchar(255), @departamento varchar(255),@municipio varchar(255), @direccion varchar(100))
AS
BEGIN
	if not exists 
	(select * from DimCliente where ClienteID=@ClienteID and
	nombre_completo=@nombre_completo and email=@email
	and genero=@genero and telefono=@telefono and departamento=@departamento
	and municipio=@municipio and direccion=@direccion and Activo=1)

		BEGIN
		--Deshabilitar el registro anterior
		update DimCliente set FechaActualizacion=getdate(),
		Activo=0 where ClienteKey=@ClienteKey

		--Crear el nuevo registro
		insert into DimCliente(ClienteID, nombre_completo, email, genero, telefono, departamento, municipio, direccion)
		values(@ClienteID, @nombre_completo, @email, @genero, @telefono, @departamento, @municipio, @direccion)
		END
END