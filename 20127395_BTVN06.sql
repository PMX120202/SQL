--20127395_PHAN MINH XUÂN
--TRUY VÂN LỒNG ĐỀ TÀI 


--Q36. Cho biết những giáo viên có lương lớn nhất.
SELECT GV.HOTEN
FROM GIAOVIEN GV 
WHERE LUONG >= ALL ( SELECT LUONG FROM GIAOVIEN)
--Q38. Cho biết tên giáo viên lớn tuổi nhất của bộ môn Hệ thống thông tin.
SELECT GV.HOTEN
FROM  GIAOVIEN GV,BOMON BM 
WHERE BM.MABM=GV.MABM AND BM.TENBM=N'Hệ thống thông tin'
GROUP BY GV.HOTEN,GV.NGSINH
HAVING DATEDIFF ( YEAR , GV.NGSINH ,GETDATE())>=ALL (SELECT DATEDIFF ( YEAR , GV.NGSINH ,GETDATE())
													   FROM  GIAOVIEN GV,BOMON BM 
													   WHERE BM.MABM=GV.MABM AND BM.TENBM=N'Hệ thống thông tin'
													   GROUP BY GV.NGSINH)
--Q40. Cho biết tên giáo viên và tên khoa của giáo viên có lương cao nhất.
SELECT GV.HOTEN, K.TENKHOA
FROM GIAOVIEN GV , BOMON BM, KHOA K
WHERE GV.MABM=BM.MABM AND BM.MAKHOA=K.MAKHOA AND LUONG >= ALL ( SELECT LUONG FROM GIAOVIEN )
--Q42. Cho biết tên những đề tài mà giáo viên Nguyễn Hoài An chưa tham gia.
SELECT DT.TENDT
FROM DETAI DT, GIAOVIEN GV
WHERE GV.HOTEN=N'Nguyễn Hoài An' AND DT.MADT NOT IN ( SELECT MADT FROM THAMGIADT )
--Q44. Cho biết tên những giáo viên khoa Công nghệ thông tin mà chưa tham gia đề tài nào.
SELECT GV.HOTEN 
FROM GIAOVIEN GV , BOMON BM, KHOA K
WHERE GV.MABM=BM.MABM AND BM.MAKHOA=K.MAKHOA AND K.TENKHOA=N'Công nghệ thông tin' AND NOT EXISTS ( SELECT*
																								   FROM THAMGIADT TG
																								   WHERE TG.MAGV=GV.MAGV)
--Q46. Cho biết giáo viên có lương lớn hơn lương của giáo viên “Nguyễn Hoài An”
SELECT GV.HOTEN
FROM GIAOVIEN GV 
WHERE LUONG > ( SELECT LUONG FROM GIAOVIEN WHERE HOTEN =N'Nguyễn Hoài An')
--Q48. Tìm giáo viên trùng tên và cùng giới tính với giáo viên khác trong cùng bộ môn
SELECT DISTINCT GV1.HOTEN --CHUA XONG
FROM GIAOVIEN GV1, GIAOVIEN GV2,BOMON BM1, BOMON BM2
WHERE BM1.MABM=BM2.MABM AND GV1.HOTEN=GV2.HOTEN AND GV1.PHAI=GV2.PHAI
--Q50. Tìm những giáo viên có lương lớn hơn lương của tất cả giáo viên thuộc bộ môn “Hệ thống thông tin”
SELECT DISTINCT GV.HOTEN--CON SAI 
FROM GIAOVIEN GV , BOMON BM
WHERE LUONG >= ALL ( SELECT LUONG FROM GIAOVIEN GV1 , BOMON BM WHERE  GV1.MABM=BM.MABM  AND BM.TENBM=N'Hệ thống thông tin' )
--Q52. Cho biết họ tên giáo viên chủ nhiệm nhiều đề tài nhất
SELECT GV.HOTEN
FROM GIAOVIEN GV ,DETAI DT
WHERE DT.GVCNDT=GV.MAGV
GROUP BY GV.HOTEN
HAVING COUNT (DT.GVCNDT )>=ALL (SELECT COUNT (DT.GVCNDT )
								FROM  DETAI DT
								GROUP BY DT.GVCNDT)
--Q54. Cho biết tên giáo viên và tên bộ môn của giáo viên tham gia nhiều đề tài nhất.
SELECT GV.HOTEN,BM.TENBM
FROM GIAOVIEN GV , BOMON BM, THAMGIADT TG
WHERE GV.MABM=BM.MABM AND GV.MAGV=TG.MAGV
GROUP BY GV.MAGV,GV.HOTEN,BM.TENBM
HAVING COUNT (TG.MADT) >=ALL (SELECT COUNT (DT.MADT )
								FROM  THAMGIADT DT
								GROUP BY DT.MADT,MAGV)
--Q56. Cho biết tên giáo viên và tên bộ môn của giáo viên có nhiều người thân nhất.
SELECT GV.HOTEN,BM.TENBM
FROM GIAOVIEN GV , BOMON BM, NGUOITHAN NT
WHERE GV.MABM=BM.MABM AND GV.MAGV=NT.MAGV
GROUP BY GV.MAGV,GV.HOTEN,BM.TENBM
HAVING COUNT (NT.MAGV) >=ALL (SELECT COUNT (NT.MAGV )
								FROM  NGUOITHAN NT
								GROUP BY NT.MAGV)



--TRUY VẤN LỒNG CHUYẾN BAY 
--34. Cho biết hãng sản xuất, mã loại và số hiệu của máy bay đã được sử dụng nhiều nhất.
SELECT DISTINCT L.HANGSX ,L.MALOAI,LB.SOHIEU
FROM LOAIMB L ,LICHBAY LB
WHERE L.MALOAI=LB.MALOAI
GROUP BY L.HANGSX ,L.MALOAI,LB.SOHIEU
HAVING COUNT (L.MALOAI) >= ALL (SELECT COUNT(LB.MALOAI)
								FROM LICHBAY LB
								GROUP BY LB.MALOAI)
--35. Cho biết tên nhân viên được phân công đi nhiều chuyến bay nhất.
SELECT NV.TEN
FROM NHANVIEN NV ,PHANCONG PC
WHERE NV.MANV=PC.MANV
GROUP BY NV.TEN
HAVING COUNT (NV.MANV ) >= ALL ( SELECT COUNT ( PB.MANV)
							 FROM PHANCONG PB
							 GROUP BY PB.MANV)   
--36. Cho biết thông tin của phi công (tên, địa chỉ, điện thoại) lái nhiều chuyến bay nhất.
 SELECT NV.TEN, NV.DCHI, NV.DTHOAI
 FROM NHANVIEN NV, PHANCONG PC
 WHERE PC.MANV = NV.MANV AND NV.LOAINV = 1
 GROUP BY NV.TEN, NV.DCHI, NV.DTHOAI
 HAVING COUNT(*) >= ALL (SELECT COUNT(*)
						 FROM PHANCONG PC, NHANVIEN NV
						 WHERE PC.MANV = NV.MANV AND NV.LOAINV = 1
						 GROUP BY PC.MANV)
--37. Cho biết sân bay (SBDEN) và số lượng chuyến bay của sân bay có ít chuyến bay đáp xuống nhất.
SELECT CB.SBDEN,COUNT (SBDEN)'số lượng chuyến bay'
FROM CHUYENBAY CB
GROUP BY CB.SBDEN
HAVING COUNT (CB.SBDEN ) <= ALL ( SELECT COUNT ( PC.SBDEN)
							 FROM CHUYENBAY PC
							 GROUP BY PC.SBDEN)
--38. Cho biết sân bay (SBDI) và số lượng chuyến bay của sân bay có nhiều chuyến bay xuất phát nhất.
SELECT CB.SBDI,COUNT (SBDI)'số lượng chuyến bay'
FROM CHUYENBAY CB
GROUP BY CB.SBDI
HAVING COUNT (CB.SBDI ) >= ALL ( SELECT COUNT ( PC.SBDI)
							 FROM CHUYENBAY PC
							 GROUP BY PC.SBDI)
--39. Cho biết tên, địa chỉ, và điện thoại của khách hàng đã đi trên nhiều chuyến bay nhất.
SELECT KH.TEN,KH.DCHI,KH.DTHOAI
FROM KHACHHANG KH ,DATCHO DC
WHERE KH.MAKH=DC.MAKH
GROUP BY KH.TEN,KH.DCHI,KH.DTHOAI
HAVING COUNT (KH.MAKH ) >= ALL ( SELECT COUNT ( DC.MAKH)
							 FROM DATCHO DC
							 GROUP BY DC.MAKH)
--40. Cho biết mã số, tên và lương của các phi công có khả năng lái nhiều loại máy bay nhất.
SELECT NV.MANV, NV.TEN,NV.LUONG
FROM NHANVIEN NV ,KHANANG KN
WHERE NV.MANV=KN.MANV 
GROUP BY NV.MANV, NV.TEN,NV.LUONG
HAVING COUNT (NV.MANV ) >= ALL ( SELECT COUNT ( KN.MANV)
							 FROM KHANANG KN
							 GROUP BY KN.MANV)
--41. Cho biết thông tin (mã nhân viên, tên, lương) của nhân viên có mức lương cao nhất.
SELECT NV.MANV, NV.TEN,NV.LUONG
FROM NHANVIEN NV
WHERE NV.LOAINV=0 AND LUONG >= ALL (SELECT LUONG FROM NHANVIEN )
--42. Cho biết tên, địa chỉ của các nhân viên có lương cao nhất trong phi hành đoàn (các nhân viên được phân công trong một chuyến bay) mà người đó tham gia.
SELECT DISTINCT   NV.TEN,NV.DCHI,NV.LUONG
FROM NHANVIEN NV,PHANCONG PC
WHERE PC.MANV=NV.MANV AND NV.LOAINV=0 AND LUONG >= ALL (SELECT LUONG FROM NHANVIEN )
--43. Cho biết mã chuyến bay, giờ đi và giờ đến của chuyến bay bay sớm nhất trong ngày.
SELECT CB.MACB, LB.NGAYDI, CB.GIODI, CB.GIODEN
FROM LICHBAY LB, CHUYENBAY CB
WHERE LB.MACB = CB.MACB AND EXISTS (
          SELECT*
          FROM LICHBAY LB1, CHUYENBAY CB1
          WHERE LB1.MACB = CB1.MACB AND LB.NGAYDI = LB1.NGAYDI
          GROUP BY LB1.NGAYDI
          HAVING CB.GIODI = MIN(CB1.GIODI)
          )
--44. Cho biết mã chuyến bay có thời gian bay dài nhất. Xuất ra mã chuyến bay và thời gian bay (tính bằng phút).
SELECT CB.MACB, DATEDIFF(MI, CB.GIODI, CB.GIODEN)'thời gian bay (tính bằng phút)'
FROM CHUYENBAY CB
WHERE DATEDIFF(MI, CB.GIODI, CB.GIODEN) >= ALL (SELECT DATEDIFF(MI, CB.GIODI, CB.GIODEN) 
												FROM CHUYENBAY CB)
--45. Cho biết mã chuyến bay có thời gian bay ít nhất. Xuất ra mã chuyến bay và thời gian bay.
 SELECT CB.MACB, DATEDIFF(MI, CB.GIODI, CB.GIODEN)
 FROM CHUYENBAY CB
 WHERE DATEDIFF(MI, CB.GIODI, CB.GIODEN) <= ALL (SELECT DATEDIFF(MI, CB.GIODI, CB.GIODEN) 
												 FROM CHUYENBAY CB)
--46. Cho biết mã chuyến bay và ngày đi của những chuyến bay bay trên loại máy bay B747 nhiều nhất.
SELECT MACB, NGAYDI
FROM LICHBAY LB
WHERE EXISTS(
   SELECT *
   FROM LICHBAY LB1
   WHERE LB1.MALOAI = 'B747' AND LB1.MACB = LB.MACB
   GROUP BY MACB
   HAVING COUNT(LB1.NGAYDI) >= ALL (SELECT COUNT(LB2.NGAYDI)
									FROM LICHBAY LB2
								    WHERE LB2.MALOAI = 'B747'
									GROUP BY MACB))
--47. Với mỗi chuyến bay có trên 3 hành khách, cho biết mã chuyến bay và số lượng nhân viên trên chuyến bay đó. Xuất ra mã chuyến bay và số lượng nhân viên.
 SELECT LB.MACB, COUNT(DISTINCT PC.MANV) 'số lượng nhân viên'
 FROM DATCHO DC, PHANCONG PC, LICHBAY LB
 WHERE DC.MACB = LB.MACB AND DC.NGAYDI = LB.NGAYDI AND PC.NGAYDI = LB.NGAYDI AND PC.MACB = LB.MACB
 GROUP BY LB.MACB, LB.NGAYDI
 HAVING COUNT(DISTINCT DC.MAKH) > 2
--48. Với mỗi loại nhân viên có tổng lương trên 600000, cho biết số lượng nhân viên trong từng loại nhân viên đó. Xuất ra loại nhân viên, và số lượng nhân viên tương ứng.
SELECT NV.LOAINV,COUNT (NV.MANV)'số lượng nhân viên'
FROM NHANVIEN NV 
GROUP BY  NV.LOAINV
HAVING SUM (LUONG)>600000
--49. Với mỗi chuyến bay có trên 3 nhân viên, cho biết mã chuyến bay và số lượng khách hàng đã đặt chỗ trên chuyến bay đó.
SELECT LB.MACB, COUNT(DISTINCT DC.MAKH) 'số lượng khách'
FROM DATCHO DC, PHANCONG PC, LICHBAY LB
WHERE DC.MACB = LB.MACB AND DC.NGAYDI = LB.NGAYDI AND PC.NGAYDI = LB.NGAYDI AND PC.MACB = LB.MACB
GROUP BY LB.MACB, LB.NGAYDI
HAVING COUNT(DISTINCT PC.MANV) > 2		
--50. Với mỗi loại máy bay có nhiều hơn một chiếc, cho biết số lượng chuyến bay đã được bố trí bay bằng loại máy bay đó. Xuất ra mã loại và số lượng.
 SELECT LB.MALOAI, COUNT(*) 'số lượng chuyến bay'
 FROM LICHBAY LB
 WHERE LB.MALOAI IN (SELECT MALOAI
      FROM MAYBAY MB
      GROUP BY MALOAI
      HAVING COUNT(*) > 1)
 GROUP BY LB.MALOAI