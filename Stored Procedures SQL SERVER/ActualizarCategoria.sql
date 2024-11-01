USE [NanoDW]
GO
/****** Object:  StoredProcedure [dbo].[ActualizarCategoria]    Script Date: 29/10/2024 15:35:50 ******/
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
		insert into DimCategoria(CategoriaID, nombreCategoria,Activo)
		values(@CategoriaID, @nombreCategoria,1)
		END
END