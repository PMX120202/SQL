
-- Câu a In ra câu chào “Hello World !!!”.
if object_id('sp_HelloWorld', 'p') is not null
	drop proc sp_HelloWorld
go
CREATE PROCEDURE sp_HelloWorld
AS
	Print 'Hello World!!!'

Exec sp_HelloWorld

-- Câu b In ra tổng 2 số.
if object_id('sp_Sum_2_Print', 'p') is not null
	drop proc sp_Sum_2_Print
go
CREATE PROCEDURE sp_Sum_2_Print @So1 int, @So2 int
AS
	DECLARE @Tong int
	SET @Tong = @So1 + @So2
	Print @Tong

Exec sp_Sum_2_Print 1, -2

-- Câu c Tính tổng 2 số (sử dụng biến output để lưu kết quả trả về).
if object_id('sp_Sum_2', 'p') is not null
	drop proc sp_Sum_2
go
CREATE PROCEDURE sp_Sum_2 @So1 int, @So2 int, @Tong int out
AS
	SET @Tong = @So1 + @So2


DECLARE @Sum int
Exec sp_Sum_2 1, -2, @Sum out
Print @Sum

-- Câu d In ra tổng 3 số (Sử dụng lại stored procedure Tính tổng 2 số).
if object_id('sp_Sum_3_Print', 'p') is not null
	drop proc sp_Sum_3_Print
go
CREATE PROCEDURE sp_Sum_3_Print @So1 int, @So2 int,@So3 int
AS
	DECLARE @Tong int
	Exec sp_Sum_2 @So1, @So2, @Tong out
	SET @Tong = @Tong + @So3
	Print @Tong

Exec sp_Sum_3_Print 1, -2, 4

-- Câu e In ra tổng các số nguyên từ m đến n.
if object_id('sp_Sum_MN', 'p') is not null
	drop proc sp_Sum_MN
go
CREATE PROCEDURE sp_Sum_MN @m int, @n int
AS
	DECLARE @Tong int
	DECLARE @i int
	SET @Tong = 0
	SET @i = @m
	
	WHILE (@i < @n)
	BEGIN
		SET @Tong = @Tong + @i
		SET @i = @i + 1
	END
	
	Print @Tong


Exec sp_Sum_MN 1,6


-- Câu f Kiểm tra 1 số nguyên có phải là số nguyên tố hay không.
if OBJECT_ID('sp_check_NgTo','p') is not null
	drop proc sp_check_NgTo
go
CREATE PROCEDURE sp_check_NgTo @num int, @check bit out
AS
	DECLARE @bound float
	DECLARE @i int
	SET @check = 1
	SET @i = 2
	SET @bound = SQRT(@num)
	if (@num <2 ) SET @check = 0
	While (@i <= @bound)
	BEGIN
		IF (@num % @i = 0)
			BEGIN
				SET @check = 0
				break
			END
		SET @i = @i + 1		
	END


DECLARE @check bit
Exec sp_check_NgTo 5, @check out
IF (@check = 1)
	BEGIN
		Print N'5 là số nguyên tố.'
	END
ELSE
	BEGIN
		Print N'5 không là số nguyên tố.'
	END
	
Exec sp_check_NgTo 1, @check out
IF (@check = 1)
	BEGIN
		Print N'1 là số nguyên tố.'
	END
ELSE
	BEGIN
		Print N'1 không là số nguyên tố.'
	END
	
-- Câu g In ra tổng các số nguyên tố trong đoạn m, n.
if object_id('sp_Sum_NgTo_MN', 'p') is not null
	drop proc sp_Sum_NgTo_MN
go
CREATE PROCEDURE sp_Sum_NgTo_MN @m int, @n int
AS
	DECLARE @Tong int
	DECLARE @i int
	DECLARE @check bit
	SET @Tong = 0
	SET @i = @m
	
	While (@i <= @n)
	BEGIN
		Exec sp_check_NgTo @i, @check out
		IF (@check = 1)
			BEGIN
				SET @Tong = @Tong + @i
			END
			
		SET @i = @i + 1
	END
	Print N'Tổng các số nguyên tố trong [' + cast(@m as varchar(12)) + N', ' + cast(@n as varchar(12)) + '] = ' + cast(@Tong as varchar(12))


Exec sp_Sum_NgTo_MN 1, 5

-- Câu h Tính ước chung lớn nhất của 2 số nguyên.
if object_id('sp_GCD', 'p') is not null--UCLN
	drop proc sp_GCD
go
CREATE PROCEDURE sp_GCD @a int, @b int, @ret int out
AS
	SET @a = ABS(@a)
	SET @b = ABS(@b)
	
	IF (@a = 0 OR @b = 0)
		BEGIN
			SET @ret = @a + @b
		END
	ELSE
		BEGIN
			While (@a <> @b)
			BEGIN
				IF (@a > @b)
					SET @a = @a - @b
				ELSE
					SET @b = @b - @a
			END
		END
	SET @ret = @a


DECLARE @UCLN int
Exec sp_GCD 2, 7, @UCLN out
Print @UCLN

-- Câu i Tính bội chung nhỏ nhất của 2 số nguyên.
if object_id('sp_LCM', 'p') is not null
	drop proc sp_LCM
go
CREATE PROCEDURE sp_LCM @a int, @b int, @ret int out
AS
	DECLARE @temp int 
	
	Exec sp_GCD @a, @b, @temp out
	
	SET @ret = ABS(@a*@b)/@temp


DECLARE @LCM int
Exec sp_LCM 4, 14, @LCM out
Print @LCM

-- Cau j Xuất ra toàn bộ danh sách giáo viên.
if object_id('sp_DSGV', 'p') is not null
	drop proc sp_DSGV
go
CREATE PROCEDURE sp_DSGV
AS
	SELECT * FROM GIAOVIEN


Exec sp_DSGV


-- Câu k Tính số lượng đề tài mà một giáo viên đang thực hiện.
if object_id('sp_SLDT', 'p') is not null
	drop proc sp_SLDT
go
CREATE PROCEDURE sp_SLDT @MaGV varchar(9)
AS
	DECLARE @ret int
	SET @ret = (SELECT COUNT(DISTINCT MADT) FROM THAMGIADT WHERE MAGV = @MaGV GROUP BY MAGV)
	Print N'Số lượng đề tài của GV có MAGV = ' + @MaGV + ' là ' + CAST(@ret AS VARCHAR(12))


Exec sp_SLDT '003'

-- Câu l In thông tin chi tiết của một giáo viên(sử dụng lệnh print): Thông tin cá nhân, Số lượng đề tài tham gia, Số lượng thân nhân của giáo viên đó.
if object_id('sp_TTGV', 'p') is not null
	drop proc sp_TTGV
go
CREATE PROCEDURE sp_TTGV @MaGV varchar(9)
AS
	DECLARE @HoTen nvarchar(30)
	SET @HoTen = (SELECT HOTEN FROM GIAOVIEN WHERE MAGV = @MaGV)
	Print N'Họ tên: ' + @HoTen
	
	DECLARE @Luong decimal(18,1)
	SET @Luong = (SELECT LUONG FROM GIAOVIEN WHERE MAGV = @MaGV)
	Print N'Lương: ' + CAST(@Luong AS VARCHAR(12))
	
	DECLARE @NGSINH date
	SET @NGSINH = (SELECT NGSINH FROM GIAOVIEN WHERE MAGV = @MaGV)
	Print N'Ngày sinh: ' + CAST(@NGSINH AS VARCHAR(12))
	
	DECLARE @DiaChi nvarchar(50)
	Set @DiaChi = (SELECT DIACHI FROM GIAOVIEN WHERE MAGV = @MaGV)
	Print N'Địa chỉ: ' + @DiaChi
	
	DECLARE @SLDT int
	SET @SLDT = (SELECT COUNT(DISTINCT MADT) FROM THAMGIADT WHERE MAGV = @MaGV GROUP BY MAGV)
	Print N'SLDT: ' + CAST(@SLDT AS VARCHAR(12))
	
	DECLARE @SLNT int
	SET @SLNT = (SELECT COUNT(*) FROM NGUOITHAN WHERE MAGV = @MaGV GROUP BY MAGV)
	Print N'SLNT: ' + CAST(@SLNT AS VARCHAR(12))


Exec sp_TTGV '001'

-- Câu m Kiểm tra xem một giáo viên có tồn tại hay không (dựa vào MAGV).
if object_id('sp_CheckGVExist', 'p') is not null
	drop proc sp_CheckGVExist
go
CREATE PROCEDURE sp_CheckGVExist @MaGV varchar(9)
AS
	IF (EXISTS (SELECT *FROM GIAOVIEN WHERE MAGV=@MaGV ))
		Print N'Giao vien co ton tai' +' '+ @MaGV
	else 
		Print N'Giao vien khong ton tai'+' '+ @MaGV

 exec sp_CheckGVExist '102'

-- Câu n Kiểm tra quy định của một giáo viên: Chỉ được thực hiện các đề tài mà bộ môn của giáo viên đó làm chủ nhiệm.
if object_id('sp_CheckRuleGV', 'p') is not null
	drop proc sp_CheckRuleGV
go
CREATE PROCEDURE sp_CheckRuleGV @MaGV varchar(9), @MaDT varchar(3), @check bit out
AS
	DECLARE @GVCNDT varchar(3)
	SET @GVCNDT = (SELECT GVCNDT FROM DETAI WHERE MADT = @MaDT)
	
	IF ((SELECT MABM FROM GIAOVIEN WHERE MAGV = @MaGV) = (SELECT MABM FROM GIAOVIEN WHERE MAGV = @GVCNDT))
		BEGIN
			Print 'True'
			Set @check = 1
		END
	ELSE
		BEGIN
			Print 'False'
			Set @check = 0
		END


DECLARE @check bit
Exec sp_CheckRuleGV '001', '003', @check out
Exec sp_CheckRuleGV '001', '007', @check out

-- Câu o 
--Thực hiện thêm một phân công cho giáo viên thực hiện một công việc của đề tài:
--o Kiểm tra thông tin đầu vào hợp lệ: giáo viên phải tồn tại, công việc phải tồn tại, thời gian tham gia phải >0
--o Kiểm tra quy định ở câu n.
if object_id('sp_PhanCongCongViec', 'p') is not null
	drop proc sp_PhanCongCongViec
go
CREATE PROCEDURE sp_PhanCongCongViec @MaGV varchar(3), @MaDT varchar(3), @Stt int, @PhuCap int, @Ketqua nvarchar(3)
AS
	DECLARE @check bit
	SET @check = 1
	
	IF (NOT EXISTS(SELECT * FROM GIAOVIEN WHERE MAGV = @MaGV))
		BEGIN
			Print N'Lỗi! Mã GV không tồn tại!'
			SET @check = 0
		END
	
	IF (NOT EXISTS(SELECT * FROM CONGVIEC WHERE MADT = @MaDT AND SOTT = @Stt))
		BEGIN
			Print N'Lỗi! Công việc không tồn tại!'
			SET @check = 0
		END
	DECLARE @GVCNDT varchar(3)
	SET @GVCNDT = (SELECT GVCNDT FROM DETAI WHERE MADT = @MaDT)
	
	IF (@check = 1 AND (SELECT MABM FROM GIAOVIEN WHERE MAGV = @MaGV) <> (SELECT MABM FROM GIAOVIEN WHERE MAGV = @GVCNDT))
		BEGIN
			Print N'Lỗi! Đề tài không do bộ môn của GV làm chủ nhiệm!'
			Set @check = 0
		END
	-- Thêm phân công
	IF (@check = 1)
		BEGIN
			INSERT INTO THAMGIADT(MAGV, MADT, STT, PHUCAP, KETQUA)
			VALUES (@MaGV, @MaDT, @Stt, @PhuCap, @Ketqua)
			Print N'Phân công thành công.'
		END


Exec sp_PhanCongCongViec '001', '002', 3, 0, NULL

-- Câu p Thực hiện xoá một giáo viên theo mã. Nếu giáo viên có thông tin liên quan (Có thân nhân, có làm đề tài, ...) thì báo lỗi.
if object_id('sp_XoaGV', 'p') is not null
	drop proc sp_XoaGV
go
CREATE PROCEDURE sp_XoaGV @MaGV varchar(9)
AS
	DECLARE @check bit
	SET @check = 1
	
	IF (EXISTS(SELECT * FROM GIAOVIEN WHERE MAGV = @MaGV))
		BEGIN
			IF (EXISTS(SELECT * FROM NGUOITHAN WHERE MAGV = @MaGV))
				BEGIN
					Print N'Giáo viên tồn tại người thân! Lỗi!'
					SET @check = 0
				END
				
			IF (EXISTS(SELECT * FROM THAMGIADT WHERE MAGV = @MaGV))
				BEGIN
					Print N'Giáo viên có tham gia đề tại! Lỗi!'
					SET @check = 0
				END
				
			IF (EXISTS(SELECT * FROM BOMON WHERE TRUONGBM = @MaGV))
				BEGIN
					Print N'Giáo viên đang là trưởng bộ môn! Lỗi!'
					SET @check = 0
				END
				
			IF (EXISTS(SELECT * FROM KHOA WHERE TRUONGKHOA = @MaGV))
				BEGIN
					Print N'Giáo viên đang là trưởng khoa! Lỗi!'
					SET @check = 0
				END
				
			IF (EXISTS(SELECT * FROM DETAI WHERE GVCNDT = @MaGV))
				BEGIN
					Print N'Giáo viên đang chủ nhiệm đề tài! Lỗi!'
					SET @check = 0
				END
				
			IF (EXISTS(SELECT * FROM GV_DT WHERE MAGV = @MaGV))
				BEGIN
					Print N'Giáo viên có tồn tại số điện thoại! Lỗi!'
					SET @check = 0
				END
				
			IF (@check = 1)
				BEGIN
					DELETE FROM GIAOVIEN WHERE MAGV = @MaGV
					Print N'Xóa thành công.'
				END
		END
	ELSE
		Print N'Không tồn tại giáo viên có MAGV = ' + @MaGV

-- Test Câu p
Exec sp_XoaGV '011'

-- Câu q In ra danh sách giáo viên của một phòng ban nào đó cùng với số lượng đề tài mà giáo viên tham gia, số thân nhân, số giáo viên mà giáo viên đó quản lý nếu có, ...

if object_id('sp_DSGVQL', 'p') is not null
	drop proc sp_DSGVQL
go
CREATE PROCEDURE sp_DSGVQL
AS
	DECLARE cs_DSGV CURSOR FOR (SELECT MAGV FROM GIAOVIEN)
	OPEN cs_DSGV
	
	DECLARE @MaGV varchar(3)
	FETCH NEXT FROM cs_DSGV INTO @MaGV
	
	WHILE (@@FETCH_STATUS = 0)
	BEGIN
		DECLARE @HoTen nvarchar(30)
		SET @HoTen = (SELECT HOTEN FROM GIAOVIEN WHERE MAGV = @MaGV)
		Print N'Họ tên: ' + @HoTen
		
		DECLARE @Luong decimal(18,1)
		SET @Luong = (SELECT LUONG FROM GIAOVIEN WHERE MAGV = @MaGV)
		Print N'Lương: ' + CAST(@Luong AS VARCHAR(12))
		
		DECLARE @NGSINH date
		SET @NGSINH = (SELECT NGSINH FROM GIAOVIEN WHERE MAGV = @MaGV)
		Print N'Ngày sinh: ' + CAST(@NGSINH AS VARCHAR(12))
		
		DECLARE @DiaChi nvarchar(50)
		Set @DiaChi = (SELECT DIACHI FROM GIAOVIEN WHERE MAGV = @MaGV)
		Print N'Địa chỉ: ' + @DiaChi
		
		DECLARE @SLDT int
		SET @SLDT = (SELECT COUNT(DISTINCT MADT) FROM THAMGIADT WHERE MAGV = @MaGV GROUP BY MAGV)
		Print N'SLDT: ' + CAST(@SLDT AS VARCHAR(12))
		
		DECLARE @SLNT int
		SET @SLNT = (SELECT COUNT(*) FROM NGUOITHAN WHERE MAGV = @MaGV GROUP BY MAGV)
		Print N'SLNT: ' + CAST(@SLNT AS VARCHAR(12))
		
		DECLARE @SoGVQL int
		SET @SoGVQL = (SELECT COUNT(*) FROM GIAOVIEN WHERE GVQLCM = @MaGV)
		Print N'Số GV mà GV quản lý: ' + CAST(@SoGVQL AS VARCHAR(12))
		
		Print '-------------------------------------------------------------'
		FETCH NEXT FROM cs_DSGV INTO @MaGV  
	END
	
	CLOSE cs_DSGV
	DEALLOCATE cs_DSGV

Exec sp_DSGVQL

-- Câu r Kiểm tra quy định của 2 giáo viên a, b: Nếu a là trưởng bộ môn c của b thì lương của a phải cao hơn lương của b. (a, b: mã giáo viên)
if object_id('sp_CheckRuleGV_AB', 'p') is not null
	drop proc sp_CheckRuleGV_AB
go
CREATE PROCEDURE sp_CheckRuleGV_AB @MaGVA varchar(9), @MaGVB varchar(9)
AS
	IF ((SELECT MABM FROM GIAOVIEN WHERE MAGV = @MaGVA) = (SELECT MABM FROM GIAOVIEN WHERE MAGV = @MaGVB))
		IF (EXISTS(SELECT * FROM BOMON WHERE TRUONGBM = @MaGVA))
			IF ((SELECT LUONG FROM GIAOVIEN WHERE MAGV = @MaGVA) < (SELECT LUONG FROM GIAOVIEN WHERE MAGV = @MaGVB))
				BEGIN
					Print 'FALSE'
				END
			ELSE
				BEGIN
					Print 'TRUE'
				END
		ELSE 
			IF (EXISTS(SELECT * FROM BOMON WHERE TRUONGBM = @MaGVB))
				IF ((SELECT LUONG FROM GIAOVIEN WHERE MAGV = @MaGVA) > (SELECT LUONG FROM GIAOVIEN WHERE MAGV = @MaGVB))
					Print 'FALSE'
				ELSE
					Print 'TRUE'
			ELSE
				Print 'TRUE'
	ELSE
		Print 'TRUE'

Exec sp_CheckRuleGV_AB '003', '002'

-- Câu s Thêm một giáo viên: Kiểm tra các quy định: Không trùng tên, tuổi > 18, lương > 0
if object_id('sp_AddGV', 'p') is not null
	drop proc sp_AddGV
go
CREATE PROCEDURE sp_AddGV @MaGV varchar(9), @HoTen nvarchar(30), @Luong int, @Phai nchar(3), @NgSinh date, @DiaChi nvarchar(50), @GVQLCM varchar(3), @MaBM  nchar(4)
AS
	DECLARE @check bit
	SET @check = 1
	
	IF (EXISTS(SELECT * FROM GIAOVIEN WHERE HOTEN = @HoTen))
		BEGIN
			Print N'Lỗi! Trùng họ tên GV khác'
			SET @check = 0
		END
		
	IF (YEAR(GetDate()) - YEAR(@NgSinh) < 18)
		BEGIN
			Print N'Lỗi! Tuổi < 18'
			SET @check = 0
		END
		
	IF (@Luong <= 0)
		BEGIN
			Print N'Lỗi! Lương < 0'
			SET @check = 0
		END
	
	IF (@check = 1)
		BEGIN
			INSERT INTO GIAOVIEN(MAGV, HOTEN, LUONG, PHAI, NGSINH, DIACHI, GVQLCM, MABM)
			VALUES (@MaGV, @HoTen, @Luong, @Phai, @NgSinh, @DiaChi, @GVQLCM, @MaBM)
			Print N'Thêm thành công!'
		END

Exec sp_AddGV '011', N'ABC ', 1000, N'Nam', '12/02/2002', N'ABC HCM', NULL, NULL

-- Câu t Mã giáo viên được xác định tự động theo quy tắc: Nếu đã có giáo viên 001, 002, 003 thì MAGV của giáo viên mới sẽ là 004. Nếu đã có giáo viên 001, 002, 005 thì MAGV của giáo viên mới là 003.
if object_id('sp_Auto', 'p') is not null
	drop proc sp_Auto
go
CREATE PROCEDURE sp_Auto @MaGV varchar(3) out
AS
	DECLARE @num int
	DECLARE @temp varchar(3)
	SET @num = 1
	
	WHILE (1=1)
	BEGIN
		IF (@num < 10)
			BEGIN
				SET @temp = '00' + CAST(@num as varchar(1))
			END
		ELSE IF (@num < 100)
			BEGIN
				SET @temp = '0' + CAST(@num as varchar(2))
			END
		ELSE
			BEGIN
				SET @temp = CAST(@num as varchar(3))
			END
		
		IF (NOT EXISTS(SELECT * FROM GIAOVIEN WHERE MAGV = @temp))
			BEGIN
				Set @MaGV = @temp
				break
			END
		
		SET @num = @num + 1
	END

DECLARE @MaGV varchar(3)
Exec sp_Auto @MaGV out
Print @MaGV

