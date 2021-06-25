CREATE DATABASE QLNT_ASM

--Loainha(Maloainha,tenloainha)
CREATE TABLE LoaiNha(
Maloainha VARCHAR(10) PRIMARY KEY,
tenloainha NVARCHAR(50),
);
INSERT INTO LoaiNha
	VALUES('N01',N'Nhà trọ'),
		('N02',N'Chung Cư');

--Noidung(Mand,Tennd,gioitinh,dienthoai,sonha,duong,phuong,quan,email)
CREATE TABLE NoiDung(
Mand VARCHAR(10) PRIMARY KEY,
Tennd NVARCHAR(50) NOT NULL,
gioitinh NVARCHAR(10) NOT NULL,
dienthoai VARCHAR(15) NOT NULL,
sonha VARCHAR(10) NOT NULL,
duong NVARCHAR(50) NOT NULL,
phuong NVARCHAR(40) NOT NULL,
quan NVARCHAR(50) NOT NULL,
email NVARCHAR(30) NOT NULL,
);
INSERT INTO NoiDung
	VALUES('ND01',N'Nội dung 1',N'Nam','0987329892','10A',N'Đường xuân phương',N'Xuân phương',N'Nam từ liêm',N'A@gmail.com'),
		('ND02',N'Nội dung 2',N'Nam','0987329762','10B',N'Đường xuân phương',N'Xuân phương',N'Nam từ liêm',N'B@gmail.com');
--Nhatro(Mant,dientich,giaphong,sonha,duongphuong,quan,mota,ngaydang,Maloainha,Mand)
CREATE TABLE NhaTro(
Mant VARCHAR(10) PRIMARY KEY,
dientich FLOAT NOT NULL,
giaphong FLOAT NOT NULL,
sonha VARCHAR(10) NOT NULL,
duongphuong NVARCHAR(40) NOT NULL,
quan NVARCHAR(50) NOT NULL,
mota NVARCHAR(50) NOT NULL,
ngaydang DATE,
Maloainha VARCHAR(10),
Mand VARCHAR(10),
CONSTRAINT FK_Maloainha FOREIGN KEY (Maloainha) REFERENCES LoaiNha(Maloainha),
CONSTRAINT FK_Mand FOREIGN KEY (Mand) REFERENCES NoiDung(Mand),
);
INSERT INTO NhaTro
	VALUES('NT01',56.3,2000,'1A',N'Đường xuân phương',N'Nam từ liêm',N'Mô tả 1','10/1/2021','N01','ND02'),
		('NT02',66.3,4000,'1B',N'Đường xuân phương',N'Nam từ liêm',N'Mô tả 2','10/1/2020','N02','ND01');
--Danhgia(id,mand,Mant,like_dislike,Noidung)
CREATE TABLE DanhGia(
id INT PRIMARY KEY IDENTITY,
mand VARCHAR(10),
Mant VARCHAR(10),
like_dislike NVARCHAR(50),
Noidung NVARCHAR(50),
CONSTRAINT FK_mand_DanhGia FOREIGN KEY (mand) REFERENCES NoiDung(Mand),
CONSTRAINT FK_Mant FOREIGN KEY (Mant) REFERENCES NhaTro(Mant),
);
INSERT INTO DanhGia
	VALUES('ND01','NT02',N'LIKE',N'Mát mẻ'),
		('ND02','NT01',N'Dis LIKE',N'Nóng nực');

CREATE PROC SP_TimKiem(
@Quan NVARCHAR(50)=N'%',
@LoaiNhaTro NVARCHAR(50)=N'%',
@DienTichMin FLOAT = NULL,
@DienTichMax FLOAT = NULL,
@GiaPhongMin FLOAT = NULL,
@GiaPhongMax FLOAT = NULL,
@NgayMin DATE = NULL,
@NgayMax DATE = NULL
)
AS
BEGIN
IF(@DienTichMin IS NULL ) SELECT @DienTichMin = MIN(DIENTICH) FROM NhaTro
IF(@DienTichMax IS NULL ) SELECT @DienTichMax = MAX(DIENTICH) FROM NhaTro
IF(@GiaPhongMin IS NULL ) SELECT @GiaPhongMin = MIN(giaphong) FROM NhaTro
IF(@GiaPhongMax IS NULL ) SELECT @GiaPhongMax = MAX(giaphong) FROM NhaTro
IF(@NgayMin IS NULL ) SELECT @NgayMin = MIN(ngaydang) FROM NhaTro
IF(@NgayMax IS NULL ) SELECT @NgayMax = MAX(ngaydang) FROM NhaTro
SELECT N'CHO THUÊ PHÒNG TRỌ TẠI'+N.SONHA+' '+N.DUONG+' '+N.PHUONG+' '+N.QUAN AS DIACHITHUENHA,
	REPLACE(CAST(DIENTICH AS nvarchar(20)),'.',',')+N'm2' AS DIENTICH,
	LEFT(CONVERT(NVARCHAR,GIAPHONG,1),LEN(CONVERT(NVARCHAR,GIAPHONG,1))-3) AS GIAPHONG,MOTA,
	CONVERT(NVARCHAR(15),NGAYDANG,105) AS NGAYDANG,
	IIF(GIOITINH=N'NAM',N'A. ',N'C. ')+TENND AS NGUOIDANGTIN,
	DIENTHOAI,
	ND.SONHA+' '+ND.DUONG+' '+ND.DUONG+' '+ND.QUAN AS DIACHILIENHE
	FROM NHATRO N INNER JOIN NGUOIDUNG ND ON N.Mand=ND.MAND
	WHERE N.quan LIKE @QUAN AND MALOAINHA LIKE @LOAINHATRO AND
	dientich BETWEEN @DIENTICHMIN AND @DIENTICHMAX
	AND (giaphong BETWEEN @GIAPHONGMIN AND @GIAPHONGMAX)
	AND(ngaydang BETWEEN @NGAYMIN AND @NGAYMAX)


FROM NhaTro N JOIN NoiDung ND ON N.Mand = ND.Mand
END


--
CREATE FUNCTION FN_TongLike(@mant NVARCHAR(10))
RETURNS INT
AS
BEGIN
RETURN (SELECT COUNT(*) FROM DanhGia WHERE Mant=@mant AND like_dislike=1)
END
--
CREATE FUNCTION FN_TongDisLike(@mant NVARCHAR(10))
RETURNS INT
AS
BEGIN
RETURN (SELECT COUNT(*) FROM DanhGia WHERE Mant=@mant AND like_dislike=0)
END
--
SELECT dbo.FN_TongDisLike(Mant) FROM NhaTro
