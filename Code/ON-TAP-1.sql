/*Phần 1 :Cho cơ sở dữ liệu “Quản lý dự án“ gồm các quan hệ sau:
DuAn (MaDA, TenDA, DiaDiem)
NhanVien(MaNV, HoTen, NgaySinh, QueQuan, SDT, HeSoLuong)
NV_DA(MaNV, MaDA,NgayThamGia, NgayKetThuc)
1) Viết lệnh SQL thực hiện tạo Database + Table (ràng buộc về khóa chính, khóa ngoại )
2) Nhập dữ liệu cho các Table ít nhất 5 dòng dữ liệu.*/


DROP DATABASE FPOLY_ONTAP_1;
CREATE DATABASE FPOLY_ONTAP_1;
USE FPOLY_ONTAP_1;


DROP TABLE IF EXISTS DuAn;
CREATE TABLE DuAn(
  ID INT PRIMARY KEY IDENTITY,
  MaDA VARCHAR(10),
  TenDA NVARCHAR(100) DEFAULT NULL,
  DiaDiem NVARCHAR(100) DEFAULT NULL
);


DROP TABLE IF EXISTS NhanVien;
CREATE TABLE NhanVien(
  ID INT PRIMARY KEY IDENTITY,
  MaNV VARCHAR(10) DEFAULT NULL, 
  HoTen NVARCHAR(50) DEFAULT NULL, 
  NgaySinh DATE DEFAULT NULL, 
  QueQuan NVARCHAR(100) DEFAULT NULL, 
  SDT VARCHAR(20) DEFAULT NULL, 
  HeSoLuong INT DEFAULT 0
);


DROP TABLE IF EXISTS NV_DA;
CREATE TABLE NV_DA(
  IDNhanVien INT DEFAULT 0,
  IDDuAn INT DEFAULT 0,
  MaNV VARCHAR(10) DEFAULT NULL,
  MaDA VARCHAR(10) DEFAULT NULL,
  NgayThamGia DATE DEFAULT NULL,
  NgayKetThuc DATE DEFAULT NULL,
  PRIMARY KEY (IDNhanVien,IDDuAn),
  CONSTRAINT FK1 FOREIGN KEY (IDNhanVien) REFERENCES NhanVien(ID),
  CONSTRAINT FK2 FOREIGN KEY (IDDuAn) REFERENCES DuAn(ID)
);


DELETE FROM DuAn
DBCC CHECKIDENT(DuAn, RESEED, 0);
INSERT INTO DuAn(MaDA,TenDA,DiaDiem)
VALUES ('DA01',N'Du hành thời gian',N'Hà Nội'),
('DA02',N'Phá hủy mặt trăng',N'Hồ Chí Minh'),
('DA03',N'Đóng băng thời gian',N'Hải Dương'),
('DA04',N'Chế tạo máy bay tàng hình',N'Đà Nẵng'),
('DA05',N'Chế tạo máy bay phản lưc',N'Đà Nẵng');


DELETE FROM NhanVien
DBCC CHECKIDENT(NhanVien, RESEED, 0);
INSERT INTO NhanVien(MaNV, HoTen, NgaySinh, QueQuan, SDT, HeSoLuong)
VALUES ('NV001',N'Hoàng Hải','2002-11-30',N'Hải Dương','0868833489',1),
('NV002',N'Đức Cường','1990-10-23',N'Hà Nội','0234567897',2),
('NV003',N'Hoài Nam','1995-12-09',N'Hà Nội','02446786578',3),
('NV004',N'Tiến Dũng','1997-09-25',N'Hà Nội','0657864535',4),
('NV005',N'Tấn Thành','1996-11-25',N'Hà Nội','0457864533',5);


DELETE FROM NV_DA
DBCC CHECKIDENT(NV_DA,RESEED,0);
INSERT INTO NV_DA(IDNhanVien, IDDuAn, MaNV, MaDA, NgayThamGia, NgayKetThuc)
VALUES('1','1','NV001','DA01','2021-02-03','2021-05-06'),
('2','2','NV002','DA02','2021-02-03','2021-05-06'),
('3','1','NV003','DA01','2021-02-03','2021-05-06'),
('2','3','NV002','DA03','2021-02-03','2021-05-06'),
('1','5','NV001','DA05','2021-02-03','2021-05-06');



/*Phần 2. Thực hiện câu truy vấn sau
Câu 1. In danh sách mã nhân viên, họ tên, ngày sinh của nhân viên sinh năm 1990
Câu 2. Tìm thông tin nhân viên đã tham gia dự án có mã “DA01” , “DA02”
Câu 3. Thống kê số dự án đã tham gia của từng nhân viên, kể cả những nhân viên chưa tham gia dự án nào (Đưa ra thông tin: Tên nhân viên, số dự án tham gia)
Câu 4. Đưa ra thông tin dự án chưa có nhân viên nào tham gia?
Câu 5. Đưa ra họ tên, quê quán, hệ số lương, lương thực lĩnh của tất cả các nhân viên (biết Lương thực lĩnh=hệ số lương * 900+ 1000) và sắp xếp theo lương thực lĩnh giảm dần.
Câu 6. Sửa tên của nhân viên có mã “NV001” thành “Nguyễn Lan Hương"*/

--CÂU 1:--

SELECT MaNV, HoTen, NgaySinh
FROM NhanVien
WHERE NgaySinh LIKE '1990%';


--CÂU 2:--

SELECT NV_DA.MaNV,NgaySinh,HoTen,QueQuan,SDT,HeSoLuong
FROM NV_DA
JOIN NhanVien ON NhanVien.ID=NV_DA.IDNhanVien
WHERE MaDA = 'DA01' OR MaDA = 'DA02';


--Câu 3. Thống kê số dự án đã tham gia của từng nhân viên, kể cả những nhân viên chưa tham gia dự án nào (Đưa ra thông tin: Tên nhân viên, số dự án tham gia)

SELECT HoTen, COUNT(NV_DA.MaDA) as N'Số dự án tham gia'
FROM NV_DA
RIGHT JOIN NhanVien  ON NV_DA.IDNhanVien = NhanVien.ID
GROUP BY NhanVien.HoTen;


--Câu 4. Đưa ra thông tin dự án chưa có nhân viên nào tham gia?
SELECT MaDA,TenDA,DiaDiem
FROM DuAn
WHERE DuAn.MaDA NOT IN(SELECT MaDA FROM NV_DA);


--Câu 5. Đưa ra họ tên, quê quán, hệ số lương, lương thực lĩnh của tất cả các nhân viên (biết Lương thực lĩnh=hệ số lương * 900+ 1000) và sắp xếp theo lương thực lĩnh giảm dần.

SELECT HoTen,QueQuan,HeSoLuong,(HeSoLuong*900)+100 AS N'Lương thực'
FROM NhanVien
ORDER BY HeSoLuong DESC;
--Câu 6. Sửa tên của nhân viên có mã “NV001” thành “Nguyễn Lan Hương"
UPDATE NhanVien
SET HoTen = N'Nguyễn Lan Hương'
WHERE MaNV = 'NV001';
