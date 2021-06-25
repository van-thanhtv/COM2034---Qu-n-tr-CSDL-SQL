--Database: QLLICHDAY	
use master
go
--
if exists (select * from sysdatabases where name=N'quanlylichday')
drop database quanlylichday
go
--
create database quanlylichday
--on
--(name='quanlylichday',
--filename='D:\FPT POLYTECHNIC\COM2034\BAITAP\LAB2\quanlylichday.mdf',
--size=5MB,
--maxsize=10MB,
--filegrowth=1MB
--)
--log on
--(
--name='quanlylichday_log',
--filename='D:\FPT POLYTECHNIC\COM2034\BAITAP\LAB2\quanlylichday.ldf',
--size=5MB,
--maxsize=10MB,
--filegrowth=1MB
--)
go
--mở
use quanlylichday
go
--Khoa(MAKHOA,TENKHOA)
create table khoa
(makhoa nvarchar(10) primary key,
tenkhoa nvarchar(100)
)

insert into khoa values (N'K1',N'Công nghệ thông tin')
insert into khoa values (N'K2',N'Ngoại ngữ')
insert into khoa values (N'K3',N'Cơ bản')

--Lop(MALOP,TENLOP,MAKHOA)
create table lop
(malop nvarchar(10) primary key ,
tenlop nvarchar(100),
makhoa nvarchar(10) foreign key references khoa(makhoa)
)

insert into lop values (N'L1',N'Ứng dụng 1',N'K1')
insert into lop values (N'L2',N'Ứng dụng 2',N'K1')
insert into lop values (N'L3',N'Ngoại ngữ',N'K2')
insert into lop values (N'L4',N'Tin học',N'K3')
--Sinhvien(MASV, HOTENSV,GIOITINH, NGAYSINH, QUEQUAN, MALOP)
create table sinhvien
(
masv nvarchar(10) primary key,
hotensv nvarchar(100),
gioitinh nvarchar(5),
ngaysinh date,
quequan nvarchar(200),
malop nvarchar(10) foreign key references lop(malop)
)
insert into sinhvien values (N's001',N'Nguyễn Thu Trang',N'Nữ','4/3/2000',N'Hà Nội',N'L1')
insert into sinhvien values (N's002',N'Lê Quang Thắng',N'Nam','9/3/1999',N'Hà Nội',N'L2')
insert into sinhvien values (N's003',N'Trần Bảo Nam',N'Nam','1/3/1999',N'Hà Nội',N'L1')
insert into sinhvien values (N's004',N'Nguyễn Thu Trang',N'Nữ','4/3/1990',N'Hà Nội',N'L3')
--Monhoc(MAMH,TENMH,DONVIHT)
create table monhoc
(
mamh nvarchar(10) primary key,
tenmh nvarchar(100),
donviht int
)
insert into monhoc values(N'csdl',N'Cơ sở dữ liệu',4)
insert into monhoc values(N'com2034',N'Hệ quản trị csdl',5)
insert into monhoc values(N'com107',N'tin học văn phòng',3)
insert into monhoc values(N'mob1014',N'Lập trình java1',4)
--Giangvien(MAGV,HOTENGV,HOCVI,CHUYENNGANH,NGAYSINH,QUEQUAN,GIOITINH,MAKHOA)
create table giangvien
(
magv nvarchar(10) primary key,
hotengv nvarchar(100),
hocvi nvarchar(50),
chuyennganh nvarchar(100),
ngaysinh date,
quequan nvarchar(200),
gioitinh nvarchar(5),
makhoa nvarchar(10) foreign key references khoa(makhoa)
)
insert into giangvien values (N'gv1',N'Đào Thị Lệ Thủy',N'Tiến sĩ',N'Khoa học máy tính','5/5/1976',N'Hà Nội',N'Nữ',N'K1')
insert into giangvien values (N'gv2',N'Trần Thị Huệ',N'Thạc sỹ',N'Khoa học máy tính','08/08/1989',N'Hà Tĩnh',N'Nữ',N'K1')
insert into giangvien values (N'gv3',N'Phạm Quang Hùng',N'Cử nhân',N'ngoại ngữ','2/5/1980',N'Hà Nội',N'Nam',N'K2')
insert into giangvien values (N'gv4',N'Lê Quang Tèo',N'Cử nhân',N'ngoại ngữ','8/7/1979',N'Hà Nội',N'Nam',N'K2')
--Ketqua(MASV, MAMH, LANTHI,DIEMTHI)
create table ketqua
(masv nvarchar(10) foreign key references sinhvien(masv),
mamh nvarchar(10) foreign key references monhoc(mamh),
lanthi int,
diemthi float,
constraint kc primary key(masv,mamh,lanthi)
)
insert into ketqua values (N's001',N'com107',1,4)
insert into ketqua values (N's001',N'com107',2,6.5)
insert into ketqua values (N's002',N'com107',1,9)
insert into ketqua values (N's003',N'com107',1,8.5)
insert into ketqua values (N's001',N'mob1014',1,7)
insert into ketqua values (N's002',N'mob1014',1,5.5)
insert into ketqua values (N's003',N'mob1014',1,8)
--Phancong(MALOP,MAMH,MAGV)
create table phancong
(malop nvarchar(10) foreign key references lop(malop),
mamh nvarchar(10) foreign key references monhoc(mamh),
magv nvarchar(10) foreign key references giangvien(magv),
constraint kc1 primary key(malop,mamh,magv)
)
insert into phancong values (N'L1',N'com107',N'gv1')
insert into phancong values (N'L1',N'mob1014',N'gv2')
insert into phancong values (N'L1',N'com2034',N'gv3')
insert into phancong values (N'L2',N'com107',N'gv1')
insert into phancong values (N'L2',N'mob1014',N'gv1')
--2.	Cho biet ket qua hoc tap cua sinh vien co ma S007
select * from ketqua where masv='s007'
--3.	Liet ke nhung sinh vien sinh vao ngay 03 thang 07
--(dùng hàm day() và hàm month() )
select * from sinhvien
where day(ngaysinh)=03 and month(ngaysinh)=07
--4.	 Cho biet danh sach sinh vien ma ho co chua chu Anh
select * from sinhvien
where hotensv like N'%Anh%'
--5.	Cho biet ket qua hoc tap gom: Hoten, MAMH, LANTHI, DIEM cua sinhvien S007
select hotensv,mamh,lanthi,diemthi
from sinhvien s inner join ketqua k on s.masv=k.masv
where s.masv='s007'
--6.	 Cho biet ket qua hoc tap gom: Hoten, TENMH, LANTHI, DIEM cua sinh vien S007
select hotensv,tenmh,lanthi,diemthi
from sinhvien s inner join ketqua k on k.masv=s.masv 
     inner join monhoc m on m.mamh=k.mamh
where s.masv='s007'
--7.	Cho biet danh sach sinh vien Nam khoa 'Cong Nghe Thong Tin' sap tang dan theo ten
select s.masv,hotensv, gioitinh,quequan
from sinhvien s inner join lop l on l.malop=s.malop
     inner join khoa k on k.makhoa=l.makhoa
where tenkhoa=N'Công nghệ thông tin' and gioitinh='nam'
order by hotensv asc
--2.	Cho biet ket qua hoc tap cua sinh vien co ma S007
select * from ketqua where masv='s007'
--3.	Liet ke nhung sinh vien sinh vao ngay 03 thang 07
--(dùng hàm day() và hàm month() )
select * from sinhvien where day(ngaysinh)='03' and month(ngaysinh)='07'
--4.	 Cho biet danh sach sinh vien ma ho co chua chu Anh
select * from sinhvien
where hotensv like '%Anh%'
--5.	Cho biet ket qua hoc tap gom: Hoten, MAMH, LANTHI, DIEM cua sinhvien S007
select hotensv,mamh,lanthi,diemthi
from sinhvien s inner join ketqua k on k.masv=s.masv
where k.masv='s007'
--6.	 Cho biet ket qua hoc tap gom: Hoten, TENMH, LANTHI, DIEM cua sinh vien S007
select hotensv,tenmh,lanthi,diemthi
from sinhvien s inner join ketqua k on k.masv=s.masv inner join monhoc m on m.mamh=k.mamh
where k.masv='s007'
--7.	Cho biet danh sach sinh vien Nam khoa 'Cong Nghe Thong Tin' sap tang dan theo ten

--8.	Cho biet danh sach cac mon hoc tren 4 trình va co ten bat dau bang chu T
select * from monhoc
where donviht>4 and tenmh like 'T%'
--liet ke nhung sinh vien tu 22 tuoi tro len khoa 'Cong Nghe Thong Tin' va khoa 'Dien Tu Vien Thong'
select masv,hotensv,quequan 
from sinhvien s inner join lop l on s.malop=l.malop inner join khoa k on k.makhoa=l.makhoa
where year(getdate())-year(ngaysinh) >=22 and tenkhoa in (N'Công nghệ thông tin','Điện tử viễn thông')
--10.	Cho biet ten lop nao khong co Sinh Vien
select * from lop
where malop not in(select malop from sinhvien)
--11.	 Cho biet danh sach sinh vien sinh vien chua hoc mon nao, thong tin gom Ho, Ten, Ngay sinh, Ten khoa
--12.	Cho biet danh sach nhung sinh vien da hoc mon co ma AV, sap giam dan theo ngay sinh. Thong tin hien thi gom MASV,HOSV,TENSV,NGAYSINH,ten KHOA
--13.	Cho biet ten sinh vien duoc diem cao nhat
--14.	Cho biet sinh vien nao rot mon CSDL o lan thi thu nhat
--15.	 Cho biet sinh vien nao rot mon CSDL o lan thi thu nhat ma chua thi lai lan 2
--16.	 Dem so luong sinh vien cua khoa 'Quan Tri Kinh Doanh'
--17.	Dem so luong sinh vien cua tung lop
--18.	Cho biet ten lop co dong sinh vien nhat
--19.	 Cho biet diem thap nhat cua moi mon hoc
--20.	Cho biet ten mon hoc nao chua co sinh vien hoc
--21.	Cho biet diem trung binh lan thi thu nhat cua sinh vien S004




--LAP 2
--1.	Cho biết danh sách sinh viên có điểm thi lớn nhất môn mob1014
DECLARE @Max_Diem float
SELECT @Max_Diem=MAX(diemthi)
FROM ketqua
WHERE mamh = N'mob1014'
PRINT 'Điểm max :' + CONVERT (CHAR (15),@Max_Diem)
GO
--2.	Cho biết danh sách sinh viên có điểm trên mức trung bình môn mob1014
DECLARE @Trung_Binh FLOAT
SET @Trung_Binh = (SELECT AVG(diemthi)
				FROM ketqua k
				WHERE k.mamh = N'mob1014')
SELECT hotensv,diemthi
FROM ketqua k
JOIN sinhvien S ON S.masv = k.masv
WHERE diemthi>=@Trung_Binh;
--3.	Cho biết danh sách sinh viên có tuổi lớn nhất: thông tin gồm hoten, tuổi
DECLARE @Tuoi_max INT
SET @Tuoi_max = (SELECT year(getdate())-year(ngaysinh) AS TUOI FROM sinhvien
				WHERE year(getdate())-year(ngaysinh) >= ALL (SELECT year(getdate())-year(ngaysinh) FROM sinhvien))
SELECT hotensv,year(getdate())-year(ngaysinh) AS TUOI
FROM sinhvien
WHERE year(getdate())-year(ngaysinh)>=@Tuoi_max;
--4.	Cho biết khoa (makhoa,tenkhoa) có số lượng giáo viên có số lượng >2
DECLARE @Cau4 TABLE (makhoa VARCHAR(10),tenkhoa NVARCHAR(50),SOLUONG INT)
INSERT INTO @Cau4 
SELECT G.makhoa,tenkhoa,COUNT(hotengv)
FROM giangvien G JOIN khoa K ON K.makhoa=G.makhoa
GROUP BY G.makhoa,tenkhoa
HAVING COUNT(hotengv) = 2
--
SELECT * FROM @Cau4
--9.	Cho biết môn học nào chưa có sinh viên học:mamh,tenmh
DECLARE @Cau9 TABLE (mamh VARCHAR(10),tenmh NVARCHAR(50))
INSERT INTO @Cau9
SELECT mamh,tenmh FROM MonHoc
WHERE MaMH NOT IN (SELECT MaMH FROM Ketqua)
--
SELECT * FROM @Cau9

--8.	Cho biết thông tin lớp có số lượng sinh viên lớn nhất:malop, tenlop,soluong 
DECLARE @Cau8 TABLE (MALOP VARCHAR(10),TENLOP NVARCHAR(50),SOLUONG INT)
INSERT INTO @Cau8
SELECT S.MaLop,TenLop,COUNT(MaSV) AS SL
FROM Lop L
JOIN SinhVien S ON L.MaLop = S.MaLop
GROUP BY S.MaLop,TenLop
HAVING  COUNT(MaSV) >= ALL(SELECT COUNT(MaSV) FROM SinhVien GROUP BY MaLop)
SELECT * FROM @Cau8
--7.	Đưa ra thông tin: malop, tenlop, so luong sinh vien của lớp có số lượng >20
DECLARE @Cau7 TABLE (MALOP VARCHAR(10),TENLOP NVARCHAR(50),SOLUONG INT)
INSERT INTO @Cau7
SELECT S.MaLop,TenLop,COUNT(MaSV) AS SL
FROM SinhVien S
JOIN Lop L ON L.MaLop = S.MaLop
GROUP BY S.MaLop,TenLop
HAVING COUNT(MaSV) >20
--
SELECT * FROM @Cau7

--5.	Cho biết danh sách sinh viên chưa học môn nào, thông tin gồm hoten, Ngay sinh, 
DECLARE @Cau5 TABLE (HOTENSV NVARCHAR(50),NGAYSINH DATE,TENKOA NVARCHAR(50))
INSERT INTO @Cau5
SELECT hotensv,ngaysinh,tenkhoa
FROM Ketqua Q
JOIN SinhVien S ON S.MaSV = Q.MaSV
JOIN Lop L ON L.MaLop = S.MaLop
JOIN Khoa K ON K.MaKhoa = L.MaLop
WHERE S.masv NOT IN (SELECT masv FROM ketqua)
--
SELECT * FROM @Cau5
--6.	Đưa ra thông tin: malop,tenlop, so luong sinh vien của mỗi lớp
DECLARE @cau6 Table(malop nvarchar(10),tenlop nvarchar(100),soluong int )
insert into @cau6
select s.malop,tenlop,count(*) as soluong
from sinhvien s inner join lop l on s.malop=l.malop
group by s.malop,tenlop

select * from @cau6
--Lap 3
--
--1. Cho biết danh sách sinh viên có điểm thi lớn nhất môn mob1014: thông tin hotensv, Điểm (điểm xuất định dạng kiểu float)
SELECT hotensv,CAST(diemthi as float) as diemthi
FROM ketqua k join sinhvien s on s.masv=k.masv
WHERE mamh='mob1014' AND diemthi >= ALL(SELECT diemthi FROM ketqua WHERE mamh = 'mob1014')
/*2. Cho biết danh sách sinh viên có điểm trên mức trung bình môn mob1014: thông
tin hotensv, Điểm (điểm xuất định dạng với kiểu decimal với 2 số thập phân, sử dụng
dấu phẩy để phân biệt phần nguyên và phần thập phân.)*/
SELECT hotensv,REPLACE(CAST(diemthi as decimal(10,2)),'.',',') as diemthi
FROM ketqua k join sinhvien s on s.masv=k.masv
WHERE diemthi >= ALL(SELECT AVG(diemthi) FROM ketqua WHERE mamh = 'mob1014')
--3. Cho biết danh sách sinh viên có tuổi lớn nhất: thông tin gồm hoten, tuổi (xuất định dạng tuổi kiểu nvarchar)
SELECT  hotensv,CAST(YEAR(GETDATE())-YEAR(ngaysinh) AS nvarchar(10)) AS TUOI
FROM sinhvien
WHERE YEAR(GETDATE())-YEAR(ngaysinh) >= ALL (SELECT YEAR(GETDATE())-YEAR(ngaysinh) FROM sinhvien)
--4. Cho biết khoa (makhoa,tenkhoa,soluong giáo viên) có số lượng giáo viên &gt;2 (in hoa cột tên khoa)
SELECT K.makhoa,UPPER(tenkhoa),COUNT(*) as sl_gv
FROM khoa K JOIN giangvien G ON G.makhoa=K.makhoa
GROUP BY K.makhoa,tenkhoa
HAVING COUNT(*)>2
--5. Đưa ra thông tin: malop,tenlop, so luong sinh vien của mỗi lớp (Dữ liệu cột TENLOP có ký tự thứ 3 được viết in hoa, các ký tự còn lại viết thường)
SELECT L.malop, LOWER(SUBSTRING(tenlop,1,2))+UPPER(SUBSTRING(tenlop,3,1))+LOWER(SUBSTRING(tenlop,4,LEN(tenlop)-3)) as Ten_lop,COUNT(*) AS SL_SV
FROM lop L JOIN sinhvien S ON S.malop=L.malop
GROUP BY L.malop,tenlop
--6. Đưa ra thông tin: malop, tenlop, so luong sinh vien của lớp có số lượng &gt;20 (in thường cột tên lớp)
SELECT L.malop,LOWER(tenlop) as Ten_lop,COUNT(*) AS SL_SV
FROM lop L JOIN sinhvien S ON S.malop=L.malop
GROUP BY L.malop,tenlop
HAVING COUNT(*)>20
--7. Đưa ra thông tin : masv,hoten, ngaysinh,tên lớp (ngaysinh hiển thi theo định dạng dd-mm-yy)
SELECT masv,hotensv,CONVERT(nvarchar(10),ngaysinh,105)AS NGAY_SINH,tenlop
FROM sinhvien S JOIN lop L ON S.malop=L.malop
--8. Đưa ra thông tin sinh viên cho biết sinh viên sinh vào thứ mấy,quý mấy,ngày bao nhiêu của năm
SELECT masv,ngaysinh,DATENAME(WEEKDAY,ngaysinh) as thu,DATENAME(DAYOFYEAR,ngaysinh) as ngay_cua_nam,DATEPART(QUARTER, ngaysinh) as quy
FROM sinhvien
--9. Đưa ra thông tin sinh viên:masv,hotensv, họ sinh viên (cắt chuỗi từ hotenssv)
SELECT masv,hotensv,SUBSTRING(hotensv,1,CHARINDEX(' ',hotensv))
FROM sinhvien