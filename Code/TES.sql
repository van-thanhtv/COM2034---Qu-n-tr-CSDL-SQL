-- đề 2
CREATE DATABASE TES;

CREATE TABLE NhanVien(
	MaNV VARCHAR(10) PRIMARY KEY,
	HoTen NVARCHAR(50),
	NgaySinh DATE,
	Luong FLOAT(10),
	GioiTinh NVARCHAR(10),
);

CREATE TABLE DuAn(
	MaDA VARCHAR(10) PRIMARY KEY,
	TenDa NVARCHAR(50),
	NamBatDau INT,
);
DROP TABLE ChamCong;
CREATE TABLE ChamCong(
	MaDA VARCHAR(10),
	MaNV VARCHAR(10),
	SoGio INT,
	PRIMARY KEY (MaDA,MaNV),
	CONSTRAINT FK_1 FOREIGN KEY (MaDA) REFERENCES DuAn(MaDA),
	CONSTRAINT FK_2 FOREIGN KEY (MaNV) REFERENCES NhanVien(MaNV),
);
INSERT INTO NhanVien
VALUES ('V01',N'trần văn tèo','19680301','9000000',N'nam'),
	('V02',N'lê huy','19880303','6000000',N'nam'),
	('V03',N'đặng thị hiếu','20010105','60000000',N'nữ');
INSERT INTO DuAn
VALUES ('DA1',N'phần mềm dạy online','2019'),
	('DA2',N'mạng toàn cầu','2020'),
	('DA3',N'quán lý sách','2021');
INSERT INTO ChamCong
VALUES ('DA1','V01','28'),
	('DA2','V02','200'),
	('DA3','V03','90');
SELECT ChamCong.MaDA,TenDa
FROM ChamCong
JOIN NhanVien ON ChamCong.MaNV = NhanVien.MaNV
JOIN DuAn ON ChamCong.MaDA = DuAn.MaDA
WHERE NhanVien.HoTen = 'Lê huy';
SELECT ChamCong.MaNV,MAX(SUM(SoGio)) AS 'Tổng số giờ',HoTen
FROM ChamCong
JOIN NhanVien ON ChamCong.MaNV = NhanVien.MaNV
GROUP BY ChamCong.MaNV,HoTen;
SELECT  TOP 2  MaNV,HoTen,Luong FROM NhanVien
JOIN ChamCong ON NhanVien.MaNV = ChamCong
WHERE ;



INSERT INTO ChamCong
VALUES ('DA2','V03','208');
