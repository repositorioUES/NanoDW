USE [NanoDW]
GO
/****** Object:  StoredProcedure [dbo].[ActualizarRedes]    Script Date: 29/10/2024 15:36:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER   PROCEDURE [dbo].[ActualizarRedes](
@RedesKey int, @RedesID int, @nombre_red_social varchar(255))
AS
BEGIN

	if not exists 
	(select * from DimRedes where RedesID=@RedesID 
	and Activo=1)

		BEGIN
		--Deshabilitar el registro anterior
		update DimRedes set FechaActualizacion=getdate(),
		Activo=0  where RedesKey=@RedesKey

		--Crear el nuevo registro
		insert into DimRedes(RedesID, nombre_red_social.Activo )
		values(@RedesID, @nombre_red_social,1)
		END
END