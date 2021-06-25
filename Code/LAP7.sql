--Câu 1
--➢ Nhập vào MaNV cho biết tuổi của nhân viên này.
ALTER FUNCTION fn_C1A(@MaNV VARCHAR(10))
RETURNS INT 
AS
BEGIN 
		RETURN (SELECT YEAR(GETDATE())- YEAR(NGSINH) FROM NHANVIEN WHERE MANV=@MaNV)
END
GO
--Gọi hàm
PRINT N'Tuổi nhân viên là '+CAST(dbo.fn_C1A('002') AS NVARCHAR(10))
--
--➢ Nhập vào Manv cho biết số lượng đề án nhân viên này đã tham gia
CREATE FUNCTION fn_C1B(@MaNV VARCHAR(10))
RETURNS INT 
AS
BEGIN 
		RETURN (SELECT COUNT(MADA) FROM PHANCONG WHERE MA_NVIEN=@MaNV)
END
GO
--➢ Truyền tham số vào phái nam hoặc nữ, xuất số lượng nhân viên theo phái
CREATE FUNCTION fn_C1C(@PHAI NVARCHAR(10))
RETURNS INT 
AS
BEGIN 
		RETURN (SELECT COUNT(*) FROM NHANVIEN WHERE PHAI=@PHAI)
END
GO
--➢ Truyền tham số đầu vào là tên phòng, tính mức lương trung bình của phòng đó, Cho biết 
--họ tên nhân viên (HONV, TENLOT, TENNV) có mức lương trên mức lương trung bình 
--của phòng đó.
ALTER FUNCTION fn_C1D(@TENP NVARCHAR(20))
RETURNS TABLE 
AS
	RETURN (
		SELECT HONV,TENLOT,TENNV 
		FROM NHANVIEN N JOIN PHONGBAN P ON P.MAPHG = N.PHG
		GROUP BY HONV,TENLOT,TENNV ,TENPHG,LUONG
		HAVING LUONG>=AVG(LUONG) AND @TENP=TENPHG
	)
GO
--
SELECT * FROM DBO.fn_C1D(N'CNTT')

--➢ Tryền tham số đầu vào là Mã Phòng, cho biết tên phòng ban, họ tên người trưởng phòng 
--và số lượng đề án mà phòng ban đó chủ trì.
CREATE FUNCTION fn_C1E(@MAP VARCHAR(10))
RETURNS TABLE 
AS
	RETURN (
		SELECT TENPHG,N1.HONV+N1.TENLOT+N1.TENNV AS TENTRP,COUNT(*) AS SL
		FROM NHANVIEN N JOIN PHONGBAN P ON P.MAPHG=N.PHG
		JOIN NHANVIEN N1 ON N1.MANV = P.TRPHG
		GROUP BY TENPHG,N1.TENNV,P.MAPHG
		HAVING P.MAPHG =@MAP
	)
GO
--
SELECT * FROM DBO.fn_C1E('03')

--Câu 2
--➢ Hiển thị thông tin HoNV,TenNV,TenPHG, DiaDiemPhg.
CREATE VIEW V_BAI2A
AS
SELECT 
FROM DEAN D JOIN PHONGBAN P ON P.MAPHG=D.PHONG
	JOIN NHANVIEN N ON N.PHG=P.MAPHG

--➢ Hiển thị thông tin TenNv, Lương, Tuổi.

--➢ Hiển thị tên phòng ban và họ tên trưởng phòng của phòng ban có đông nhân viên nhất