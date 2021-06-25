
--Hiển thị thông tin nhân viên ,Nếu lương>500000,thì chức vụ là trưởng phòng còn ko nhân viên
SELECT TENNV,IIF(LUONG>30000,N'Trưởng phòng',N'Nhân Viên') as ChuVu
FROM NHANVIEN
--
DECLARE @DTB FLOAT
SET @DTB = 4
IF @DTB >5
BEGIN
PRINT N'Đậu'
END
ELSE 
PRINT N'Trượt'
/*
Viết chương trình xem xét có tăng lương cho nhân viên hay không. Hiển thị cột thứ 1 là 
TenNV, cột thứ 2 nhận giá trị
o “TangLuong” nếu lương hiện tại của nhân viên nhở hơn trung bình lương trong 
phòng mà nhân viên đó đang làm việc. 
o “KhongTangLuong “ nếu lương hiện tại của nhân viên lớn hơn trung bình lương 
trong phòng mà nhân viên đó đang làm việc.
*/
--Lấy dữ liệu lương trung bình từ 1 bảng tạm
DECLARE @LUONG TABLE (MAPB VARCHAR(10),LUONGTB FLOAT)
INSERT INTO @LUONG
SELECT PHG,AVG(LUONG)
FROM NHANVIEN
GROUP BY PHG
--
SELECT TENNV,GHICHU=CASE
WHEN LUONG<LUONGTB THEN N'T'
ELSE N'K'
END
FROM NHANVIEN N JOIN @LUONG L ON L.MAPB=N.PHG

SELECT TENNV,IIF(CAST(LUONG as float)   < LUONGTB,'Tăng Lương','Không Tăng') AS GHICHU
FROM NHANVIEN N JOIN @LUONG L ON L.MAPB=N.PHG
--
DECLARE @LUONG TABLE (MAPB VARCHAR(10),LUONGTB FLOAT)
INSERT INTO @LUONG
SELECT PHG,AVG(LUONG)
FROM NHANVIEN
GROUP BY PHG
--
SELECT TENNV,GHICHU=CASE
WHEN LUONG>LUONGTB THEN N'Trưởng phòng'
ELSE N'Nhân viên'
END
FROM NHANVIEN N JOIN @LUONG L ON L.MAPB=N.PHG


--Cách 1
SELECT TENNV = case PHAI
WHEN N'Nam' then N'Mr'+TENNV
WHEN N'Nữ' then N'Ms'+TENNV
ELSE N'Đồng giới'+TENNV
END
FROM NHANVIEN
--Cách 2
SELECT TENNV = case
WHEN PHAI = N'Nam' then N'Mr'+TENNV
WHEN PHAI = N'Nữ' then N'Ms'+TENNV
ELSE N'Đồng giới'+TENNV
END
FROM NHANVIEN
/*
Viết chương trình tính thuế mà nhân viên phải đóng theo công thức:
o 0<luong<25000 thì đóng 10% tiền lương
o 25000<luong<30000 thì đóng 12% tiền lương
o 30000<luong<40000 thì đóng 15% tiền lương
o 40000<luong<50000 thì đóng 20% tiền lương
o Luong>50000 đóng 25% tiền lương
*/
SELECT TENNV,LUONG,THUE=CASE
WHEN LUONG BETWEEN 0 AND 25000 THEN 0.1*LUONG
WHEN LUONG BETWEEN 25000 AND 30000 THEN 0.12*LUONG
WHEN LUONG BETWEEN 30000 AND 40000 THEN 0.15*LUONG
WHEN LUONG BETWEEN 40000 AND 50000 THEN 0.2*LUONG
ELSE 0.25*LUONG
END
FROM NHANVIEN
--
SELECT MAPHG,COUNT(*) AS SL,trangThai=CASE
WHEN COUNT(*)<3 THEN N'THIEU'
WHEN COUNT(*)<5 THEN N'DU'
ELSE N'THUA'
END
FROM NHANVIEN N JOIN PHONGBAN P ON P.MAPHG = N.PHG
GROUP BY MAPHG
--
DECLARE @DEM INT = 1,@TONG INT =0;
WHILE @DEM<=10
BEGIN
SET @TONG = @TONG+@DEM
SET @DEM = @DEM + 1
END
PRINT @TONG
--Viết chương trình tinh số chẵn 
DECLARE @DEM INT = 1,@TONG INT =0;
WHILE @DEM<=10
BEGIN
	IF @DEM%2=0
	BEGIN
		SET @TONG = @TONG+@DEM
	END
SET @DEM = @DEM + 1
END
PRINT @TONG
--Viết chương trình tính tổng các số chẵn từ 1 đến 10 trừ số 4
DECLARE @DEM INT = 1,@TONG INT =0;
WHILE @DEM<=10
BEGIN
IF @DEM=4
BEGIN
SET @DEM = @DEM + 1
CONTINUE
END
SET @TONG = @TONG+@DEM
SET @DEM = @DEM + 1
END
PRINT @TONG
--
SELECT * FROM PHONGBAN
BEGIN TRY
	INSERT INTO PHONGBAN VALUES (N'Kế toán',N'1',N'001','2/2/2020')
	PRINT N'Thành công'
END TRY
BEGIN CATCH
	PRINT N'Thất bại'+ERROR_MESSAGE()
END CATCH
--➢ Cho biết thông tin nhân viên (HONV, TENLOT, TENNV) có MaNV là số chẵn.
SELECT manv,honv,tenlot,tennv 
FROM NHANVIEN
WHERE CAST(manv as int)%2=0
--Cách 2
DECLARE @i INT = 2 ,@DEM INT
SET @DEM=(SELECT COUNT(*) FROM NHANVIEN)
WHILE (@i<@DEM)
BEGIN 
	SELECT HONV,TENLOT,TENNV
	FROM NHANVIEN
WHERE CAST(MANV AS INT)=@I
SET @i=@i+2
END
--➢ Cho biết thông tin nhân viên (HONV, TENLOT, TENNV) có MaNV là số chẵn nhưng
--không tính nhân viên có MaNV là 4.
SELECT manv,honv,tenlot,tennv 
FROM NHANVIEN
WHERE CAST(manv as int)%2=0 and CAST(manv as int)!=4
--C2
DECLARE @i INT = 2 ,@DEM INT
SET @DEM=(SELECT COUNT(*) FROM NHANVIEN)
WHILE (@i<@DEM)
BEGIN 
	IF (@i=4)
	BEGIN
	SET @i=@i+2
	CONTINUE
	END
	SELECT HONV,TENLOT,TENNV
	FROM NHANVIEN
WHERE CAST(MANV AS INT)=@I
SET @i=@i+2
END