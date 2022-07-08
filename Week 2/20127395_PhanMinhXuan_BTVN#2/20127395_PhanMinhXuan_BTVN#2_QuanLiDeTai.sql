﻿USE MASTER 
GO
IF DB_ID('QLDT') IS NOT NULL
	DROP  DATABASE QLDT
CREATE DATABASE QLDT
GO
USE QLDT
GO
--TAO BẢNG KHOA
CREATE TABLE KHOA 
(
	MAKHOA VARCHAR(5) NOT NULL,
	TENKHOA  NVARCHAR(30) NOT NULL,
	NAMTL INT,
	PHONG CHAR(3), 
	DIENTHOAI CHAR(10) UNIQUE,
	TRUONGKHOA CHAR (3),
	NGAYNHANCHUC DATE

	CONSTRAINT PK_KHOA 
	PRIMARY KEY(MAKHOA)
)
--TẠO BẢNG GIÁO VIÊN
CREATE TABLE GIAOVIEN
(
	MAGV CHAR(3),
	HOTEN NVARCHAR(30),
	LUONG INT,
	PHAI NVARCHAR(5),
	NGAYSINH DATE,
	DIACHI NVARCHAR(50),
	GVQLCM CHAR(3),
	MABM VARCHAR(5)

	CONSTRAINT PK_GIAOVIEN
	PRIMARY KEY (MAGV)
	
)

--TẠO BẢNG BOMON
CREATE TABLE BOMON
(
	MABM VARCHAR(5),
	TENBM NVARCHAR(30) NOT NULL,
	PHONG CHAR(3),
	DIENTHOAI CHAR(10) UNIQUE,
	TRUONGBM CHAR(3),
	MAKHOA VARCHAR(5),
	NGAYNHANCHUC DATE

	CONSTRAINT PK_BOMON
	PRIMARY KEY(MABM) 
)

--TẠO BẢNG THAM GIA ĐÈ TÀI 
CREATE TABLE THAMGIADT
(
	MAGV  CHAR(3),
	MADT CHAR (3),
	STT INT,
	PHUCAP MONEY,
	KETQUA NVARCHAR (10)

	CONSTRAINT PK_THAMGIADT
	PRIMARY KEY (MAGV, MADT,STT)
)

--TAỌ BẢNG CONG VIỆC
CREATE TABLE CONGVIEC
(
	MADT CHAR (3),
	SOTT INT,
	TENCV NVARCHAR(50),
	NGAYBD DATE,
	NGAYKETTHUC DATE

	CONSTRAINT PK_CONGVIEC
	PRIMARY KEY ( MADT,SOTT)
)
--TẠO BẢNG ĐỀ TÀI 
CREATE TABLE DETAI
(
	MADT CHAR (3) ,
	TENDT NVARCHAR (50),
	CAPQL NVARCHAR (50),
	KINHPHI INT,
	NGAYBD DATE,
	NGAYKETTHUC DATE,
	MACD CHAR(5),
	GVCNDT CHAR(3)

	CONSTRAINT PK_DETAI
	PRIMARY KEY ( MADT)
)

--TẠO BẢN CHỦ ĐỀ 
CREATE TABLE CHUDE
(
	MACD  CHAR(5) NOT NULL,
	TENCD NVARCHAR (50)

	CONSTRAINT PK_CHUDE
	PRIMARY KEY (MACD)
)

--TẠO BẢNG NGƯỜI THÂN
CREATE TABLE NGUOITHAN
(
	MAGV  CHAR(3),
	TEN NVARCHAR (50),
	NGAYSINH DATE,
	PHAI NVARCHAR(5)

	CONSTRAINT PK_NGUOITHAN
	PRIMARY KEY (MAGV,TEN)
)

--TẠO BẢNG GV_DT
CREATE TABLE GV_DT
(
	MAGV  CHAR(3),
	DIENTHOAI CHAR (10)

	CONSTRAINT PK_GV_DT
	PRIMARY KEY (MAGV,DIENTHOAI)
)


--KHOA NGOAI
ALTER TABLE KHOA
ADD
	CONSTRAINT FK_KHOA_GIAOVIEN
	FOREIGN KEY(TRUONGKHOA) 
	REFERENCES GIAOVIEN
--KHÓA NGOẠI CHO BỘ MÔN -> KHOA 
ALTER TABLE BOMON
ADD
	CONSTRAINT FK_BOMON_KHOA
	FOREIGN KEY(MAKHOA) 
	REFERENCES KHOA
	--KHÓA NGOẠI CHO BỘ MÔN -> GIAO VIÊN
ALTER TABLE BOMON
ADD
	CONSTRAINT FK_TBM_GIAOVIEN
	FOREIGN KEY(TRUONGBM) 
	REFERENCES GIAOVIEN

	--KHÓA NGOẠI CHO GIAO VIÊN -> BỘ MÔN 
ALTER TABLE GIAOVIEN
ADD
	CONSTRAINT FK_GIAOVIEN_BOMON
	FOREIGN KEY(MABM) 
	REFERENCES BOMON
	--KHÓA NGOẠI CHO GIAO VIÊN -> GIAO VIÊN
ALTER TABLE GIAOVIEN
ADD
	CONSTRAINT FK_GIAOVIEN_GIAOVIEN
	FOREIGN KEY(GVQLCM) 
	REFERENCES GIAOVIEN

	--KHÓA NGOẠI CHO THAMGIADT -> CONG VIỆC
ALTER TABLE THAMGIADT
ADD
	CONSTRAINT FK_TGDT_CV
	FOREIGN KEY(MADT,STT) 
	REFERENCES CONGVIEC
	--KHÓA NGOẠI CHO THAMGIADT -> GIAO VIÊN
ALTER TABLE THAMGIADT
ADD
	CONSTRAINT FK_TGDT_GV
	FOREIGN KEY(MAGV) 
	REFERENCES GIAOVIEN
	--KHÓA NGOẠI CHO CÔNG VIỆC  -> ĐỀ TÀI 
ALTER TABLE CONGVIEC
ADD
	CONSTRAINT FK_CV_DT
	FOREIGN KEY(MADT) 
	REFERENCES DETAI

ALTER TABLE DETAI
ADD
-- ĐỀ TÀI -> GIÁO VIÊN 
	CONSTRAINT FK_DT_GV
	FOREIGN KEY(GVCNDT) 
	REFERENCES GIAOVIEN,
--ĐỀ TÀI -> CHỦ ĐỀ 
	CONSTRAINT FK_DT_CD
	FOREIGN KEY(MACD) 
	REFERENCES CHUDE

--KHÓA NGOẠI CHO NGƯỜI THÂN -> GIÁO VIÊN 
ALTER TABLE NGUOITHAN
ADD
	CONSTRAINT FK_NT_GV
	FOREIGN KEY(MAGV) 
	REFERENCES GIAOVIEN

--KHÓA NGOẠI CHO GV_DT -> GIAO VIÊN
ALTER TABLE GV_DT
ADD
	CONSTRAINT FK_GV_DT_GV
	FOREIGN KEY(MAGV) 
	REFERENCES GIAOVIEN


-- NHAP LIEU CHO KHOA 
INSERT INTO KHOA VALUES ('CNTT',N'Công nghệ thông tin', 1995,'B11',0838123456,NULL,'02/20/2005')
INSERT INTO KHOA VALUES ('HH',N'Hóa học', 1980,'B41',0838456456,NULL,'10/15/2005')
INSERT INTO KHOA VALUES ('SH',N'Sinh học', 1980,'B31',0838454545,NULL,'10/11/2005')
INSERT INTO KHOA VALUES ('VL',N'Vật lí', 1976,'B21',0838223223,NULL,'09/18/2005')
--NHẬP DL CHO BỘ MÔN 
INSERT INTO BOMON VALUES ('CNTT',N'Công nghệ tri thức','B15',0838126126,NULL,'CNTT',NULL)
INSERT INTO BOMON VALUES ('HHC',N'Hóa hữu cơ','B44',838222222,NULL,'HH',NULL)
INSERT INTO BOMON VALUES ('HL',N'Hóa lí','B42',0838878787,NULL,'HH',NULL)
INSERT INTO BOMON VALUES ('HPT',N'Hóa phân tích ','B43',0838777777,NULL,'HH',NULL)
INSERT INTO BOMON VALUES ('HTTT',N'Hệ thống thông tin','B13',0838125125,NULL,'CNTT',NULL)
INSERT INTO BOMON VALUES ('MMT',N'Mạng máy tính','B16',0838676767,NULL,'CNTT',NULL)
INSERT INTO BOMON VALUES ('SH',N'Sinh hóa','B33',0838898989,NULL,'SH',NULL)
INSERT INTO BOMON VALUES ('VLDT',N'Vật lí điện tử','B23',0838234234,NULL,'VL',NULL)
INSERT INTO BOMON VALUES ('VLUD',N'Vật lí ứng dụng','B24',0838454545,NULL,'VL',NULL)
INSERT INTO BOMON VALUES ('VS',N'Vi sinh','B32',0838909090,NULL,'SH',NULL)
-- NHAP LIEU CHO GIÁO VIÊN 
INSERT INTO GIAOVIEN VALUES ('001',N'Nguyễn Hoài An', 2000,N'Nam','02/15/1973',N'25/3 Lạc Long Quân, Q.10, TP HCM',NULL,'MMT')
INSERT INTO GIAOVIEN VALUES ('002',N'Trần Trà Hương', 2500,N'Nữ','06/20/1960',N'125 Trần Hưng Đạo ,Q.1, TP HCM',NULL,'HTTT')
INSERT INTO GIAOVIEN VALUES ('003',N'Nguyễn Ngọc Ánh', 2200,N'Nữ','05/11/1975',N'12/21 Võ Văn Ngân Thủ Đức, TP HCM','002','HTTT')
INSERT INTO GIAOVIEN VALUES ('004',N'Trương Nam Sơn', 2300,N'Nam','06/20/1959',N'215 Lý Thường Kiệt,TP Biên Hòa',NULL,'VS')
INSERT INTO GIAOVIEN VALUES ('005',N'Lý Hoàng Hà', 2500,N'Nam','10/23/1954',N'22/5 Nguyễn Xí, Q.Bình Thạnh, TP HCM',NULL,'VLDT')
INSERT INTO GIAOVIEN VALUES ('006',N'Trần Bạch Tuyết', 1500,N'Nữ','05/20/1980',N'127 Hùng Vương,TP Mỹ Tho','004','VS')
INSERT INTO GIAOVIEN VALUES ('007',N'Nguyễn An Trung', 2100,N'Nam','06/05/1975',N'234 3/2,TP Biên Hòa',NULL,'HPT')
INSERT INTO GIAOVIEN VALUES ('008',N'Trần Trung Hiếu', 1800,N'Nam','08/06/1977',N'22/11 Lý Thường Kiệt, TP Mỹ Tho','007','HPT')
INSERT INTO GIAOVIEN VALUES ('009',N'Trần Hoàng Nam', 2000,N'Nam','11/22/1975',N'234 Trần Não ,An Phú , TP HCM','001','MMT')
INSERT INTO GIAOVIEN VALUES ('010',N'Pham Nam Thanh', 1500,N'Nam','12/12/1980',N'221 Hùng Vương, Q.5, TP HCM','007','HPT')

UPDATE KHOA
SET TRUONGKHOA ='002' WHERE MAKHOA ='CNTT'
UPDATE KHOA
SET TRUONGKHOA ='007' WHERE MAKHOA ='HH'
UPDATE KHOA
SET TRUONGKHOA ='004' WHERE MAKHOA ='SH'
UPDATE KHOA
SET TRUONGKHOA ='005' WHERE MAKHOA ='VL'


UPDATE BOMON
SET TRUONGBM='007' WHERE MABM='HPT'
UPDATE BOMON
SET TRUONGBM='002' WHERE MABM='HTTT'
UPDATE BOMON
SET TRUONGBM='001' WHERE MABM='MMT'
UPDATE BOMON
SET TRUONGBM='005' WHERE MABM='VLUD'
UPDATE BOMON
SET TRUONGBM='004' WHERE MABM='VS'


UPDATE BOMON
SET NGAYNHANCHUC='10/15/2007' WHERE MABM='HPT'
UPDATE BOMON
SET NGAYNHANCHUC='09/20/2004' WHERE MABM='HTTT'
UPDATE BOMON
SET NGAYNHANCHUC='05/15/2005' WHERE MABM='MMT'
UPDATE BOMON
SET NGAYNHANCHUC='02/18/2006' WHERE MABM='VLUD'
UPDATE BOMON
SET NGAYNHANCHUC='01/01/2007' WHERE MABM='VS'
--NHAP LIEU CHO CHU DE 
INSERT INTO CHUDE VALUES ('NCPT',N'Nghiên cứu phát triển')
INSERT INTO CHUDE VALUES ('QLGD',N'Quản lí giáo dục')
INSERT INTO CHUDE VALUES ('UDCN',N'Ứng dụng công nghệ')

--NHẬP LIỆU CHO ĐỀ TÀI 
INSERT INTO DETAI VALUES ('001',N'HTTT quản lí trường ĐH',N'DHQG',20,'10/20/2007','10/20/2008','QLGD','002')
INSERT INTO DETAI VALUES ('002',N'HTTT quản lí giáo vụ cho một Khoa',N'Trường',20,'10/12/2000','10/12/2001','QLGD','002')
INSERT INTO DETAI VALUES ('003',N'Nghiên cứu chế tạo sợ Nano Platin',N'DHQG',300,'05/15/2008','05/15/2010','NCPT','005')
INSERT INTO DETAI VALUES ('004',N'Taoj vật liệu sinh học bằng màng ối người ',N'Nhà nước',100,'01/01/2007','12/31/2009','NCPT','004')
INSERT INTO DETAI VALUES ('005',N'Ứng dụng hóa học xanh',N'Trường',200,'10/10/2003','12/10/2004','UDCN','007')
INSERT INTO DETAI VALUES ('006',N'Nghiên cứu tế bào gốc',N'Nhà nước',4000,'10/20/2006','10/20/2009','NCPT','004')
INSERT INTO DETAI VALUES ('007',N'HTTT quản lý thư viện ở các trưòng ĐH',N'Trường',20,'05/10/2007','05/10/2010','QLGD','001')


--NHẬP DỮ LIỆU CHO CÔNG VIỆC 
INSERT INTO CONGVIEC VALUES ('001',1,N'Khởi tạo và lập kế hoạch','10/20/2007','12/20/2008' )
INSERT INTO CONGVIEC VALUES ('001',2,N'Xác định yêu cầu','12/21/2008','03/21/2008' )
INSERT INTO CONGVIEC VALUES ('001',3,N'Phân tích hệ thống','03/22/2008','05/22/2008' )
INSERT INTO CONGVIEC VALUES ('001',4,N'Thiết kế hệ thống ','05/23/2008','06/23/2008' )
INSERT INTO CONGVIEC VALUES ('001',5,N'Cài đặt thử nghiệm','06/24/2008','10/20/2009' )
INSERT INTO CONGVIEC VALUES ('002',1,N'Khởi tạo và lập kế hoạch ','05/10/2009','07/10/2009' )
INSERT INTO CONGVIEC VALUES ('002',2,N'Xác định yêu cầu','07/11/2009','10/11/2009' )
INSERT INTO CONGVIEC VALUES ('002',3,N'Phân tích hệ thống','10/12/2009','12/20/2009' )
INSERT INTO CONGVIEC VALUES ('002',4,N'Thiết kế hệ thống','12/21/2009','03/22/2010' )
INSERT INTO CONGVIEC VALUES ('002',5,N'Cài đặt thử nghiệm','03/23/2010','05/10/2010' )
INSERT INTO CONGVIEC VALUES ('006',1,N'LấY mẫu','10/20/2006','02/20/2007' )
INSERT INTO CONGVIEC VALUES ('006',2,N'Nuôi cấy','02/21/2007','08/21/2008' )

--NHẬP DỮ LIỆU THAM GIA ĐỀ TÀI 
INSERT INTO THAMGIADT VALUES('001','002',1,0,NULL)
INSERT INTO THAMGIADT VALUES('001','002',2,2,NULL)
INSERT INTO THAMGIADT VALUES('002','001',4,2,N'đạt')
INSERT INTO THAMGIADT VALUES('003','001',1,1,N'đạt')
INSERT INTO THAMGIADT VALUES('003','001',2,0,N'đạt')
INSERT INTO THAMGIADT VALUES('003','001',4,1,N'đạt')
INSERT INTO THAMGIADT VALUES('003','002',2,0,NULL)
INSERT INTO THAMGIADT VALUES('004','006',1,0,N'đạt')
INSERT INTO THAMGIADT VALUES('004','006',2,1,N'đạt')
INSERT INTO THAMGIADT VALUES('006','006',2,1,N'đạt')
INSERT INTO THAMGIADT VALUES('009','002',3,0,NULL)
INSERT INTO THAMGIADT VALUES('009','002',4,1,NULL)


--NHẬP DỮ LIỆU NGƯỜI THÂN 
INSERT INTO NGUOITHAN VALUES('001',N'Hùng','01/14/1990',N'Nam')
INSERT INTO NGUOITHAN VALUES('001',N'Thủy','12/08/1994',N'Nữ')
INSERT INTO NGUOITHAN VALUES('003',N'Hà','09/03/1998',N'Nữ')
INSERT INTO NGUOITHAN VALUES('003',N'Thu','09/03/1998',N'Nữ')
INSERT INTO NGUOITHAN VALUES('007',N'Mai','03/26/2003',N'Nữ')
INSERT INTO NGUOITHAN VALUES('007',N'Vy','02/14/2000',N'Nữ')
INSERT INTO NGUOITHAN VALUES('008',N'Nam','05/06/1991',N'Nam')
INSERT INTO NGUOITHAN VALUES('009',N'An','08/19/1996',N'Nam')
INSERT INTO NGUOITHAN VALUES('010',N'Nguyệt','01/14/2006',N'Nữ')

--NHẬP DỮ LIỆU GV-DT
INSERT INTO GV_DT VALUES ('001','0838912112')
INSERT INTO GV_DT VALUES ('001','0903123123')
INSERT INTO GV_DT VALUES ('002','0913454545')
INSERT INTO GV_DT VALUES ('003','0838121212')
INSERT INTO GV_DT VALUES ('003','0903656565')
INSERT INTO GV_DT VALUES ('003','0937125125')
INSERT INTO GV_DT VALUES ('006','0937888888')
INSERT INTO GV_DT VALUES ('008','0653717171')
INSERT INTO GV_DT VALUES ('008','0913232323')


ALTER TABLE GIAOVIEN
ADD
	CONSTRAINT CKL
	CHECK (LUONG >=0)
--Q1
SELECT * FROM GIAOVIEN 

SELECT GV.HOTEN ,GV.LUONG
FROM GIAOVIEN GV
WHERE GV.PHAI=N'Nữ'
--Q3
SELECT DISTINCT GV.MAGV
FROM GIAOVIEN GV , BOMON BM
WHERE ( GV.HOTEN LIKE N'Nguyễn %' AND GV.LUONG>2000) OR (GV.MAGV =BM.TRUONGBM AND YEAR(BM.NGAYNHANCHUC) >1995)
--Q5
SELECT DISTINCT BM.MABM,BM.TENBM, GV.MAGV
FROM GIAOVIEN GV , BOMON BM
WHERE GV.MAGV =BM.TRUONGBM
--Q7
SELECT DT.TENDT ,GV.HOTEN
FROM GIAOVIEN GV , DETAI DT
WHERE GV.MAGV = DT.GVCNDT
--Q9
SELECT  GV.HOTEN
FROM GIAOVIEN GV , BOMON BM, DETAI DT
WHERE GV.MAGV =BM.TRUONGBM AND BM.TENBM=N'VI SINH' AND DT.MADT='006'
--Q11 KO BK LAM 
SELECT  GV.HOTEN
FROM GIAOVIEN GV 
WHERE GV.MAGV=GV.GVQLCM
--Q13
SELECT GV.HOTEN
FROM GIAOVIEN GV , BOMON BM
WHERE GV.MAGV =BM.TRUONGBM AND BM.TENBM=N'HỆ THỐNG THÔNG TIN'
--Q15 chua xong 
SELECT CV.TENCV
FROM DETAI DT , CONGVIEC CV
WHERE DT.MADT=CV.MADT AND DT.TENDT=N'HTTT quản lí trường ĐH' AND   CV.NGAYBD like '03/__/2005'
--Q17
SELECT CV.TENCV
FROM CONGVIEC CV 
WHERE CV.NGAYBD BETWEEN '01/01/2007' AND '08/01/2007'
--Q19
SELECT DISTINCT GV.HOTEN
FROM DETAI DT ,BOMON BM, GIAOVIEN GV
WHERE DT.GVCNDT=BM.TRUONGBM AND GV.MAGV=BM.TRUONGBM
--Q21
SELECT DISTINCT GV.HOTEN
FROM DETAI DT ,BOMON BM, GIAOVIEN GV
WHERE DT.GVCNDT=BM.TRUONGBM AND GV.MAGV=BM.TRUONGBM
--Q23 DK THU 1 BI SAI
SELECT DISTINCT GV.MAGV
FROM DETAI DT ,BOMON BM, GIAOVIEN GV
WHERE (GV.MABM=BM.MABM  AND BM.MABM ='HTTP') OR (DT.GVCNDT=GV.MAGV  AND DT.MADT='001' )
--Q25
SELECT  GV.HOTEN
FROM GIAOVIEN GV , BOMON BM
WHERE GV.MAGV=BM.TRUONGBM