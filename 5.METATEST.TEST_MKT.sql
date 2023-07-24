SELECT
   J.ID,
   J.TEST_ID,
   J.TIPE_ID,
   J.SUB_TIPE_ID,
   J.FPP_ID,
   J.COVID_ID
FROM
   ERP_JOURNAL_RJK J
JOIN
   ERP_FINISH F ON F.ID = J.ID
JOIN
   ERP_RECEIPT R ON R.ID = J.ID
JOIN
   ERP_TRANSACTION T ON T.ID = J.ID
JOIN
   ERP_CUSTOMER C ON C.ID = J.ID
JOIN
   ERP_CUSTOMER C2 ON C2.ID = J.ID;



NOTE UNTUK 5.METATEST.TEST_MKT
ini ketemu untuk kolom yang bersinggungan tapi
untuk kolom
'TIPE_ID',
'SUB_TIPE_ID',
'FPP_ID',
'COVID_ID')
itu tidak ada... so This is Red table !