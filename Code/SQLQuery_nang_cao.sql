create database quanlydiem_1
go
--
use quanlydiem_1
go
--tao bang lop
create table lop
(
Malop nvarchar(10) ,
Tenlop nvarchar(50),
Constraint kc primary key(Malop)
)
create table sinhvien
(Masv nvarchar(10),
Hoten nvarchar(50),
Ngaysinh date,
Quequan nvarchar(100),
Gioitinh nvarchar(5),
Malop nvarchar(10),
Constraint kc_sv primary key(Masv),
Constraint fk_sv foreign key(Malop) 
references lop(Malop)
) 
--tao bang monhoc
Create table Monhoc
(Mamh nvarchar(10),
Tenmh nvarchar(100),
Sotiet int,
Constraint kc_mh primary key(Mamh)
)
--tao bang ket qua
create table ketqua
(Masv nvarchar(10),
Mamh nvarchar(10),
Lanthi int,
Diemthi float,
Constraint fk_kq1 foreign key(Masv) references sinhvien(Masv),
Constraint fk_kq2 foreign key(Mamh) references Monhoc(Mamh),
constraint kc_kq primary key(Masv,Mamh,Lanthi)
)
--CHEN DU LIEU
insert into LOP values('PT13301',N'Ứng dụng phần mềm 1')
insert into LOP values('PT13302',N'Ứng dụng phần mềm 2')
insert into LOP values('PT13303','Ứng dụng phần mềm 3')
insert into LOP values('PT13304',N'Ứng dụng phần mềm 4')
insert into LOP values('PT13305',N'Ứng dụng phần mềm 5')
--nhập dữ liệu bảng môn học
insert into MONHOC values('mob1013',N'lập trình java1',36)
insert into MONHOC values('mob1022',N'lập trình java2',36)
insert into MONHOC values('sof203',N'lập trình java3',36)
insert into MONHOC values('com2012',N'Cơ sở dữ liệu',36)
insert into MONHOC values('com2032',N'Hệ quản trị CSDL',30)
--nhập bảng sinh viên
Insert into SINHVIEN values('ph06230',N'Trần Lê Huy','1/1/2008',N'Hà Nội','Nam','PT13302')
Insert into SINHVIEN values('ph06231',N'Nguyễn Thị Mỹ Duyên','7/16/2009',N'Hà Nội','Nữ','PT13302')
Insert into SINHVIEN values('ph06232',N'Võ Tá Nhật Anh','1/1/2008',N'Hà Tĩnh','Nam','PT13302')
Insert into SINHVIEN values('ph06233',N'Trần Thị Thùy Trang','1/1/2008',N'Hải Phòng','Nữ','PT13302')
Insert into SINHVIEN values('ph06234',N'Nguyễn Thị Mừng','1/1/2008',N'Hà Nội','Nữ','PT13305')
Insert into SINHVIEN values('ph06235',N'Nguyễn Xuân Trường','1/1/2008',N'Hà Nội','Nam','PT13305')
--chèn bảng kết quả
insert into KETQUA values('ph06230','sof203',1,3)
insert into KETQUA values('ph06230','sof203',2,6)
insert into KETQUA values('ph06230','com2012',1,8)
insert into KETQUA values('ph06233','sof203',1,7)
insert into KETQUA values('ph06234','sof203',1,9)
--đưa ra thông tin masv, hoten, quequan
--cua sv thuoc lop Ứng dụng phần mềm 1
SELECT Masv, Hoten, Quequan
FROM sinhvien;
--cau2: dua ra thông tin:masv,hoten,tenmh,diemthi,lanthi
--cua những sv có quê quan hà nôi
--câu 3: đưa ra thông tin masv, hoten học môn lt java3
--câu 4:thống kê số lượng sv của mỗi lớp:malop,tenlop,soluong
--co so luong >30
--câu 5:thống kê số lượng sv của mỗi lớp:malop,tenlop,soluong
--có sô lượng lớn nhất
--c6 đưa ra thông tin những sinh viên có cùng ngay sinh
--cau 10: dưa ra thông tin những lớp không có sinh viên
--cau 11: đưa ra thông tin masv, hoten có tenlop:ung dung
SELECT ketqua.Masv,Hoten,Tenmh,Diemthi,Lanthi
FROM ketqua inner
JOIN sinhvien ON ketqua.Masv = sinhvien.Masv
JOIN Monhoc ON ketqua.Mamh = Monhoc.Mamh
where Quequan=N'hà nội';

SELECT S.Malop,Tenlop,COUNT(Masv) as sl
FROM sinhvien S
JOIN lop L ON L.Malop = S.Malop
group by S.Malop,Tenlop
HAVING COUNT(Masv)>30;

SELECT S.Malop,Tenlop,COUNT(Masv) as sl
FROM sinhvien S
JOIN lop L ON L.Malop = S.Malop
group by S.Malop,Tenlop
HAVING COUNT(Masv)>= all(select COUNT(Masv)  from sinhvien);