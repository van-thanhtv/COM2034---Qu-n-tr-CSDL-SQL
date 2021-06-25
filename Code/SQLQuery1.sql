--Ôn tập CSDL 
--Tạo database có tên -FPOLY_ONTAP
CREATE DATABASE FPOLY_ONTAP;
USE FPOLY_ONTAP;
--Tạo các bảng dưới đây
--KhachHang(ID,Ho,Ten,TenDem,GioiTinh,Tuoi,Sdt1,Sdt2,NgaySinh,DiaChi1,DiaChi2,ThanhPho)
CREATE TABLE KhachHang(
	ID INT PRIMARY KEY IDENTITY,
	Ho NVARCHAR(20),
	Ten NVARCHAR(20),
	TenDem NVARCHAR(20),
	GioiTinh NVARCHAR(10),
	Tuoi INT,
	Sdt1 VARCHAR(15),
	Sdt2 VARCHAR(15),
	NgaySinh DATETIME,
	DiaChi1 NVARCHAR(50),
	DiaChi2 NVARCHAR(50),
	ThanhPho NVARCHAR(30),
);
--HoaDon(ID,MaHD,NgayTaoHoaDon,NgaySipHang,IDKhachHang)
CREATE TABLE HoaDon(
	ID INT PRIMARY KEY IDENTITY,
	MaHD VARCHAR(10),
	NgayTaoHoaDon DATETIME,
	NgaySipHang DATE,
	IDKhachHang INT,
);
ALTER TABLE HoaDon
	ADD FOREIGN KEY (IDKhachHang) REFERENCES KhachHang(ID);
--HoaDonChiTiet(IDHoaDon,IDSanPham,Index(Biết được vị trí của sản phẩm nằm vị trí số mấy trong hóa đơn),SoLuong,DonGia)
DROP TABLE HoaDonChiTiet;
CREATE TABLE HoaDonChiTiet(
	IDHoaDon INT,
	IDSanPham INT,
	--IMARY KEY (IDHoaDon,IDSanPham),--Tạo khóa chính tổng hợp
	Indexx INT,
	SoLuong INT,
	DonGia FLOAT,
	CONSTRAINT PK_HDSP PRIMARY KEY(IDHoaDon,IDSanPham)
);
ALTER TABLE HoaDonChiTiet
	ADD FOREIGN KEY (IDSanPham) REFERENCES SanPham(ID);
ALTER TABLE HoaDonChiTiet
	ADD FOREIGN KEY (IDHoaDon) REFERENCES HoaDon(ID);
--SanPham(ID,MaSP,TenSP,DonGia,GiaNhap,GiaBan,TrongLuong)
DROP TABLE SanPham;
CREATE TABLE SanPham(
	ID INT PRIMARY KEY IDENTITY,
	MaSP VARCHAR(10),
	TenSP NVARCHAR(50),
	DonGia FLOAT(10),
	GiaNhap FLOAT(10),
	GiaBan FLOAT(10),
	TrongLong FLOAT(10),
);
--NhanVIen(ID,MaNV,Ho,Ten,TenDem,GioiTinh,Tuoi,Sdt1,Sdt2,NgaySinh,DiaChi1,ThanhPho)
CREATE TABLE Nhanvien(
	ID INT PRIMARY KEY IDENTITY,
	MaNV VARCHAR(10),
	Ho NVARCHAR(20),
	Ten NVARCHAR(20),
	TenDem NVARCHAR(20),
	GioiTinh NVARCHAR(10),
	Tuoi INT,
	Sdt1 VARCHAR(15),
	Sdt2 VARCHAR(15),
	NgaySinh DATETIME,
	DiaChi1 NVARCHAR(50),
	ThanhPho NVARCHAR(30),
);
--Sử dụng câu lệnh xóa cột sdt2 trong bảng NhanVien
ALTER TABLE NhanVien
	DROP COLUMN Sdt2; 
--Sử dụng câu lệnh thêm 1 cột có tên TinhTrangHĐ trpng bảng HoaDon
ALTER TABLE HoaDon
	ADD TinhTrangHD NVARCHAR(20);--Thêm cột
--Insert dữ liệu vào cho các bảng được nêu trên mỗi bảng có 10 bản ghi.
INSERT INTO KhachHang(Ho,Ten,TenDem,GioiTinh,Tuoi,Sdt1,Sdt2,NgaySinh,DiaChi1,DiaChi2,ThanhPho)
VALUES (N'Trần Văn',N'Thành',NULL,N'Nam','19','0385613085','0972908818','1/10/2002',N'Xóm 1 đặng sơn',N'Số 4A ngõ 116 Thị Trấn Phùng',N'HÀ Nội'),
	(N'Phạm Thị',N'Nga',NULL,N'Nữ','19','0385613085','0972908818','1/12/2002',N'Xóm 1 đặng sơn',N'Số 4A ngõ 116 Thị Trấn Phùng',N'HÀ Nội'),
	(N'Phạm Văn',N'Mạnh',NULL,N'Nam','19','0385613085','0972908818','1/10/2002',N'Xóm 1 đặng sơn',N'Số 4A ngõ 116 Thị Trấn Phùng',N'HÀ Nội'),
	(N'Viết Tiến',N'Vương',NULL,N'Nam','19','0385613085','0972908818','1/10/2002',N'Xóm 1 đặng sơn',N'Số 4A ngõ 116 Thị Trấn Phùng',N'HÀ Nội'),
	(N'Doãn Thanh',N'Tú',NULL,N'Nam','19','0385613085','0972908818','1/10/2002',N'Xóm 1 đặng sơn',N'Số 4A ngõ 116 Thị Trấn Phùng',N'HÀ Nội'),
	(N'Nguyễn Đức',N'Hải',NULL,N'Nam','19','0385613085','0972908818','1/10/2002',N'Xóm 1 đặng sơn',N'Số 4A ngõ 116 Thị Trấn Phùng',N'HÀ Nội'),
	(N'Nguyễn Thị',N'Hảo',N'Thái',N'Nữ','19','0385613085','0972908818','1/10/2002',N'Xóm 1 đặng sơn',N'Số 4A ngõ 116 Thị Trấn Phùng',N'HÀ Nội'),
	(N'Trần Văn',N'Phương',NULL,N'Nam','19','0385613085','0972908818','1/10/2002',N'Xóm 1 đặng sơn',N'Số 4A ngõ 116 Thị Trấn Phùng',N'HÀ Nội');
INSERT INTO HoaDon(MaHD,NgayTaoHoaDon,NgaySipHang)
VALUES ('HD01','2/2/2021','4/2/2021'),
	('HD02','2/2/2021','4/2/2021'),
	('HD03','2/2/2021','4/2/2021'),
	('HD04','2/2/2021','4/2/2021'),
	('HD05','2/2/2021','14/2/2021'),
	('HD06','2/2/2021','4/2/2021'),
	('HD07','2/2/2021','4/2/2021'),
	('HD08','2/2/2021','4/2/2021'),
	('HD09','2/2/2021','4/2/2021');
INSERT INTO HoaDonChiTiet(Indexx,SoLuong,DonGia)
VALUES ('01','02','23,4'),
	('01','02','21,4'),
	('01','02','23,4'),
	('01','02','23,4'),
	('01','02','20,4'),
	('01','02','29,4'),
	('01','02','26,4');
SELECT * FROM KhachHang;