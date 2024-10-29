USE [NanoDW]
GO
/****** Object:  StoredProcedure [dbo].[ActualizarCategoria]    Script Date: 28/10/2024 21:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER   PROCEDURE [dbo].[ActualizarCategoria](
@CategoriaKey int, @CategoriaID int, @nombreCategoria varchar(255))
AS
BEGIN

	if not exists 
	(select * from DimCategoria where CategoriaID=@CategoriaID 
	and Activo=1)

		BEGIN
		--Deshabilitar el registro anterior
		update DimCategoria set FechaActualizacion=getdate(),
		Activo=0  where CategoriaKey=@CategoriaKey

		--Crear el nuevo registro
		insert into DimCategoria(CategoriaID, nombreCategoria )
		values(@CategoriaID, @nombreCategoria)
		END
END