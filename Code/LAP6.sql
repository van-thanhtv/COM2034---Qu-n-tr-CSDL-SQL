--Viết trigger rang buộc quy định mức lương của nhân viên không được <5000 cho thao tác thêm và cập nhật bảng nhân viên.
CREATE TRIGGER DEMO1
ON NHANVIEN
FOR INSERT,UPDATE
AS
	IF (SELECT LUONG FROM inserted)<5000
	BEGIN 
		PRINT N'Lương ko được < 5000'
		ROLLBACK TRANSACTION
	END


--Viết trigger rang buộc không được xóa nhân viên ở TP HCM
CREATE TRIGGER DEMO2
ON NHANVIEN
FOR DELETE
AS
	IF EXISTS (SELECT DCHI FROM deleted WHERE DCHI LIKE N'%TP HCM')
	BEGIN 
		PRINT N'không được xóa nhân viên ở TP HCM'
		ROLLBACK TRANSACTION
	END
--➢ Ràng buộc khi thêm mới nhân viên thì mức lương phải lớn hơn 15000, nếu vi phạm thì 
--xuất thông báo “luong phải >15000’
CREATE TRIGGER BAI1A
ON NHANVIEN
FOR INSERT,UPDATE
AS
	IF (SELECT LUONG FROM inserted)>15000
	BEGIN 
		PRINT N'luong phải >15000'
		ROLLBACK TRANSACTION
	END

--➢ Ràng buộc khi thêm mới nhân viên thì độ tuổi phải nằm trong khoảng 18 <= tuổi <=65.
CREATE TRIGGER BAI1B
ON NHANVIEN
FOR INSERT
AS
	IF (SELECT YEAR(GETDATE()-YEAR(NGSINH)) FROM inserted) < 18  OR (SELECT YEAR(GETDATE()-YEAR(NGSINH)) FROM inserted)>65
	BEGIN 
		PRINT N'độ tuổi phải nằm trong khoảng 18 <= tuổi <=65.'
		ROLLBACK TRANSACTION
	END
--➢ Ràng buộc khi cập nhật nhân viên thì không được cập nhật những nhân viên ở TP HCM
CREATE TRIGGER BAI2C
ON NHANVIEN
FOR UPDATE
AS
	IF EXISTS (SELECT DCHI FROM inserted WHERE DCHI LIKE N'%TP HCM')
	BEGIN 
		PRINT N'không được Cập nhập nhân viên ở TP HCM'
		ROLLBACK TRANSACTION
	END
--Hiển thị tổng số lượng nhân viên nữ, tổng số lượng nhân viên nam mỗi khi có hành động 
--thêm mới nhân viên.
CREATE TRIGGER BAI3A
ON NHANVIEN
AFTER INSERT
AS
	DECLARE @SLNAM INT,@SLNU INT
	SET @SLNAM=(SELECT COUNT(*) FROM NHANVIEN WHERE PHAI=N'Nam')
	SET @SLNAM=(SELECT COUNT(*) FROM NHANVIEN WHERE PHAI=N'Nữ')
	PRINT
--➢ Hiển thị tổng số lượng nhân viên nữ, tổng số lượng nhân viên nam mỗi khi có hành động 
--cập nhật phần giới tính nhân viên

--➢ Hiển thị tổng số lượng đề án mà mỗi nhân viên đã làm khi có hành động xóa trên bảng 
--DEAN
CREATE TRIGGER BAI3C
ON DEAN
AFTER DELETE
AS
	DECLARE @SLDEAN INT,@MANV VARCHAR(10)
	SET @MANV=(SELECT MA_NVIEN
	FROM PHANCONG)
	SET @SLDEAN=(SELECT COUNT(*),MA_NVIEN
	FROM PHANCONG
	GROUP BY MA_NVIEN) 
	PRINT N'SL ĐÊN ÁN NHÂN VIÊN '+@MANV+N'LÀ'+CAST(@SLDEAN AS NVARCHAR(10))

	SELECT * FROM DEAN