﻿--B2
IF OBJECT_ID('B2') IS NOT NULL 
DROP PROC B2
GO
CREATE PROC (

)
AS
	IF @ IS NULL OR @ IS NULL OR @ IS NULL OR @ IS NULL OR @IS NULL
	PRINT 'Không được để trống'
	ELSE 
	INSERT INTO  VALUES (@,@,@,@,@)
EXEC B2
--B3
IF OBJECT_ID('B3') IS NOT NULL
DROP FUNCTION B3
GO
CREATE FUNCTION B3 (@MAKH VARCHAR(10))
RETURNS INT
AS
BEGIN
	RETURN (SELECT FROM )
END
--
SELECT DBO.B3()
----------------------------------------------------
--B4 XOA--
IF OBJECT_ID ('B4') IS NOT NULL
DROP PROC B4
GO
CREATE PROC B4(@MAKH)
AS
BEGIN TRY
	--BANG TAM
	DECLARE @TAM TABLE (MA VARCHAR(10))
	INSERT INTO @TAM
	SELECT FROM
	BEGIN TRAN
		--KHOA NGOAI
		DELETE
		WHERE
		--KHOA CHINH
		DELETE
		WHERE
	COMMIT TRAN
END TRY
BEGIN CATCH
	ROLLBACK TRAN
END CATCH
--
EXEC B4 ''
-----------
--B5 VIEW 
IF OBJECT_ID('B5') IS NOT NULL
DROP VIEW B5
GO
CREATE VIEW B5
	AS 
	SELECT TOP 2 
	GROUP BY 
	ORDER BY  DESC
SELECT * FROM B5
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