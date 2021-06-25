-------------------------------------------LAP 7 Bài Thêmm------------------------------------------------------
--1. Nhập vào Magv cho biết tuổi của giáo viên này.
if OBJECT_ID ('fn_BT1') is not null
drop function fn_BT1
go

alter function fn_BT1(@magv nvarchar(20))
returns int
as
begin
	return (select YEAR(getdate())-YEAR(ngaysinh) AS Tuổi from giangvien where magv=@magv)
end
--
select dbo.fn_BT1('gv2')
	
--2. Nhập vào Malop cho biết số lượng sinh viên của lớp
if OBJECT_ID ('fn_BT2') is not null
drop function fn_B2
go

alter function BTT2 (@malop nvarchar(20))
returns TABLE
as

	return (Select s.malop,count(*) as sl from sinhvien s 
		where s.malop=@malop
		group by s.malop)

--
select*FROM dbo.BTT2('L1')
select * from sinhvien

--3. Truyền tham số vào giới tính nam hoặc nữ, xuất số lượng sinh viên theo phái
if OBJECT_ID ('B3') is not null
drop function B3
go
CREATE FUNCTION BAI3 (@GIOITINH NVARCHAR(5))
RETURNS TABLE
AS

	RETURN (SELECT gioitinh,COUNT(masv) AS SL FROM sinhvien 
	WHERE @GIOITINH=gioitinh  
	GROUP BY gioitinh)

SELECT*FROM dbo.BAI3('NAM')
select * from sinhvien
--4. Nhập vào Makhoa cho biết thông tin: malop, tenlop, số lượng sinh viên của lớp
--thuộc khoa nhập vào
CREATE FUNCTION BAI4 (@MAKHOA NVARCHAR(10))
RETURNS TABLE
AS
	RETURN(SELECT L.MALOP,TENLOP,COUNT(MASV) AS SL
	FROM lop L JOIN khoa K ON L.makhoa=K.makhoa
		JOIN sinhvien S ON S.malop=L.malop
		WHERE K.makhoa = @MAKHOA
		GROUP BY L.malop,tenlop
	)
SELECT*FROM BAI4 ('K1')
SELECT *FROM khoa
SELECT *FROM lop
select * from sinhvien
--5. Truyền tham số đầu vào là tên môn học, tính mức điểm trung bình của môn học đó,
--Cho biết họ tên sinh viên (masv, hotensv,gioitinh ) có mức điểm trên mức điểm
--trung bình của môn học nhập vào.
CREATE FUNCTION BAI5 (@TENMH NVARCHAR(20))
RETURNS TABLE
AS
	RETURN (SELECT S.masv,hotensv,gioitinh FROM sinhvien S 
	JOIN ketqua K ON S.masv=K.masv 
	JOIN monhoc M ON M.mamh=K.mamh
	WHERE diemthi>ALL(SELECT AVG(diemthi) FROM ketqua K JOIN monhoc M ON M.mamh=K.mamh GROUP BY tenmh HAVING tenmh=@TENMH) AND M.tenmh=@TENMH
	)
--
SELECT*FROM monhoc
SELECT*FROM ketqua
SELECT *FROM  BAI5 (N'tin học văn phòng')
--6. Tryền tham số đầu vào là Mã khoa, cho biết tên khoa, số lượng giáo viên của mã
--khoa nhập vào.
ALTER FUNCTION BAI6 (@MAK NVARCHAR(10))
RETURNS TABLE
AS
	RETURN(SELECT TENKHOA,COUNT(g.makhoa) AS SLGV 
			FROM khoa K JOIN giangvien G ON K.makhoa=G.makhoa
			WHERE K.makhoa=@MAK
			GROUP BY tenkhoa
	)
SELECT*FROM giangvien
SELECT*FROM khoa
SELECT*FROM phancong
SELECT * FROM BAI6('K2')
--7. Viết hàm các tham số đầu vào tương ứng với các cột của bảng sinh viên. Hàm này
--trả về Masv thỏa mãn các giá trị được truyền tham số.
CREATE FUNCTION BAI7(
	@MASV NVARCHAR(10),
	@HOTEN NVARCHAR(50),
	@GIOITINH NVARCHAR(5),
	@NGSINH DATE,
	@QUEQUAN NVARCHAR(100),
	@MAL NVARCHAR(10)
)
RETURNS TABLE
AS
	RETURN(SELECT MASV FROM sinhvien
	WHERE @MASV=masv AND
	@HOTEN=hotensv AND
	@GIOITINH=gioitinh AND
	@NGSINH=ngaysinh AND
	@QUEQUAN=quequan AND
	@MAL=malop 		
	)
SELECT*FROM BAI7 (N's001',N'Nguyễn Thu Trang',N'Nữ','20000403',N'Hà Nội',N'L1')
--8. Viết hàm các tham số đầu vào tương ứng với các cột của bảng sinh viên. Hàm này
--trả về Malop thỏa mãn các giá trị được truyền tham số.
CREATE FUNCTION BAI8(
	@MASV NVARCHAR(10),
	@HOTEN NVARCHAR(50),
	@GIOITINH NVARCHAR(5),
	@NGSINH DATE,
	@QUEQUAN NVARCHAR(100),
	@MAL NVARCHAR(10)
)
RETURNS TABLE
AS
	RETURN(SELECT malop FROM sinhvien
	WHERE @MASV=masv AND
	@HOTEN=hotensv AND
	@GIOITINH=gioitinh AND
	@NGSINH=ngaysinh AND
	@QUEQUAN=quequan AND
	@MAL=malop 		
	)

SELECT*FROM BAI8 (N's001',N'Nguyễn Thu Trang',N'Nữ','20000403',N'Hà Nội',N'L1')


--9. Hiển thị thông tin masv,hoten,tên môn học,điểm thi.
create VIEW BAI9 
AS 
SELECT S.MASV,HOTENSV,TENMH,DIEMTHI 
FROM sinhvien S JOIN ketqua Q ON S.masv=Q.masv
JOIN monhoc H ON H.mamh=Q.mamh
--
SELECT*FROM BAI9
--10. Hiển thị thông tin magv,hoten, tuổi
CREATE VIEW BAI10
AS
	SELECT MAGV,hotengv,YEAR(GETDATE())-YEAR(ngaysinh) AS TUOI FROM giangvien
--
SELECT*FROM BAI10
--11. Hiển thị tenkhoa, số lượng giáo viên của khóa có đông giáo viên nhất
ALTER VIEW BAI11
AS
	SELECT TENKHOA,COUNT(G.makhoa) AS SLGV FROM khoa K 
	JOIN giangvien G ON K.makhoa=G.makhoa
	GROUP BY tenkhoa
	HAVING COUNT(G.makhoa)>= ALL (SELECT COUNT(makhoa) FROM giangvien GROUP BY magv)
SELECT * FROM BAI11
--12. Tạo View lưu thông tin của TOP 5 có giá trị số lượng giáo viên đông nhất gồm
--các thông tin sau: Makhoa, tenkhoa, số lượng giáo viên.
ALTER VIEW BAI12
AS
	SELECT TOP 5 TENKHOA,COUNT(G.makhoa) AS SLGV FROM khoa K 
	LEFT JOIN giangvien G ON K.makhoa=G.makhoa
	GROUP BY tenkhoa
	ORDER BY COUNT(G.makhoa) DESC
SELECT * FROM BAI12
--13. Tạo View lưu thông tin của TOP 5 có giá trị số lượng sinh viên đông nhất gồm
--các thông tin sau: Malop, tenlop, số lượng sinh viên.
ALTER VIEW BAI13
AS
	SELECT TOP 5 L.malop,tenlop,COUNT(S.malop) AS SLGV FROM sinhvien S 
	RIGHT JOIN lop L ON S.malop=L.malop
	GROUP BY L.malop,tenlop
	ORDER BY COUNT(S.malop) DESC
SELECT * FROM BAI13
SELECT*FROM sinhvien
SELECT*FROM lop