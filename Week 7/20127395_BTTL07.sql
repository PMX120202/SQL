--Q58. Cho biết tên giáo viên nào mà tham gia đề tài đủ tất cả các chủ đề.
SELECT GV.HOTEN
FROM GIAOVIEN GV
WHERE  NOT EXISTS (SELECT CD.MACD
					FROM CHUDE CD
					EXCEPT
					SELECT TG.MADT
					FROM THAMGIADT TG
					WHERE TG.MAGV=GV.MAGV)
--Q60. Cho biết tên đề tài có tất cả giảng viên bộ môn “Hệ thống thông tin” tham gia
SELECT DT.TENDT
FROM DETAI DT
WHERE  NOT EXISTS (SELECT GV.MAGV
					FROM GIAOVIEN GV
					WHERE GV.MABM='HTTT'
					EXCEPT
					SELECT TG.MAGV
					FROM THAMGIADT TG
					WHERE TG.MADT=DT.MADT)

--Q62. Cho biết tên giáo viên nào tham gia tất cả các đề tài mà giáo viên Trần Trà Hương đã tham gia.
SELECT GV.HOTEN
FROM GIAOVIEN  GV
WHERE  NOT EXISTS (SELECT DISTINCT DT.MADT
					FROM DETAI DT, THAMGIADT DT1, THAMGIADT DT2
					WHERE  DT1.MADT=DT2.MADT AND GV.HOTEN=N'Trần Trà Hương'
					GROUP BY DT1.MAGV,DT1.MADT ,DT2.MADT,DT.MADT
					EXCEPT
					SELECT TG.MADT
					FROM THAMGIADT TG
					WHERE TG.MAGV=GV.MAGV)
          

SELECT GV2.MAGV,GV2.HOTEN
FROM GIAOVIEN GV1 ,GIAOVIEN GV2
WHERE GV1.MABM =GV2.MABM AND GV1.MAGV='002' AND GV2.MAGV <>'002'
--Q64. Cho biết tên giáo viên nào mà tham gia tất cả các công việc của đề tài 006.
SELECT GV.HOTEN
FROM GIAOVIEN GV
WHERE  NOT EXISTS (SELECT CV.MADT
					FROM CONGVIEC CV
					WHERE CV.MADT='006'
					EXCEPT
					SELECT TG.MAGV
					FROM THAMGIADT TG
					WHERE TG.MAGV=GV.MAGV)

--Q66. Cho biết tên giáo viên nào đã tham gia tất cả các đề tài của do Trần Trà Hương làm chủ nhiệm.
SELECT GV.HOTEN
FROM GIAOVIEN  GV
WHERE  NOT EXISTS (SELECT DT.MADT
					FROM DETAI DT
					WHERE  DT.GVCNDT='002'
					EXCEPT
					SELECT TG.MADT
					FROM THAMGIADT TG
					WHERE TG.MAGV=GV.MAGV)
--Q68. Cho biết tên giáo viên nào mà tham gia tất cả các công việc của đề tài Nghiên cứu tế bào gốc.
SELECT GV.HOTEN
FROM GIAOVIEN GV
WHERE  NOT EXISTS (SELECT DT.MADT
					FROM DETAI DT, CONGVIEC CV
					WHERE DT.MADT=CV.MADT AND DT.TENDT=N'Nghiên cứu tế bào gốc'
					EXCEPT
					SELECT TG.MAGV
					FROM THAMGIADT TG
					WHERE TG.MAGV=GV.MAGV)
--Q70. Cho biết tên đề tài nào mà được tất cả các giáo viên của khoa Sinh Học tham gia.
SELECT DT.TENDT
FROM DETAI DT
WHERE  NOT EXISTS (SELECT GV.MAGV
					FROM KHOA K,GIAOVIEN GV
					WHERE K.TRUONGKHOA=GV.MAGV AND K.TENKHOA=N'Sinh học'
					EXCEPT
					SELECT TG.MAGV
					FROM THAMGIADT TG
					WHERE TG.MADT=DT.MADT)
--Q72. Cho biết mã số, họ tên, tên bộ môn và tên người quản lý chuyên môn của giáo viên tham gia tất cả các đề tài thuộc chủ đề “Nghiên cứu phát triển”.
SELECT GV.MAGV,GV.HOTEN,BM.TENBM,DT.GVCNDT
FROM GIAOVIEN GV ,BOMON BM ,DETAI DT
WHERE  NOT EXISTS (SELECT DT.MADT
					FROM DETAI DT, CHUDE CD
					WHERE DT.MACD=CD.MACD AND CD.TENCD=N'Nghiên cứu phát triển'
					EXCEPT
					SELECT TG.MADT
					FROM THAMGIADT TG
					WHERE TG.MAGV=GV.MAGV)
--Q74. Cho biết họ tên giáo viên khoa “Công nghệ thông tin” tham gia tất cả các công việc của đề tài có trưởng bộ môn của bộ môn đông nhất khoa “Công nghệ thông tin” làm chủ nhiệm.
SELECT GV.HOTEN
FROM GIAOVIEN GV ,BOMON BM ,KHOA K
WHERE K.MAKHOA=BM.MAKHOA AND BM.MABM=GV.MABM AND K.TENKHOA=N'Công nghệ thông tin' AND NOT EXISTS 
					(SELECT DT.MADT
					FROM DETAI DT
					WHERE K.TENKHOA=N'Công nghệ thông tin' AND BM.TRUONGBM='002' AND BM.TRUONGBM='001'
					EXCEPT
					SELECT TG.MADT
					FROM THAMGIADT TG
					WHERE TG.MAGV=GV.MAGV)

--Q76. Cho danh sách tên bộ môn và họ tên trưởng bộ môn đó nếu có
SELECT BM.TENBM, GV.HOTEN
FROM BOMON BM , GIAOVIEN GV
WHERE BM.MABM= GV.MABM AND BM.TRUONGBM IN (SELECT MAGV FROM GIAOVIEN)
GROUP BY BM.TENBM, GV.HOTEN

SELECT DISTINCT BM.TENBM,A.HOTEN
FROM BOMON BM , (SELECT GV.HOTEN, GV.MAGV,GV.MABM
					FROM GIAOVIEN GV,BOMON BM
					WHERE BM.TRUONGBM=GV.MAGV
					) A
WHERE BM.TRUONGBM=A.MAGV
-- Câu 59: Cho biết tên đề tài nào mà được tất cả các giáo viên của bộ môn hệ thống thông tin tham gia
SELECT TENDT
FROM DETAI DT
WHERE DT.MADT IN(SELECT DT.MADT
    FROM DETAI DT
    WHERE NOT EXISTS (SELECT GV.MAGV
          FROM GIAOVIEN GV
          WHERE GV.MABM = 'HTTT'
          EXCEPT
          SELECT TG.MAGV
          FROM THAMGIADT TG
          WHERE DT.MADT = TG.MADT 
          )
          )
-- Câu 61: Cho biết giáo viên nào đã tham gia tất cả các đề tài có mã chủ đề là QLGD
SELECT *
FROM GIAOVIEN GV
WHERE NOT EXISTS (SELECT DT.MADT
      FROM DETAI DT
      WHERE DT.MACD = 'QLGD'
      EXCEPT 
      SELECT TG.MADT
      FROM THAMGIADT TG
      WHERE GV.MAGV = TG.MAGV )
        
-- Câu 63: Cho biết tên đề tài nào mà được tất cả giáo viên của bộ môn hóa hữu cơ tham gia
SELECT TENDT
FROM DETAI DT
WHERE DT.MADT IN(SELECT DT.MADT
    FROM DETAI DT
    WHERE NOT EXISTS (SELECT GV.MAGV
          FROM GIAOVIEN GV, BOMON BM
          WHERE GV.MABM = BM.MABM AND BM.TENBM = N'Hóa hữu cơ'
          EXCEPT
          SELECT TG.MAGV
          FROM THAMGIADT TG
          WHERE DT.MADT = TG.MADT
           )
         )
       
-- Câu 65: Cho biết giáo viên nào đã tham gia tất cả các đề tài của chủ đề ứng dụng công nghệ
SELECT *
FROM GIAOVIEN GV
WHERE NOT EXISTS (SELECT DT.MADT
      FROM DETAI DT, CHUDE CD
      WHERE DT.MACD = CD.MACD AND CD.TENCD = N'Ứng dụng công nghệ'
      EXCEPT 
      SELECT TG.MADT
      FROM THAMGIADT TG
      WHERE GV.MAGV = TG.MAGV )
-- Câu 67: Cho biết tên đề tài nào được tất cả giáo viên của khoa CNTT tham gia
SELECT TENDT
FROM DETAI DT
WHERE DT.MADT IN(SELECT DT.MADT
    FROM DETAI DT
    WHERE NOT EXISTS (SELECT GV.MAGV
          FROM GIAOVIEN GV, BOMON BM
          WHERE GV.MABM = BM.MABM AND BM.MAKHOA = 'CNTT'
          EXCEPT
          SELECT TG.MAGV
          FROM THAMGIADT TG
          WHERE DT.MADT = TG.MADT
           )
         )
-- 69: Tìm tên các giáo viên được phân công làm tất cả các công việc của đề tài có kinh phí trên 100tr
SELECT GV.HOTEN
FROM GIAOVIEN GV
WHERE GV.MAGV IN (SELECT GV.MAGV
      FROM GIAOVIEN GV
      WHERE NOT EXISTS (SELECT DT.MADT
         FROM DETAI DT
         WHERE DT.KINHPHI >100000000
      
         EXCEPT
         SELECT TG.MADT
         FROM THAMGIADT TG
         WHERE GV.MAGV = TG.MAGV
         ) 
         )
-- 71: Cho biết mã số, họ tên, ngày sinh của giáo viên của giáo viên tham gia tất cả các công việc của đề tài ứng dụng xanh 
SELECT GV.HOTEN, GV.MAGV, GV.NGSINH
FROM GIAOVIEN GV
WHERE GV.MAGV IN (SELECT GV.MAGV
      FROM GIAOVIEN GV
      WHERE NOT EXISTS (SELECT DT.MADT, CV.SOTT
         FROM DETAI DT, CONGVIEC CV
         WHERE DT.MADT = CV.MADT AND DT.TENDT = N'Ứng dụng xanh'
      
         EXCEPT
         SELECT TG.MADT
         FROM THAMGIADT TG
         WHERE GV.MAGV = TG.MAGV
         )
         )