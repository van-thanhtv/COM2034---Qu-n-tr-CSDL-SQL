create database QuanLyNhaTro_ASM
go
use QuanLyNhaTro_ASM
go
if OBJECT_ID('LoaiNha') is not null
drop table LoaiNha
go
create table LoaiNha
(
	ID_loainha nchar(10),
	tenLoaiNha nvarchar(50) default null,
	constraint PK_ID_loainha primary key (ID_loainha)
);
go
delete from LoaiNha
insert into LoaiNha 
values
('LN01',N'Khách Sạn'),
('LN02',N'Trung Cư'),
('LN03',N'Nhà Trọ'),
('LN04',N'Homestay'),
('LN05',N'Biệt thự')
go
if OBJECT_ID('NguoiDung') is not null
drop table NguoiDung
go
create table NguoiDung
(
	ID_NguoiDung nchar(10),
	TenNguoiDung nvarchar(50) default null,
	SDT nchar(10) default null,
	CMND nchar(12) default null,
	DiaChi nvarchar(50) default null,
	QueQuan nvarchar(50) default null,
	GioiTinh nvarchar(5) default null,
	Email nvarchar(50) default null,
	constraint PK_ID_NguoiDung primary key(ID_NguoiDung)
);
go
delete from NguoiDung
insert into NguoiDung
values
('ND01',N'Nguyễn Quốc Huy',0914704741,011223344556,N'39/92 Nguyễn Sơn-Long Biên- Hà Nội',N'Hà Nội','Nam','huy@gmail.com'),
('ND02',N'Thân Văn Nam',0914704742,011223344557,N'39/92 Bắc Giang',N'Bắc Giang','Nam','nam@gmail.com'),
('ND03',N'Nguyễn Xuân Linh',0914704743,011223344558,N'39/92 Thái Bình',N'Thái Bình','Nam','linh@gmail.com'),
('ND04',N'Đỗ Thị Vi',0914704743,011223344559,N'39 Thái Bình',N'Thái Bình',N'Nữ','vi@gmail.com'),
('ND05',N'Hoàng Văn Tuệ',0914704744,011223344560,N'40 Yên Bái',N'Yên Bái','Nam','tue@gmail.com')
go
if OBJECT_ID('QuanHuyen') is not null
drop table QuanHuyen
go
create table QuanHuyen
(
	ID_quanhuyen nchar(10),
	tenquanhuyen nvarchar(50) default null,
	constraint PK_ID_quanhuyen primary key(ID_quanhuyen)
);
go
delete from QuanHuyen
insert into QuanHuyen
values
('QH01',N'Long Biên'),
('QH02',N'Hoàn Kiếm'),
('QH03',N'Đống Đa'),
('QH04',N'Tây Hồ'),
('QH05',N'Hai Bà Trưng')
go

if OBJECT_ID('NhaTro') is not null
drop table NhaTro
go
create table NhaTro
(
	ID_loainha nchar(10),
	ID_quanhuyen nchar(10),
	ID_nhatro nchar(10),
	diachi nvarchar(50) default null,
	dientich float default null,
	ngaybatdauthue datetime default null,
	giaphong money default null,
	mota nvarchar(50) default null,
	constraint PK_nhatro primary key(ID_nhatro),
	constraint FK_ID_loainha foreign key(ID_loainha) references LoaiNha,
	constraint FK_ID_quanhuyen foreign key(ID_quanhuyen) references QuanHuyen	
);
go
delete from NhaTro
insert into NhaTro
values
('LN01','QH01','NT01',N'39/92 Nguyễn Sơn',40.3,'01-02-2020','',N'Nhà đẹp'),
('LN01','QH02','NT02',N'93 Giải Phóng',50.5,'01-03-2020','',''),
('LN02','QH01','NT03',N'101 Xã Đàn',60.5,'01-04-2020','',N'Nhà đẹp'),
('LN02','QH02','NT04',N'20 Lê Văn Lương',48.3,'01-05-2020','',''),
('LN03','QH01','NT05',N'30 Lê Duẩn',45.5,'01-06-2020','',N'Nhà đẹp')
go
if OBJECT_ID('DanhGia') is not null
drop table DanhGia
go
create table DanhGia
( ID_nhatro nchar(10),
  ID_NguoiDung nchar(10),
  [Like/Dislike] bit,
  noidung nvarchar(50),
  constraint PK_ID_nhatro foreign key (ID_nhatro) references  NhaTro,
  constraint PK_ID_NguoiDung1 foreign key(ID_NguoiDung) references NguoiDung,
  constraint FK_IDnhatroIDnguoidung primary key (ID_nhatro,ID_NguoiDung)
)
go
select * from DanhGia
delete from DanhGia
insert into DanhGia
values
('NT05','ND01',1,''),
('NT03','ND02',1,''),
('NT04','ND02',1,''),
('NT02','ND01',1,''),
('NT03','ND01',1,'')
go
----------------------------------------------------------------------------------------------------------------------------
-- caau1--
IF OBJECT_ID('SPINSND') IS NOT NULL
DROP PROC SPINSND
GO 
CREATE PROC SPINSND
	@ID_NguoiDung NCHAR(10),
	@TenNguoiDung NVARCHAR(50),
	@SDT NCHAR(10),
	@CMND NCHAR(12),
	@DiaChi NVARCHAR(50),
	@QueQuan NVARCHAR(50),
	@GioiTinh NVARCHAR(5),
	@Email NVARCHAR(50)
AS
    IF @ID_NguoiDung IS  NULL OR  @TenNguoiDung IS NULL OR @SDT IS NULL OR @CMND IS NULL OR @DiaChi IS NULL
		OR @QueQuan IS NULL OR @GioiTinh IS NULL OR @Email IS NULL
		PRINT N'DỮ LIỆU KHÔNG HỢP LỆ'
	ELSE
		INSERT INTO NguoiDung VALUES(@ID_NguoiDung,@TenNguoiDung,@SDT,@CMND,@DiaChi,@QueQuan,@GioiTinh,@Email)

-- THÊM KHÔNG THÀNH CÔNG--
SELECT * FROM NguoiDung
EXEC SPINSND 'ND07',N'NGUYỄN QUỐC HUY','0914703741','1122334455',N'Long Biên',N'Hà Nội','Nam','huy@gamil.com'
--- THÊM THÀNH CÔNG ---
IF OBJECT_ID('SPINSNT') IS NOT NULL
DROP PROC SPINSNT
GO 
CREATE PROC SPINSNT
@ID_LOAINHA NCHAR(10),
@ID_QUANHUYEN NCHAR(10),
@ID_NHATRO NCHAR(10),
@DIACHI NVARCHAR(50),
@DIENTICH DECIMAL(8,2),
@NGAYBD DATETIME,
@GIAPHONG MONEY,
@MOTA NVARCHAR(50)
AS
	IF @ID_LOAINHA IS NULL OR @ID_QUANHUYEN IS NULL OR @ID_NHATRO IS NULL OR @DIACHI IS NULL OR @DIENTICH IS NULL OR @NGAYBD IS NULL
		OR @GIAPHONG IS NULL OR @MOTA IS NULL
		PRINT N'DỮ LIỆU KHÔNG HỢP LỆ'
	ELSE
		INSERT INTO NhaTro VALUES(@ID_LOAINHA,@ID_QUANHUYEN,@ID_NHATRO,@DIACHI,@DIENTICH,@NGAYBD,@GIAPHONG,@MOTA)
SELECT * FROM NhaTro
EXEC SPINSNT 'LN02','QH03','NT06',N'NGUYỄN SƠN',58.5,'2021-01-02',10000,N'ĐẸP'

IF OBJECT_ID('SPINSDG') IS NOT NULL
DROP PROC SPINSDG
GO 
CREATE PROC SPINSDG
@IDNHATRO NCHAR(10),
@IDNGUOIDUNG NCHAR(10),
@LIKE BIT,
@ND NVARCHAR(50)
AS
	IF @IDNHATRO IS NULL OR @IDNGUOIDUNG IS NULL OR @LIKE IS NULL OR @ND IS NULL 
		PRINT N'DỮ LIỆU KHÔNG HỢP LỆ'
	ELSE
		INSERT INTO DANHGIA VALUES(@IDNHATRO,@IDNGUOIDUNG,@LIKE,@ND)
EXEC SPINSDG 'NT02','ND02',0,N'NHÀ SẠCH ĐẸP'
SELECT * FROM DanhGia
--- cau 3.1----
IF OBJECT_ID('SPXOANT') IS NOT NULL
	DROP PROC SPXOANT
GO
CREATE PROC SPXOANT
	@DIS INT
AS
	BEGIN TRY
		BEGIN TRAN
			DECLARE @BANG TABLE
				(MANT VARCHAR(10), DIS INT)
			INSERT @BANG SELECT ID_nhatro, COUNT([LIKE/DISLIKE]) AS SOLIKE
						 FROM DanhGia
						 WHERE [LIKE/DISLIKE] = 0
						 GROUP BY ID_nhatro
			DELETE DANHGIA
			WHERE ID_nhatro = (SELECT MANT FROM @BANG
						WHERE DIS > @DIS)
		COMMIT TRAN
	END TRY
	BEGIN CATCH
		ROLLBACK TRAN
	END CATCH

EXEC SPXOANT 2
--cau2b--
IF OBJECT_ID ('FNND') IS NOT NULL
DROP FUNCTION FNND
GO 
CREATE FUNCTION FNND
(
	@TENND NVARCHAR(50),
	@SDT NCHAR(10),
	@CMND NCHAR(12),
	@DIACHI NVARCHAR(50),
	@QUEQUAN NVARCHAR(50),
	@GIOITINH NVARCHAR(5),
	@EMAIL NVARCHAR(50)
)
RETURNS NVARCHAR(10)
BEGIN 
	RETURN
		( SELECT ID_NguoiDung  FROM NguoiDung
			WHERE TenNguoiDung = @TENND
			AND SDT = @SDT
			AND CMND = @CMND
			AND DiaChi =@DIACHI
			AND QueQuan = @QUEQUAN
			AND GioiTinh = @GIOITINH
			AND Email = @EMAIL
			)
END
--GỌI--         
DECLARE @MAND NVARCHAR(10)
SET @MAND = DBO.FNND(N'NGUYỄN QUỐC HUY','0914703741','1122334455',N'Long Biên',N'Hà Nội','Nam','huy@gamil.com')
SELECT @MAND AS MANGUOIDUNG
-- câu 2a---
IF OBJECT_ID('SPTIMNT') IS NOT NULL
		DROP PROC SPTIMNT
GO
CREATE PROC SPTIMNT
	@MAQH VARCHAR(10), @DTMIN DECIMAL(8,2), @DTMAX DECIMAL(8,2), @NGAYBD DATETIME, @NGAYKT DATETIME,
	@GIAMIN MONEY, @GIAMAX MONEY, @MALN VARCHAR(10)
AS
	SELECT DISTINCT N'CHO THUÊ PHÒNG TRỌ TẠI: ' + NHATRO.DiaChi AS DCNT,
	REPLACE(CAST(DienTich AS VARCHAR),'.',',') + 'M2' AS DTICH,
	REPLACE(CONVERT(VARCHAR,GiaPhong,1),',','.') AS GIAPHG,
	MOTA,
	CONVERT(VARCHAR,ngaybatdauthue,105) AS NGAYDANGTIN,
	CASE
		WHEN GioiTinh = 'NAM' THEN 'A.' + TenNguoiDung
		WHEN GioiTinh = N'NỮ' THEN 'C.' + TenNguoiDung
	END AS NGUOILH,
	NGUOIDUNG.DiaChi
	FROM NHATRO join DanhGia ON NHATRO.ID_nhatro = DANHGIA.ID_nhatro JOIN NGUOIDUNG ON NGUOIDUNG.ID_NguoiDung = DANHGIA.ID_NguoiDung
	WHERE ID_quanhuyen = @MAQH
		AND DienTich BETWEEN @DTMIN AND @DTMAX
		AND ngaybatdauthue BETWEEN @NGAYBD AND @NGAYKT
		AND GiaPhong BETWEEN @GIAMIN AND @GIAMAX
		AND ID_loainha = @MALN
		select * from NhaTro
		EXEC SPTIMNT 'QH01',20.30,48.3,'2020-01-02','2020-01-02',0.0,0.0,'LN01'
--câu 2--
IF OBJECT_ID('SPTTNT') IS NOT NULL
DROP TABLE SPTTNT
GO
CREATE PROC SPTTNT
@MANT NVARCHAR(10)
AS
IF @MANT IS NULL
PRINT N'DỮ LIỆU KHÔNG HỢP LỆ'
ELSE
SELECT DISTINCT ID_nhatro,TenNguoiDung,[Like/Dislike],noidung      
FROM DanhGia JOIN NguoiDung ON NguoiDung.ID_NguoiDung = DanhGia.ID_NguoiDung
WHERE ID_nhatro =@MANT
EXEC SPTTNT 'NT04'
---CÂU 3.2--
IF OBJECT_ID('SPXOATT1') IS NOT NULL
DROP PROC SPXOATT1
GO
CREATE PROC SPXOATT1
@NGAYBD DATETIME,@NGAYKT DATETIME
AS
BEGIN TRY
		BEGIN TRAN
		--XÓA KHÓA NGOẠI--
		DELETE DanhGia
		WHERE ID_nhatro IN ( SELECT ID_nhatro FROM NhaTro
							WHERE ngaybatdauthue BETWEEN @NGAYBD AND @NGAYKT)
		--- XÓA KHÓA CHÍNH ---
		DELETE NhaTro
		WHERE ngaybatdauthue BETWEEN @NGAYBD AND @NGAYKT
		COMMIT TRAN
END TRY
BEGIN CATCH
			ROLLBACK TRAN
END CATCH
EXEC SPXOATT1 '2020-01-02','2020-01-02'
SELECT * FROM DanhGia
SELECT * FROM NhaTro
-- CÂU 3--
IF OBJECT_ID('FNTKE') IS NOT NULL
DROP FUNCTION FNTKE
GO
CREATE FUNCTION FNTKE ( @MANT NVARCHAR(10))
RETURNS @THONGKE TABLE 
([LIKE] INT , [DISLIKE] INT )
BEGIN 
	DECLARE @SL INT
	SET @SL = (SELECT COUNT(*) FROM DanhGia WHERE ID_nhatro = @MANT)
	DECLARE @LIKE INT
	SET @LIKE = (SELECT COUNT(*) FROM DanhGia WHERE ID_nhatro = @MANT AND [Like/Dislike] = 1)
	INSERT INTO @THONGKE VALUES(@LIKE,@SL - @LIKE)
	RETURN
END
SELECT * FROM FNTKE
--CÂU 3--
IF OBJECT_ID('TOP10_W') IS NOT NULL
DROP VIEW TOP10_W
GO 
CREATE VIEW TOP10_W
AS
	SELECT TOP 10 dientich,giaphong,mota,ngaybatdauthue,TenNguoiDung,NguoiDung.DiaChi,
	SDT,Email,COUNT([Like/Dislike]) AS SOLIKE
	FROM NhaTro JOIN DanhGia ON NhaTro.ID_nhatro = DanhGia.ID_nhatro
	JOIN NguoiDung ON NguoiDung.ID_NguoiDung = DanhGia.ID_NguoiDung
	WHERE [Like/Dislike] ='TRUE'
	GROUP BY dientich,giaphong,mota,ngaybatdauthue,TenNguoiDung,NguoiDung.DiaChi,
	SDT,Email
	ORDER BY SOLIKE
SELECT * FROM TOP10_W
