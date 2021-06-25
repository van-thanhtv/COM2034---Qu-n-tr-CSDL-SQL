CREATE DATABASE LAP1
GO
USE LAP1
GO
/*
Sinhvien(MASV, HOTENSV,GIOITINH, NGAYSINH, QUEQUAN, MALOP)
Lop(MALOP,TENLOP,MAKHOA)
Khoa(MAKHOA,TENKHOA)
Monhoc(MAMH,TENMH,DONVIHT)

Giangvien(MAGV,HOTENGV,HOCVI,CHUYENNGANH,NGAYSINH,QUEQUAN,GIOITINH,MAKHOA)
Ketqua(MASV, MAMH, LANTHI,DIEMTHI)
Phancong(MALOP,MAMH,MAGV)
*/
--Khoa(MAKHOA,TENKHOA)
CREATE TABLE Khoa(
MaKhoa VARCHAR(10) PRIMARY KEY,
TenKhoa NVARCHAR(50),
);

--Lop(MALOP,TENLOP,MAKHOA)
CREATE TABLE Lop(
MaLop VARCHAR(10) PRIMARY KEY,
TenLop NVARCHAR(50),
MaKhoa VARCHAR(10),
CONSTRAINT FK_1 FOREIGN KEY(MaKhoa) REFERENCES Khoa(MaKhoa)
);
--Sinhvien(MASV, HOTENSV,GIOITINH, NGAYSINH, QUEQUAN, MALOP)
CREATE TABLE SinhVien(
MaSV VARCHAR(10) PRIMARY KEY,
HoTenSV NVARCHAR(50),
GioiTinh NVARCHAR(5),
NgaySinh DATE,
QueQuan NVARCHAR(50),
MaLop VARCHAR(10),
CONSTRAINT FK_2 FOREIGN KEY(MaLop) REFERENCES Lop(MaLop),
);
--Monhoc(MAMH,TENMH,DONVIHT)
CREATE TABLE Monhoc(
MaMH VARCHAR(10) PRIMARY KEY,
TenMH NVARCHAR(50),
DonViHT FLOAT,
);
--Giangvien(MAGV,HOTENGV,HOCVI,CHUYENNGANH,NGAYSINH,QUEQUAN,GIOITINH,MAKHOA)
CREATE TABLE Giangvien(
MaGV VARCHAR(10) PRIMARY KEY,
HoTenGV NVARCHAR(50),
HocVI NVARCHAR(50),
ChuenNganh NVARCHAR(50),
NgaySinh DATE,
QueQuan NVARCHAR(50),
GioiTinh NVARCHAR(5),
MaKhoa VARCHAR(10),
CONSTRAINT FK_3 FOREIGN KEY(MaKhoa) REFERENCES Khoa(MaKhoa),
);
--Ketqua(MASV, MAMH, LANTHI,DIEMTHI)
CREATE TABLE Ketqua(
MaSV VARCHAR(10),
MaMH VARCHAR(10),
LanThi INT,
DiemThi FLOAT,
CONSTRAINT FK_4 FOREIGN KEY(MaSV) REFERENCES SinhVien(MaSV),
CONSTRAINT FK_5 FOREIGN KEY(MaMH) REFERENCES MonHoc(MaMH),
);
--Phancong(MALOP,MAMH,MAGV)
CREATE TABLE Phancong(
MaLop VARCHAR(10),
MaMH VARCHAR(10),
MaGV VARCHAR(10),
CONSTRAINT FK_6 FOREIGN KEY(MaLop) REFERENCES Lop(MaLop),
CONSTRAINT FK_7 FOREIGN KEY(MaMH) REFERENCES MonHoc(MaMH),
CONSTRAINT FK_8 FOREIGN KEY(MaGV) REFERENCES Giangvien(MaGV),
);
INSERT INTO Lop VALUES('PT13301',N'Ứng dụng phần mềm 1','K1'),
						('PT13302',N'Ứng dụng phần mềm 2','K3'),
						('PT13303','Ứng dụng phần mềm 3','K1'),
						('PT13304',N'Ứng dụng phần mềm 4','K5'),
						('PT13305',N'Ứng dụng phần mềm 5','K3');
INSERT INTO Khoa VALUES('K1',N'Khoa thứ 1'),
						('K2',N'Khoa thứ 2'),
						('K3',N'Khoa thứ 3'),
						('K4',N'Khoa thứ 4'),
						('K5',N'Khoa thứ 5');
INSERT INTO SinhVien VALUES('ph06230',N'Trần Lê Huy',N'Nam','1/1/2008',N'Hà Nội','PT13302'),
							('ph06231',N'Nguyễn Thị Mỹ Duyên',N'Nữ','7/16/2009',N'Hà Nội','PT13302'),
							('ph06232',N'Võ Tá Nhật Anh',N'Nam','1/1/2008',N'Hà Tĩnh','PT13302'),
							('ph06233',N'Trần Thị Thùy Trang',N'Nữ','1/1/2008',N'Hải Phòng','PT13302'),
							('ph06234',N'Nguyễn Thị Mừng',N'Nữ','1/1/2008',N'Hà Nội','PT13305'),
							('ph06235',N'Nguyễn Xuân Trường',N'Nam','1/1/2008',N'Hà Nội','PT13305');
--Monhoc(MAMH,TENMH,DONVIHT)
INSERT INTO Monhoc VALUES('mob1013',N'lập trình java1',6),
							('mob1022',N'lập trình java2',5),
							('sof203',N'lập trình java3',4),
							('com2012',N'Cơ sở dữ liệu',4),
							('com2032',N'Hệ quản trị CSDL',2);
--Giangvien(MAGV,HOTENGV,HOCVI,CHUYENNGANH,NGAYSINH,QUEQUAN,GIOITINH,MAKHOA)
INSERT INTO Giangvien VALUES('PT01',N'Trần văn thành',N'Giáo sư',N'Ứng dụng phềm','10/1/2002',N'Nghệ An',N'Nam','k1'),
('PT02',N'Trần văn Phương',N'Giáo sư',N'Ứng dụng phềm','10/1/2002',N'Hà Nội',N'Nam','k1'),
('PT03',N'lê thị ánh',N'Tiến sĩ',N'Ứng dụng phềm','10/4/2008',N'Hà Nội',N'Nữ','k2'),
('PT04',N'Trần thị vi',N'Thạc sĩ',N'Ứng dụng phềm','10/1/2002',N'Hải Phòng',N'Nữ','k2'),
('PT05',N'Hoàng đức mạnh',N'Sư phạm',N'Ứng dụng phềm','10/1/2002',N'Hải Phòng',N'Nam','k5');
--Ketqua(MASV, MAMH, LANTHI,DIEMTHI)
INSERT INTO Ketqua VALUES('ph06230','mob1022',1,9),
('ph06231','sof203',1,9),
('ph06232','com2012',2,7),
('ph06232','com2012',2,9),
('ph06233','mob1022',1,9),
('ph06234','com2032',1,6);
--Phancong(MALOP,MAMH,MAGV)
INSERT INTO Phancong VALUES('PT13301','com2032','PT01'),
('PT13302','com2032','PT01'),
('PT13302','mob1022','PT02'),
('PT13303','com2012','PT03'),
('PT13304','sof203','PT04');
--1. Xóa thông tin kết quả học tập của sv có mã HuyNVph07543
DELETE FROM Ketqua
WHERE MaSV='HuyNVph07543';
--2. Cập nhật thông tin của sv có mã HuyNVph07543: quê quán thành Hà nội, giớitình:nam
UPDATE SinhVien
SET QueQuan=N'Hà Nội',GioiTinh=N'Nam'
WHERE MaSV='HuyNVph07543';
--3. Cập nhật lại môn học Tin Văn Phòng thành Cơ sở dữ liệu
UPDATE Monhoc
SET TenMH=N'Cơ sở dữ liệu'
WHERE TenMH=N'Tin Văn Phòng';
--4. Sửa số đơn vị học trình của môn &quot;tin học văn phòng&quot; thành 6
UPDATE Monhoc
SET DonViHT=6
WHERE TenMH=N'tin học văn phòng';
--5. Sửa sinh viên &#39;Nguyen Thu Trang’ thành &#39;Nguyen Thanh Son&#39; va giới tình thành&#39;Nam&#39;
UPDATE SinhVien
SET HoTenSV = N'Nguyen Thanh Son',GioiTinh=N'Nam'
WHERE HoTenSV= N'Nguyen Thu Trang';
--6. Chuyển sinh viên &#39;Le Thi Lan Anh&#39; sang lớp Pt14353MoB
UPDATE SinhVien
SET MaLop='Pt14353MoB'
WHERE HoTenSV=N'Le Thi Lan Anh';
--7. Cho biết kết quả học tập của sinh viên s001
SELECT * FROM Ketqua WHERE MaSV='ph06231';
--8. Liệt kê những sinh viên sinh viên ngày 3 tháng 7(dùng hàm day() và hàm month() )
DECLARE @Cau8 TABLE (HOTENSV NVARCHAR(50), NGAYSINH DATE)
INSERT INTO @Cau8
SELECT HoTenSV,NgaySinh
FROM SinhVien
WHERE DAY(NgaySinh)='3' AND MONTH(NgaySinh)='07'
--
SELECT * FROM @Cau8
--9. Cho biết danh sách sinh viên có họ nguyễn và tuổi &gt;18
SELECT HoTenSV,YEAR(GETDATE())-YEAR(NgaySinh) AS Tuổi
FROM SinhVien
WHERE YEAR(GETDATE())-YEAR(NgaySinh) = 18 AND HoTenSV LIKE N'Nguyễn%';

--10. Cho biết kết quả học tập gồm: Hoten, MAMH, LANTHI, DIEM cua sinhvien S007
SELECT HoTenSV,K.MaMH,LanThi,DiemThi
FROM Ketqua K
JOIN SinhVien S ON S.MaSV=K.MaSV
JOIN Monhoc M ON M.MaMH = K.MaMH
WHERE K.MaSV='S007';
--11. Cho biết kết quả học tập gồm: Hoten, MAMH, LANTHI, DIEM cua sinhvien S007
SELECT HoTenSV,K.MaMH,LanThi,DiemThi
FROM Ketqua K
JOIN SinhVien S ON S.MaSV=K.MaSV
JOIN Monhoc M ON M.MaMH = K.MaMH
WHERE K.MaSV='S007';
--12. Cho biết danh sách sinh viên nam khoa &#39;Cong Nghe Thong Tin&#39; sắp xếp giảm dần theo tên
SELECT HoTenSV
FROM SinhVien S
JOIN Lop L ON L.MaLop = S.MaLop
JOIN Khoa K ON K.MaKhoa = L.MaKhoa
WHERE K.TenKhoa = N'Cong Nghe Thong Tin' AND GioiTinh = N'Nam'
ORDER BY HoTenSV DESC;
--13. Cho biết danh sách các môn học có số đơn vị học trình trên 4 và có tên bắt đầu bằng C
SELECT TenMH,DonViHT
FROM Monhoc
WHERE DonViHT>4 AND TenMH LIKE N'C%';
--14. Liet ke nhung sinh vien tu 22 tuoi tro len khoa &#39;Cong Nghe Thong Tin&#39; va khoa &#39;Dien Tu Vien Thong&#39;
SELECT HoTenSV,YEAR(GETDATE())-YEAR(NgaySinh) AS Tuổi
FROM SinhVien S
JOIN Lop L ON L.MaLop = S.MaLop
JOIN Khoa K ON K.MaKhoa = L.MaKhoa
WHERE YEAR(GETDATE())-YEAR(NgaySinh) >= 22 AND TenKhoa IN (N'Cong Nghe Thong Tin',N'Dien Tu Vien Thong');
--15. Cho biết thông tin những lớp chưa có sinh viên
SELECT * FROM Lop
WHERE MaLop NOT IN (SELECT MaLop FROM SinhVien);
--16. Cho biết danh sách sinh viên chưa học môn nào, thông tin gồm hoten, Ngay sinh,Ten khoa
SELECT HoTenSV,NgaySinh,TenKhoa
FROM Ketqua Q
JOIN SinhVien S ON S.MaSV = Q.MaSV
JOIN Lop L ON L.MaLop = S.MaLop
JOIN Khoa K ON K.MaKhoa = L.MaLop
WHERE S.MaSV NOT IN (SELECT MaSV FROM Ketqua);
--17. Cho biết danh sách những sinh viên đã học môn có mã com107 sắp xếp giảm dần theo họ tên. Thông tin hiển thị gồm MASV,HOSV,TENSV,NGAYSINH,ten KHOA
SELECT S.MaSV,HoTenSV,NgaySinh,TenKhoa
FROM SinhVien S
JOIN Lop L ON L.MaLop = S.MaLop
JOIN Khoa K ON K.MaKhoa = L.MaKhoa
JOIN Ketqua Q ON Q.MaSV = S.MaSV
WHERE MaMH = N'com107'
ORDER BY HoTenSV DESC;
--18. Đưa ra thông tin: malop,tenlop, so luong sinh vien của mỗi lớp
SELECT S.MaLop,TenLop,COUNT(MaSV) AS SL
FROM SinhVien S
JOIN Lop L ON L.MaLop = S.MaLop
GROUP BY S.MaLop,TenLop;
--19. Đưa ra thông tin: malop, tenlop, so luong sinh vien của lớp có số lượng &gt;20
SELECT S.MaLop,TenLop,COUNT(MaSV) AS SL
FROM SinhVien S
JOIN Lop L ON L.MaLop = S.MaLop
GROUP BY S.MaLop,TenLop
HAVING COUNT(MaSV) >20;
--20. Cho biết tên lớp có số lượng sinh viên lớn nhất
SELECT S.MaLop,TenLop,COUNT(MaSV) AS SL
FROM Lop L
JOIN SinhVien S ON L.MaLop = S.MaLop
GROUP BY S.MaLop,TenLop
HAVING  COUNT(MaSV) >= ALL(SELECT COUNT(MaSV) FROM SinhVien GROUP BY MaLop);
--21. Cho biết môn học nào chưa có sinh viên học
SELECT * FROM MonHoc
WHERE MaMH NOT IN (SELECT MaMH FROM Ketqua);
/*
1. Xóa thông tin kết quả học tập của sv có mã HuyNVph07543
2. Cập nhật thông tin của sv có mã HuyNVph07543: quê quán thành Hà nội, giới
tình:nam
3. Cập nhật lại môn học Tin Văn Phòng thành Cơ sở dữ liệu
4. Sửa số đơn vị học trình của môn &quot;tin học văn phòng&quot; thành 6
5. Sửa sinh viên &#39;Nguyen Thu Trang’ thành &#39;Nguyen Thanh Son&#39; va giới tình thành&#39;Nam&#39;
6. Chuyển sinh viên &#39;Le Thi Lan Anh&#39; sang lớp Pt14353MoB
7. Cho biết kết quả học tập của sinh viên s001
8. Liệt kê những sinh viên sinh viên ngày 3 tháng 7(dùng hàm day() và hàm month() )
9. Cho biết danh sách sinh viên có họ nguyễn và tuổi &gt;18
10. Cho biết kết quả học tập gồm: Hoten, MAMH, LANTHI, DIEM cua sinhvien S007
11. Cho biết kết quả học tập gồm: Hoten, TENMH, LANTHI, DIEM cua sinh vien
S007
12. Cho biết danh sách sinh viên nam khoa &#39;Cong Nghe Thong Tin&#39; sắp xếp giảm dần
theo tên
13. Cho biết danh sách các môn học có số đơn vị học trình trên 4 và có tên bắt đầu
bằng C
14. Liet ke nhung sinh vien tu 22 tuoi tro len khoa &#39;Cong Nghe Thong Tin&#39; va khoa
&#39;Dien Tu Vien Thong&#39;
15. Cho biết thông tin những lớp chưa có sinh viên
16. Cho biết danh sách sinh viên chưa học môn nào, thông tin gồm hoten, Ngay sinh,
Ten khoa
17. Cho biết danh sách những sinh viên đã học môn có mã com107 sắp xếp giảm dần
theo họ tên. Thông tin hiển thị gồm MASV,HOSV,TENSV,NGAYSINH,ten
KHOA
18. Đưa ra thông tin: malop,tenlop, so luong sinh vien của mỗi lớp
19. Đưa ra thông tin: malop, tenlop, so luong sinh vien của lớp có số lượng &gt;20
20. Cho biết tên lớp có số lượng sinh viên lớn nhất
21. Cho biết môn học nào chưa có sinh viên học
*/