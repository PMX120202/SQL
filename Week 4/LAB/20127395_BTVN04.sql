--20127395_PHAN MINH XUÂN

--17 Với mỗi sân bay (SBDEN), cho biết số lượng chuyến bay hạ cánh xuống sân bay đó. Kết quả được sắp xếp theo thứ tự tăng dần của sân bay đến.
SELECT CB.SBDEN ,COUNT(SBDEN) 'SỐ LƯỢNG CHIẾN BAY ĐẾN '
FROM CHUYENBAY CB
GROUP BY CB.SBDEN
ORDER BY COUNT (SBDEN) ASC
--18 Với mỗi sân bay (SBDI), cho biết số lượng chuyến bay xuất phát từ sân bay đó, sắp xếp theo thứ tự tăng dần của sân bay xuất phát.
SELECT CB.SBDI ,COUNT(SBDI) 'SỐ LƯỢNG CHIẾN BAY ĐI'
FROM CHUYENBAY CB
GROUP BY CB.SBDI
ORDER BY COUNT (SBDI) ASC
--19 Với mỗi sân bay (SBDI), cho biết số lượng chuyến bay xuất phát theo từng ngày. Xuất ra mã sân bay đi, ngày và số lượng.
SELECT CB.SBDI ,LB.NGAYDI , COUNT (NGAYDI) 'SỐ LƯỢNG CHIẾN BAY'
FROM CHUYENBAY CB JOIN LICHBAY LB ON CB.MACB =LB.MACB
GROUP BY CB.SBDI ,LB.NGAYDI
--20 Với mỗi sân bay (SBDEN), cho biết số lượng chuyến bay hạ cánh theo từng ngày. Xuất ra mã sân bay đến, ngày và số lượng.
SELECT CB.SBDEN ,LB.NGAYDI , COUNT (NGAYDI) 'SỐ LƯỢNG CHIẾN BAY'
FROM CHUYENBAY CB JOIN LICHBAY LB ON CB.MACB =LB.MACB
GROUP BY CB.SBDEN ,LB.NGAYDI
--21 Với mỗi lịch bay, cho biết mã chuyến bay, ngày đi cùng với số lượng nhân viên không phải là phi công của chuyến bay đó.
SELECT LB.MACB , LB.NGAYDI, COUNT ( LOAINV)
FROM LICHBAY LB JOIN PHANCONG PC ON LB.MACB =PC.MACB AND LB.NGAYDI=PC.NGAYDI JOIN NHANVIEN NV ON NV.MANV = PC.MANV AND NV.LOAINV =0
GROUP BY LB.MACB , LB.NGAYDI
--22 Số lượng chuyến bay xuất phát từ sân bay MIA vào ngày 11/01/2000.
SELECT COUNT ( SBDI) 'SỐ LƯỢNG CHUYẾN BAY XUẤT PHÁT TỪ MIA VÀ NGÀY 11/01/2000'
FROM CHUYENBAY CB JOIN LICHBAY LB ON CB.MACB=LB.MACB AND CB.SBDI='MIA' AND LB.NGAYDI='11/01/2000'
--23 Với mỗi chuyến bay, cho biết mã chuyến bay, ngày đi, số lượng nhân viên được phân công trên chuyến bay đó, sắp theo thứ tự giảm dần của số lượng.
SELECT LB.MACB , LB.NGAYDI, COUNT (*) 'số lượng nhân viên được phân công trên chuyến bay'
FROM LICHBAY LB JOIN PHANCONG PC ON LB.MACB =PC.MACB AND LB.NGAYDI=PC.NGAYDI JOIN NHANVIEN NV ON NV.MANV = PC.MANV 
GROUP BY LB.MACB , LB.NGAYDI
ORDER BY COUNT (*) DESC 
--24 Với mỗi chuyến bay, cho biết mã chuyến bay, ngày đi, cùng với số lượng hành khách đã đặt chỗ của chuyến bay đó, sắp theo thứ tự giảm dần của số lượng.
SELECT DC.MACB, DC.NGAYDI ,COUNT (*) 'số lượng hành khách đã đặt chỗ của chuyến bay' 
FROM CHUYENBAY CB JOIN DATCHO DC ON CB.MACB=DC.MACB JOIN KHACHHANG KH ON KH.MAKH=DC .MAKH 
GROUP BY DC.MACB, DC.NGAYDI
--25 Với mỗi chuyến bay, cho biết mã chuyến bay, ngày đi, tổng lương của phi hành đoàn (các nhân viên được phân công trong chuyến bay), sắp xếp theo thứ tự tăng dần của tổng lương.
SELECT LB.MACB , LB.NGAYDI, SUM (LUONG) 'tổng lương của phi hành đoàn'
FROM LICHBAY LB JOIN PHANCONG PC ON LB.MACB =PC.MACB AND LB.NGAYDI=PC.NGAYDI JOIN NHANVIEN NV ON NV.MANV = PC.MANV 
GROUP BY LB.MACB , LB.NGAYDI
ORDER BY SUM (LUONG) ASC
--26 Cho biết lương trung bình của các nhân viên không phải là phi công.
SELECT AVG (LUONG) 'lương trung bình của các nhân viên không phải là phi công'
FROM NHANVIEN NV
WHERE NV.LOAINV=0
--27 Cho biết mức lương trung bình của các phi công.
SELECT AVG (LUONG) 'Cho biết mức lương trung bình của các phi công'
FROM NHANVIEN NV
WHERE NV.LOAINV=1
--28 Với mỗi loại máy bay, cho biết số lượng chuyến bay đã bay trên loại máy bay đó hạ cánh xuống sân bay ORD. Xuất ra mã loại máy bay, số lượng chuyến bay.
SELECT L.MALOAI ,COUNT (*) 'số lượng chuyến bay'
FROM LOAIMB L JOIN LICHBAY LB ON LB.MALOAI =L.MALOAI JOIN CHUYENBAY CB ON CB.MACB=LB.MACB AND CB.SBDEN='ORD'
GROUP BY L.MALOAI
--29 Cho biết sân bay (SBDI) và số lượng chuyến bay có nhiều hơn 2 chuyến bay xuất phát trong khoảng 10 giờ đến 22 giờ.
SELECT  CB.SBDI ,COUNT (*) 'số lượng chuyến bay có nhiều hơn 2 chuyến'
FROM CHUYENBAY CB
WHERE CB.GIODI BETWEEN '10:00' AND '22:00'
GROUP BY CB.SBDI
HAVING COUNT (*)>2
--30 Cho biết tên phi công được phân công vào ít nhất 2 chuyến bay trong cùng một ngày.
SELECT NV.TEN ,COUNT ( NGAYDI)
FROM NHANVIEN NV JOIN PHANCONG PC ON PC.MANV=NV.MANV  AND NV .LOAINV=1 
GROUP BY NV.TEN 
HAVING COUNT ( NGAYDI) >=2
--31 Cho biết mã chuyến bay và ngày đi của những chuyến bay có ít hơn 3 hành khách đặt chỗ.
SELECT DC.MACB , DC.NGAYDI
FROM DATCHO DC 
GROUP BY DC.MACB , DC.NGAYDI
HAVING COUNT (MAKH)<3
--32 Cho biết số hiệu máy bay và loại máy bay mà phi công có mã 1001 được phân công lái trên 2 lần.
SELECT MB.SOHIEU , MB.MALOAI
FROM MAYBAY MB JOIN LICHBAY LB ON LB.MALOAI =MB.MALOAI JOIN PHANCONG PC ON PC.MACB= LB.MACB AND PC.NGAYDI=LB.NGAYDI AND PC.MANV ='1001'
GROUP BY MB.SOHIEU , MB.MALOAI
HAVING COUNT (MANV)>2
--33 Với mỗi hãng sản xuất, cho biết số lượng loại máy bay mà hãng đó đã sản xuất. Xuất ra hãng sản xuất và số lượng.
SELECT L.HANGSX ,COUNT (MALOAI) 'số lượng'
FROM LOAIMB L
GROUP BY L.HANGSX