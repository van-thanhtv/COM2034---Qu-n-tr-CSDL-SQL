-- 1. Xóa thông tin kết quả học tập của sv có mã sinh viên do người dùng nhập vào
CREATE PROC B1 (@MASINH NVARCHAR(20))
AS
	DELETE FROM KETQUA
	WHERE MASV=@MASINH
--
EXEC B1 N'001'
--2. Cho biết danh sách sinh viên có mã sv và tuổi do người dùng nhập vào
CREATE PROC B2 (@MASV NVARCHAR(20), @TUOI INT)
AS
SELECT * FROM SINHVIEN
WHERE MASV=@MASV AND YEAR(GETDATE())-YEAR(NGAYSINH)=@TUOI

--
EXEC B2 N's001',21
--3. Cho biết kết quả học tập gồm: Hoten, MAMH, LANTHI, DIEM cua sinhvien có
--mã sv do người dùng nhạp vào
CREATE PROC B3 (@MASVIEN NVARCHAR(20))
AS
SELECT hotensv,MAMH,LANTHI,DIEMTHI FROM SINHVIEN S 
JOIN ketqua Q ON S.masv=Q.masv
WHERE S.masv=@MASVIEN

--
EXEC B3 N's001'

--4. Đưa ra thông tin: malop,tenlop, so luong sinh vien của lớp có mã lớp do người
--dùng nhập vào
CREATE PROC B4 (@MALOP NVARCHAR(20))
AS
SELECT L.MALOP,tenlop,COUNT(MASV)AS SOLUONG FROM lop L 
JOIN khoa K ON L.makhoa=K.makhoa JOIN sinhvien S ON L.malop=S.malop
WHERE L.malop=@MALOP
GROUP BY L.malop,tenlop
SELECT * FROM LOP
--
EXEC B4 N'L1'

--5. Cho biết danh sách sinh viên có điểm thi lớn nhất môn có mamh do người dùng
--nhập vào
ALTER PROC B5(@MAMH NVARCHAR(30))
AS
SELECT mamh,diemthi
FROM KETQUA
where diemthi >= all(SELECT diemthi FROM ketqua WHERE mamh=@MAMH) and mamh=@MAMH
--

EXEC B5 N'mob1014'

--6. Cho biết danh sách sinh viên có điểm trên mức trung bình môn có mamh do người
--dùng nhập vào
CREATE PROC B6 (@MAMH NVARCHAR(20))
AS
SELECT * FROM sinhvien S JOIN ketqua K ON S.masv=K.masv
WHERE diemthi > ALL (SELECT AVG(diemthi) FROM ketqua) AND mamh = @MAMH

--
EXEC B6 N'COM107'
--7. Nhập vào @Magv xuất thông tin các giáo viên theo @Magv.
CREATE PROC B7 (@MAGV NVARCHAR(20))
AS
SELECT * FROM giangvien
WHERE magv=@MAGV
--
EXEC B7 N'gv1'
--8. Nhập vào @Mkhoa. cho biết số lượng giáo viên của khoa
CREATE PROC B8 (@MAKHOA NVARCHAR(20))
AS
SELECT COUNT(*)AS SOLUONG FROM khoa K JOIN giangvien G ON K.makhoa=G.makhoa
WHERE K.makhoa=@MAKHOA
--
EXEC B8 N'K1'
--9. Nhập vào @Magv và @hoten giáo viên cho biết số lượng lớp mà giáo viên dạy
CREATE PROC B9 (@MAGVV NVARCHAR(20),@HOTEN NVARCHAR(50))
AS
	SELECT COUNT(P.MAGV) AS SOLUONG FROM LOP L 
	JOIN phancong P ON L.malop=P.malop JOIN giangvien G ON G.magv=P.magv
	WHERE P.magv=@MAGVV AND hotengv=@HOTEN
	SELECT * FROM giangvien
	--
	EXEC B9 N'gv2',N'Trần Văn Thành '
select * from phancong
--10. Nhập vào @makhoa (mã khoa), xuất thông tin các lớp có khoa là @makhoa mà lớp
--không có sinh viên tham gia
CREATE PROC B10 (@MKHOA NVARCHAR(20))
AS
SELECT * FROM lop
WHERE makhoa = @MKHOA AND malop NOT IN (SELECT malop FROM sinhvien)
--
EXEC B10 N'K3'