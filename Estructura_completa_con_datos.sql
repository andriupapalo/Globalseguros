USE [master]
GO
/****** Object:  Database [prueba]    Script Date: 14/11/2020 6:21:15 p. m. ******/
CREATE DATABASE [prueba]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'prueba', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\prueba.mdf' , SIZE = 4288KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'prueba_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\prueba_log.ldf' , SIZE = 1072KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [prueba] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [prueba].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [prueba] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [prueba] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [prueba] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [prueba] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [prueba] SET ARITHABORT OFF 
GO
ALTER DATABASE [prueba] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [prueba] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [prueba] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [prueba] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [prueba] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [prueba] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [prueba] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [prueba] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [prueba] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [prueba] SET  ENABLE_BROKER 
GO
ALTER DATABASE [prueba] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [prueba] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [prueba] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [prueba] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [prueba] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [prueba] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [prueba] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [prueba] SET RECOVERY FULL 
GO
ALTER DATABASE [prueba] SET  MULTI_USER 
GO
ALTER DATABASE [prueba] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [prueba] SET DB_CHAINING OFF 
GO
ALTER DATABASE [prueba] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [prueba] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [prueba] SET DELAYED_DURABILITY = DISABLED 
GO
USE [prueba]
GO
/****** Object:  Table [dbo].[Cargo]    Script Date: 14/11/2020 6:21:15 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Cargo](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[descripcion] [char](100) NULL,
	[salario] [int] NOT NULL,
 CONSTRAINT [PK_Cargo] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Empleado]    Script Date: 14/11/2020 6:21:15 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Empleado](
	[Id] [char](20) NOT NULL,
	[NombreCompleto] [char](100) NULL,
	[cargoId] [int] NOT NULL,
	[direccionResidencia] [char](150) NULL,
	[TelefonoContacto] [char](50) NULL,
	[Email] [char](100) NULL,
	[Edad] [int] NOT NULL,
	[Sexo] [char](1) NULL,
	[FechaNacimiento] [date] NULL,
 CONSTRAINT [PK_Empleado] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Movimiento]    Script Date: 14/11/2020 6:21:15 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[Movimiento](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[TiendaId] [int] NULL,
	[EmpleadoId] [char](20) NULL,
	[FechaMovimiento] [datetime] NULL,
	[Horaini] [int] NULL,
	[Horafin] [int] NULL,
	[TotalHoras] [float] NOT NULL,
 CONSTRAINT [PK_Movimiento] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Tienda]    Script Date: 14/11/2020 6:21:15 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Tienda](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[descripcion] [char](100) NULL,
	[direccion] [char](150) NULL,
	[Telefono] [char](50) NULL,
 CONSTRAINT [PK_Tienda] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  View [dbo].[vm_Movimientos]    Script Date: 14/11/2020 6:21:15 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create View [dbo].[vm_Movimientos] 
as
select a.FechaMovimiento as fecha,b.descripcion as nomtienda,a.empleadoID as Cedula,c.NombreCompleto as nomempleado, 
d.descripcion as NomCargo, a.totalhoras,d.ID as cargoid,a.tiendaid
from Movimiento a inner join Tienda b on a.TiendaId=b.Id
Inner join Empleado c on a.EmpleadoId=C.Id
inner join Cargo d on c.cargoId=d.Id

GO
SET IDENTITY_INSERT [dbo].[Cargo] ON 

INSERT [dbo].[Cargo] ([Id], [descripcion], [salario]) VALUES (1, N'Gerente de Zona                                                                                     ', 5000000)
INSERT [dbo].[Cargo] ([Id], [descripcion], [salario]) VALUES (2, N'Gerente de piso                                                                                     ', 2500000)
INSERT [dbo].[Cargo] ([Id], [descripcion], [salario]) VALUES (3, N'Jefe de Grupo                                                                                       ', 2000000)
INSERT [dbo].[Cargo] ([Id], [descripcion], [salario]) VALUES (4, N'Operario Caja                                                                                       ', 1500000)
INSERT [dbo].[Cargo] ([Id], [descripcion], [salario]) VALUES (5, N'Repartidor                                                                                          ', 900000)
INSERT [dbo].[Cargo] ([Id], [descripcion], [salario]) VALUES (6, N'Operario Normal                                                                                     ', 900000)
SET IDENTITY_INSERT [dbo].[Cargo] OFF
INSERT [dbo].[Empleado] ([Id], [NombreCompleto], [cargoId], [direccionResidencia], [TelefonoContacto], [Email], [Edad], [Sexo], [FechaNacimiento]) VALUES (N'1032379860          ', N'carolina Pulido                                                                                     ', 2, N'calle 181 c no 15-74                                                                                                                                  ', N'6548751                                           ', N'carol@gmila.com                                                                                     ', 37, N'F', CAST(N'1980-06-01' AS Date))
INSERT [dbo].[Empleado] ([Id], [NombreCompleto], [cargoId], [direccionResidencia], [TelefonoContacto], [Email], [Edad], [Sexo], [FechaNacimiento]) VALUES (N'22639103            ', N'iris Cuentas                                                                                        ', 5, N'calle 146 no 52-14                                                                                                                                    ', N'3215869417                                        ', N'iriscuentas@gmail.com                                                                               ', 32, N'F', CAST(N'1980-09-01' AS Date))
INSERT [dbo].[Empleado] ([Id], [NombreCompleto], [cargoId], [direccionResidencia], [TelefonoContacto], [Email], [Edad], [Sexo], [FechaNacimiento]) VALUES (N'2283688             ', N'Jaime Cifuentes                                                                                     ', 5, N'Calle 26 no 25-78                                                                                                                                     ', N'5423698                                           ', N'jaime@gmail.com                                                                                     ', 41, N'M', CAST(N'1984-01-01' AS Date))
INSERT [dbo].[Empleado] ([Id], [NombreCompleto], [cargoId], [direccionResidencia], [TelefonoContacto], [Email], [Edad], [Sexo], [FechaNacimiento]) VALUES (N'79782606            ', N'Fabian Andres Vanegas Soto                                                                          ', 1, N'Calle 125 no 128-70                                                                                                                                   ', N'3006856458                                        ', N'andriupapalo@gmail.com                                                                              ', 44, N'M', CAST(N'1975-07-16' AS Date))
SET IDENTITY_INSERT [dbo].[Movimiento] ON 

INSERT [dbo].[Movimiento] ([Id], [TiendaId], [EmpleadoId], [FechaMovimiento], [Horaini], [Horafin], [TotalHoras]) VALUES (3, 1, N'79782606', CAST(N'2020-11-14 08:00:00.000' AS DateTime), 8, 17, 9)
INSERT [dbo].[Movimiento] ([Id], [TiendaId], [EmpleadoId], [FechaMovimiento], [Horaini], [Horafin], [TotalHoras]) VALUES (4, 1, N'1032379860', CAST(N'2020-11-14 08:00:00.000' AS DateTime), 8, 17, 9)
INSERT [dbo].[Movimiento] ([Id], [TiendaId], [EmpleadoId], [FechaMovimiento], [Horaini], [Horafin], [TotalHoras]) VALUES (5, 2, N'1032379860', CAST(N'2020-11-15 08:00:00.000' AS DateTime), 8, 17, 9)
INSERT [dbo].[Movimiento] ([Id], [TiendaId], [EmpleadoId], [FechaMovimiento], [Horaini], [Horafin], [TotalHoras]) VALUES (6, 2, N'79782606', CAST(N'2020-11-15 08:00:00.000' AS DateTime), 8, 17, 9)
INSERT [dbo].[Movimiento] ([Id], [TiendaId], [EmpleadoId], [FechaMovimiento], [Horaini], [Horafin], [TotalHoras]) VALUES (7, 2, N'2283688', CAST(N'2020-11-15 08:00:00.000' AS DateTime), 8, 17, 9)
INSERT [dbo].[Movimiento] ([Id], [TiendaId], [EmpleadoId], [FechaMovimiento], [Horaini], [Horafin], [TotalHoras]) VALUES (8, 2, N'1032379860', CAST(N'2020-11-16 08:00:00.000' AS DateTime), 8, 17, 9)
INSERT [dbo].[Movimiento] ([Id], [TiendaId], [EmpleadoId], [FechaMovimiento], [Horaini], [Horafin], [TotalHoras]) VALUES (9, 2, N'79782606', CAST(N'2020-11-16 08:00:00.000' AS DateTime), 8, 17, 9)
INSERT [dbo].[Movimiento] ([Id], [TiendaId], [EmpleadoId], [FechaMovimiento], [Horaini], [Horafin], [TotalHoras]) VALUES (10, 2, N'2283688', CAST(N'2020-11-16 08:00:00.000' AS DateTime), 12, 17, 5)
SET IDENTITY_INSERT [dbo].[Movimiento] OFF
SET IDENTITY_INSERT [dbo].[Tienda] ON 

INSERT [dbo].[Tienda] ([Id], [descripcion], [direccion], [Telefono]) VALUES (1, N'Calle 170 Bogota                                                                                    ', N'Calle 170 No 15-25                                                                                                                                    ', N'4602598                                           ')
INSERT [dbo].[Tienda] ([Id], [descripcion], [direccion], [Telefono]) VALUES (2, N'Centro Andino Bogota                                                                                ', N'Calle 85 No 7-45                                                                                                                                      ', N'315289865                                         ')
INSERT [dbo].[Tienda] ([Id], [descripcion], [direccion], [Telefono]) VALUES (3, N'Centro Internacional                                                                                ', N'Calle 26 No 68-91                                                                                                                                     ', N'324586932                                         ')
INSERT [dbo].[Tienda] ([Id], [descripcion], [direccion], [Telefono]) VALUES (4, N'Aeropuerto                                                                                          ', N'Calle 26 No 121-33                                                                                                                                    ', N'5215487                                           ')
INSERT [dbo].[Tienda] ([Id], [descripcion], [direccion], [Telefono]) VALUES (5, N'Plaza Imperial                                                                                      ', N'Calle 128 No 121-25                                                                                                                                   ', N'5423697                                           ')
SET IDENTITY_INSERT [dbo].[Tienda] OFF
ALTER TABLE [dbo].[Movimiento] ADD  DEFAULT (getdate()) FOR [FechaMovimiento]
GO
ALTER TABLE [dbo].[Empleado]  WITH CHECK ADD  CONSTRAINT [fk_cargoId] FOREIGN KEY([cargoId])
REFERENCES [dbo].[Cargo] ([Id])
GO
ALTER TABLE [dbo].[Empleado] CHECK CONSTRAINT [fk_cargoId]
GO
ALTER TABLE [dbo].[Movimiento]  WITH CHECK ADD  CONSTRAINT [FK_Empleado] FOREIGN KEY([EmpleadoId])
REFERENCES [dbo].[Empleado] ([Id])
GO
ALTER TABLE [dbo].[Movimiento] CHECK CONSTRAINT [FK_Empleado]
GO
ALTER TABLE [dbo].[Movimiento]  WITH CHECK ADD  CONSTRAINT [FK_Tienda] FOREIGN KEY([TiendaId])
REFERENCES [dbo].[Tienda] ([Id])
GO
ALTER TABLE [dbo].[Movimiento] CHECK CONSTRAINT [FK_Tienda]
GO
USE [master]
GO
ALTER DATABASE [prueba] SET  READ_WRITE 
GO
