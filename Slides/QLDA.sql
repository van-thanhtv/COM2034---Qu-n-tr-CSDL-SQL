USE [master]
GO
/****** Object:  Database [QLDA]    Script Date: 02/04/2019 1:38:58 PM ******/
CREATE DATABASE [QLDA]
GO
ALTER DATABASE [QLDA] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [QLDA].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [QLDA] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [QLDA] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [QLDA] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [QLDA] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [QLDA] SET ARITHABORT OFF 
GO
ALTER DATABASE [QLDA] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [QLDA] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [QLDA] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [QLDA] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [QLDA] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [QLDA] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [QLDA] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [QLDA] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [QLDA] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [QLDA] SET  DISABLE_BROKER 
GO
ALTER DATABASE [QLDA] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [QLDA] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [QLDA] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [QLDA] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [QLDA] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [QLDA] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [QLDA] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [QLDA] SET RECOVERY FULL 
GO
ALTER DATABASE [QLDA] SET  MULTI_USER 
GO
ALTER DATABASE [QLDA] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [QLDA] SET DB_CHAINING OFF 
GO
ALTER DATABASE [QLDA] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [QLDA] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [QLDA] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'QLDA', N'ON'
GO
ALTER DATABASE [QLDA] SET QUERY_STORE = OFF
GO
USE [QLDA]
GO
ALTER DATABASE SCOPED CONFIGURATION SET IDENTITY_CACHE = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
USE [QLDA]
GO
/****** Object:  UserDefinedFunction [dbo].[fDemNv]    Script Date: 02/04/2019 1:38:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fDemNv]()
RETURNS int
BEGIN
  RETURN (SELECT count(MANV)
  FROM NHANVIEN)
 END
GO
/****** Object:  UserDefinedFunction [dbo].[fDemNv_gioitinh]    Script Date: 02/04/2019 1:38:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fDemNv_gioitinh](@phai nvarchar(3))
RETURNS int
BEGIN
  RETURN (SELECT count(MANV)
  FROM NHANVIEN
  where PHAI like @phai)
 END
GO
/****** Object:  UserDefinedFunction [dbo].[fListPhong]    Script Date: 02/04/2019 1:38:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fListPhong] (@phong Int)
  RETURNS @ProdList Table
   (  ten nvarchar(15) , ma int, trphg nvarchar(9), ngay date
   )
 AS
  BEGIN
   IF @phong IS NULL
    BEGIN
     INSERT INTO @ProdList (ten,ma,trphg,ngay)
     SELECT TENPHG, MAPHG,TRPHG,NG_NHANCHUC
     FROM PhongBan
    END
   ELSE
   BEGIN
     INSERT INTO @ProdList (ten,ma,trphg,ngay)
    SELECT TENPHG, MAPHG,TRPHG,NG_NHANCHUC
     FROM PHONGBAN
     WHERE MAPHG=@phong
   END
  RETURN
  END
GO
/****** Object:  UserDefinedFunction [dbo].[fMaPHG]    Script Date: 02/04/2019 1:38:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fMaPHG] (@Manv nvarchar(9))
RETURNS  int
BEGIN
    RETURN (SELECT PHG FROM NHANVIEN WHERE MANV = @Manv)
END
GO
/****** Object:  UserDefinedFunction [dbo].[fTuoi]    Script Date: 02/04/2019 1:38:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create function [dbo].[fTuoi] (@ns int) 
Returns int  
As  
Begin   
return year(getdate()) - @ns 
end 
GO
/****** Object:  Table [dbo].[NHANVIEN]    Script Date: 02/04/2019 1:38:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NHANVIEN](
	[HONV] [nvarchar](15) NOT NULL,
	[TENLOT] [nvarchar](15) NOT NULL,
	[TENNV] [nvarchar](15) NOT NULL,
	[MANV] [nvarchar](9) NOT NULL,
	[NGSINH] [datetime] NOT NULL,
	[DCHI] [nvarchar](30) NOT NULL,
	[PHAI] [nvarchar](3) NOT NULL,
	[LUONG] [float] NOT NULL,
	[MA_NQL] [nvarchar](9) NULL,
	[PHG] [int] NULL,
 CONSTRAINT [PK_NhanVien] PRIMARY KEY CLUSTERED 
(
	[MANV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[FNhanVien_PB]    Script Date: 02/04/2019 1:38:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--Viết hàm trả về bảng các nhân viên làm việc ở phòng số 5 
 CREATE FUNCTION [dbo].[FNhanVien_PB](@Maphg int)
 RETURNS Table
 AS
   RETURN
   (
     SELECT MANV,HONV,TENNV FROM NHANVIEN
     WHERE PHG = @Maphg
    )
GO
/****** Object:  Table [dbo].[PHONGBAN]    Script Date: 02/04/2019 1:38:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PHONGBAN](
	[TENPHG] [nvarchar](15) NOT NULL,
	[MAPHG] [int] NOT NULL,
	[TRPHG] [nvarchar](9) NULL,
	[NG_NHANCHUC] [date] NOT NULL,
 CONSTRAINT [PK_PhongBan] PRIMARY KEY CLUSTERED 
(
	[MAPHG] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[NV_PB]    Script Date: 02/04/2019 1:38:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create View [dbo].[NV_PB]
  as
  Select TENNV,TENPHG
  From NHANVIEN inner join PhongBan on NHANVIEN.PHG=PHONGBAN.MAPHG
GO
/****** Object:  View [dbo].[ThongtinNV]    Script Date: 02/04/2019 1:38:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ThongtinNV] AS
Select TenNV, LUONG,YEAR(GetDate()) - YEAR(NHANVIEN.NGSINH) as Tuoi
  from NHANVIEN
  where YEAR(GetDate()) - YEAR(NHANVIEN.NGSINH)>57
GO
/****** Object:  View [dbo].[COMP]    Script Date: 02/04/2019 1:38:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[COMP] (TenNV, Luong)
 AS SELECT TENLOT, LUONG AS Pay
 FROM NHANVIEN;
GO
/****** Object:  View [dbo].[test]    Script Date: 02/04/2019 1:38:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[test]
  as
  select TENNV, LUONG
  from NHANVIEN
GO
/****** Object:  View [dbo].[test1]    Script Date: 02/04/2019 1:38:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 create view [dbo].[test1]
  as
  select TENNV, (LUONG +10) as a
  from NHANVIEN
GO
/****** Object:  View [dbo].[test2]    Script Date: 02/04/2019 1:38:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[test2]
  as
  select TENNV,LUONG
  from NHANVIEN
GO
/****** Object:  View [dbo].[NV_Phai]    Script Date: 02/04/2019 1:38:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[NV_Phai]
AS
 SELECT TenNV,PHAI
 FROM NHANVIEN
 WHERE PHAI like N'nữ'
GO
/****** Object:  View [dbo].[NV_Phai1]    Script Date: 02/04/2019 1:38:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[NV_Phai1]
AS
 SELECT TENPHG,MAPHG
 FROM PHONGBAN
 WHERE MAPHG =5
GO
/****** Object:  View [dbo].[ThongTin_Phong]    Script Date: 02/04/2019 1:38:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ThongTin_Phong]
AS
 SELECT TENPHG,MAPHG
 FROM PHONGBAN
 WHERE MAPHG =6
GO
/****** Object:  Table [dbo].[CONGVIEC]    Script Date: 02/04/2019 1:38:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CONGVIEC](
	[MADA] [int] NOT NULL,
	[STT] [int] NOT NULL,
	[TEN_CONG_VIEC] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_CongViec] PRIMARY KEY CLUSTERED 
(
	[MADA] ASC,
	[STT] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DEAN]    Script Date: 02/04/2019 1:38:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DEAN](
	[TENDEAN] [nvarchar](15) NOT NULL,
	[MADA] [int] NOT NULL,
	[DDIEM_DA] [nvarchar](15) NOT NULL,
	[PHONG] [int] NULL,
 CONSTRAINT [PK_DeAn] PRIMARY KEY CLUSTERED 
(
	[MADA] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DIADIEM_PHG]    Script Date: 02/04/2019 1:38:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DIADIEM_PHG](
	[MAPHG] [int] NOT NULL,
	[DIADIEM] [nvarchar](15) NOT NULL,
 CONSTRAINT [PK_DiaDiemPhong] PRIMARY KEY CLUSTERED 
(
	[MAPHG] ASC,
	[DIADIEM] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PHANCONG]    Script Date: 02/04/2019 1:38:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PHANCONG](
	[MA_NVIEN] [nvarchar](9) NOT NULL,
	[MADA] [int] NOT NULL,
	[STT] [int] NOT NULL,
	[THOIGIAN] [float] NOT NULL,
 CONSTRAINT [PK_PhanCong] PRIMARY KEY CLUSTERED 
(
	[MA_NVIEN] ASC,
	[MADA] ASC,
	[STT] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[THANNHAN]    Script Date: 02/04/2019 1:38:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[THANNHAN](
	[MA_NVIEN] [nvarchar](9) NOT NULL,
	[TENTN] [nvarchar](15) NOT NULL,
	[PHAI] [nvarchar](3) NOT NULL,
	[NGSINH] [date] NOT NULL,
	[QUANHE] [nvarchar](15) NOT NULL,
 CONSTRAINT [PK_ThanNhan] PRIMARY KEY CLUSTERED 
(
	[MA_NVIEN] ASC,
	[TENTN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[CONGVIEC] ([MADA], [STT], [TEN_CONG_VIEC]) VALUES (1, 1, N'Thiết kế sản phẩm X')
INSERT [dbo].[CONGVIEC] ([MADA], [STT], [TEN_CONG_VIEC]) VALUES (1, 2, N'Thử nghiệm sản phẩm X')
INSERT [dbo].[CONGVIEC] ([MADA], [STT], [TEN_CONG_VIEC]) VALUES (2, 1, N'Sản xuất sản phẩm Y')
INSERT [dbo].[CONGVIEC] ([MADA], [STT], [TEN_CONG_VIEC]) VALUES (2, 2, N'Quảng cáo sản phẩm Y')
INSERT [dbo].[CONGVIEC] ([MADA], [STT], [TEN_CONG_VIEC]) VALUES (3, 1, N'Khuyến mãi sản phẩm Z')
INSERT [dbo].[CONGVIEC] ([MADA], [STT], [TEN_CONG_VIEC]) VALUES (10, 1, N'Tin học hóa phòng nhân sự')
INSERT [dbo].[CONGVIEC] ([MADA], [STT], [TEN_CONG_VIEC]) VALUES (10, 2, N'Tin học hóa phòng kinh doanh')
INSERT [dbo].[CONGVIEC] ([MADA], [STT], [TEN_CONG_VIEC]) VALUES (20, 1, N'Lắp đặt cáp quang')
INSERT [dbo].[CONGVIEC] ([MADA], [STT], [TEN_CONG_VIEC]) VALUES (30, 1, N'Đào tạo nhân viên Marketing')
INSERT [dbo].[CONGVIEC] ([MADA], [STT], [TEN_CONG_VIEC]) VALUES (30, 2, N'Đào tạo nhân viên thiết kế')
INSERT [dbo].[DEAN] ([TENDEAN], [MADA], [DDIEM_DA], [PHONG]) VALUES (N'Sản Phẩm x', 1, N'Vũng Tàu', 5)
INSERT [dbo].[DEAN] ([TENDEAN], [MADA], [DDIEM_DA], [PHONG]) VALUES (N'Sản Phẩm Y', 2, N'Nha Trang', 5)
INSERT [dbo].[DEAN] ([TENDEAN], [MADA], [DDIEM_DA], [PHONG]) VALUES (N'Sản Phẩm Z', 3, N'TP HCM', 5)
INSERT [dbo].[DEAN] ([TENDEAN], [MADA], [DDIEM_DA], [PHONG]) VALUES (N'Tin Học Hóa', 10, N'Hà Nội', 4)
INSERT [dbo].[DEAN] ([TENDEAN], [MADA], [DDIEM_DA], [PHONG]) VALUES (N'Cáp quang', 20, N'TP HCM', 1)
INSERT [dbo].[DEAN] ([TENDEAN], [MADA], [DDIEM_DA], [PHONG]) VALUES (N'Đào tạo', 30, N'Hà Nội', 4)
INSERT [dbo].[DIADIEM_PHG] ([MAPHG], [DIADIEM]) VALUES (1, N'TP HCM')
INSERT [dbo].[DIADIEM_PHG] ([MAPHG], [DIADIEM]) VALUES (4, N'Hà Nội')
INSERT [dbo].[DIADIEM_PHG] ([MAPHG], [DIADIEM]) VALUES (5, N'Nha Trang')
INSERT [dbo].[DIADIEM_PHG] ([MAPHG], [DIADIEM]) VALUES (5, N'TP HCM')
INSERT [dbo].[DIADIEM_PHG] ([MAPHG], [DIADIEM]) VALUES (5, N'Vũng Tàu')
INSERT [dbo].[NHANVIEN] ([HONV], [TENLOT], [TENNV], [MANV], [NGSINH], [DCHI], [PHAI], [LUONG], [MA_NQL], [PHG]) VALUES (N'Đinh', N'Quỳnh', N'Như', N'001', CAST(N'1967-02-01T00:00:00.000' AS DateTime), N'291 Hồ Văn Huê, TP HCM', N'Nữ', 43000, N'006', 4)
INSERT [dbo].[NHANVIEN] ([HONV], [TENLOT], [TENNV], [MANV], [NGSINH], [DCHI], [PHAI], [LUONG], [MA_NQL], [PHG]) VALUES (N'Phan', N'Viet', N'The', N'002', CAST(N'1984-01-11T00:00:00.000' AS DateTime), N'778 nguyễn kiệm , TP hcm', N'', 30000, N'001', 4)
INSERT [dbo].[NHANVIEN] ([HONV], [TENLOT], [TENNV], [MANV], [NGSINH], [DCHI], [PHAI], [LUONG], [MA_NQL], [PHG]) VALUES (N'Trần', N'Thanh', N'Tâm', N'003', CAST(N'1957-05-04T00:00:00.000' AS DateTime), N'34 Mai Thị Lự, Tp Hồ Chí Minh', N'Nam', 25000, N'005', 5)
INSERT [dbo].[NHANVIEN] ([HONV], [TENLOT], [TENNV], [MANV], [NGSINH], [DCHI], [PHAI], [LUONG], [MA_NQL], [PHG]) VALUES (N'Nguyễn', N'Mạnh ', N'Hùng', N'004', CAST(N'1967-03-04T00:00:00.000' AS DateTime), N'95 Bà Rịa, Vũng Tàu', N'Nam', 38000, N'005', 5)
INSERT [dbo].[NHANVIEN] ([HONV], [TENLOT], [TENNV], [MANV], [NGSINH], [DCHI], [PHAI], [LUONG], [MA_NQL], [PHG]) VALUES (N'Nguễn', N'Thanh', N'Tùng', N'005', CAST(N'1962-08-20T00:00:00.000' AS DateTime), N'222 Nguyễn Văn Cừ, Tp HCM', N'Nam', 40000, N'006', 5)
INSERT [dbo].[NHANVIEN] ([HONV], [TENLOT], [TENNV], [MANV], [NGSINH], [DCHI], [PHAI], [LUONG], [MA_NQL], [PHG]) VALUES (N'Phạm', N'Văn', N'Vinh', N'006', CAST(N'1965-01-01T00:00:00.000' AS DateTime), N'15 Trưng Vương, Hà Nội', N'Nữ', 55000, NULL, 1)
INSERT [dbo].[NHANVIEN] ([HONV], [TENLOT], [TENNV], [MANV], [NGSINH], [DCHI], [PHAI], [LUONG], [MA_NQL], [PHG]) VALUES (N'Bùi ', N'Ngọc', N'Hành', N'007', CAST(N'1954-03-11T00:00:00.000' AS DateTime), N'332 Nguyễn Thái Học, Tp HCM', N'Nam', 25000, N'001', 4)
INSERT [dbo].[NHANVIEN] ([HONV], [TENLOT], [TENNV], [MANV], [NGSINH], [DCHI], [PHAI], [LUONG], [MA_NQL], [PHG]) VALUES (N'Trần', N'Hồng', N'Quang', N'008', CAST(N'1967-09-01T00:00:00.000' AS DateTime), N'80 Lê Hồng Phong, Tp HCM', N'Nam', 25000, N'001', 4)
INSERT [dbo].[NHANVIEN] ([HONV], [TENLOT], [TENNV], [MANV], [NGSINH], [DCHI], [PHAI], [LUONG], [MA_NQL], [PHG]) VALUES (N'Đinh ', N'Bá ', N'Tiên', N'009', CAST(N'1960-02-11T00:00:00.000' AS DateTime), N'119 Cống Quỳnh, Tp HCM', N'N', 30000, N'005', 5)
INSERT [dbo].[NHANVIEN] ([HONV], [TENLOT], [TENNV], [MANV], [NGSINH], [DCHI], [PHAI], [LUONG], [MA_NQL], [PHG]) VALUES (N'Đinh ', N'Bá ', N'Tiên', N'017', CAST(N'1960-02-11T00:00:00.000' AS DateTime), N'119 Cống Quỳnh, Tp HCM', N'N', 30000, N'005', 5)
INSERT [dbo].[PHANCONG] ([MA_NVIEN], [MADA], [STT], [THOIGIAN]) VALUES (N'001', 20, 1, 15.321547)
INSERT [dbo].[PHANCONG] ([MA_NVIEN], [MADA], [STT], [THOIGIAN]) VALUES (N'001', 30, 1, 20.5)
INSERT [dbo].[PHANCONG] ([MA_NVIEN], [MADA], [STT], [THOIGIAN]) VALUES (N'003', 1, 2, 20)
INSERT [dbo].[PHANCONG] ([MA_NVIEN], [MADA], [STT], [THOIGIAN]) VALUES (N'003', 2, 1, 20)
INSERT [dbo].[PHANCONG] ([MA_NVIEN], [MADA], [STT], [THOIGIAN]) VALUES (N'004', 3, 1, 40.7)
INSERT [dbo].[PHANCONG] ([MA_NVIEN], [MADA], [STT], [THOIGIAN]) VALUES (N'005', 3, 1, 10)
INSERT [dbo].[PHANCONG] ([MA_NVIEN], [MADA], [STT], [THOIGIAN]) VALUES (N'005', 10, 2, 10)
INSERT [dbo].[PHANCONG] ([MA_NVIEN], [MADA], [STT], [THOIGIAN]) VALUES (N'005', 20, 1, 10)
INSERT [dbo].[PHANCONG] ([MA_NVIEN], [MADA], [STT], [THOIGIAN]) VALUES (N'006', 20, 1, 30)
INSERT [dbo].[PHANCONG] ([MA_NVIEN], [MADA], [STT], [THOIGIAN]) VALUES (N'007', 10, 2, 10.7)
INSERT [dbo].[PHANCONG] ([MA_NVIEN], [MADA], [STT], [THOIGIAN]) VALUES (N'007', 30, 2, 30)
INSERT [dbo].[PHANCONG] ([MA_NVIEN], [MADA], [STT], [THOIGIAN]) VALUES (N'008', 10, 1, 35.2)
INSERT [dbo].[PHANCONG] ([MA_NVIEN], [MADA], [STT], [THOIGIAN]) VALUES (N'008', 30, 2, 5)
INSERT [dbo].[PHANCONG] ([MA_NVIEN], [MADA], [STT], [THOIGIAN]) VALUES (N'009', 1, 1, 32.54)
INSERT [dbo].[PHANCONG] ([MA_NVIEN], [MADA], [STT], [THOIGIAN]) VALUES (N'009', 2, 2, 8.9)
INSERT [dbo].[PHONGBAN] ([TENPHG], [MAPHG], [TRPHG], [NG_NHANCHUC]) VALUES (N'Quản Lý', 1, N'006', CAST(N'1971-06-19' AS Date))
INSERT [dbo].[PHONGBAN] ([TENPHG], [MAPHG], [TRPHG], [NG_NHANCHUC]) VALUES (N'Điều Hành', 4, N'008', CAST(N'1985-01-01' AS Date))
INSERT [dbo].[PHONGBAN] ([TENPHG], [MAPHG], [TRPHG], [NG_NHANCHUC]) VALUES (N'Nghiên Cứu', 5, N'005', CAST(N'0197-05-22' AS Date))
INSERT [dbo].[PHONGBAN] ([TENPHG], [MAPHG], [TRPHG], [NG_NHANCHUC]) VALUES (N'IT', 6, N'008', CAST(N'1985-01-01' AS Date))
INSERT [dbo].[THANNHAN] ([MA_NVIEN], [TENTN], [PHAI], [NGSINH], [QUANHE]) VALUES (N'001', N'Minh', N'Nam', CAST(N'1932-02-29' AS Date), N'Vợ Chồng')
INSERT [dbo].[THANNHAN] ([MA_NVIEN], [TENTN], [PHAI], [NGSINH], [QUANHE]) VALUES (N'005', N'Khang', N'Nam', CAST(N'1973-10-25' AS Date), N'Con Trai')
INSERT [dbo].[THANNHAN] ([MA_NVIEN], [TENTN], [PHAI], [NGSINH], [QUANHE]) VALUES (N'005', N'Phương', N'Nữ', CAST(N'1948-05-03' AS Date), N'Vợ Chồng')
INSERT [dbo].[THANNHAN] ([MA_NVIEN], [TENTN], [PHAI], [NGSINH], [QUANHE]) VALUES (N'005', N'Trinh', N'Nữ', CAST(N'1976-04-05' AS Date), N'Con Gái')
INSERT [dbo].[THANNHAN] ([MA_NVIEN], [TENTN], [PHAI], [NGSINH], [QUANHE]) VALUES (N'009', N'Châu ', N'Nữ', CAST(N'1978-09-30' AS Date), N'Con Gái')
INSERT [dbo].[THANNHAN] ([MA_NVIEN], [TENTN], [PHAI], [NGSINH], [QUANHE]) VALUES (N'009', N'Phương', N'Nữ', CAST(N'1957-05-05' AS Date), N'Vợ Chồng')
INSERT [dbo].[THANNHAN] ([MA_NVIEN], [TENTN], [PHAI], [NGSINH], [QUANHE]) VALUES (N'009', N'Tiến ', N'Nam', CAST(N'1978-01-01' AS Date), N'Con Trai')
INSERT [dbo].[THANNHAN] ([MA_NVIEN], [TENTN], [PHAI], [NGSINH], [QUANHE]) VALUES (N'017', N'Tiến ', N'Nam', CAST(N'1978-01-01' AS Date), N'Con Trai')
ALTER TABLE [dbo].[CONGVIEC]  WITH CHECK ADD  CONSTRAINT [FK_DeAn_CongViec] FOREIGN KEY([MADA])
REFERENCES [dbo].[DEAN] ([MADA])
GO
ALTER TABLE [dbo].[CONGVIEC] CHECK CONSTRAINT [FK_DeAn_CongViec]
GO
ALTER TABLE [dbo].[DEAN]  WITH CHECK ADD  CONSTRAINT [FK_PhongBan_DeAn] FOREIGN KEY([PHONG])
REFERENCES [dbo].[PHONGBAN] ([MAPHG])
GO
ALTER TABLE [dbo].[DEAN] CHECK CONSTRAINT [FK_PhongBan_DeAn]
GO
ALTER TABLE [dbo].[DIADIEM_PHG]  WITH CHECK ADD  CONSTRAINT [FK_PhongBan_DiaDiemPhg] FOREIGN KEY([MAPHG])
REFERENCES [dbo].[PHONGBAN] ([MAPHG])
GO
ALTER TABLE [dbo].[DIADIEM_PHG] CHECK CONSTRAINT [FK_PhongBan_DiaDiemPhg]
GO
ALTER TABLE [dbo].[NHANVIEN]  WITH CHECK ADD  CONSTRAINT [FK_NhanVien_NhanVien] FOREIGN KEY([MA_NQL])
REFERENCES [dbo].[NHANVIEN] ([MANV])
GO
ALTER TABLE [dbo].[NHANVIEN] CHECK CONSTRAINT [FK_NhanVien_NhanVien]
GO
ALTER TABLE [dbo].[NHANVIEN]  WITH CHECK ADD  CONSTRAINT [FK_PhongBan_NhanVien] FOREIGN KEY([PHG])
REFERENCES [dbo].[PHONGBAN] ([MAPHG])
GO
ALTER TABLE [dbo].[NHANVIEN] CHECK CONSTRAINT [FK_PhongBan_NhanVien]
GO
ALTER TABLE [dbo].[PHANCONG]  WITH CHECK ADD  CONSTRAINT [FK_CongViec_PhanCong] FOREIGN KEY([MADA], [STT])
REFERENCES [dbo].[CONGVIEC] ([MADA], [STT])
GO
ALTER TABLE [dbo].[PHANCONG] CHECK CONSTRAINT [FK_CongViec_PhanCong]
GO
ALTER TABLE [dbo].[PHANCONG]  WITH CHECK ADD  CONSTRAINT [FK_NhanVien_PhanCong] FOREIGN KEY([MA_NVIEN])
REFERENCES [dbo].[NHANVIEN] ([MANV])
GO
ALTER TABLE [dbo].[PHANCONG] CHECK CONSTRAINT [FK_NhanVien_PhanCong]
GO
ALTER TABLE [dbo].[PHONGBAN]  WITH CHECK ADD  CONSTRAINT [FK_NhanVien_PhongBan] FOREIGN KEY([TRPHG])
REFERENCES [dbo].[NHANVIEN] ([MANV])
GO
ALTER TABLE [dbo].[PHONGBAN] CHECK CONSTRAINT [FK_NhanVien_PhongBan]
GO
ALTER TABLE [dbo].[THANNHAN]  WITH CHECK ADD  CONSTRAINT [FK_NhanVien_ThanNhan] FOREIGN KEY([MA_NVIEN])
REFERENCES [dbo].[NHANVIEN] ([MANV])
GO
ALTER TABLE [dbo].[THANNHAN] CHECK CONSTRAINT [FK_NhanVien_ThanNhan]
GO
/****** Object:  StoredProcedure [dbo].[DemNv]    Script Date: 02/04/2019 1:38:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DemNv]
  @cityvar nvarchar(30)
 AS
     DECLARE @num Int
     SELECT @num = Count(*) FROM NHANVIEN
     WHERE DCHI like '%' + @cityvar
 RETURN @num
GO
/****** Object:  StoredProcedure [dbo].[NumberWeek_Year]    Script Date: 02/04/2019 1:38:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create proc [dbo].[NumberWeek_Year]
as
--Setup Variables
DECLARE @myTable TABLE(WeekNumber int,
                       DateStarting smalldatetime)
DECLARE @n int = 0
DECLARE @firstWeek smalldatetime = '12/31/2017'

--Loop Through weeks
WHILE @n <= 52
BEGIN
   INSERT INTO @myTable VALUES (@n, DATEADD(wk,@n,@firstWeek));
   SELECT @n = @n + 1
END

--Show Results
SELECT WeekNumber, DateStarting
FROM   @myTable
GO
/****** Object:  StoredProcedure [dbo].[sp_ThemPhongBan]    Script Date: 02/04/2019 1:38:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_ThemPhongBan]
 @TenPHG nvarchar(15),  @MaPHG int,
 @TRPHG nvarchar(9),  @NG_NHANCHUC date
 AS
 IF EXISTS(SELECT * From PHONGBAN Where MAPHG = @MaPHG)
 UPDATE PHONGBAN SET TENPHG =  @TenPHG, TRPHG = @Trphg,NG_NHANCHUC=@NG_NHANCHUC
 WHERE MAPHG = @MaPHG
 ELSE
 INSERT INTO PHONGBAN
 VALUES (@TenPHG,@MaPHG,@TRPHG,@NG_NHANCHUC)
GO
/****** Object:  StoredProcedure [dbo].[sp_ThongtinNV]    Script Date: 02/04/2019 1:38:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_ThongtinNV] @MaNV nvarchar(9)
 AS
 Begin
 SELECT * from NHANVIEN WHERE MaNV = @MaNV
 End
GO
/****** Object:  StoredProcedure [dbo].[sp_Tong]    Script Date: 02/04/2019 1:38:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Tong] @So1 int =3, @So2 int=2
AS 
Begin 
Declare @Tong int  
SET @Tong = @So1 + @So2; 
Print @Tong
End 
GO
USE [master]
GO
ALTER DATABASE [QLDA] SET  READ_WRITE 
GO

/*
Chương trình tính diện tích, chu vi hình chữ nhật khi biết chiều dài và chiều 
rộng.
➢ Dựa trên csdl QLDA thực hiện truy vấn, các giá trị truyền vào và trả ra phải 
dưới dạng sử dụng biến.
1. Cho biêt nhân viên có lương cao nhất
2. Cho biết họ tên nhân viên (HONV, TENLOT, TENNV) có mức lương 
trên mức lương trung bình của phòng "Nghiên cứu”
3. Với các phòng ban có mức lương trung bình trên 30,000, liệt kê tên
phòng ban và số lượng nhân viên của phòng ban đó.
4. Với mỗi phòng ban, cho biết tên phòng ban và số lượng đề án mà
phòng ban đó chủ trì

*/
--Chương trình tính diện tích, chu vi hình chữ nhật khi biết chiều dài và chiều rộng.
DECLARE @ChieuDai FLOAT,@ChieuRong FLOAT,@ChuVi FLOAT,@DienTich FLOAT
SET @ChieuDai = 20 
SET @ChieuRong = 10
SET @ChuVi=(@ChieuDai+@ChieuRong)*2
SET @DienTich = (@ChieuDai*@ChieuRong)
SELECT @ChuVi,@DienTich
--1. Cho biêt nhân viên có lương cao nhất
DECLARE @Max_Luong float
SELECT @Max_Luong=MAX(LUONG)
FROM NHANVIEN
PRINT 'NHAN VIEN LUONG MAX' + CONVERT (CHAR (15),@Max_Luong)
GO
--2. Cho biết họ tên nhân viên (HONV, TENLOT, TENNV) có mức lương trên mức lương trung bình của phòng "Nghiên cứu”
DECLARE @Trung_Binh FLOAT
SET @Trung_Binh = (SELECT AVG(LUONG)
				FROM NHANVIEN N JOIN PHONGBAN P ON N.PHG = P.MAPHG
				WHERE TENPHG = N'Nghiên Cứu')
SELECT HONV,TENLOT,TENNV
FROM NHANVIEN
WHERE LUONG>=@Trung_Binh;
--3. Với các phòng ban có mức lương trung bình trên 30,000, liệt kê tên phòng ban và số lượng nhân viên của phòng ban đó.
DECLARE @Cau3 TABLE (TENPB NVARCHAR(50),SOLUONG INT)
INSERT INTO @Cau3
SELECT TENPHG,COUNT(*) AS SL
FROM NHANVIEN N JOIN PHONGBAN P ON N.PHG=P.MAPHG
GROUP BY TENPHG
HAVING AVG(LUONG)>=all(SELECT AVG(LUONG) FROM NHANVIEN GROUP BY PHG)
--
SELECT * FROM @Cau3
--4. Với mỗi phòng ban, cho biết tên phòng ban và số lượng đề án mà phòng ban đó chủ trì
DECLARE @Cau4 TABLE (TENPB NVARCHAR(50),SOLUONG INT)
INSERT INTO @Cau4 
SELECT TENPHG,COUNT(*) AS SL
FROM PHONGBAN P JOIN DEAN D ON D.PHONG = P.MAPHG
GROUP BY TENPHG
--
SELECT * FROM @Cau4


--LAP 2
/*
1. 	Cho biết họ tên nhân viên (HONV, TENLOT, TENNV) có tổng thời gian trên mức lương tổng thời gian của mỗi nhân viên
2.	Đưa ra thông tin: tennv,tổng thời gian làm việc của mỗi nhân viên
3.	Đưa ra thông tin: tennv,tổng thời gian làm việc của  nhân viên có tổng thời gian >50
4.	Đưa ra thông tin: tennv,tổng thời gian làm việc của nhân viên có tổng thời gian làm việc lớn nhất
5.	Với mỗi nhân viên cho biết tennv,số lượng đề án của mỗi nhân viên 
6.	Với các nhân viên có số lượng đề án >2, liệt kê tên nhân viên và số lượng đề án của nhân viên đó
*/
--1.	Cho biết họ tên nhân viên (HONV, TENLOT, TENNV) có tổng thời gian trên mức tổng thời gian của nhân viên phòng nghiên cứu
DECLARE @L2_Cau1 TABLE (HONV NVARCHAR(50), TENLOT NVARCHAR(50), TENNV NVARCHAR(50))
INSERT INTO @L2_Cau1
SELECT HONV,TENLOT,TENNV
FROM NHANVIEN N JOIN PHANCONG P ON P.MA_NVIEN = N.MANV
GROUP BY HONV,TENLOT,TENNV,LUONG
HAVING SUM(THOIGIAN)> ALL (SELECT SUM(THOIGIAN) FROM PHANCONG P JOIN NHANVIEN N ON N.MANV = P.MA_NVIEN JOIN PHONGBAN B ON N.PHG = B.MAPHG GROUP BY MAPHG,TENPHG HAVING TENPHG = N'Nghiên Cứu')
--
SELECT * FROM @L2_Cau1
--2.	Đưa ra thông tin: tennv,tổng thời gian làm việc của mỗi nhân viên
DECLARE @L2_Cau2 TABLE (TENNV NVARCHAR(50),THOIGIAN FLOAT)
INSERT INTO @L2_Cau2
SELECT TENNV,SUM(THOIGIAN)
FROM NHANVIEN N JOIN PHANCONG P ON P.MA_NVIEN = N.MANV
GROUP BY TENNV
--
SELECT * FROM @L2_Cau2
--3.	Đưa ra thông tin: tennv,tổng thời gian làm việc của  nhân viên có tổng thời gian >50
DECLARE @L2_Cau3 TABLE (TENNV NVARCHAR(50),THOIGIAN FLOAT)
INSERT INTO @L2_Cau3
SELECT TENNV,SUM(THOIGIAN)
FROM NHANVIEN N JOIN PHANCONG P ON P.MA_NVIEN = N.MANV
GROUP BY TENNV
HAVING SUM(THOIGIAN)>50
--
SELECT * FROM @L2_Cau3
--4.	Đưa ra thông tin: tennv,tổng thời gian làm việc của nhân viên có tổng thời gian làm việc lớn nhất
DECLARE @L2_Cau4 TABLE (TENNV NVARCHAR(50),THOIGIAN FLOAT)
INSERT INTO @L2_Cau4
SELECT TENNV,SUM(THOIGIAN)
FROM NHANVIEN N JOIN PHANCONG P ON P.MA_NVIEN = N.MANV
GROUP BY TENNV
HAVING SUM(THOIGIAN) >= ALL(SELECT SUM(THOIGIAN) FROM PHANCONG GROUP BY  MA_NVIEN)
--
SELECT * FROM @L2_Cau4
--5 Với mỗi nhân viên cho biết tennv,số lượng đề án của mỗi nhân viên 
-- SELECT * FROM DEAN
-- SELECT * FROM NHANVIEN
-- SELECT * FROM PHANCONG
DECLARE @L2_Cau5 TABLE (TENNV NVARCHAR(50),SL_DA INT)
INSERT INTO @L2_Cau5
SELECT TENNV,COUNT(*) AS SL
FROM PHANCONG P JOIN NHANVIEN N ON N.MANV = P.MA_NVIEN
				JOIN DEAN D ON D.MADA = P.MADA
GROUP BY TENNV
--
SELECT * FROM @L2_Cau5
--6.	Với các nhân viên có số lượng đề án >2, liệt kê tên nhân viên và số lượng đề án của nhân viên đó
DECLARE @L2_Cau6 TABLE (TENNV NVARCHAR(50),SL_DA INT)
INSERT INTO @L2_Cau6
SELECT TENNV,COUNT(*) AS SL
FROM PHANCONG P JOIN NHANVIEN N ON N.MANV = P.MA_NVIEN
				JOIN DEAN D ON D.MADA = P.MADA
GROUP BY TENNV
HAVING COUNT(*) >2
--
SELECT * FROM @L2_Cau6


--LAP3
SELECT cast(123.2 as decimal(6,2))
SELECT REPLACE(RIGHT('(559) 555-1212', 13), ') ', '-')
SELECT DATEDIFF(month, '2008-09-30', '2007-12-01')
DECLARE @FullName VarChar(25) SET @FullName = 'www.poly.edu.vn' SELECT SUBSTRING(@FullName, 5, 4)

--Với mỗi đề án, liệt kê tên đề án và tổng số giờ làm việc một tuần của tất cả các nhân viên tham dự đề án đó. 
SELECT TENDEAN,CAST( SUM(THOIGIAN) AS decimal(10,2))
FROM PHANCONG P JOIN DEAN D ON P.MADA = D.MADA
GROUP BY TENDEAN
-- Xuất định dạng “tổng số giờ làm việc” kiểu varchar
SELECT TENDEAN,CAST( SUM(THOIGIAN) AS varchar(10))
FROM PHANCONG P JOIN DEAN D ON P.MADA = D.MADA
GROUP BY TENDEAN
--
SELECT TENDEAN,CONVERT(varchar(10),SUM(THOIGIAN)) AS TONGGIO
FROM PHANCONG P JOIN DEAN D ON P.MADA = D.MADA
GROUP BY TENDEAN
--Với mỗi phòng ban, liệt kê tên phòng ban và lương trung bình của những nhân viên làm việc cho phòng ban đó
SELECT TENPHG,CAST(AVG(LUONG) AS decimal(10,2)) AS BTLUONG
FROM PHONGBAN P JOIN NHANVIEN N ON N.PHG=P.MAPHG
GROUP BY TENPHG
--Xuất định dạng “luong trung bình” kiểu decimal với 2 số thập phân, sử dụng dấu phẩy để phân biệt phần nguyên và phần thập phân.
SELECT TENPHG,replace(CAST(AVG(LUONG) AS decimal(10,2)),'.',',')
FROM PHONGBAN P JOIN NHANVIEN N ON N.PHG=P.MAPHG
GROUP BY TENPHG
-- Xuất định dạng “luong trung bình” kiểu varchar. Sử dụng dấu phẩy tách cứ mỗi 3 chữ số trong chuỗi ra, gợi ý dùng thêm các hàm Left, Replace
SELECT DCHI,LEFT(DCHI,2) AS LEFT2,RIGHT(DCHI,3) AS DCHI3,
SUBSTRING(DCHI,LEN(DCHI)-2,3) AS DIACHI
FROM NHANVIEN
SELECT DCHI,
SUBSTRING(dchi ,charindex(' ',dchi),charindex(',' ,dchi) -charindex(' ',dchi) ) as 'Ten duong'
from NHANVIEN

--
SELECT TENNV,LOWER(SUBSTRING(TENNV,1,1))+UPPER(SUBSTRING(TENNV,2,1))+LOWER(SUBSTRING(TENNV,3,LEN(TENNV)-2))
FROM NHANVIEN
--Danh sách những nhân viên (HONV, TENLOT, TENNV, DCHI) có trên 2 thân nhân, thỏa các yêu cầu
--Dữ liệu cột HONV được viết in hoa toàn bộ
SELECT UPPER(HONV) AS HONV,TENLOT,TENNV,DCHI,COUNT(*) AS SOLUONG 
FROM NHANVIEN N JOIN THANNHAN T ON N.MANV=T.MA_NVIEN 
GROUP BY HONV,TENLOT,TENNV,DCHI 
HAVING COUNT(*)>2
--Dữ liệu cột TENLOT được viết chữ thường toàn bộ
SELECT HONV,LOWER(TENLOT) AS TENLOT,TENNV,DCHI,COUNT(*) AS SOLUONG 
FROM NHANVIEN N JOIN THANNHAN T ON N.MANV=T.MA_NVIEN 
GROUP BY HONV,TENLOT,TENNV,DCHI 
HAVING COUNT(*)>2
--Dữ liệu chột TENNV có ký tự thứ 2 được viết in hoa, các ký tự còn lại viết thường( ví dụ: kHanh)
SELECT TENNV,LOWER(SUBSTRING(TENNV,1,1))+UPPER(SUBSTRING(TENNV,2,1))+LOWER(SUBSTRING(TENNV,3,LEN(TENNV)-2))
FROM NHANVIEN
--Dữ liệu cột DCHI chỉ hiển thị phần tên đường, không hiển thị các thông tin khác như số nhà hay thành phố
SELECT DCHI,LEFT(DCHI,2) AS LEFT2,RIGHT(DCHI,3) AS DCHI3,
SUBSTRING(DCHI,LEN(DCHI)-2,3) AS DIACHI
FROM NHANVIEN
SELECT DCHI,
SUBSTRING(dchi ,charindex(' ',dchi),charindex(',' ,dchi) -charindex(' ',dchi) ) as 'Ten duong'
from NHANVIEN
--
SELECT TENPHG,N1.TENNV,COUNT(*) AS SL
FROM NHANVIEN N JOIN PHONGBAN P ON P.MAPHG=N.PHG
	JOIN NHANVIEN N1 ON N1.MANV = P.TRPHG
GROUP BY TENPHG,N1.TENNV
--
SELECT TENPHG,N1.TENNV,COUNT(*) AS SL
FROM NHANVIEN N JOIN PHONGBAN P ON P.MAPHG=N.PHG
	JOIN NHANVIEN N1 ON N1.MANV = P.TRPHG
GROUP BY TENPHG,N1.TENNV
HAVING COUNT(*) >= ALL(SELECT COUNT(*) FROM NHANVIEN GROUP BY PHG)
--Bài 2
-- Với mỗi đề án, liệt kê tên đề án và tổng số giờ làm việc một tuần của tất cả các nhân viên tham dự đề án đó.
SELECT TENDEAN,SUM(THOIGIAN) AS TONGGILAM
FROM DEAN D JOIN PHANCONG P ON D.MADA = P.MADA
GROUP BY TENDEAN
--Xuất định dạng “tổng số giờ làm việc” với hàm CEILING
SELECT TENDEAN,CEILING(SUM(THOIGIAN)) AS TONGGILAM
FROM DEAN D JOIN PHANCONG P ON D.MADA = P.MADA
GROUP BY TENDEAN
--Xuất định dạng “tổng số giờ làm việc” với hàm FLOOR
SELECT TENDEAN,FLOOR(SUM(THOIGIAN)) AS TONGGILAM
FROM DEAN D JOIN PHANCONG P ON D.MADA = P.MADA
GROUP BY TENDEAN
--Xuất định dạng “tổng số giờ làm việc” làm tròn tới 2 chữ số thập phân
SELECT TENDEAN,ROUND(SUM(THOIGIAN),2) AS TONGGILAM
FROM DEAN D JOIN PHANCONG P ON D.MADA = P.MADA
GROUP BY TENDEAN
--Cho biết họ tên nhân viên (HONV, TENLOT, TENNV) có mức lương trên mức lương trung bình (làm tròn đến 2 số thập phân) của phòng "Nghiên cứu"
SELECT HONV, TENLOT, TENNV
FROM NHANVIEN 
GROUP BY HONV, TENLOT,TENNV,LUONG
HAVING LUONG > ALL (SELECT ROUND(AVG(LUONG),2) FROM NHANVIEN N JOIN PHONGBAN P ON P.MAPHG=N.PHG GROUP BY MANV,TENPHG HAVING TENPHG = N'Nghiên cứu')
--BÀI 4
--Cho biết các nhân viên có năm sinh trong khoảng 1960 đến 1965.
SELECT TENNV,YEAR(NGSINH) AS NAM_SINH
FROM NHANVIEN
WHERE YEAR(NGSINH)>=1960 AND YEAR(NGSINH)<=1965
-- Cho biết tuổi của các nhân viên tính đến thời điểm hiện tại.
SELECT TENNV,YEAR(GETDATE())-YEAR(NGSINH) AS TUOI
FROM NHANVIEN
--Dựa vào dữ liệu NGSINH, cho biết nhân viên sinh vào thứ mấy
SELECT TENNV,DATENAME(WEEKDAY,NGSINH) AS THU
FROM NHANVIEN
--Cho biết số lượng nhân viên, tên trưởng phòng, ngày nhận chức trưởng phòng và ngày nhận chức trưởng phòng hiển thi theo định dạng dd-mm-yy (ví dụ 25-04-2019)
SELECT TENPHG,N1.TENNV,COUNT(*) AS SL,CONVERT(varchar(10),NG_NHANCHUC,105) as NGAY_NHAN_CHUC
FROM NHANVIEN N JOIN PHONGBAN P ON P.MAPHG=N.PHG
	JOIN NHANVIEN N1 ON N1.MANV = P.TRPHG
GROUP BY TENPHG,N1.TENNV,NG_NHANCHUC


--

