--1. Viết chương trình hiển thị thông thi: masv, hoten,điểm, xếp loại của môn com2012
--Trong đó xếp loại dựa theo công thức
--0&lt;diem&lt;5:xếp loại yếu
--5&lt;=diem&lt;7:xếp loại trung bình
--7&lt;=diem&lt;8:xếp loại khá
--8&lt;=diem:xếp loại giỏi
SELECT s.masv,hotensv,diemthi,xeploai = case
	WHEN diemthi < 5 THEN N'Yếu'
	WHEN diemthi < 7 THEN N'TB'
	WHEN diemthi < 8 THEN N'Khá'
	ELSE N'Giỏi'
	END
FROM sinhvien s JOIN ketqua q on s.masv=q.masv
WHERE q.mamh = N'com107'

--2. Viết chương trinh hiển thị masv,tuổi, hotensv như hình dưới tùy thuộc Vào giới
--tính của sinh viên
SELECT masv,YEAR(GETDATE())-YEAR(ngaysinh) AS tuoi,hotensv = case
	WHEN gioitinh= N'Nam' THEN 'Mr .'+hotensv
	WHEN gioitinh=N'Nữ' THEN 'Ms .'+hotensv
	END
FROM sinhvien

--3. Viết chương trình xem xét có tuyển giáo viên hay không. Hiển thị cột thứ 1 là Tenkhoa,
--cột thứ 2 nhận giá trị
--a. “Tuyển giáo viên” số giáo viên hiện tại của khoa nhỏ hơn &lt;5.
--b. “không tuyển giáo viên “ nếu số giáo viên hiện tại của khoa &gt;=5.
SELECT tenkhoa,tinhtrang = case
	WHEN count(magv)<5 THEN N'Tuyển' 
	WHEN count(magv)>=5 THEN N'Không'
	END
FROM khoa k JOIN giangvien g ON k.makhoa=g.makhoa
GROUP BY tenkhoa

--4. Viết chương trình xem xét có tuyển giáo viên hay không. Hiển thị cột thứ 1 là makhoa,
--cột thứ 2 nhận giá trị
--a. “Tuyển giáo viên” số giáo viên hiện tại của khoa nhỏ hơn &lt;số lớp hiện tại của
--khoa
--b. “Không tuyển giáo viên “ nếu số giáo viên hiện tại của khoa nhỏ hơn &gt;=số lớp
--hiện tại của khoa
--

DECLARE @GV TABLE (MAKHOA VARCHAR(10),SL int)
INSERT INTO @GV
SELECT k.makhoa,COUNT(magv)
FROM khoa K LEFT JOIN giangvien G ON K.makhoa = G.makhoa
GROUP BY k.makhoa

--SELECT * FROM @GV
DECLARE @LOP TABLE (MAKHOA VARCHAR(10),SLL FLOAT)
INSERT INTO @LOP
SELECT K.makhoa,COUNT(*)
FROM khoa K LEFT JOIN lop L ON K.makhoa = L.makhoa
GROUP BY K.makhoa
--SELECT * FROM @LOP
SELECT k.makhoa,tinhtrang = case
	WHEN SL<SLL THEN N'Tuyển thêm' 
	ELSE N'Không tuyển'
	END
FROM khoa k JOIN lop l ON k.makhoa=l.makhoa
			JOIN @GV G ON G.MAKHOA=K.makhoa
			JOIN @LOP LO ON LO.makhoa=K.makhoa
GROUP BY k.makhoa,SL,SLL
--
--5. Cho biết thông tin sinh viên (masv,hotensv,tuổi) có MaNV là số lẻ sau
--Cách 1
DECLARE @i INT = 1 ,@DEM INT
SET @DEM=(SELECT COUNT(*) FROM SINHVIEN)
WHILE (@i<@DEM)
BEGIN 
	SELECT masv,hotensv,YEAR(GETDATE())-YEAR(ngaysinh) as Tuoi
	FROM sinhvien
WHERE CAST(RIGHT(masv,1) AS int) = @i
SET @i=@i+2
END
--Cách 2
SELECT masv,hotensv,YEAR(GETDATE())-YEAR(ngaysinh) as Tuoi
FROM sinhvien
WHERE CAST(RIGHT(masv,1) AS int)%2!=0
--Cách 3 
DECLARE @AO TABLE(MA INT ,masv VARCHAR(5))
INSERT INTO @AO
SELECT RIGHT(masv,1),masv FROM sinhvien
--
IF EXISTS (SELECT MA FROM @AO WHERE MA %2!=0)
BEGIN
PRINT N'Danh sách sinh viên có MaNV là số lẻ sau'
SELECT S.masv,hotensv,YEAR(GETDATE())-YEAR(ngaysinh) as Tuoi
FROM sinhvien S JOIN @AO A ON S.masv=A.masv
WHERE MA %2!=0
END
ELSE 
PRINT N'Không có ai '
--6.Cho biết thông tin sinh viên (masv,hotensv,tuổi) có MaNV là số lẻ sau nhưng không tính sinh viên có mã là 03 sau
--Cánh 1
DECLARE @i INT = 1 ,@DEM INT
SET @DEM=(SELECT COUNT(*) FROM SINHVIEN)
WHILE (@i<@DEM)
BEGIN
	IF (@i=3)
	BEGIN
	SET @i=@i+2
	CONTINUE
	END
	SELECT masv,hotensv,YEAR(GETDATE())-YEAR(ngaysinh) as Tuoi
	FROM sinhvien
WHERE CAST(RIGHT(masv,1) AS int) = @i
SET @i=@i+2
END
--Cách 2
SELECT masv,hotensv,(YEAR(GETDATE())-YEAR(ngaysinh)) as Tuoi
FROM sinhvien
WHERE CAST(RIGHT(masv,1) AS int)%2!=0 and CAST(RIGHT(masv,1) AS int) !=3
--Cách 3
DECLARE @c6 TABLE(MA INT ,masv VARCHAR(5))
INSERT INTO @c6
SELECT RIGHT(masv,1),masv FROM sinhvien
--
IF EXISTS (SELECT MA FROM @c6 WHERE MA %2!=0)
BEGIN
PRINT N'Danh sách sinh viên có MaNV là số lẻ sau'
SELECT S.masv,hotensv,YEAR(GETDATE())-YEAR(ngaysinh) as Tuoi
FROM sinhvien S JOIN @c6 A ON S.masv=A.masv
WHERE MA %2!=0 AND MA !=3
END
ELSE 
PRINT N'Không có ai '
--7. Cho biết thông tin:mamh,tenmh,nếu điểm trung bình mỗi môn học&gt;=5,thì điền &quot;đạt&quot;, còn
--không điền &quot;chưa đạt&quot;
SELECT m.mamh,tenmh,diemtb = case
	WHEN avg(diemthi)>=5 THEN N'Đạt'
	ELSE N'Chưa đạt'
	END
FROM monhoc m JOIN ketqua q ON q.mamh = m.mamh
GROUP BY m.mamh,tenmh