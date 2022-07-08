CREATE DATABASE QLDA
GO
USE QLDA
GO
-----------------------------------------------------------
-- Bước 1 : TẠO BẢNG VÀ KHÓA CHÍNH
-----------------------------------------------------------
create table PHONGBAN 
(
	TENPHG 	nvarchar(30),
	MAPHG 	int NOT NULL,
	TRPHG 	char(9),
	NG_NHANCHUC 	datetime,
	primary key (MAPHG)
)

create table NHANVIEN 
(
	HONV 	nvarchar(30),
	TENLOT 	nvarchar(30),
	TENNV 	nvarchar(30),
	MANV 	char(9) NOT NULL,
	NGSINH 	datetime,
	DCHI 	nvarchar(50),
	PHAI 	nchar(6),
	LUONG 	float,
	MA_NQL 	char(9),
	PHG 	int,
	primary key (MANV)	
)

create table DIADIEM_PHG
(
	MAPHG 	int NOT NULL,
	DIADIEM nvarchar(30) NOT NULL,
	primary key (MAPHG, DIADIEM)
)
create table CONGVIEC
(
	MADA	int NOT NULL,
	STT	int NOT NULL,
	TEN_CONG_VIEC nvarchar(50),
	primary key (MADA, STT)
)

create table PHANCONG 
(
	MA_NVIEN	char(9) NOT NULL,
	MADA 	int NOT NULL,
	STT		int NOT NULL, 
	THOIGIAN	decimal(5,1),
	primary key (MA_NVIEN, MADA, STT)
)

create table THANNHAN 
(
	MA_NVIEN char(9) NOT NULL,
	TENTN 	nvarchar(30) NOT NULL,
	PHAI 	nchar(6),
	NGSINH 	datetime,
	QUANHE 	nvarchar(16),
	primary key (MA_NVIEN, TENTN)
)

create table DEAN 
(
	TENDA nvarchar(30),
	MADA int NOT NULL,
	DDIEM_DA nvarchar(30),
	PHONG int,
	primary key (MADA)
)

-----------------------------------------------------------
-- Bước 2 : TẠO RÀNG BUỘC KHÓA NGOẠI
-----------------------------------------------------------
alter table NHANVIEN add constraint FK_NHANVIEN_NHANVIEN foreign key (MA_NQL) references  NHANVIEN(MANV)

alter table NHANVIEN add constraint FK_NHANVIEN_PHONGBAN foreign key (PHG) references  PHONGBAN(MAPHG)
-----------------------------------------------------------
alter table PHONGBAN add constraint FK_PHONGBAN_NHANVIEN foreign key (TRPHG) references  NHANVIEN(MANV)
-----------------------------------------------------------
alter table DIADIEM_PHG add constraint FK_DIADIEM_PHG_PHONGBAN foreign key (MAPHG) references  PHONGBAN(MAPHG)
-----------------------------------------------------------
alter table PHANCONG add constraint FK_PHANCONG_NHANVIEN foreign key (MA_NVIEN) references  NHANVIEN(MANV)
alter table PHANCONG add constraint FK_PHANCONG_CONGVIEC foreign key (MADA, STT) references  CONGVIEC(MADA, STT)
-----------------------------------------------------------
alter table CONGVIEC add constraint FK_CONGVIEC_DEAN foreign key (MADA) references  DEAN(MADA)
-----------------------------------------------------------
alter table THANNHAN add constraint FK_THANNHAN_NHANVIEN foreign key (MA_NVIEN) references  NHANVIEN(MANV)
-----------------------------------------------------------
alter table DEAN add constraint FK_DEAN_PHONGBAN foreign key (PHONG) references  PHONGBAN(MAPHG)
----------------------------------------------------------

-----------------------------------------------------------
-- Bước 3 : INSERT DỮ LIỆU 
-----------------------------------------------------------
--------------------INSERT PHONGBAN----------------------

insert into PHONGBAN
values(N'Nghiên cứu', 5, null, '05/22/1988')

insert into PHONGBAN
values(N'Điều hành', 4, null, '01/01/1995')

insert into PHONGBAN
values(N'Quản lý', 1, null, '06/19/1981')
----------------- INSERT NHANVIEN--------------------
insert into NHANVIEN 
values (N'Đinh',N'Bá',N'Tiến','009','02/11/1960',
	N'119 Cống Quỳnh, Tp HCM',N'Nam',30000,null,5)

insert into NHANVIEN
values (N'Nguyễn',N'Thanh',N'Tùng','005','08/20/1962',
	N'222 Nguyễn Văn Cừ, Tp HCM',N'Nam',40000,null,5)
insert into NHANVIEN
values (N'Bùi',N'Ngọc',N'Hằng','007','3/11/1954',
	N'332 Nguyễn Thái Học, Tp HCM',N'Nam',25000,null,4)

insert into NHANVIEN
values (N'Lê',N'Quỳnh',N'Như','001','02/01/1967',
	N'291 Hồ Văn Huê,  Tp HCM',N'Nữ',43000,null,4)

insert into NHANVIEN
values (N'Nguyễn',N'Mạnh',N'Hùng','004','03/04/1967',N'95 Bà Rịa, Vũng Tàu',N'Nam',38000,null,5)

insert into NHANVIEN
values (N'Trần',N'Thanh',N'Tâm','003','05/04/1957',N'34 Mai Thị Lựu, Tp HCM',N'Nam',25000,null,5)

insert into NHANVIEN
values (N'Trần',N'Hồng',N'Quang','008','09/01/1967',N'80 Lê Hồng Phong, Tp HCM',N'Nam',25000,null,4)

insert into NHANVIEN
values (N'Phạm',N'Văn',N'Vinh','006','01/01/1965',N'45 Trưng Vương, Hà Nội',N'Nữ',55000, null,	1)
----------------- UPDATE PHONGBAN--------------------
update  PHONGBAN
set TRPHG=N'005'
where MAPHG=5

update  PHONGBAN
set TRPHG=N'008'
where MAPHG=4

update  PHONGBAN
set TRPHG=N'006'
where MAPHG=1

----------------- UPDATE NHANVIEN--------------------

update  NHANVIEN set MA_NQL='005' where MANV=N'009'

update  NHANVIEN set MA_NQL='006' where MANV=N'005'

update  NHANVIEN set MA_NQL='001' where MANV='007'

update  NHANVIEN set MA_NQL='006' where MANV='001'

update  NHANVIEN set MA_NQL='005' where MANV='004'

update  NHANVIEN set MA_NQL='005' where MANV='003'

update  NHANVIEN set MA_NQL='001' where MANV='008'
-----------------INSERT DIADIEM_PHG --------------------
insert into DIADIEM_PHG
values(1,N'TP HCM')

insert into DIADIEM_PHG
values(4,N'Hà Nội')

insert into DIADIEM_PHG
values(5,N'Vũng Tàu')

insert into DIADIEM_PHG
values(5,N'Nha Trang')

insert into DIADIEM_PHG
values(5,N'TP HCM')
----------------- INSERT THANNHAN--------------------
insert into THANNHAN
values('005', N'Trinh', N'Nam', '04/05/1976', N'Con gái')

insert into THANNHAN
values('005', N'Khang', N'Nam', '10/25/1973', N'Con trai')

insert into THANNHAN
values('005', N'Phương', N'Nữ', '05/03/1948', N'Vợ chồng')

insert into THANNHAN
values('001', N'Minh', N'Nam', '02/28/1932', N'Vợ chồng')

insert into THANNHAN
values('009', N'Tiến', N'Nam', '01/01/1978', N'Con trai')

insert into THANNHAN
values('009', N'Châu', N'Nam', '12/30/1978', N'Con trai')

insert into THANNHAN
values('009', N'Phương', N'Nữ', '05/05/1957', N'Vợ chồng')
----------------- INSERT DEAN--------------------
insert into DEAN
values(N'Sản phẩm X', 1, N'Vũng Tàu', 5)

insert into DEAN
values(N'Sản phẩm Y', 2, N'Nha Trang', 5)

insert into DEAN
values(N'Sản phẩm Z', 3, N'TP HCM', 5)

insert into DEAN
values(N'Tin học hóa', 10, N'Hà Nội', 4)

insert into DEAN
values(N'Cáp quang', 20, N'TP HCM', 1)

insert into DEAN
values(N'Đào tạo', 30, N'Hà Nội', 4)

----------------- INSERT CONGVIEC--------------------
insert into CONGVIEC (MADA, STT, TEN_CONG_VIEC) 
values (1, 	1, 	N'Thiet ke san pham X')

insert into CONGVIEC (MADA, STT, TEN_CONG_VIEC) 
values (1, 	2, 	N'Thu nghiem san pham X')

insert into CONGVIEC (MADA, STT, TEN_CONG_VIEC) 
values (2, 	1, 	N'San xuat san pham Y')

insert into CONGVIEC (MADA, STT, TEN_CONG_VIEC) 
values (2, 	2, 	N'Quang cao san pham Y')

insert into CONGVIEC (MADA, STT, TEN_CONG_VIEC) 
values (3, 	1, 	N'Khuyen mai san pham Z')

insert into CONGVIEC (MADA, STT, TEN_CONG_VIEC) 
values (10, 	1, 	N'Tin hoc hoa nhan su tien luong')

insert into CONGVIEC (MADA, STT, TEN_CONG_VIEC) 
values (10, 	2, 	N'Tin hoc hoa phong Kinh doanh')

insert into CONGVIEC (MADA, STT, TEN_CONG_VIEC) 
values (20, 	1, 	N'Lap dat cap quang')

insert into CONGVIEC (MADA, STT, TEN_CONG_VIEC) 
values (30, 	1, 	N'Dao tao nhan vien Marketing')

insert into CONGVIEC (MADA, STT, TEN_CONG_VIEC) 
values (30, 	2,	N'Dao tao chuyen vien vien thiet ke')

insert into PHANCONG (MA_NVIEN,MADA,STT,THOIGIAN) 
values ('009',	1,	1,	32)

insert into PHANCONG (MA_NVIEN,MADA,STT,THOIGIAN) 
values ('009',	2,	2,	8)

insert into PHANCONG (MA_NVIEN,MADA,STT,THOIGIAN) 
values ('004',	3,	1,	40)

insert into PHANCONG (MA_NVIEN,MADA,STT,THOIGIAN) 
values ('003',	1,	2,	20.0)

insert into PHANCONG (MA_NVIEN,MADA,STT,THOIGIAN) 
values ('003',	2,	1,	20.0)

insert into PHANCONG (MA_NVIEN,MADA,STT,THOIGIAN) 
values ('008',	10,	1,	35)
----------------- INSERT PHANCONG--------------------

insert into PHANCONG (MA_NVIEN,MADA,STT,THOIGIAN) 
values ('008',	30,	2,	5)

insert into PHANCONG (MA_NVIEN,MADA,STT,THOIGIAN) 
values ('001',	30,	1,	20)

insert into PHANCONG (MA_NVIEN,MADA,STT,THOIGIAN) 
values ('001',	20,	1,	15)

insert into PHANCONG (MA_NVIEN,MADA,STT,THOIGIAN) 
values ('006',	20,	1,	30)

insert into PHANCONG (MA_NVIEN,MADA,STT,THOIGIAN) 
values ('005',	3,	1,	10)

insert into PHANCONG (MA_NVIEN,MADA,STT,THOIGIAN) 
values ('005',	10,	2,	10)

insert into PHANCONG (MA_NVIEN,MADA,STT,THOIGIAN) 
values ('005',	20,	1,	10)

insert into PHANCONG (MA_NVIEN,MADA,STT,THOIGIAN) 
values ('007',	30,	2,	30)

insert into PHANCONG (MA_NVIEN,MADA,STT,THOIGIAN) 
values ('007',	10,	2,	10)







																--2.2 GOM NHÓM 

--19 Cho biết số lượng đề án của công ty.
SELECT DA.*, COUNT (*) 'SỐ LƯỢNG ĐỀ ÁN'  
FROM DEAN DA 
GROUP BY DA.TENDA,DA.MADA, DA.DDIEM_DA,DA.PHONG

--20 Cho biết số lượng đề án do phòng 'Nghiên Cứu' chủ trì.
SELECT DA.*, COUNT (*) 'SỐ LƯỢNG ĐỀ ÁN'  
FROM DEAN DA JOIN PHONGBAN PB ON PB.MAPHG =DA.PHONG AND PB.TENPHG=N'Nghiên cứu'
GROUP BY DA.TENDA,DA.MADA, DA.DDIEM_DA,DA.PHONG

--21 Cho biết lương trung bình của các nữ nhân viên.
SELECT NV.* ,AVG(LUONG) 'LƯƠNG TRUNG BÌNH'
FROM NHANVIEN NV
WHERE NV.PHAI= N'NỮ'
GROUP BY NV.HONV,NV.TENLOT, NV.TENNV,NV.DCHI,NV.LUONG,NV.MA_NQL, NV.MANV, NV.NGSINH, NV.PHAI, NV.PHG

--22 .Cho biết số thân nhân của nhân viên 'Đinh Bá Tiến'.
SELECT TN.*, COUNT (*) 'THÂN NHÂN'
FROM THANNHAN TN JOIN NHANVIEN NV ON NV.MANV = TN. MA_NVIEN AND NV.HONV =N'ĐINH' AND NV.TENLOT =N'BÁ ' AND NV.TENNV =N'TIẾN'
GROUP BY TN.TENTN ,TN.MA_NVIEN,TN.NGSINH, TN.PHAI, TN.QUANHE

--23 Với mỗi đề án, liệt kê tên đề án và tổng số giờ làm việc một tuần của tất cả các nhân viên tham dự đề án đó
SELECT DA.TENDA , SUM ( THOIGIAN) 'TỔNG GIỜ LÀM VIỆC TRONG 1 TUẦN '
FROM DEAN DA  JOIN PHANCONG PC ON PC.MADA =DA.MADA
GROUP BY DA.TENDA

--24 .Với mỗi đề án, cho biết có bao nhiêu nhân viên tham gia đề án đó. Xuất ra mã đề án, tên đề án và số lượng nhân viên tham gia.
SELECT DA.MADA, DA.TENDA , COUNT (*) 'SỐ LƯỢNG NHÂN VIÊN THAM GIA'
FROM DEAN DA JOIN NHANVIEN NV ON DA.PHONG =NV.PHG
GROUP BY DA.MADA, DA.TENDA

--25 Với mỗi nhân viên, cho biết họ và tên nhân viên và số lượng thân nhân của nhân viên đó.
SELECT NV.HONV+' '+NV.TENLOT+' '+NV.TENNV 'HỌ VÀ TÊN', COUNT (*) 'SỐ LƯỢNG THÂN NHÂN'
FROM NHANVIEN NV JOIN THANNHAN TN ON NV.MANV=TN.MA_NVIEN
GROUP BY  NV.HONV+' '+NV.TENLOT+' '+NV.TENNV

--26.Với mỗi nhân viên, cho biết họ tên của nhân viên và số lượng đề án mà nhân viên đó đã tham gia.
SELECT NV.HONV,NV.TENLOT,NV.TENNV , COUNT(PC.MADA)[SO DE AN]
FROM NHANVIEN NV JOIN PHANCONG PC ON PC.MA_NVIEN = NV.MANV
GROUP BY NV.HONV,NV.TENLOT,NV.TENNV 

--27.Với mỗi nhân viên, cho biết số lượng nhân viên mà nhân viên đó quản lý trực tiếp.
SELECT NV.MANV , COUNT(NV2.MANV)[SO LUONG NHAN VIEN]
FROM NHANVIEN NV JOIN NHANVIEN NV2 ON NV2.MA_NQL = NV.MANV AND NV2.MANV != NV.MANV
GROUP BY NV.MANV

--28.Cho biết tên những nhân viên mà quản lý từ 2 nhân viên trở lên. Xuất ra họ, tên
--và tên phòng mà nhân viên đó làm việc
SELECT  NV.HONV +' ' + NV.TENLOT +' '+ NV.TENNV , PB.TENPHG
FROM NHANVIEN NV JOIN NHANVIEN NV2 ON NV2.MA_NQL = NV.MANV AND NV2.MANV != NV.MANV
JOIN PHONGBAN PB ON PB.MAPHG = NV.PHG
GROUP BY  NV.HONV , NV.TENNV ,NV.TENLOT, PB.TENPHG
HAVING COUNT(NV2.MANV) >= 2

--29.Với mỗi phòng ban, liệt kê tên phòng ban và lương trung bình của những nhân viên làm việc cho phòng ban đó.
SELECT PB.TENPHG , AVG(NV.LUONG)[AGV SALARY]
FROM PHONGBAN PB JOIN NHANVIEN NV ON NV.PHG = PB.MAPHG
GROUP BY PB.TENPHG 

--30.Với mỗi địa điểm, cho biết số lượng phòng ban tọa lạc tại địa điểm đó và số lượng đề án được triển khai tại địa điểm đó.
   

--31.Với các phòng ban có mức lương trung bình trên 30,000, liệt kê tên phòng ban và số lượng nhân viên của phòng ban đó.
SELECT PB.TENPHG ,COUNT(NV.MANV)[SO NHANVIEN]
FROM PHONGBAN PB JOIN NHANVIEN NV ON PB.MAPHG = NV.PHG
GROUP BY PB.TENPHG 
HAVING AVG(NV.LUONG) > 30000

--32.Với mỗi phòng ban, cho biết tên phòng ban và số lượng đề án mà phòng ban đó chủ trì
SELECT PB.TENPHG,COUNT(DA.MADA)[SO DEAN]
FROM PHONGBAN PB JOIN DEAN DA ON DA.PHONG = PB.MAPHG
GROUP BY PB.TENPHG


												--2.3 TRUY VẤN LỒNG + GOM NHÓM


--39 .Cho biết danh sách các đề án (MADA) được phân công cho nhân viên có họ (HONV) là 'Đinh' hoặc có người trưởng phòng chủ trì đề án có họ (HONV) là 'Đinh'.
SELECT DA.*, (SELECT NV.HONV+' '+NV.TENLOT+' '+NV.TENNV 'HỌ VÀ TÊN'
              FROM NHANVIEN NV 
			  WHERE NV.PHG=DA.PHONG AND NV.HONV=N'ĐINH'),
			  (SELECT COUNT (MADA)
			  FROM PHANCONG PC 
			  WHERE PC.MADA=DA.MADA)
FROM DEAN DA

--40 Danh sách những nhân viên (HONV, TENLOT, TENNV) có trên 2 thân nhân
SELECT NV.HONV+' '+NV.TENLOT+' '+NV.TENNV 'HỌ VÀ TÊN'
FROM NHANVIEN NV , (SELECT PC.MA_NVIEN, COUNT(*) SOLUONG
					FROM THANNHAN PC
					GROUP BY MA_NVIEN
					HAVING COUNT(*)>2) A
WHERE NV.MANV = A.MA_NVIEN

--41 Danh sách những nhân viên (HONV, TENLOT, TENNV) không có thân nhân nào.
SELECT  NV.HONV+' '+NV.TENLOT+' '+NV.TENNV 'HỌ VÀ TÊN'
FROM NHANVIEN NV
WHERE MANV NOT IN (SELECT MA_NVIEN
					FROM THANNHAN )

--42 Cho biết những nhân viên (HONV, TENLOT, TENNV) có nhiều thân nhân nhất.
SELECT NV.HONV+' '+NV.TENLOT+' '+NV.TENNV 'HỌ VÀ TÊN',COUNT(MANV) 'SỐ LƯỢNG NHÂN THÂN'
FROM NHANVIEN NV,THANNHAN TN
WHERE TN.MA_NVIEN=NV.MANV 
GROUP BY NV.HONV+' '+NV.TENLOT+' '+NV.TENNV 
HAVING COUNT(MANV) >= ALL (SELECT COUNT(MA_NVIEN)
							FROM THANNHAN
							GROUP BY MA_NVIEN)

--43.Cho biết địa điểm (DIADIEM) mà có nhiều phòng ban tọa lạc tại địa điểm đó nhất.
SELECT DD.DIADIEM
FROM DIADIEM_PHG DD, PHONGBAN PB
WHERE DD.MAPHG=PB.MAPHG
GROUP BY DD.DIADIEM 
HAVING COUNT(DIADIEM) >= ALL (SELECT COUNT(DIADIEM)
							FROM DIADIEM_PHG
							GROUP BY DIADIEM)

--44.Danh sách những trưởng phòng (HONV, TENLOT, TENNV) có tối thiểu một thân nhân.
SELECT  NV.HONV +' ' + NV.TENLOT +' '+ NV.TENNV [HOTEN NV]
FROM NHANVIEN NV JOIN PHONGBAN PB ON NV.MANV = PB.TRPHG 
JOIN THANNHAN TN ON NV.MANV = TN.MA_NVIEN
GROUP BY  NV.HONV , NV.TENNV ,NV.TENLOT
HAVING COUNT(TN.TENTN) > 1

--45.Tìm họ (HONV) của những trưởng phòng chưa có gia đình.
SELECT PB.TRPHG FROM PHONGBAN PB 
GROUP BY PB.TRPHG
HAVING PB.TRPHG IN (SELECT NV.MANV FROM NHANVIEN NV  
                   WHERE NV.MANV NOT IN (SELECT TN.MA_NVIEN FROM THANNHAN TN))
--46.Cho biết họ tên nhân viên (HONV, TENLOT, TENNV) có mức lương trên mức lương trung bình của phòng "Nghiên cứu".

SELECT  NV.HONV +' ' + NV.TENLOT +' '+ NV.TENNV FROM NHANVIEN NV 
GROUP BY NV.HONV , NV.TENLOT , NV.TENNV ,NV.LUONG
HAVING NV.LUONG > (SELECT AVG(NV1.LUONG) FROM NHANVIEN NV1 JOIN PHONGBAN PB ON NV1.PHG = PB.MAPHG AND PB.TENPHG = N'Nghiên cứu')

--47.Cho biết họ tên nhân viên (HONV, TENLOT, TENNV) có lương lớn nhất.
SELECT  NV.HONV +' ' + NV.TENLOT +' '+ NV.TENNV
FROM NHANVIEN NV
GROUP BY NV.HONV , NV.TENLOT , NV.TENNV,NV.LUONG
HAVING NV.LUONG = (SELECT MAX(LUONG) FROM NHANVIEN )

--48.Cho biết họ tên nhân viên có lương lớn nhất trong từng phòng ban.'
SELECT NV.HONV +' ' + NV.TENLOT +' '+ NV.TENNV , PB.TENPHG
FROM  NHANVIEN NV ,PHONGBAN PB
GROUP BY NV.HONV , NV.TENLOT , NV.TENNV , PB.TENPHG , NV.LUONG , NV.PHG , PB.MAPHG 
HAVING NV.PHG IN (SELECT PB.MAPHG) AND NV.LUONG = (SELECT MAX(NV2.LUONG) FROM NHANVIEN NV2 WHERE NV2.PHG = PB.MAPHG) 
--49.Cho biết tên những nhân viên vừa tham gia đề án “Đào Tạo” và đề án “Sản phẩm X”.
SELECT NV.TENNV
FROM NHANVIEN NV
GROUP BY NV.TENNV , NV.MANV
HAVING NV.MANV = (SELECT MANV FROM NHANVIEN JOIN DEAN DA ON DA.TENDA = N'Đào tạo' AND DA.TENDA = N'Sản phẩm X' 
											JOIN PHANCONG PC ON MANV = PC.MA_NVIEN AND PC.MADA = DA.MADA)

--50.Cho biết tên phòng ban và họ tên trưởng phòng của phòng ban có đông nhân viên nhất.
SELECT PB.TENPHG , NV2.HONV +' ' + NV2.TENLOT +' '+ NV2.TENNV 
FROM PHONGBAN PB JOIN NHANVIEN NV  ON NV.PHG = PB.MAPHG 
JOIN NHANVIEN NV2 ON NV2.MANV = PB.MAPHG
GROUP BY PB.TENPHG , PB.MAPHG ,NV2.HONV , NV2.TENLOT , NV2.TENNV
HAVING  COUNT(NV.MANV) >= ALL (SELECT (COUNT(MANV))
								FROM PHONGBAN JOIN NHANVIEN ON PHG = MAPHG
								GROUP BY MAPHG)

															--2.4 PHÉP CHIA

--55 .Danh sách những nhân viên (HONV, TENLOT, TENNV) làm việc trong mọi đề án của công ty.
SELECT  NV.HONV+' '+NV.TENLOT+' '+NV.TENNV 'HỌ VÀ TÊN'
FROM NHANVIEN NV
WHERE NOT EXISTS (SELECT DA.MADA
					FROM DEAN DA
					EXCEPT
					SELECT PC.MADA
					FROM PHANCONG PC
					WHERE PC.MA_NVIEN = NV. MANV)
--56 Danh sách những nhân viên (HONV, TENLOT, TENNV) được phân công tất cả đề án do phòng số 4 chủ trì
SELECT  NV.HONV+' '+NV.TENLOT+' '+NV.TENNV 'HỌ VÀ TÊN'
FROM NHANVIEN NV
WHERE NOT EXISTS (SELECT DA.MADA
					FROM DEAN DA
					WHERE DA.PHONG=4
					EXCEPT
					SELECT PC.MADA
					FROM PHANCONG PC
					WHERE PC.MA_NVIEN = NV. MANV)

--57.Tìm những nhân viên (HONV, TENLOT, TENNV) được phân công tất cả đề án mà
--nhân viên 'Đinh Bá Tiến' làm việc.

SELECT NV1.MANV
FROM NHANVIEN NV1 
WHERE NV1.HONV = N'Đinh' AND NV1.TENLOT = N'Bá' AND NV1.TENNV = N'Tiến' AND EXISTS (SELECT TRPHG FROM PHONGBAN 
																					WHERE NV1.MANV = TRPHG AND EXISTS (SELECT MA_NVIEN FROM PHANCONG WHERE  )) 


--58.Cho biết những nhân viên được phân công cho tất cả các công việc trong đề án 'Sản
--phẩm X'
SELECT NV.MANV
FROM NHANVIEN NV
WHERE EXISTS (	SELECT PC.MA_NVIEN
						FROM PHANCONG PC
						WHERE NV.MANV = PC.MA_NVIEN AND EXISTS (	SELECT DA.MADA
						FROM DEAN DA
						WHERE DA.TENDA = N'Sản phẩm X' AND PC.MADA = DA.MADA))

