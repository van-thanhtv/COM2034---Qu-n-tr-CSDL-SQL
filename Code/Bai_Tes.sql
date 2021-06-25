CREATE DATABASE BAI_TES
USE BAI_TES

CREATE TABLE KhachHang(
MaKH VARCHAR(10) PRIMARY KEY,
TenKH NVARCHAR(50),
TaiKhoan NVARCHAR(50)
);
CREATE TABLE DatHang(
MaDatHang VARCHAR(10) PRIMARY KEY,
MaKH VARCHAR(10),
SoLuong INT,
DonGia FLOAT,
CONSTRAINT FK_1 FOREIGN KEY(MaKH) REFERENCES KhachHang(MaKH),
);
-- Xây dựng thủ tục Stored Procedure (SP) với các tham số đầu vào phù hợp thêm thông tin vào các bảng trên.
-- Yêu cầu mỗi SP phải kiểm tra tham số đầu vào. Với các cột không chấp nhận thuộc tính Null.
-- Với mỗi SP viết 2 lời gọi thành công
CREATE PROC KH (@MaKH VARCHAR(10),@TenKH NVARCHAR(50),@TaiKhoan NVARCHAR(50))
AS
IF @MaKH IS  NULL OR  @TenKH IS NULL OR @TaiKhoan IS NULL
	PRINT N'DỮ LIỆU KHÔNG HỢP LỆ'
	ELSE
		INSERT INTO KhachHang VALUES(@MaKH,@TenKH,@TaiKhoan)
--
EXEC KH 001,'Trần Văn Thành','Thanhtvph15016'
EXEC KH 001,'Trần Văn Thành',NULL

--
CREATE PROC DH (@MaDatHang VARCHAR(10),@MaKH VARCHAR(10),@SoLuong INT,@DonGia FLOAT)
AS
IF @MaDatHang IS  NULL OR  @MaKH IS NULL OR @SoLuong IS NULL
	PRINT N'DỮ LIỆU KHÔNG HỢP LỆ'

	ELSE
		INSERT INTO DatHang VALUES(@MaDatHang,@MaKH,@SoLuong,@DonGia)
--
EXEC DH 'DH002',001,2,NULL
EXEC DH 'DH001',001,NULL,NULL
SELECT * FROM KhachHang
SELECT * FROM DatHang

--
--Xây dựng hàm có đầu vào là MaKH, hàm trả về toàn bộ thông tin về khách của
--MaKH truyền vào: MaKH, TenKH, TaiKhoan, soluong, dongia,
--thanhtien (2.5 điểm)
-- Viết lời gọi hàm.
IF OBJECT_ID ('B3') IS NOT NULL
DROP FUNCTION B3
GO

CREATE FUNCTION B3 (@MAKH NVARCHAR(10))
	RETURNS TABLE 
AS
		RETURN (SELECT * FROM KHACHHANG WHERE MAKH=@MAKH)

SELECT*FROM B3(001)
--C4
--Viết một SP nhận một tham số đầu vào là đơn giá, SP này thực hiện thao tác xóa
--thông tin dathang và khachhang tương ứng nếu dongia lớn hơn giá trị tham số
--dongia đầu vào.
--Yêu cầu: Sử dụng giao dịch trong thân SP, để đảm bảo tính toàn vẹn dữ liệu khi một
--thao tác xóa thực hiện không thành công. (2.5 điểm)
-- Viết lời gọi SP thành công.


--Tạo view Lưu thông tin Top 3 khách hàng mua hàng với số tiền nhiều nhất:
--makh,tenkh, tổng tiền (1 điểm)
CREATE VIEW B5
AS
SELECT TOP 3 D.MAKH,TENKH,DonGia FROM KHACHHANG K JOIN DATHANG D ON K.MAKH=D.MAKH
ORDER BY DonGia DESC
JM
SELECT* FROM B5