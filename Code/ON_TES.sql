--1. Tạo cơ sở dữ liệu như sau (Lưu ý: Sinh viên có thể viết code hoặc dùng tool) (1 điểm)
--Mathang (Mamh, tenmh, dongia)
--ChitietDH (Madh, Mamh, soluong)
CREATE DATABASE ON_TES3

CREATE TABLE Mathang (
	Mamh VARCHAR(10) PRIMARY KEY,
	tenmh NVARCHAR(50),
	dongia FLOAT
	);
CREATE TABLE ChitietDH(
	Madh VARCHAR(10) PRIMARY KEY,
	Mamh VARCHAR(10),
	soluong INT,
	CONSTRAINT FK1 FOREIGN KEY (Mamh) REFERENCES Mathang(Mamh)
	);
--2. Xây dựng thủ tục Stored Procedure (SP) với các tham số đầu vào phù hợp thêm thông tin vào
-- các bảng trên. (2 điểm)
-- Với mỗi SP viết 2 lời gọi thành công
IF OBJECT_ID ('B2A') IS NOT NULL
DROP PROC B2A
GO
CREATE PROC B2A(
	@Mamh VARCHAR(10),
	@tenmh NVARCHAR(50),
	@dongia FLOAT
)
AS
IF @Mamh IS NULL OR @tenmh IS NULL OR @dongia IS NULL
	PRINT N'KHÔNG ĐƯỢC ĐỂ NULL'
	ELSE 
		INSERT INTO  Mathang VALUES (@Mamh,@tenmh,@dongia)
--
EXEC B2A 'MH01',N'LAPTOP',5000
EXEC B2A 'MH02',N'LAPTOP 2',3000
SELECT * FROM Mathang
--------------B
IF OBJECT_ID ('B2B') IS NOT NULL
DROP PROC B2B
GO
CREATE PROC B2B(
	@Madh VARCHAR(10),
	@Mamh VARCHAR(10),
	@soluong INT
)
AS
IF @Madh IS NULL OR @Mamh IS NULL OR @soluong IS NULL
	PRINT N'KHÔNG ĐƯỢC ĐỂ NULL'
	ELSE 
		INSERT INTO  ChitietDH VALUES (@Madh,@Mamh,@soluong)
EXEC B2B 'DH01','MH02',2
EXEC B2B 'DH02','MH01',3
EXEC B2B 'DH03','MH01',1
SELECT * FROM ChitietDH
--B3 Xây dựng hàm có đầu vào là MaMH, hàm trả về tổng số lượng mua hàng của MaMH truyền
--vào (1diem)
-- Viết lời gọi hàm.
IF OBJECT_ID ('B3') IS NOT NULL
DROP FUNCTION B3
GO
CREATE FUNCTION B3(@MaMH VARCHAR(10))
RETURNS INT
AS
BEGIN
RETURN (SELECT SUM(soluong) FROM ChitietDH WHERE Mamh=@MaMH GROUP BY Mamh )
END

SELECT dbo.B3('MH01')

--B4 Viết hàm các tham số đầu vào tương ứng với các cột của bảng mathang. Hàm này trả về
--Mamh thỏa mãn các giá trị được truyền tham số. (1diem)
IF OBJECT_ID ('B4') IS NOT NULL
DROP FUNCTION B4
GO
CREATE FUNCTION B4 (
	@Mamh VARCHAR(10)=N'%',
	@tenmh NVARCHAR(50)=N'%',
	@dongia FLOAT=N'%'
)
RETURNS TABLE
AS
RETURN (SELECT Mamh FROM Mathang WHERE Mamh LIKE @Mamh AND tenmh LIKE @tenmh AND dongia LIKE @dongia )
SELECT * FROM DBO.B4('MH01',N'LAPTOP',5000)
--5. Xây dựng thủ tục xóa có đầu vào là MaMH. Thủ tục thực hiện xóa thông tin chi tiết Đơn hàng
--và thông tin của Mathang của MaMH truyền vào. (2.5 điểm)
IF OBJECT_ID ('B5') IS NOT NULL
DROP PROC B5
GO
CREATE PROC B5(@Mamh VARCHAR(10))
AS
BEGIN TRY
	BEGIN TRAN
	DELETE ChitietDH
	WHERE Mamh = @Mamh
	DELETE Mathang
	WHERE Mamh = @Mamh
	COMMIT TRAN
END TRY
BEGIN CATCH
	ROLLBACK TRAN
END CATCH

EXEC B5 'MH01'
--B6 Xây dựng thủ tục Cho biết thông tin Đặt hàng của các mặt hàng. Thông tin bao gồm:
--MaMH, TenMH, Tổng số lượng đặt, Trạng thái(2 điểm)
--Trong đó:
-- Trạng thái: Nếu tổng số lượng đặt &gt;300: Bán chạy, còn lại thì không bán chạy
IF OBJECT_ID ('B6') IS NOT NULL
DROP PROC B6
GO
CREATE PROC B6
AS
BEGIN
	SELECT C.Mamh,tenmh,SUM(soluong),IIF(SUM(soluong)>300,'Bán chạy','Không chạy' ) 
	AS TRANG_THAI FROM ChitietDH C JOIN Mathang M ON M.Mamh = C.Mamh GROUP BY C.Mamh,tenmh
END
EXEC B6
--7.Tạo view Lưu thông tin Top 3 NhanVien có nhiều hàng nhất: MAmh, tenmh, tong so luong (1
if OBJECT_ID ('b7') is not null
drop view b7 
go
create view b7
as
	select top 3 m.mamh,tenmh,SUM(soluong) as tongsl 
	from mathang m join chitietDH c on m.mamh=c.Mamh
	group by m.mamh,tenmh,soluong
	order by SUM(soluong) desc

SELECT * FROM b7