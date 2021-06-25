--Đưa ra thông tin nhân viên có s001
SELECT * FROM NHANVIEN WHERE MANV = 's001'
--Đưa ra thông tin nhân viên có Mã do người dùng nhập vào
CREATE PROC VIDU1
AS
SELECT * FROM NHANVIEN
--GỌI THỦ TỤC
EXEC VIDU1
--Đưa ra thông tin nhân viên có Mã do người dùng nhập vào
CREATE PROC VIDU1B(@MANV NVARCHAR(10))
AS
SELECT * FROM NHANVIEN
WHERE MANV = @MANV
--
EXEC VIDU1B N'001'
--
ALTER PROC VIDU1B(@MANV NVARCHAR(10),@GT NVARCHAR(10))
AS
SELECT * FROM NHANVIEN
WHERE MANV = @MANV AND PHAI=@GT
--
EXEC VIDU1B N'001',N'Nữ'
--Tạo thủ tục tính tổng



/*
➢ In ra dòng ‘Xin chào’ + @ten với @ten là tham số đầu vào là tên Tiếng Việt có dấu của 
bạn. Gợi ý:
o sử dụng UniKey để gõ Tiếng Việt ♦
o chuỗi unicode phải bắt đầu bởi N (vd: N’Tiếng Việt’) ♦
o dùng hàm cast (<biểuThức> as <kiểu>) để đổi thành kiểu <kiểu> của<biểuThức>.
➢ Nhập vào 2 số @s1,@s2. In ra câu ‘Tổng là : @tg’ với @tg=@s1+@s2.
➢ Nhập vào số nguyên @n. In ra tổng các số chẵn từ 1 đến @n.
➢ Nhập vào 2 số. In ra ước chung lớn nhất của chúng theo gợi ý dưới đây:
o b1. Không mất tính tổng quát giả sử a <= A 
o b2. Nếu A chia hết cho a thì : (a,A) = a ngược lại : (a,A) = (A%a,a) hoặc (a,A) = (a,A-a) 
o b3. Lặp lại b1,b2 cho đến khi điều kiện trong b2 được thỏa
*/
--➢ In ra dòng ‘Xin chào’ + @ten với @ten là tham số đầu vào là tên Tiếng Việt có dấu của 
CREATE PROC B1A(@TEN VARCHAR(20))
AS
PRINT N'Xin chào' + CAST(@TEN AS NVARCHAR(20))
--
EXEC B1A N'Lan anh'
--➢ Nhập vào 2 số @s1,@s2. In ra câu ‘Tổng là : @tg’ với @tg=@s1+@s2.
CREATE PROC BT1B(@S1 INT ,@S2 INT)
AS
BEGIN
DECLARE @TONG INT
SET @TONG = @S1+@S2
PRINT N'Tổng là : '+ CAST(@TONG AS NVARCHAR(20))
END
--
EXEC BT1B 4,5
--➢ Nhập vào số nguyên @n. In ra tổng các số chẵn từ 1 đến @n.
ALTER PROC BT1C(@N INT)
AS
BEGIN
DECLARE @TONG INT = 0,@DEM INT = 1
WHILE @DEM<=@N
	BEGIN
		IF @DEM%2=0
			BEGIN
			SET @TONG = @TONG+@DEM
			END
		SET @DEM = @DEM + 1
	END
PRINT N'TỔNG LÀ : ' + CAST(@TONG AS NVARCHAR(20))
END

--
EXEC BT1C 10
--➢ Nhập vào 2 số. In ra ước chung lớn nhất của chúng theo gợi ý dưới đây:
--o b1. Không mất tính tổng quát giả sử a <= A 
--o b2. Nếu A chia hết cho a thì : (a,A) = a ngược lại : (a,A) = (A%a,a) hoặc (a,A) = (a,A-a) 
--o b3. Lặp lại b1,b2 cho đến khi điều kiện trong b2 được thỏa
ALTER PROC BT1D(@A INT,@B INT)
AS
BEGIN
	IF @A=@B
	PRINT N'UCLN là :'+CAST(@A AS NVARCHAR(10))
	ELSE
	BEGIN
		WHILE (@A!=@B)
		BEGIN
		IF @A>@B
		SET @A=@A-@B
		ELSE
		SET @B=@B-@A
		END
		PRINT N'UCLN là :'+CAST(@A AS NVARCHAR(10))
	END
END

EXEC BT1D 9,12
/*
Viết store procedure nhận vào tham số là năm sinh, xuất ra tên các nhân viên.
Viết store procedure đếm số lượng thân nhân của nhân viên có mã nhân viên được nhập từ người dùng
*/
--Viết store procedure nhận vào tham số là năm sinh, xuất ra tên các nhân viên.
CREATE PROC DEMO1A(@NAMSINH INT)
AS
SELECT * FROM NHANVIEN
WHERE YEAR(NGSINH)=@NAMSINH
--
EXEC DEMO1A 1967



--➢ Nhập vào @Manv, xuất thông tin các nhân viên theo @Manv.
CREATE PROC BAI2A(@Manv NVARCHAR(10))
AS
SELECT * FROM NHANVIEN
WHERE MANV=@Manv
--
EXEC BAI2A N'001'

--➢ Nhập vào @MaDa (mã đề án), cho biết số lượng nhân viên tham gia đề án đó
ALTER PROC BAI2B(@MaDa NVARCHAR(10))
AS
SELECT MADA,COUNT(MA_NVIEN) AS SOLUONG FROM PHANCONG
WHERE MADA=@MaDa
GROUP BY MADA
--
EXEC BAI2B N'10'
--➢ Nhập vào @MaDa và @Ddiem_DA (địa điểm đề án), cho biết số lượng nhân viên tham 
--gia đề án có mã đề án là @MaDa và địa điểm đề án là @Ddiem_DA
CREATE PROC BAI2C(@MaDa NVARCHAR(10),@Ddiem_DA NVARCHAR(20))
AS
SELECT P.MADA,COUNT(MA_NVIEN) AS SOLUONG FROM PHANCONG P
			JOIN CONGVIEC C ON C.MADA= P.MADA AND P.STT=C.STT
			JOIN DEAN D ON D.MADA=P.MADA
WHERE P.MADA=@MaDa AND DDIEM_DA=@Ddiem_DA
GROUP BY P.MADA
--
EXEC BAI2C N'1',N'Vũng tàu'
SELECT * FROM CONGVIEC
--➢ Nhập vào @Trphg (mã trưởng phòng), xuất thông tin các nhân viên có trưởng phòng là @Trphg và các nhân viên này không có thân nhân.
CREATE PROC BAI2D(@TRPHONG NVARCHAR(10))
AS
SELECT HONV,TENLOT,TENNV
FROM NHANVIEN N JOIN PHONGBAN P ON P.MAPHG= N.PHG
WHERE TRPHG=@TRPHONG AND N.MANV NOT IN (SELECT MANV FROM THANNHAN)
--
EXEC BAI2D N'008'
--➢ Nhập vào @Manv và @Mapb, kiểm tra nhân viên có mã @Manv có thuộc phòng ban có mã @Mapb hay không
CREATE PROC BAI2E(@Manv VARCHAR(10),@Mapb VARCHAR(10))
AS
SELECT IIF(@Manv = N.MANV AND @Mapb=P.MAPHG,N'CÓ',N'KO' ) AS GHI_CHU
FROM NHANVIEN N JOIN PHONGBAN P ON P.MAPHG= N.PHG
--
EXEC BAI2E N'001',N'4'
--BÀI 3
--Thêm phòng ban có tên CNTT vào csdl QLDA, các giá trị được thêm vào dưới dạng tham số đầu vào, kiếm tra nếu trùng Maphg thì thông báo thêm thất bại.
ALTER PROC BAI3A(@TENPB NVARCHAR(50), @MAPB NVARCHAR(10), @TP NVARCHAR(10),@NGAYNC DATE)
AS
BEGIN 
IF EXISTS (SELECT * FROM PHONGBAN WHERE MAPHG=@MAPB)
	PRINT N'Trùng mã pb ,Thất bại'
ELSE
INSERT INTO PHONGBAN VALUES(@TENPB,@MAPB,@TP,@NGAYNC)
END
--
EXEC BAI3A N'CNTT',N'2',N'004','5/6/2000'
SELECT * FROM PHONGBAN
create proc B3A (
@tenphg nvarchar(50),@maphg nvarchar(10),@trphg nvarchar(10),@ngaync date
)
as
begin
 if exists (select * from PHONGBAN where MAPHG=@maphg)
	print N'Tồn tại mã phòng ban,chèn thất bại'
 else
	insert into PHONGBAN values(@tenphg,@maphg,@trphg,@ngaync)
end

--
exec B3A N'CNTT',N'2',N'004','5/6/2000'
-- Cập nhật phòng ban có tên CNTT thành phòng IT.
ALTER PROC BAI3BT(@TENPB NVARCHAR(50), @MAPB NVARCHAR(10), @TP NVARCHAR(10),@NGAYNC DATE)
AS
BEGIN 
IF EXISTS (SELECT * FROM PHONGBAN WHERE MAPHG=@MAPB)
	UPDATE PHONGBAN
	SET TENPHG=@TENPB,TRPHG=@TP,@NGAYNC=NG_NHANCHUC
	WHERE @MAPB=MAPHG
ELSE
INSERT INTO PHONGBAN VALUES(@TENPB,@MAPB,@TP,@NGAYNC)
END
--
EXEC BAI3BT N'CNTT',N'6',N'004','5/6/2000'
SELECT * FROM PHONGBAN
CREATE PROC BAI3B
AS
	UPDATE PHONGBAN
	SET TENPHG=N'IT'
	WHERE TENPHG='CNTT'


--Thêm một nhân viên vào bảng NhanVien, tất cả giá trị đều truyền dưới dạng tham số đầu vào với điều kiện:
--nhân viên này trực thuộc phòng IT
--Nhận @luong làm tham số đầu vào cho cột Luong, nếu @luong<25000 thì nhân 
--viên này do nhân viên có mã 009 quản lý, ngươc lại do nhân viên có mã 005 quản 
--lý
--Nếu là nhân viên nam thi nhân viên phải nằm trong độ tuổi 18-65, nếu là nhân 
--viên nữ thì độ tuổi phải từ 18-60
ALTER PROC BAI3C (
@HONV NVARCHAR(20),@TENLOT NVARCHAR(50),@TENNV NVARCHAR(50),@MANV NVARCHAR(20),
@NGSINH DATE,@DIACHI NVARCHAR(100),@PHAI NVARCHAR(6),@LUONG FLOAT,@MANQL NVARCHAR(20),
@PHG NVARCHAR(20)
)
AS
 BEGIN
 --ĐIỀU KIỆN 1
  IF @PHG=(SELECT MAPHG FROM PHONGBAN WHERE TENPHG=N'IT')
	  BEGIN
	  --ĐIỀU KIỆN 2
		IF @LUONG<25000 SET @MANQL=N'009' ELSE SET @MANQL =N'005'
		--
	 --ĐIỀU KIỆN 3
	 DECLARE @TUOI INT
	 SET @TUOI=YEAR(GETDATE())-YEAR(@NGSINH)
	 IF (@PHAI=N'NAM' AND @TUOI>=18 AND @TUOI <=65) OR (@PHAI = N'NỮ' AND @TUOI>=18 AND @TUOI <=60)
		BEGIN
			INSERT INTO NHANVIEN VALUES(@HONV,@TENLOT,@TENNV,@MANV,@NGSINH,@DIACHI,@PHAI,@LUONG,@MANQL,@PHG)
		END	
	  ELSE
		PRINT N'NHÂN VIÊN KHÔNG THUỘC ĐỘ TUỔI YÊU CẦU'
	  END
	ELSE
		PRINT N'NHÂN VIÊN KHÔNG THUỘC PHÒNG IT'
 END

 --
 EXEC BAI3C N'Trần',N'Văn',N'Thành',N'PH15015','10/01/2002',N'QUẢNG NINH',N'NAM',10000,N'002',N'006'
 select * from PHONGBAN

SELECT HONV,TENLOT,TENNV 
FROM NHANVIEN N JOIN PHONGBAN P ON P.MAPHG = N.PHG
GROUP BY HONV,TENLOT,TENNV 
HAVING AVG(LUONG) >= ALL (SELECT AVG(LUONG) FROM NHANVIEN GROUP BY MANV)

--
SELECT TENPHG,N1.TENNV AS TENTRP,COUNT(*) AS SL
FROM NHANVIEN N JOIN PHONGBAN P ON P.MAPHG=N.PHG
	JOIN NHANVIEN N1 ON N1.MANV = P.TRPHG
GROUP BY TENPHG,N1.TENNV
HAVING COUNT(N.MANV) >= ALL(SELECT COUNT(*) FROM NHANVIEN N JOIN PHONGBAN P ON P.MAPHG=N.PHG GROUP BY MAPHG) 