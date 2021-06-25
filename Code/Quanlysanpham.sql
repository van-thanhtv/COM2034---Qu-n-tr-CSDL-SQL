--Đề QUẨN LÝ SẢN PHẨM
CREATE DATABASE Quanlysanpham ;
DROP TABLE MatHang;
CREATE TABLE MatHang(
	MaHang VARCHAR(10) PRIMARY KEY,
	TenHang NVARCHAR(50),
	DonGia DECIMAL(20,0),
);
DROP TABLE KhachHang;
CREATE TABLE KhachHang(
	MaKH VARCHAR(10) PRIMARY KEY,
	TenKH NVARCHAR(50),
	GioiTinh NVARCHAR(10),
	QueQuan NVARCHAR(30),
);
DROP TABLE HoaDon;
CREATE TABLE HoaDon(
	SoPhieu VARCHAR(10) PRIMARY KEY,
	NgayLap DATE,
	MaKH VARCHAR(10),
);
ALTER TABLE HoaDon
ADD FOREIGN KEY(MaKH) REFERENCES KhachHang(MaKH);
DROP TABLE CTHoaDon;
CREATE TABLE CTHoaDon(
	SoPhieu VARCHAR(10),
	MaHang VARCHAR(10),
	SoLuong INT,
	PRIMARY KEY (SoPhieu,MaHang),
	CONSTRAINT FK_1 FOREIGN KEY(SoPhieu) REFERENCES HoaDon(SoPhieu),
	CONSTRAINT FK_2 FOREIGN KEY(MaHang) REFERENCES MatHang(MaHang)
);
INSERT INTO KhachHang
VALUES ('K1',N'Trần Triệu Vi',N'Nữ',N'Hà Nội'),
	('K2',N'Trần Đình Phong',N'Nam',N'Thái Bình'),
	('K3',N'Minh Hà',N'Nữ',N'Sài Gòn');

INSERT INTO MatHang
VALUES ('M1',N'Dưỡng môi Ohui','200000'),
	('M2',N'Tinh chất Ohui','1000000'),
	('M3',N'Kem dưỡng Ohui','550000');
INSERT INTO HoaDon
VALUES ('P1','20190303','k1'),
	('P2','20190308','k2'),
	('P3','20190408','k3');
INSERT INTO CTHoaDon
VALUES ('P1','M1','2'),
	('P1','M2','3'),
	('P2','M2','1');
--B1: Đưa ra thông tin: Makh, Tenkh, Gioitinh của những khách hàng có Họ Nguyễn và Quequan là ‘Hà Nội’. 
SELECT MaKH,TenKH,GioiTinh
FROM KhachHang
WHERE TenKH LIKE N'Nguyễn%' AND QueQuan ='Hà Nội';
--BT2:b.	Đưa ra thông tin danh sách các khách hàng (Makh, Tenkh, tổng tiền) có tổng thành tiền của các hóa đơn từ 1.000.000 trở lên. Trong đó tổng tiền=số lượng*Đơn giá 

SELECT HoaDon.MaKH,TenKH,SoLuong*DonGia AS N'Tổng tiền'
FROM HoaDon
JOIN CTHoaDon ON CTHoaDon.SoPhieu = HoaDon.SoPhieu
JOIN KhachHang ON HoaDon.MaKH =KhachHang.MaKH
JOIN MatHang ON CTHoaDon.MaHang = MatHang.MaHang
WHERE SoLuong*DonGia >= 1000000;

--c.	Cho biết thông tin khách hàng chưa đặt đơn hàng nào. Thông tin gồm: Makh, Tenkh (1đ)
SELECT TenKH,MaKH
FROM KhachHang
WHERE MaKH NOT IN (SELECT MaKH FROM HoaDon);
--C
SELECT TenKH,KhachHang.MaKH
FROM KhachHang
Right JOIN HoaDon ON KhachHang.MaKH = HoaDon.MaKH
WHERE KhachHang.MaKH = NULL;

--d.	Liệt kê thông tin: Makh, Tenkh, Mahang, Tenhang, Dongia, Soluong của khách hàng có tên khách hàng là Trần Triệu Vy . (1đ)
SELECT HoaDon.MaKH,TenKH,CTHoaDon.MaHang,TenHang,DonGia,SoLuong
FROM HoaDon
JOIN CTHoaDon ON HoaDon.SoPhieu = CTHoaDon.SoPhieu 
JOIN KhachHang ON HoaDon.MaKH =KhachHang.MaKH
JOIN MatHang ON CTHoaDon.MaHang = MatHang.MaHang
WHERE TenKH = N'Trần Triệu Vi';
















--Câu 3:
--a.	Thêm một bản ghi mới vào chitiethoadon,dữ liệu phù hợp( không được nhập giá trị null). (1đ)
INSERT INTO CTHoaDon
VALUES ('P3','M3','4');
--b.	Thay đổi quê quán của khách hàng Minh Hà thành ‘Miền Tây’ (1đ)
UPDATE KhachHang
SET QueQuan=N'Miền Tây'
WHERE TenKH='Minh Hà';
--c.	 Xóa mặt hàng có tên hàng ‘Kem dưỡng Ohui’ (1đ)
DELETE FROM MatHang
WHERE TenHang = N'Kem dưỡng Ohui';