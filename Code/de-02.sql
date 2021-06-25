CREATE DATABASE DE_03;

CREATE TABLE VanPhong(
	MaVP VARCHAR(10) PRIMARY KEY,
	TenVP NVARCHAR(50),
);

CREATE TABLE NhanVien(
	MaNV VARCHAR(10) PRIMARY KEY,
	HoTen NVARCHAR(50),
	NgaySinh DATE,
	GioiTinh NVARCHAR(10),
	MaVP VARCHAR(10),
	Email VARCHAR(50),
	SoDT INT,
);
ALTER TABLE NhanVien
ADD FOREIGN KEY (MaVP) REFERENCES VanPhong(MaVP);
CREATE TABLE NhanThan(
	MaNT VARCHAR(10) PRIMARY KEY,
	HoTenTN NVARCHAR(50),
	NgaySinh DATE,
	MoiLH NVARCHAR(50),
	MaNV VARCHAR(10),
);
ALTER TABLE NhanThan
ADD FOREIGN KEY (MaNV) REFERENCES NhanVien(MaNV);

INSERT INTO VanPhong
VALUES ('HC',N'Hành chính'),
	('CTSV',N'Công tác sinh viên');

INSERT INTO NhanVien
VALUES ('NV1',N'Nguyễn Anh Tuấn','19891112',N'Nam','HC','tuanna5@fpt.edu.vn','0988554303'),
	('NV2',N'Trần Thanh Tùng','19880102',N'Nam','CTSV','tungtt2@fpt.edu.vn','0987792457'),
	('NV3',N'Trần Văn Thành','20021112',N'Nam','HC','thanhtv5@fpt.edu.vn','0988554363');
INSERT INTO NhanThan
VALUES ('TN01',N'Ngyễn Ngọc Anh','19621207',N'Người thân','NV2'),
	('TN02',N'Trần Tuấn Tú','19700606',N'Người quen','NV2');

SELECT MaNV,HoTen,MaVP
FROM NhanVien
WHERE NgaySinh LIKE '_____08%';

SELECT MaNV,HoTen,MaVP,DATEDIFF(YEAR,NgaySinh,'20210201') AS N'TUOI'
FROM NhanVien
WHERE DATEDIFF(YEAR,NgaySinh,'20210201') > 19;

SELECT MaNV,HoTen,NgaySinh,TenVP,GioiTinh,Email,SoDT
FROM NhanVien
JOIN VanPhong ON NhanVien.MaVP = VanPhong.MaVP
WHERE HoTen LIKE N'Trần%';

SELECT 
*FROM NhanVien WHERE MaNV NOT IN (SELECT MaNV FROM NhanThan);

INSERT INTO VanPhong
VALUES ('PH',N'Hành chính 2');

UPDATE NhanVien
SET SoDT='098779244'
WHERE MaNV = 'NV2';

DELETE FROM NhanThan
WHERE MoiLH = N'Người quen';
