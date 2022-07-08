﻿USE MASTER 
GO
IF DB_ID('QLCB') IS NOT NULL
	DROP  DATABASE QLCB
CREATE DATABASE QLCB
GO
USE QLCB
GO
--TAO BẢNG KHOA

CREATE TABLE KHACHHANG 
(
	MAKH CHAR (15) NOT NULL,
	TEN CHAR (15),
	DCHI VARCHAR (50),
	DTHOAI CHAR(12) 

	CONSTRAINT PK_KHACHHANG
	PRIMARY KEY (MAKH)
)

CREATE TABLE NHANVIEN 
(
	MANV CHAR (15),
	TEN CHAR (15),
	DCHI VARCHAR (50),
	DTHOAI CHAR(12)UNIQUE ,
	LUONG FLOAT,
	LOAINV BIT

	CONSTRAINT PK_NHANVIEN
	PRIMARY KEY (MANV)
)

CREATE TABLE LOAIMB
(
	HANGSX CHAR (15),
	MALOAI CHAR(15)

	CONSTRAINT PK_LOAIMB
	PRIMARY KEY (MALOAI)
)

CREATE TABLE MAYBAY 
(
	SOHIEU INT,
	MALOAI CHAR(15)

	CONSTRAINT PK_MAYBAY
	PRIMARY KEY (SOHIEU,MALOAI)
)

CREATE TABLE CHUYENBAY
(
	MACB CHAR (4),
	SBDI CHAR (3),
	SBDEN CHAR(3),
	GIODI TIME,
	GIODEN TIME

	CONSTRAINT PK_CHUYENBAY
	PRIMARY KEY (MACB)
)

CREATE TABLE LICHBAY
(
	NGAYDI DATE,
	MACB CHAR (4),
	SOHIEU INT,
	MALOAI CHAR (15)

	CONSTRAINT PK_LICHBAY
	PRIMARY KEY (NGAYDI,MACB)
)

CREATE TABLE DATCHO
(
	MAKH CHAR (15),
	NGAYDI DATE,
	MACB CHAR (4)

	CONSTRAINT PK_DATCHO
	PRIMARY KEY (MAKH,NGAYDI,MACB)
)

CREATE TABLE KHANANG
(
	MANV CHAR(15),
	MALOAI CHAR(15)

	CONSTRAINT PK_KHANANG
	PRIMARY KEY (MANV, MALOAI)
)

CREATE TABLE PHANCONG
(
	MANV CHAR (15),
	NGAYDI DATE,
	MACB CHAR (4)

	CONSTRAINT PK_PHANCONG
	PRIMARY KEY (MANV,NGAYDI,MACB)
)

--KHOA NGOAI

ALTER TABLE DATCHO 
ADD 
	CONSTRAINT FK_DATCHO_KHACHHANG
	FOREIGN KEY(MAKH) 
	REFERENCES KHACHHANG,

	CONSTRAINT FK_DATCHO_LICHBAY
	FOREIGN KEY(NGAYDI,MACB) 
	REFERENCES LICHBAY


ALTER TABLE LICHBAY
ADD 
	CONSTRAINT FK_LICHBAY_CHUYENBAY
	FOREIGN KEY(MACB) 
	REFERENCES CHUYENBAY,

	CONSTRAINT FK_LICHBAY_MAYBAY
	FOREIGN KEY(SOHIEU,MALOAI) 
	REFERENCES MAYBAY


ALTER TABLE MAYBAY
ADD 
	CONSTRAINT FK_MAYBAY_LOAIMB
	FOREIGN KEY(MALOAI) 
	REFERENCES LOAIMB

ALTER TABLE KHANANG
ADD 
	CONSTRAINT FK_KHANANG_LOAIMB
	FOREIGN KEY(MALOAI) 
	REFERENCES LOAIMB,

	CONSTRAINT FK_KHANANG_NHANVIEN
	FOREIGN KEY(MANV) 
	REFERENCES NHANVIEN

ALTER TABLE PHANCONG
ADD 
	CONSTRAINT FK_PC_NV
	FOREIGN KEY(MANV) 
	REFERENCES NHANVIEN,
	
	CONSTRAINT FK_PC_LB
	FOREIGN KEY(NGAYDI,MACB) 
	REFERENCES LICHBAY

	--NHAP DL
INSERT INTO KHACHHANG VALUES ('0009' ,'Nga',' 223 Nguyen Trai ','8932320')
INSERT INTO KHACHHANG VALUES ('0101' ,'Anh',' 567 Tran Phu ','8826729')
INSERT INTO KHACHHANG VALUES ('0045' ,'Thu','285 Le Loi ','8932203')
INSERT INTO KHACHHANG VALUES ('0012' ,'Ha','435 Quang Trung ','8933232')
INSERT INTO KHACHHANG VALUES ('0238' ,'Hung',' 456 Pasteur ','9812101')
INSERT INTO KHACHHANG VALUES ('0397' ,'Thanh',' 234 Le Van Si ','8952943')
INSERT INTO KHACHHANG VALUES ('0582' ,'Mai',' 789 Nguyen Du ',NULL)
INSERT INTO KHACHHANG VALUES ('0934' ,'Minh',' 678 Le Lai ',NULL )
INSERT INTO KHACHHANG VALUES ('0091' ,'Hai',' 345 Hung Vuong ','8893223')
INSERT INTO KHACHHANG VALUES ('0314' ,'Phuong',' 395 Vo Van Tan ','8232320')
INSERT INTO KHACHHANG VALUES ('0613' ,'Vu',' 348 CMT8 ','8343232')
INSERT INTO KHACHHANG VALUES ('0586' ,'Son',' 123 Bach Dang ','8556223')
INSERT INTO KHACHHANG VALUES ('0422' ,'Tien','75 Nguyen Thong','8332222')

INSERT INTO LOAIMB VALUES ('Airbus', 'A310')
INSERT INTO LOAIMB VALUES ('Airbus', 'A320')
INSERT INTO LOAIMB VALUES ('Airbus', 'A330')
INSERT INTO LOAIMB VALUES ('Airbus', 'A340')
INSERT INTO LOAIMB VALUES ('Boeing', 'B727')
INSERT INTO LOAIMB VALUES ('Boeing', 'B747')
INSERT INTO LOAIMB VALUES ('Boeing', 'B757')
INSERT INTO LOAIMB VALUES ('MD', 'DC10')
INSERT INTO LOAIMB VALUES ('MD', 'DC9')

INSERT INTO NHANVIEN VALUES('1006', 'Chi', '12/6 Nguyen Kiem', '8120012', 150000 ,0)
INSERT INTO NHANVIEN VALUES('1005', 'Giao', '65 Nguyen Thai Son', '8324467', 500000 ,0)
INSERT INTO NHANVIEN VALUES('1001', 'Huong', '8 Dien Bien Phu', '8330733', 500000 ,1)
INSERT INTO NHANVIEN VALUES('1002', 'Phong', '1 Ly Thuong Kiet', '8308117', 450000 ,1)
INSERT INTO NHANVIEN VALUES('1004', 'Phuong', '351 Lac Long Quan', '8308155', 250000 ,0)
INSERT INTO NHANVIEN VALUES('1003', 'Quang', '78 Truong Dinh', '8324461', 350000 ,1)
INSERT INTO NHANVIEN VALUES('1007', 'Tam', '36 Nguyen Van Cu', '8458188', 500000 ,0)

INSERT INTO KHANANG VALUES('1001', 'B727')
INSERT INTO KHANANG VALUES('1001', 'B747')
INSERT INTO KHANANG VALUES('1001', 'DC10')
INSERT INTO KHANANG VALUES('1001', 'DC9')
INSERT INTO KHANANG VALUES('1002', 'A320')
INSERT INTO KHANANG VALUES('1002', 'A340')
INSERT INTO KHANANG VALUES('1002', 'B757')
INSERT INTO KHANANG VALUES('1002', 'DC9')
INSERT INTO KHANANG VALUES('1003', 'A310')
INSERT INTO KHANANG VALUES('1003', 'DC9')

INSERT INTO MAYBAY VALUES (10, 'B747')
INSERT INTO MAYBAY VALUES (11, 'B727')
INSERT INTO MAYBAY VALUES (13, 'B727')
INSERT INTO MAYBAY VALUES (13, 'B747')
INSERT INTO MAYBAY VALUES (21, 'DC10')
INSERT INTO MAYBAY VALUES (21, 'DC9')
INSERT INTO MAYBAY VALUES (22, 'B757')
INSERT INTO MAYBAY VALUES (22, 'DC9')
INSERT INTO MAYBAY VALUES (23, 'DC9')
INSERT INTO MAYBAY VALUES (24, 'DC9')
INSERT INTO MAYBAY VALUES (70, 'A310')
INSERT INTO MAYBAY VALUES (80, 'A310')
INSERT INTO MAYBAY VALUES (93, 'B757')


INSERT INTO CHUYENBAY VALUES('100','SLC','BOS',' 08:00',' 17:50')
INSERT INTO CHUYENBAY VALUES('112','DCA','DEN',' 14:00',' 18:07')
INSERT INTO CHUYENBAY VALUES('121','STL','SLC',' 04:00',' 09:13')
INSERT INTO CHUYENBAY VALUES('122','STL','YYV',' 08:30',' 10:19')
INSERT INTO CHUYENBAY VALUES('206','DFW','STL',' 09:00',' 11:40')
INSERT INTO CHUYENBAY VALUES('330','JFK','YYV',' 16:00',' 18:53')
INSERT INTO CHUYENBAY VALUES('334','ORD','MIA',' 12:00',' 14:14')
INSERT INTO CHUYENBAY VALUES('335','MIA','ORD',' 15:00',' 17:14')
INSERT INTO CHUYENBAY VALUES('336','ORD','MIA',' 18:00',' 20:14')
INSERT INTO CHUYENBAY VALUES('337','MIA','ORD',' 20:30',' 23:53')
INSERT INTO CHUYENBAY VALUES('394','DFW','MIA',' 19:00',' 21:20')
INSERT INTO CHUYENBAY VALUES('395','MIA','DFW',' 21:00',' 23:43')
INSERT INTO CHUYENBAY VALUES('449','CDG','DEN',' 10:00',' 19:29')
INSERT INTO CHUYENBAY VALUES('930','YYV','DCA',' 13:00',' 16:10')
INSERT INTO CHUYENBAY VALUES('931','DCA','YYV',' 17:00',' 18:10')
INSERT INTO CHUYENBAY VALUES('932','DCA','YYV',' 18:00',' 19:10')
INSERT INTO CHUYENBAY VALUES('991','BOS','ORD',' 17:00',' 12:22')

INSERT INTO LICHBAY VALUES('11/01/2000', '100', 80, 'A310')
INSERT INTO LICHBAY VALUES('11/01/2000', '112', 21, 'DC10')
INSERT INTO LICHBAY VALUES('11/01/2000', '206', 22, 'DC9')
INSERT INTO LICHBAY VALUES('11/01/2000', '334', 10, 'B747')
INSERT INTO LICHBAY VALUES('11/01/2000', '395', 23, 'DC9')
INSERT INTO LICHBAY VALUES('11/01/2000', '991', 22, 'B757')
INSERT INTO LICHBAY VALUES('11/01/2000', '337', 10, 'B747')
INSERT INTO LICHBAY VALUES('10/31/2000', '100', 11, 'B727')
INSERT INTO LICHBAY VALUES('10/31/2000', '112', 11, 'B727')
INSERT INTO LICHBAY VALUES('10/31/2000', '206', 13, 'B727')
INSERT INTO LICHBAY VALUES('10/31/2000', '334', 10, 'B747')
INSERT INTO LICHBAY VALUES('10/31/2000', '335', 10, 'B747')
INSERT INTO LICHBAY VALUES('10/31/2000', '337', 24, 'DC9')
INSERT INTO LICHBAY VALUES('10/31/2000', '449', 70, 'A310')

INSERT INTO DATCHO VALUES ('0009',' 11/01/2000' ,'100')
INSERT INTO DATCHO VALUES ('0009',' 10/31/2000' ,'449')
INSERT INTO DATCHO VALUES ('0045',' 11/01/2000' ,'991')
INSERT INTO DATCHO VALUES ('0012',' 10/31/2000' ,'206')
INSERT INTO DATCHO VALUES ('0238',' 10/31/2000' ,'334')
INSERT INTO DATCHO VALUES ('0582',' 11/01/2000' ,'991')
INSERT INTO DATCHO VALUES ('0091',' 11/01/2000' ,'100')
INSERT INTO DATCHO VALUES ('0314',' 10/31/2000' ,'449')
INSERT INTO DATCHO VALUES ('0613',' 11/01/2000' ,'100')
INSERT INTO DATCHO VALUES ('0586',' 11/01/2000' ,'991')
INSERT INTO DATCHO VALUES ('0586',' 10/31/2000' ,'100')
INSERT INTO DATCHO VALUES ('0422',' 10/31/2000' ,'449')

INSERT INTO PHANCONG VALUES('1001', '11/01/2000', '100')
INSERT INTO PHANCONG VALUES('1001', '10/31/2000', '100')
INSERT INTO PHANCONG VALUES('1002', '11/01/2000', '100')
INSERT INTO PHANCONG VALUES('1002', '10/31/2000', '100')
INSERT INTO PHANCONG VALUES('1003', '10/31/2000', '100')
INSERT INTO PHANCONG VALUES('1003', '10/31/2000', '337')
INSERT INTO PHANCONG VALUES('1004', '10/31/2000', '100')
INSERT INTO PHANCONG VALUES('1004', '10/31/2000', '337')
INSERT INTO PHANCONG VALUES('1005', '10/31/2000', '337')
INSERT INTO PHANCONG VALUES('1006', '11/01/2000', '991')
INSERT INTO PHANCONG VALUES('1006', '10/31/2000', '337')
INSERT INTO PHANCONG VALUES('1007', '11/01/2000', '112')
INSERT INTO PHANCONG VALUES('1007', '11/01/2000', '991')
INSERT INTO PHANCONG VALUES('1007', '10/31/2000', '206')

SELECT *FROM CHUYENBAY
SELECT *FROM DATCHO
SELECT *FROM LOAIMB
SELECT *FROM NHANVIEN
SELECT *FROM KHANANG
SELECT *FROM KHACHHANG
SELECT *FROM LICHBAY
SELECT *FROM MAYBAY
SELECT *FROM PHANCONG