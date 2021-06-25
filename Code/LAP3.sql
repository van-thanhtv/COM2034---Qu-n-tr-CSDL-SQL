--LAP3
SELECT cast(123.2 as decimal(6,2))
SELECT REPLACE(RIGHT('(559) 555-1212', 13), ') ', '-')
SELECT DATEDIFF(month, '2008-09-30', '2007-12-01')
DECLARE @FullName VarChar(25) SET @FullName = 'www.poly.edu.vn' SELECT SUBSTRING(@FullName, 5, 4)

--Với mỗi đề án, liệt kê tên đề án và tổng số giờ làm việc một tuần của tất cả các nhân viên tham dự đề án đó. 
SELECT TENDEAN,CAST( SUM(THOIGIAN) AS decimal(10,2))
FROM PHANCONG P JOIN DEAN D ON P.MADA = D.MADA
GROUP BY TENDEAN
-- Xuất định dạng “tổng số giờ làm việc” kiểu varchar
SELECT TENDEAN,CAST( SUM(THOIGIAN) AS varchar(10))
FROM PHANCONG P JOIN DEAN D ON P.MADA = D.MADA
GROUP BY TENDEAN
--
SELECT TENDEAN,CONVERT(varchar(10),SUM(THOIGIAN)) AS TONGGIO
FROM PHANCONG P JOIN DEAN D ON P.MADA = D.MADA
GROUP BY TENDEAN
--Với mỗi phòng ban, liệt kê tên phòng ban và lương trung bình của những nhân viên làm việc cho phòng ban đó
SELECT TENPHG,CAST(AVG(LUONG) AS decimal(10,2)) AS BTLUONG
FROM PHONGBAN P JOIN NHANVIEN N ON N.PHG=P.MAPHG
GROUP BY TENPHG
--Xuất định dạng “luong trung bình” kiểu decimal với 2 số thập phân, sử dụng dấu phẩy để phân biệt phần nguyên và phần thập phân.
SELECT TENPHG,replace(CAST(AVG(LUONG) AS decimal(10,2)),'.',',')
FROM PHONGBAN P JOIN NHANVIEN N ON N.PHG=P.MAPHG
GROUP BY TENPHG
-- Xuất định dạng “luong trung bình” kiểu varchar. Sử dụng dấu phẩy tách cứ mỗi 3 chữ số trong chuỗi ra, gợi ý dùng thêm các hàm Left, Replace
SELECT DCHI,LEFT(DCHI,2) AS LEFT2,RIGHT(DCHI,3) AS DCHI3,
SUBSTRING(DCHI,LEN(DCHI)-2,3) AS DIACHI
FROM NHANVIEN
SELECT DCHI,
SUBSTRING(dchi ,charindex(' ',dchi),charindex(',' ,dchi) -charindex(' ',dchi) ) as 'Ten duong'
from NHANVIEN

--
SELECT TENNV,LOWER(SUBSTRING(TENNV,1,1))+UPPER(SUBSTRING(TENNV,2,1))+LOWER(SUBSTRING(TENNV,3,LEN(TENNV)-2))
FROM NHANVIEN
--Danh sách những nhân viên (HONV, TENLOT, TENNV, DCHI) có trên 2 thân nhân, thỏa các yêu cầu
--Dữ liệu cột HONV được viết in hoa toàn bộ
SELECT UPPER(HONV) AS HONV,TENLOT,TENNV,DCHI,COUNT(*) AS SOLUONG 
FROM NHANVIEN N JOIN THANNHAN T ON N.MANV=T.MA_NVIEN 
GROUP BY HONV,TENLOT,TENNV,DCHI 
HAVING COUNT(*)>2
--Dữ liệu cột TENLOT được viết chữ thường toàn bộ
SELECT HONV,LOWER(TENLOT) AS TENLOT,TENNV,DCHI,COUNT(*) AS SOLUONG 
FROM NHANVIEN N JOIN THANNHAN T ON N.MANV=T.MA_NVIEN 
GROUP BY HONV,TENLOT,TENNV,DCHI 
HAVING COUNT(*)>2
--Dữ liệu chột TENNV có ký tự thứ 2 được viết in hoa, các ký tự còn lại viết thường( ví dụ: kHanh)
SELECT TENNV,LOWER(SUBSTRING(TENNV,1,1))+UPPER(SUBSTRING(TENNV,2,1))+LOWER(SUBSTRING(TENNV,3,LEN(TENNV)-2))
FROM NHANVIEN
--Dữ liệu cột DCHI chỉ hiển thị phần tên đường, không hiển thị các thông tin khác như số nhà hay thành phố
SELECT DCHI,LEFT(DCHI,2) AS LEFT2,RIGHT(DCHI,3) AS DCHI3,
SUBSTRING(DCHI,LEN(DCHI)-2,3) AS DIACHI
FROM NHANVIEN
SELECT DCHI,
SUBSTRING(dchi ,charindex(' ',dchi),charindex(',' ,dchi) -charindex(' ',dchi) ) as 'Ten duong'
from NHANVIEN
--
SELECT TENPHG,N1.TENNV,COUNT(*) AS SL
FROM NHANVIEN N JOIN PHONGBAN P ON P.MAPHG=N.PHG
	JOIN NHANVIEN N1 ON N1.MANV = P.TRPHG
GROUP BY TENPHG,N1.TENNV
--
SELECT TENPHG,N1.TENNV,COUNT(*) AS SL
FROM NHANVIEN N JOIN PHONGBAN P ON P.MAPHG=N.PHG
	JOIN NHANVIEN N1 ON N1.MANV = P.TRPHG
GROUP BY TENPHG,N1.TENNV
HAVING COUNT(*) >= ALL(SELECT COUNT(*) FROM NHANVIEN GROUP BY PHG)
--Bài 2
-- Với mỗi đề án, liệt kê tên đề án và tổng số giờ làm việc một tuần của tất cả các nhân viên tham dự đề án đó.
SELECT TENDEAN,SUM(THOIGIAN) AS TONGGILAM
FROM DEAN D JOIN PHANCONG P ON D.MADA = P.MADA
GROUP BY TENDEAN
--Xuất định dạng “tổng số giờ làm việc” với hàm CEILING
SELECT TENDEAN,CEILING(SUM(THOIGIAN)) AS TONGGILAM
FROM DEAN D JOIN PHANCONG P ON D.MADA = P.MADA
GROUP BY TENDEAN
--Xuất định dạng “tổng số giờ làm việc” với hàm FLOOR
SELECT TENDEAN,FLOOR(SUM(THOIGIAN)) AS TONGGILAM
FROM DEAN D JOIN PHANCONG P ON D.MADA = P.MADA
GROUP BY TENDEAN
--Xuất định dạng “tổng số giờ làm việc” làm tròn tới 2 chữ số thập phân
SELECT TENDEAN,ROUND(SUM(THOIGIAN),2) AS TONGGILAM
FROM DEAN D JOIN PHANCONG P ON D.MADA = P.MADA
GROUP BY TENDEAN
--Cho biết họ tên nhân viên (HONV, TENLOT, TENNV) có mức lương trên mức lương trung bình (làm tròn đến 2 số thập phân) của phòng "Nghiên cứu"
SELECT HONV, TENLOT, TENNV
FROM NHANVIEN 
GROUP BY HONV, TENLOT,TENNV,LUONG
HAVING LUONG > ALL (SELECT ROUND(AVG(LUONG),2) FROM NHANVIEN N JOIN PHONGBAN P ON P.MAPHG=N.PHG GROUP BY MANV,TENPHG HAVING TENPHG = N'Nghiên cứu')
--BÀI 4
--Cho biết các nhân viên có năm sinh trong khoảng 1960 đến 1965.
SELECT TENNV,YEAR(NGSINH) AS NAM_SINH
FROM NHANVIEN
WHERE YEAR(NGSINH)>=1960 AND YEAR(NGSINH)<=1965
-- Cho biết tuổi của các nhân viên tính đến thời điểm hiện tại.
SELECT TENNV,YEAR(GETDATE())-YEAR(NGSINH) AS TUOI
FROM NHANVIEN
--Dựa vào dữ liệu NGSINH, cho biết nhân viên sinh vào thứ mấy
SELECT TENNV,DATENAME(WEEKDAY,NGSINH) AS THU
FROM NHANVIEN
--Cho biết số lượng nhân viên, tên trưởng phòng, ngày nhận chức trưởng phòng và ngày nhận chức trưởng phòng hiển thi theo định dạng dd-mm-yy (ví dụ 25-04-2019)
SELECT TENPHG,N1.TENNV,COUNT(*) AS SL,CONVERT(varchar(10),NG_NHANCHUC,105) as NGAY_NHAN_CHUC
FROM NHANVIEN N JOIN PHONGBAN P ON P.MAPHG=N.PHG
	JOIN NHANVIEN N1 ON N1.MANV = P.TRPHG
GROUP BY TENPHG,N1.TENNV,NG_NHANCHUC

--Lap3_them
--
--1. Cho biết danh sách sinh viên có điểm thi lớn nhất môn mob1014: thông tin hotensv, Điểm (điểm xuất định dạng kiểu float)
SELECT hotensv,CAST(diemthi as float) as diemthi
FROM ketqua k join sinhvien s on s.masv=k.masv
WHERE mamh='mob1014' AND diemthi >= ALL(SELECT diemthi FROM ketqua WHERE mamh = 'mob1014')
/*2. Cho biết danh sách sinh viên có điểm trên mức trung bình môn mob1014: thông
tin hotensv, Điểm (điểm xuất định dạng với kiểu decimal với 2 số thập phân, sử dụng
dấu phẩy để phân biệt phần nguyên và phần thập phân.)*/
SELECT hotensv,REPLACE(CAST(diemthi as decimal(10,2)),'.',',') as diemthi
FROM ketqua k join sinhvien s on s.masv=k.masv
WHERE diemthi >= ALL(SELECT AVG(diemthi) FROM ketqua WHERE mamh = 'mob1014')
--3. Cho biết danh sách sinh viên có tuổi lớn nhất: thông tin gồm hoten, tuổi (xuất định dạng tuổi kiểu nvarchar)
SELECT  hotensv,CAST(YEAR(GETDATE())-YEAR(ngaysinh) AS nvarchar(10)) AS TUOI
FROM sinhvien
WHERE YEAR(GETDATE())-YEAR(ngaysinh) >= ALL (SELECT YEAR(GETDATE())-YEAR(ngaysinh) FROM sinhvien)
--4. Cho biết khoa (makhoa,tenkhoa,soluong giáo viên) có số lượng giáo viên &gt;2 (in hoa cột tên khoa)
SELECT K.makhoa,UPPER(tenkhoa),COUNT(*) as sl_gv
FROM khoa K JOIN giangvien G ON G.makhoa=K.makhoa
GROUP BY K.makhoa,tenkhoa
HAVING COUNT(*)>2
--5. Đưa ra thông tin: malop,tenlop, so luong sinh vien của mỗi lớp (Dữ liệu cột TENLOP có ký tự thứ 3 được viết in hoa, các ký tự còn lại viết thường)
SELECT L.malop, LOWER(SUBSTRING(tenlop,1,2))+UPPER(SUBSTRING(tenlop,3,1))+LOWER(SUBSTRING(tenlop,4,LEN(tenlop)-3)) as Ten_lop,COUNT(*) AS SL_SV
FROM lop L JOIN sinhvien S ON S.malop=L.malop
GROUP BY L.malop,tenlop
--6. Đưa ra thông tin: malop, tenlop, so luong sinh vien của lớp có số lượng &gt;20 (in thường cột tên lớp)
SELECT L.malop,LOWER(tenlop) as Ten_lop,COUNT(*) AS SL_SV
FROM lop L JOIN sinhvien S ON S.malop=L.malop
GROUP BY L.malop,tenlop
HAVING COUNT(*)>20
--7. Đưa ra thông tin : masv,hoten, ngaysinh,tên lớp (ngaysinh hiển thi theo định dạng dd-mm-yy)
SELECT masv,hotensv,CONVERT(nvarchar(10),ngaysinh,105)AS NGAY_SINH,tenlop
FROM sinhvien S JOIN lop L ON S.malop=L.malop
--8. Đưa ra thông tin sinh viên cho biết sinh viên sinh vào thứ mấy,quý mấy,ngày bao nhiêu của năm
SELECT masv,ngaysinh,DATENAME(WEEKDAY,ngaysinh) as thu,DATENAME(DAYOFYEAR,ngaysinh) as ngay_cua_nam,DATEPART(QUARTER, ngaysinh) as quy
FROM sinhvien
--9. Đưa ra thông tin sinh viên:masv,hotensv, họ sinh viên (cắt chuỗi từ hotenssv)
SELECT masv,hotensv,SUBSTRING(hotensv,1,CHARINDEX(' ',hotensv))
FROM sinhvien