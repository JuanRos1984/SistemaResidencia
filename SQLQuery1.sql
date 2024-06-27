
use ORBIPE


select * from [dbo].[Empleado]

--CREACION DE LA BASE DE DATOS--
create database ORBI_SIGEI

--USO DE LA DB
use ORBI_SIGEI

--CREACION DE ESQUEMA DE RESIDENCIA--
create schema Residencia

--TABLAS DENTRO DEL ESQUEMA DE RESIDENCIA ACADEMICA--

CREATE TABLE Residencia.Induccion (
  [ID] INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
  [Cant_Horas] Int NOT NULL ,
  [Nombre] Nvarchar(100) NOT NULL,
  [Descripcion] NVarchar(MAX) NOT NULL,
  [Fecha_Inicio] DateTime NOT NULL,
  [Fecha_Fin] DateTime NOT NULL,
  [Participantes] Int NOT NULL,
  [Estatus] NVarchar(1) NOT NULL,
  [Usuario_Crea] Int NOT NULL ,
  [Usuario_Modifica] Int ,
  [Fecha_Crea] DateTime NOT NULL,
  [Fecha_Modifica] DateTime,
);

SELECT * FROM Residencia.Induccion
add 

ALTER TABLE Residencia.Induccion
ADD [Estatus] NVarchar(1) NOT NULL
  

ALTER TABLE Residencia.Induccion
ADD  [Usuario_Crea] Int NOT NULL
  

ALTER TABLE Residencia.Induccion
ADD  [Usuario_Modifica] Int 

ALTER TABLE Residencia.Induccion
ADD  [Fecha_Crea] DateTime NOT NULL

ALTER TABLE Residencia.Induccion
ADD  [Fecha_Modifica] DateTime

select * from Residencia.Induccion

CREATE TABLE Residencia.Tipo_Documento (
  [ID] INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
  [Nombre_Documento] NVarchar(Max) NOT NULL,
  [Descripcion] NVarchar(MAX) NOT NULL,
  [Estatus] NVarchar(1) NOT NULL,
  [Actualizable] Nvarchar(1)
);



CREATE TABLE Residencia.Recinto (
  [ID] INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
  [Nombre] NVarChar(MAX) NOT NULL,
  [Recinto] NVarChar(MAX) NOT NULL,
  [Estatus] NVarchar(1) NOT NULL,
  [Usuario_Crea] Int NOT NULL,
  [Usuario_Modifica] Int,
  [Fecha_Crea] DateTime NOT NULL,
  [Fecha_Modifica] DateTime,
);

CREATE TABLE Residencia.Modulos (
  [ID] INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
  [Nombre] NVarchar(60) NOT NULL,
  [Descripcion] NVarChar(MAX) NOT NULL,
  [Cantidad] Int NOT NULL,
  [Estatus] NVarchar(1) NOT NULL,
  [Usuario_Crea] Int NOT NULL,
  [Usuario_Modifica] Int,
  [Fecha_Crea] DateTime NOT NULL,
  [Fecha_Modifica] DateTime,
);


CREATE TABLE Residencia.Solicitud_ingreso (
  [ID] INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
  [IDUsuario_Aprueba] Int NOT NULL,
  [IDEstudiante] Int NOT NULL,
  [Comentario_Razon] NVarChar(MAX) NOT NULL,
  [Comentario] NVarChar(MAX),
  [Estatus] NVarchar(1) NOT NULL,
  [Becado] Bit NOT NULL ,
  [Fecha_Solicitud] DateTime NOT NULL,
  [Fecha_Ingreso] DateTime NOT NULL,
  [Usuario_Crea] Int NOT NULL,
  [Usuario_Modifica] Int,
  [Fecha_Crea] DateTime NOT NULL,
  [Fecha_Modificada] DateTime,

  --CONSTRAINT FK_SolicitudUsuarioAprueba FOREIGN KEY (IDUsuario_Aprueba) REFERENCES Usuario(IDusuario),
  --CONSTRAINT FK_SolicitudEstudiante FOREIGN KEY (IDEstudiante) REFERENCES Estudiantes(IDEstudiante),
);


CREATE TABLE Residencia.Residente (
  [ID] INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
  [IDUsuario] Int NOT NULL,
  [IDEstudiante] Int NOT NULL,
  [ID_Recinto_Residencia] Int NOT NULL,
  [ID_Mobiliario] Int NOT NULL,
  [Fecha_Solicitud_Ingreso] DateTime NOT NULL,
  [Fecha_Llegada_Ingreso] DateTime NOT NULL,
  [Fecha_Salida_Ingreso ] DateTime NOT NULL,
  [Estatus] NVarchar(1) NOT NULL,
  [Usuario_Crea] Int NOT NULL,
  [Usuario_Modifica] Int,
  [Fecha_Crea] DateTime NOT NULL,
  [Fecha_Modifica] DateTime,

  --CONSTRAINT FK_DatosResidente FOREIGN KEY (IDUsuario) REFERENCES Usuario(IDusuario),
  --CONSTRAINT FK_DatosEstudiantes FOREIGN KEY (IDEstudiante) REFERENCES Estudiantes(IDEstudiante),
  CONSTRAINT FK_DatosRecinto FOREIGN KEY (ID_Recinto_Residencia) REFERENCES Residencia.Recinto(ID),
  CONSTRAINT FK_DatosMobiliario FOREIGN KEY (ID_Mobiliario) REFERENCES Residencia.Mobiliario(ID)

);


EXEC sp_rename 'Residencia.Residencia_Mobiliario', 'Residencia.Mobiliario';



Create TABLE Residencia.Mobiliario (
  [ID] INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
  [ID_Recinto_Residencia] Int NOT NULL,
  [ID_Residente] Int NOT NULL,
  [Edificio] Int NULL,
  [Apartamento] Int NULL,
  [Habitacion] Int NULL,
  [Nivel] Int NULL,
  [Modulo] Int NULL,
  [Tipo_Cama] NVarChar(1) NULL,
  [Estatus] NVarChar(1) NOT NULL,
  [Usuario_Crea] Int NOT NULL,
  [Usuario_Modifica] int,
  [Fecha_Crea] DateTime NOT NULL,
  [Fecha_Modifica] DateTime,


  CONSTRAINT FK_Recinto_Residencia FOREIGN KEY (ID_Recinto_Residencia) REFERENCES Residencia.Recinto(ID)
);

Alter table Residencia.Mobiliario
ADD CONSTRAINT FK_Residente FOREIGN KEY (ID_Residente) REFERENCES Residencia.Residente(ID)


CREATE TABLE Residencia.Solicitud_Baja (
  [ID] INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
  [ID_Residente] Int NOT NULL,
  [Fecha_Solicitud] DateTime NOT NULL,
  [Horario] DateTime NOT NULL,
  [Fecha_Salida] DateTime NOT NULL,
  [Motivo_Salida ] NVarchar(MAX) NOT NULL,
  [Estatus] NVarchar(1) NOT NULL,
  [Usuario_Crea] Int NOT NULL,
  [Usuario_Modifica] Int,
  [Fecha_Crea] DateTime NOT NULL,
  [Fecha_Modifica] DateTime

  CONSTRAINT FK_SOlicitud_Baja_Residente FOREIGN KEY (ID_Residente) REFERENCES Residencia.Residente(ID)
);

CREATE TABLE Residencia.Articulos (
  [ID] INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
  [ID_Mobiliario] Int NOT NULL,
  [Nombre] NVarChar(MAX) NOT NULL,
  [Estatus] NVarChar(1) NOT NULL ,
  [Usuario_Crea] Int NOT NULL,
  [Usuario_Modifica] Int,
  [Fecha_Crea] DateTime NOT NULL,
  [Fecha_Modifica] DateTime

  CONSTRAINT FK_ArticulosMobiliario FOREIGN KEY (ID_Mobiliario) REFERENCES Residencia.Mobiliario(ID)
);

CREATE TABLE Residencia.Residente_Modulo (
  [ID_Residente] Int,
  [ID_Modulo] Int,
  [Encargado] Bit

  CONSTRAINT FK_Modulo_Residente FOREIGN KEY (ID_Residente) REFERENCES Residencia.Residente(ID),
  CONSTRAINT FK_Modulo FOREIGN KEY (ID_Modulo) REFERENCES Residencia.Modulos(ID)
);

CREATE TABLE Residencia.Solicitud_Induccion (
  [ID] INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
  [ID_Induccion] Int NOT NULL,
  [ID_Residente] Int NOT NULL,
  [Fecha] DateTime NOT NULL,
  [Usuario_Crea] Int NOT NULL,
  [Usuario_Modifica] Int,
  [Fecha_Crea] DateTime NOT NULL,
  [Fecha_Modifica] DateTime,

  CONSTRAINT FK_SolicitudInduccion FOREIGN KEY (ID_Induccion) REFERENCES Residencia.Induccion(ID),
  CONSTRAINT FK_SolicitudResidente FOREIGN KEY (ID_Residente) REFERENCES Residencia.Residente(ID)

);


CREATE TABLE Residencia.Reportes (
  [ID] INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
  [Tipo_reporte] NVarchar(15) NOT NULL,
  [Estatus] NVarchar(1) NOT NULL
);

CREATE TABLE Residencia.Quejas_Mantenimiento (
  [ID] INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
  [ID_Residente] Int NOT NULL,
  [Fecha_Solicitud] DateTime NOT NULL,
  [ID_Reporte] Int NOT NULL,
  [Comentario_Razon] NVarchar(MAX) NOT NULL,
  [Estatus] NVarchar(1) NOT NULL

   CONSTRAINT FK_QuejasResidente FOREIGN KEY (ID_Residente) REFERENCES Residencia.Residente(ID),
   CONSTRAINT FK_Reportes FOREIGN KEY (ID_Reporte) REFERENCES Residencia.Reportes(ID)

);

alter table Residencia.Quejas_Mantenimiento
add  Nombre_Imagen Varchar(40)

select * from Residencia.Quejas_Mantenimiento


CREATE TABLE Residencia.Documentos_Cargados (
  [ID] INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
  [ID_Residente] Int NOT NULL,
  [ID_Tipo_Documento] Int NOT NULL,
  [Fecha_cargado] DateTime NOT NULL,

  CONSTRAINT FK_DocumentoResidente FOREIGN KEY (ID_Residente) REFERENCES Residencia.Residente(ID),
  CONSTRAINT FK_TipoDocumento FOREIGN KEY (ID_Tipo_Documento) REFERENCES Residencia.Tipo_documento(ID)
);


CREATE TABLE Residencia.Alojamiento_Transitorio (
  [ID] INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
  [ID_Recinto_Residencia] Int NOT NULL,
  [Fecha_Llegada] DateTime NOT NULL,
  [Fecha_Partida] DateTime NULL,
  [Nombre] NVarchar(60) NOT NULL,
  [Apellido] NVarchar(60) NOT NULL,
  [ID_Tipo_Documento] Int NOT NULL,
  [Identificacion] Varchar(20) NULL	,
  [Correo] NVarchar(MAX) NULL,
  [Telefono] Int NULL,
  [Celular] Int NULL,
  [Tipo_Evento] NVarchar(60) NOT NULL,
  [Nombre_Evento] NVarchar(60) NOT NULL,
  [Estatus] NVarchar(1) NOT NULL,

  CONSTRAINT FK_Alojamiento_TipoDocumento FOREIGN KEY (ID_Tipo_Documento) REFERENCES Residencia.Tipo_documento(ID),
  CONSTRAINT FK_Alojamiento_Recinto_Residencia FOREIGN KEY (ID_Recinto_Residencia) REFERENCES Residencia.Recinto(ID)
);

select * from Residencia.Tipo_Documento



CREATE TABLE Residencia.Amonestaciones (
  [ID] INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
  [ID_Residente] Int NOT NULL,
  [Motivo_Falta] NVarchar(MAX) NOT NULL,
  [Descripcion] NVarchar(MAX) NOT NULL,
  [Fecha_Falta] DateTime NOT NULL,
  [Estatus] NVarchar(1) NOT NULL,
  [Usuario_Crea] Int NOT NULL,
  [Usuario_Modifica] Int,
  [Fecha_Crea] DateTime NOT NULL,
  [Fecha_modifica] DateTime,

  CONSTRAINT FK_Amonestacion_Residente FOREIGN KEY (ID_Residente) REFERENCES Residencia.Residente(ID)
);


CREATE TABLE Residencia.Articulos_Rotos (
  [ID] Int,
  [ID_Residente] Int,
  [ID_Articulos] Int,
  [Comentario] NVarchar(MAX),
  [Estatus] NVarchar(1),
  [Usuario_Crea] Int,
  [Usuariio_Modifica] Int,
  [Fecha_Crea] DateTime,
  [Fecha_Modifica] DateTime,
 

);















--TABLAS FUERA DEL ESQUEMA DE RESIDENCIA ACADEMICA--

CREATE TABLE [Tipo_Documento] (
  [ID_Tipo_Docuemento] INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
  [Nombre] NVarchar(MAX) NOT NULL,
  [Estatus] Int NOT NULL,
  [IDInstitucion] Int NOT NULL,
  [Actualizacion] Int NOT NULL,
);



CREATE TABLE [Estudiantes] (
  [IDEstudiante] INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
  [Matricula] Varchar(15) NOT NULL
);

CREATE TABLE [Usuario](
	[IDusuario] int IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[nombre_usuario] varchar(100) NOT NULL,
	[nombre] varchar(100) NOT NULL,
	[apellido] varchar(50) NOT NULL,
	[correo_personal] varchar(100) NOT NULL,
	[IDinstitucion] int NOT NULL,
	[clave] varchar(50) NOT NULL,
	[estatus] varchar(1) NOT NULL,
	[fecha_crea] datetime NOT NULL,
	[comentario] varchar(1000) NULL,
	[usuario_crea] int NULL,
	[usuario_modifica] int NULL,
	[fecha_modifica] datetime NULL,
	[usuario_anula] int NULL,
	[fecha_anula] datetime NULL,
	[token] varchar(100) NULL,
	[IDtipo_identificacion] int NULL,
	[Identificacion] varchar(20) NULL,
	[IdTipoSangre] [int] NULL
)



use ORBI









