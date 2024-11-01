USE [NanoDW]
GO
/****** Object:  StoredProcedure [dbo].[ActualizarCampaniaPublicitaria]    Script Date: 29/10/2024 15:28:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


	ALTER   PROCEDURE [dbo].[ActualizarCampaniaPublicitaria](
@CampaniaPublicitariaKey int, @CampaniaPublicitariaID int, @nombre_campania varchar(255),
@tipo_publicidad varchar (255), @medio_publicidad varchar(255), @duracion_publicidad varchar(255),
@fecha_inicio date, @fecha_finalizacion date,@costo_total decimal (10,2))
AS
BEGIN

	if not exists 
	(select * from DimCampaniaPublicitaria where CampaniaPublicitariaID=@CampaniaPublicitariaID 
	and Activo=1)

		BEGIN
		--Deshabilitar el registro anterior
		update DimCampaniaPublicitaria set FechaActualizacion=getdate(),
		Activo=0  where CampaniaPublicitariaKey=@CampaniaPublicitariaKey

		--Crear el nuevo registro
		insert into DimCampaniaPublicitaria(CampaniaPublicitariaID, nombre_campania,
tipo_publicidad, medio_publicidad, duracion_publicidad,
fecha_inicio, fecha_finalizacion,costo_total,Activo)

		values(@CampaniaPublicitariaID, @nombre_campania,
@tipo_publicidad, @medio_publicidad, @duracion_publicidad,
@fecha_inicio, @fecha_finalizacion,@costo_total,1)
		END
END