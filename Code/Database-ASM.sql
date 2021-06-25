--DATABASE FINAL ASSIGNMENT môn CSLD
DROP DATABASE FINAL_ASSIGNMENT;
CREATE DATABASE FINAL_ASSIGNMENT;
CREATE TABLE DongSanPham(
	ID int PRIMARY KEY IDENTITY,
	MaDSP Varchar(10) UNIQUE,
	TenDSP Nvarchar(50) DEFAULT NULL,
);
INSERT INTO DongSanPham(MaDSP,TenDSP)
	VALUES ('DSP01',N'Sieu Mỏng 1'),
		('DSP02',N'Sieu Mỏng 2'),
		('DSP03',N'Sieu Mỏng'),
		('DSP04',N'Sieu Mỏng'),
		('DSP05',N'Sieu Mỏng'),
		('DSP06',N'Sieu Mỏng 6'),
		('DSP07',N'Sieu Mỏng'),
		('DSP08',N'Sieu Mỏng'),
		('DSP09',N'Sieu Mỏng');
CREATE TABLE KhachHang(
	ID INT PRIMARY KEY IDENTITY,
	MaKH VARCHAR(10) UNIQUE,
	TenKH NVARCHAR(50),
	TenDemKH NVARCHAR(50),
	HoKH NVARCHAR(50),
	GioiTinh NVARCHAR(50),
	NgaySinh datetime,
	DiaChi NVARCHAR(150),
	SDT VARCHAR(15),
	ThanhPho NVARCHAR(50),
	MaCty VARCHAR(10) NULL,
	TenCty NVARCHAR(100) NULL,
	MaSoThue VARCHAR(10) NULL,
	TrangThai NVARCHAR(150),
);
INSERT INTO KhachHang(MaKH,TenKH,TenDemKH,HoKH,GioiTinh,DiaChi,SDT,ThanhPho,MaCty,TenCty,MaSoThue,TrangThai)
	VALUES ('KH01',N'Thành',NULL,N'Trần Văn',N'Nam',N'Xóm 1-đặng sơn-đô lương','0385613085',N'Nghệ An',NULL,NULL,NULL,'T'),
		('KH02',N'Phương',NULL,N'Trần Văn',N'Nam',N'Xóm 1-đặng sơn-đô lương','0972908818',N'Nghệ An',NULL,NULL,NULL,'T'),
		('KH03',N'Hảo',N'Thanh',N'Thái Thị',N'Nữ',N'Xóm 2-đặng sơn-đô lương','0385613085',N'Nghệ An',NULL,NULL,NULL,'T'),
		('KH04',N'Mạnh',NULL,N'Bùi Đức',N'Nam',N'số 4a thị trấn phùng-đan phượng','0385613085',N'Hà Nội',NULL,NULL,NULL,'T'),
		('KH05',N'Tú',NULL,N'Nguyễn Trung',N'Nam',N'Số 6 ngõ 125 thanh xuân-cầu diễn','0385613085',N'Hà Nội',NULL,NULL,NULL,'T'),
		('KH06',N'Tú',NULL,N'Doãn Thanh',N'Nam',N'Số 65 trần đứ bô-cầu diễn','0385613085',N'Hà Nội',NULL,NULL,NULL,'T'),
		('KH07',N'Nga',NULL,N'Phạm Thị',N'Nữ',N'Xóm 1-đặng sơn-đô lương','0385613085',N'Nghệ An',NULL,NULL,NULL,'T'),
		('KH08',N'Thương',N'Hoài',N'Nguyễn Thị',N'Nữ',N'Xóm 1-đặng sơn-đô lương','0385613085',N'Nghệ An',NULL,NULL,NULL,'T'),
		('KH09',N'Thành',NULL,N'Trần Văn',N'Nam',N'Xóm 1-đặng sơn-đô lương','0385613085',N'Nghệ An',NULL,NULL,NULL,'T'),
		('KH10',N'Thành',NULL,N'Trần Văn',N'Nam',N'Xóm 1-đặng sơn-đô lương','0385613085',N'Nghệ An',NULL,NULL,NULL,'T'),
		('KH11',N'Thành',NULL,N'Trần Văn',N'Nam',N'Xóm 1-đặng sơn-đô lương','0385613085',N'Nghệ An',NULL,NULL,NULL,'T'),
		('KH12',N'Thành',NULL,N'Trần Văn',N'Nam',N'Xóm 1-đặng sơn-đô lương','0385613085',N'Nghệ An',NULL,NULL,NULL,'T');
DROP TABLE HoaDon;
CREATE TABLE HoaDon(
	ID INT PRIMARY KEY IDENTITY,
	IDKhachHang INT,
	IDNhanVien INT,
	MaHD VARCHAR(10),
	NgayThanhToanHD DATETIME,
	NgayShipHang DATETIME,
	NgayNhanHang DATETIME,
	IDTrangThai INT,
);
INSERT INTO HoaDon(IDKhachHang,IDNhanVien,MaHD,NgayThanhToanHD,NgayShipHang,NgayNhanHang,IDTrangThai)
	VALUES ('3','2','HD01','20200318','20200318','20200318','1'),
		('3','2','HD02','20200318','20200318','20200318','1'),
		('3','2','HD03','20200318','20200318','20200318','1'),
		('4','3','HD04','20200318','20200318','20200318','1'),
		('5','3','HD05','20200318','20200318','20200318','1'),
		('6','2','HD06','20200318','20200318','20200318','1'),
		('7','2','HD07','20200318','20200318','20200318','1'),
		('8','2','HD08','20200318','20200318','20200318','1'),
		('8','3','HD09','20200318','20200318','20200318','1'),
		('8','4','HD10','20200318','20200318','20200318','1'),
		('9','4','HD11','20200318','20200318','20200318','1'),
		('9','4','HD12','20200318','20200318','20200318','1');
ALTER TABLE HoaDon
	ADD FOREIGN KEY (IDKhachHang) REFERENCES KhachHang(ID);
ALTER TABLE HoaDon
	ADD FOREIGN KEY (IDNhanVien) REFERENCES NhanVien(ID);
DROP TABLE TrangThai;
CREATE TABLE TrangThai(
	ID INT PRIMARY KEY IDENTITY,
	TenTrangThai NVARCHAR(100) NOT NULL,
);
INSERT INTO TrangThai(TenTrangThai)
	VALUES (N'Đang nhập hàng'),
		(N'Nàng Đã nhập kho'),
		(N'Đang gói hàng'),
		(N'Đang chuyển hàng cho người vận chuyển'),
		(N'Bên vận chuyển đã nhận hàng'),
		(N'Đang giao hàng'),
		(N'Đã giao hàng thành công');
CREATE TABLE PhieuBaoHanh(
	ID INT PRIMARY KEY IDENTITY,
	IDSanPham INT,
	IDHoaDon INT,
	MaPhieu VARCHAR(10),
	NgayBatDau DATETIME,
	NgayKetThuc DATETIME,
	MoTa NVARCHAR(100),
	IMEI IMAGE,
	TrangThai NVARCHAR(100),
);
INSERT INTO PhieuBaoHanh
	VALUES ('1','19','BH01','20200112','20220112',N'Bảo hành chính hãng 2 năm',NULL,'1'),
		('2','24','BH02','20201212','20221212',N'Bảo hành chính hãng 2 năm',NULL,'1'),
		('3','23','BH03','20200111','20220111',N'Bảo hành chính hãng 2 năm',NULL,'1'),
		('4','21','BH04','20200110','20220110',N'Bảo hành chính hãng 2 năm',NULL,'1'),
		('4','22','BH05','20200212','20220212',N'Bảo hành chính hãng 2 năm',NULL,'1'),
		('5','20','BH06','20200112','20220112',N'Bảo hành chính hãng 2 năm',NULL,'1'),
		('5','20','BH07','20200112','20220112',N'Bảo hành chính hãng 2 năm',NULL,'1');

ALTER TABLE PhieuBaoHanh
	ADD FOREIGN KEY (IDSanPham) REFERENCES SanPham(ID);
ALTER TABLE PhieuBaoHanh
	ADD FOREIGN KEY (IDHoaDon) REFERENCES HoaDon(ID);
CREATE TABLE SanPham(
	ID INT PRIMARY KEY IDENTITY,
	MaSP VARCHAR(10),
	TenSP NVARCHAR(100),
	ManHinh FLOAT(15),
	MoTaSP NVARCHAR(100),
	TrongLuongSP FLOAT(10),
	GiaNhap FLOAT(15),
	GiaBan FLOAT(15),
	SoLuong VARCHAR(3),
	TrangThai NVARCHAR(100),
);
INSERT INTO SanPham
	VALUES ('SP01',N'Laptop DELL Votrl 01','14',N'Siêu mỏng, bền và thích hợp mọi công việc','1.4','120000','200000','20','1'),
		('SP02',N'Laptop DELL Votrl 02','15.6',N'Siêu mỏng, bền và thích hợp mọi công việc','1.4','110000','190000','10','1'),
		('SP03',N'Laptop DELL Votrl 03','15.6',N'Siêu mỏng, bền và thích hợp mọi công việc','1.4','100000','430000','30','1'),
		('SP04',N'Laptop DELL Votrl 04','15.6',N'Siêu mỏng, bền và thích hợp mọi công việc','1.4','230000','440000','40','1'),
		('SP05',N'Laptop DELL Votrl 05','14',N'Siêu mỏng, bền và thích hợp mọi công việc','1.4','220000','280000','50','1'),
		('SP06',N'Laptop DELL Votrl 06','14',N'Siêu mỏng, bền và thích hợp mọi công việc','1.4','210000','290000','60','1'),
		('SP07',N'Laptop DELL Votrl 07','14',N'Siêu mỏng, bền và thích hợp mọi công việc','1.4','190000','230000','70','1');
CREATE TABLE CuaHang(
	ID INT PRIMARY KEY IDENTITY,
	MaCH VARCHAR(10),
	TenCH NVARCHAR(50),
	DiaChi NVARCHAR(50),
	ThanhPho NVARCHAR(50),
	QuocGia NVARCHAR(50),
	TrangThai NVARCHAR(100),
);
DELETE FROM CuaHang--Xóa dữ liệu
DBCC CHECKIDENT (CuaHang, RESEED, 0);--Câu lệnh RESEED Id lại từ 0
INSERT INTO CuaHang(MaCH,TenCH,DiaChi,ThanhPho,QuocGia,TrangThai,IDThuongHieu)
	VALUES ('CH01','FPT',N'Số 234 trần công dự-cầu dấy',N'Hà Nội',N'Việt Nam','1','1'),
		('CH02','FPT',N'Số 234 trần công dự-cầu dấy',N'Hà Nội',N'Việt Nam','1','1'),
		('CH03','FPT 1',N'Số 234 trần công dự-cầu dấy',N'TP Hồ Chí Minh',N'Việt Nam','1','2'),
		('CH04','Thế giới Laptop',N'Số 234 trần công dự-cầu dấy',N'Nghệ An',N'Việt Nam','1','5'),
		('CH05','Điện Máy Xanh',N'Số 234 trần công dự-cầu dấy',N'Hà Nội',N'Việt Nam','1','6'),
		('CH06','FPT 1',N'Số 234 trần công dự-cầu dấy',N'Hà Nội',N'Việt Nam','1','5'),
		('CH07','FPT 2',N'Số 234 trần công dự-cầu dấy',N'TP Hồ Chí Minh',N'Việt Nam','1','1'),
		('CH08','laptop đẹp',N'Số 234 trần công dự-cầu dấy',N'Hà Nội',N'Việt Nam','1','4'),
		('CH09','Laptop ngon',N'Số 234 trần công dự-cầu dấy',N'Hà Nội',N'Việt Nam','1','3'),
		('CH10','FPT 2',N'Số 234 trần công dự-cầu dấy',N'Hà Nội',N'Việt Nam','1','2');

ALTER TABLE CuaHang
	ADD FOREIGN KEY (IDThuongHieu) REFERENCES ThuongHieu(ID);
ALTER TABLE CuaHang
	ADD IDThuongHieu int;
CREATE TABLE ThuongHieu(
	ID INT PRIMARY KEY IDENTITY,
	MaTH VARCHAR(10),
	TenTH NVARCHAR(50),
	Website VARCHAR(100),
	TrangThai NVARCHAR(50),
);
INSERT INTO ThuongHieu(MaTH,TenTH,Website,TrangThai)
	VALUES ('TH01',N'DELL',N'https://www.dell.com/support/home/en-vn','1'),
		('TH02',N'HP',N'https://www.HP.com/support/home/en-vn','1'),
		('TH03',N'Lenovo',N'https://www.Lenovo.com/support/home/en-vn','1'),
		('TH04',N'Asus',N'https://www.Asus.com/support/home/en-vn','1'),
		('TH05',N'Apple',N'https://www.Apple.com/support/home/en-vn','1'),
		('TH06',N'Acer',N'https://www.Acer.com/support/home/en-vn','1'),
		('TH07',N'Microsoft',N'https://www.Microsoft.com/support/home/en-vn','1'),
		('TH08',N'Samsung',N'https://www.Samsung.com/support/home/en-vn','1');

CREATE TABLE NhanVien(
	ID INT PRIMARY KEY IDENTITY,
	IDCuaHang INT,
	MaNV VARCHAR(10),
	TenNV NVARCHAR(50),
	HoNV NVARCHAR(50),
	TenDemNV NVARCHAR(50),
	GioiTinh NVARCHAR(10),
	DiaChi NVARCHAR(50),
	LuongNV FLOAT(16),
	SDT VARCHAR(15),
	Emali VARCHAR(20),
	IDChucVu INT,
	TrangThai NVARCHAR(50),
);
ALTER TABLE NhanVien
		ALTER COLUMN Emali varchar(max);
INSERT INTO NhanVien(IDCuaHang,MaNV,TenNV,HoNV,TenDemNV,GioiTinh,DiaChi,LuongNV,SDT,Emali,IDChucVu,TrangThai)
	VALUES ('1','NV01',N'Thành',N'Trần Văn',NULL,N'Nam',N'Xóm1 Đặng Sơn-Đô Lương','120000','0385613085',N'Thanhtvph15016@gmail.com','1','1'),
		('1','NV02',N'Thành',N'Trần Văn',NULL,N'Nam',N'Xóm1 Đặng Sơn-Đô Lương','140000','0385613085',N'Thanhtvph15016@gmail.com','2','1'),
		('1','NV03',N'Thương',N'Nguyễn Thị',N'Hoài',N'Nữ',N'Xóm1 Đặng Sơn-Đô Lương','150000','0385613085',N'Thanhtvph15016@gmail.com','3','1'),
		('1','NV04',N'Phương',N'Trần Văn',NULL,N'Nam',N'Xóm1 Đặng Sơn-Đô Lương','160000','0385613085',N'Thanhtvph15016@gmail.com','4','1'),
		('1','NV05',N'Nga',N'Nguyễn Thị',NULL,N'Nữ',N'Xóm1 Đặng Sơn-Đô Lương','170000','0385613085',N'Ngantph15017@gmail.com','5','1'),
		('1','NV06',N'Mạnh',N'Trần Văn',NULL,N'Nam',N'Xóm1 Đặng Sơn-Đô Lương','170000','0385613085',N'Thanhtvph15016@gmail.com','6','1'),
		('1','NV07',N'Tú',N'Trần Văn',NULL,N'Nam',N'Xóm1 Đặng Sơn-Đô Lương','170000','0385613085',N'Thanhtvph15016@gmail.com','6','1'),
		('1','NV08',N'Vương',N'Trần Văn',NULL,N'Nam',N'Xóm1 Đặng Sơn-Đô Lương','200000','0385613085',N'Thanhtvph15016@gmail.com','6','1'),
		('1','NV09',N'Hảo',N'Trần Văn',NULL,N'Nam',N'Xóm1 Đặng Sơn-Đô Lương','120000','0385613085',N'Thanhtvph15016@gmail.com','6','1'),
		('1','NV10',N'Thu',N'Trần Văn',NULL,N'Nam',N'Xóm1 Đặng Sơn-Đô Lương','120000','0385613085',N'Thanhtvph15016@gmail.com','6','1'),
		('1','NV11',N'Dương',N'Trần Văn',NULL,N'Nam',N'Xóm1 Đặng Sơn-Đô Lương','120000','0385613085',N'Thanhtvph15016@gmail.com','6','1'),
		('1','NV12',N'Hải',N'Nguyễn Đắc',NULL,N'Nam',N'Xóm1 Đặng Sơn-Đô Lương','120000','0385613085',N'Thanhtvph15016@gmail.com','6','1');

ALTER TABLE NhanVien
	ADD FOREIGN KEY (IDCuaHang) REFERENCES CuaHang(ID);
ALTER TABLE NhanVien
	ADD FOREIGN KEY (IDChucVu) REFERENCES ChucVu(ID);
DROP TABLE SanPhamDongSanPham;
CREATE TABLE SanPhamDongSanPham(
	IDSanPham INT , IDDongSP INT ,
	TenDong NVARCHAR(30),
	CONSTRAINT PK_SPDSP PRIMARY KEY(IDSanPham,IDDongSP)
);
ALTER TABLE SanPhamDongSanPham
	ADD FOREIGN KEY (IDSanPham) REFERENCES SanPham(ID);
ALTER TABLE SanPhamDongSanPham
	ADD FOREIGN KEY (IDDongSP) REFERENCES DongSanPham(ID);
DROP TABLE track;
CREATE TABLE track( --Bài test tạo khóa chính tổng hợp
col1 numeric(10) , col2 numeric(10) ,col3 numeric(10), 
PRIMARY KEY (col1,col2,col3) 
);
DROP TABLE HoaDonChiTiet;
CREATE TABLE HoaDonChiTiet(
	IDHoaDon INT,IDSanPham INT,
	SoLuong VARCHAR(3),
	DonGia FLOAT(16),
	CONSTRAINT PK_HDCT PRIMARY KEY(IDHoaDon,IDSanPham)
);
ALTER TABLE HoaDonChiTiet
	ADD FOREIGN KEY (IDHoaDon) REFERENCES HoaDon(ID);
ALTER TABLE HoaDonChiTiet
	ADD FOREIGN KEY (IDSanPham) REFERENCES SanPham(ID);
INSERT INTO HoaDonChiTiet(IDHoaDon,IDSanPham,SoLuong,DonGia)
VALUES('20','3','1','17000000'),
	('21','4','1','7000000'),
	('21','5','1','17000000'),
	('22','6','1','16000000'),
	('23','6','1','15000000'),
	('25','7','1','14000000'),
	('24','2','1','13000000'),
	('22','1','1','13000000'),
	('26','1','1','12000000');
CREATE TABLE ChucVu(
	ID INT PRIMARY KEY IDENTITY,
	MaChucVu VARCHAR(10),
	TenChucVu NVARCHAR(30),
);
INSERT INTO ChucVu(MaChucVu,TenChucVu)
	VALUES ('CV01',N'Chủ tịch'),
		('CV02',N'Giám đốc'),
		('CV03',N'Thư Kí'),
		('CV04',N'Thu ngân'),
		('CV05',N'Quản lí'),
		('CV06',N'Nhân Viên');


SELECT MaDSP,TenDSP FROM DongSanPham; --Câu lệnh truy vấn dữ liệu là SELECT .......FROM.....Là tên bảng.
SELECT * FROM DongSanPham;--SELECT * FROM Là câu lệnh truy vấn hiển thị tất cả dữ liệu trong bảng cả khóa chính ID
SELECT DSP.ID,DSP.MaDSP,DSP.TenDSP --Truy vấn dữ liệu
FROM DongSanPham AS DSP;
SELECT DISTINCT TenDSP
FROM DongSanPham;--Lọc dữ liệu trùng
SELECT TOP 2 * FROM DongSanPham;--Lấy 2 giá trị đầu tiên
SELECT TOP 50 PERCENT * FROM DongSanPham;--Lấy 50% giá trị PERCENT Là % 
SELECT TOP 100 PERCENT * FROM DongSanPham WHERE TenDSP = N'Sieu Mỏng';--WHERE LÀ ĐIỀU KIỆN
DELETE FROM DongSanPham WHERE ID = 1;--Xóa bản ghi có điều kiện và nên có where
UPDATE DongSanPham--Câu lệnh cập nhập
SET TenDSP = N'Sieu Mỏng 15',MaDSP = 'DSP02'
WHERE ID=2;
SELECT * FROM CuaHang;
SELECT * FROM CuaHang WHERE DiaChi LIKE 'S%';--Tìm tất cả các chức vụ có tên bắt đầu bằng T
SELECT * FROM CuaHang WHERE TenCH = N'Cửa hàng 3' or TenCH = N'Cửa hàng 5';
SELECT * FROM CuaHang
WHERE TenCH IN (N'Cửa hàng 1',N'Cửa hàng 2');--Tìm tất cả các cửa hàng có tên là cửa hàng 1 và cửa hàng 2
SELECT *FROM CuaHang
WHERE MaCH ='CH03' AND QuocGia = N'Việt Nam';--Tìm mã của hàng là CH03 và ở việt nam
SELECT * FROM NhanVien;
--Cách 1 ko cần viết INNER JOIN
SELECT MaCH,MaNV,TenNV,GioiTinh,Sdt,TenChucVu--Hiển thị điểm chung
FROM NhanVien 
JOIN CuaHang ON NhanVien.IDCuaHang = CuaHang.ID
JOIN ChucVu ON NhanVien.IDChucVu = ChucVu.ID;
--Cách 2
SELECT MaCH,MaNV,TenNV,GioiTinh,Sdt,TenChucVu--Hiển thị điểm chung
FROM NhanVien 
INNER JOIN CuaHang ON NhanVien.IDCuaHang = CuaHang.ID
INNER JOIN ChucVu ON NhanVien.IDChucVu = ChucVu.ID;
--LEFT JOIN
SELECT MaCH,MaNV,TenNV,GioiTinh,Sdt,TenCH--Hiển thị điểm chung
FROM NhanVien 
LEFT JOIN CuaHang ON NhanVien.IDCuaHang = CuaHang.ID;
--RIGHT JOIN
SELECT * FROM CuaHang;
SELECT * FROM NhanVien;
SELECT MaCH,MaNV,TenNV,GioiTinh,Sdt,TenCH--Hiển thị điểm chung
FROM NhanVien 
RIGHT JOIN CuaHang ON NhanVien.IDCuaHang = CuaHang.ID;
