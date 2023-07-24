SELECT
    P.OUTLET_PBI
  , P.NAME CABANG
  , A.TGL
  , TO_CHAR(A.TGL,'YYYY') TAHUN
  , TO_CHAR(A.TGL,'MM')   MONTH
  , r.name                REGION
  , A.REFEREE_ID
  , C.NAME                REFEREE
  , C.COMPANY_SUBGROUP_ID SUBGROUP_ID
  , CS.NAME               SUBGROUP
  , C.COMPANY_GROUP_ID    GROUP_ID
  , CG.NAME               COMPANY_GROUP
  , CC.CC_GROUP_ID
  , CCG.NAME CONTRACT_GROUP
  , CC.CT_GROUP_ID
  , CCT.NAME CONTRACT_TYPE
  , A.DOCTOR_ID
  , DECODE(D.NAME, 'APD-CS','APD-CS', '-','APD-CS', D.NAME)                                          DOCTOR
  , DECODE(D.NAME, 'APD-CS','N/A', '-','N/A', D.SPECIALTY)                                           SPECIALTY
  , DECODE(D.NAME, 'APD-CS','N/A', '-','N/A', D.ABBR)                                                SPECIALTY_ABBR
  , DECODE(D.NAME, 'APD-CS','N/A', '-','N/A', d.specialty_group)                                   SPECIALTY_GROUP
  , DECODE(CCG.CC_GROUP_ID,'10', DECODE(A.DOCTOR_ID, '00000','01','02'),CCG.CC_GROUP_ID)             SEGMEN_ID
  , DECODE(CCG.CC_GROUP_ID,'10', DECODE(D.NAME, 'APD-CS','APD-CS', '-','APD-CS', 'APD'),CCG.NAME)    SEGMEN
  , DECODE(CCG.CC_GROUP_ID,'10', DECODE(D.NAME, 'APD-CS','APD-CS', '-','APD-CS', 'APD'),CCG.SEGMENT) SEGMENTASI_MKT
  , A.TEST_ID
  , T.NAME                                                TEST
  , vt2.kelompok                                               KELOMPOK
  , vt2.sub_kelompok                                          SUB_KELOMPOK
  ,sgp.name                                                subgroup_test
  , gp.name                                                 group_test
  , vt.covid                                              COVID_TEST
  , DECODE(I.INTENSIFIKASI, NULL,'FALSE',I.INTENSIFIKASI) INTENSIFIKASI
  , tmi.name                                              INTENSIF
  , VT.FPP                                                FPP
  , A.JUAL
  , A.RETUR
  , A.JUAL - A.RETUR VOLUME_TEST
  , A.BRUTO
  , A.DISKON
  , A.NETTO
  , A.RETUR_NETTO
  , A.NETTO - A.RETUR_NETTO TOTAL
  , A.OUTLET_ID
  , MO.NAME                                                                           OUTLET
  , DECODE(TO_CHAR(SYSDATE,'YYYY'),TO_CHAR(A.TGL,'YYYY'), A.NETTO   - A.RETUR_NETTO, 0) TAHUN_0
  , DECODE(TO_CHAR(SYSDATE,'YYYY')-1,TO_CHAR(A.TGL,'YYYY'),A.NETTO  - A.RETUR_NETTO, 0) TAHUN_1
  , DECODE(TO_CHAR(SYSDATE,'YYYY')-2,TO_CHAR(A.TGL,'YYYY'), A.NETTO - A.RETUR_NETTO, 0) TAHUN_2
  , DECODE(TO_CHAR(SYSDATE,'YYYY')-3,TO_CHAR(A.TGL,'YYYY'), A.NETTO - A.RETUR_NETTO, 0) TAHUN_3
  , DECODE(TO_CHAR(SYSDATE,'YYYY')-4,TO_CHAR(A.TGL,'YYYY'), A.NETTO - A.RETUR_NETTO, 0) TAHUN_4
  , DECODE(TO_CHAR(SYSDATE,'YYYY')-5,TO_CHAR(A.TGL,'YYYY'), A.NETTO - A.RETUR_NETTO, 0) TAHUN_5
  , DECODE(TO_CHAR(SYSDATE,'YYYY'),TO_CHAR(A.TGL,'YYYY'), A.JUAL - A.RETUR, 0) VOLUME_TAHUN_0
  , DECODE(TO_CHAR(SYSDATE,'YYYY')-1,TO_CHAR(A.TGL,'YYYY'), A.JUAL - A.RETUR, 0) VOLUME_TAHUN_1
  , DECODE(TO_CHAR(SYSDATE,'YYYY')-2,TO_CHAR(A.TGL,'YYYY'), A.JUAL - A.RETUR, 0) VOLUME_TAHUN_2
  , DECODE(TO_CHAR(SYSDATE,'YYYY')-3,TO_CHAR(A.TGL,'YYYY'), A.JUAL - A.RETUR, 0) VOLUME_TAHUN_3
  , DECODE(TO_CHAR(SYSDATE,'YYYY')-4,TO_CHAR(A.TGL,'YYYY'), A.JUAL - A.RETUR, 0) VOLUME_TAHUN_4
  , DECODE(TO_CHAR(SYSDATE,'YYYY')-5,TO_CHAR(A.TGL,'YYYY'), A.JUAL - A.RETUR, 0) VOLUME_TAHUN_5
FROM
    SALES2                      A
  , OUTLET_PBI_DET              O
  , OUTLET_PBI                  P
  , METADDT.REGION_ERP          R
  , COMPANY                     C
  , COMPANY_SUBGROUP            CS
  , COMPANY_GROUP               CG
  , COMPANY_CONTRACT            CC
  , COMPANY_CONTRACT_GROUP      CCG
  , COMPANY_CONTRACT_TYPE       CCT
  , DOCTOR                      D
  , METATEST.TEST               T
  , METATEST.TEST_ESOTERIK      E
  , METATEST.TEST_INTENSIFIKASI I
  , METADDT.OUTLET              MO
  , METATEST.V_TEST_MKT         VT
  , METATEST.v_test_mkt_new     VT2
  , METATEST.test_subgroup      sgp
  , METATEST.test_group          gp
  , METATEST.TEST_INTENS        MIT
  , METATEST.TEST_MINTENT       TMI
WHERE
    A.OUTLET_ID               = O.OUTLET_ID(+)
    AND O.OUTLET_PBI          = P.OUTLET_PBI(+)
    AND P.REGION_ID           = R.PBI_REGION_ID(+)
    AND A.REFEREE_ID          = C.COMPANY_ID(+)
    AND C.COMPANY_SUBGROUP_ID = CS.COMPANY_SUBGROUP_ID(+)
    AND C.COMPANY_GROUP_ID    = CG.COMPANY_GROUP_ID(+)
    AND A.REFEREE_ID          = CC.COMPANY_ID(+)
    AND CC.CC_GROUP_ID        = CCG.CC_GROUP_ID(+)
    AND CC.CT_GROUP_ID        = CCT.CT_GROUP_ID(+)
    AND A.DOCTOR_ID           = D.DOCTOR_ID(+)
    AND A.TEST_ID             = T.TEST_ID(+)
    AND t.test_subgroup_id    = sgp.test_subgroup_id(+)
    AND t.test_group_id       = gp.test_group_id    (+)
    AND A.TEST_ID             = E.TEST_ID(+)
    AND A.TEST_ID             = I.TEST_ID(+)
    AND A.OUTLET_ID           = MO.OUTLET_ID(+)
    AND A.TEST_ID             = VT.TEST_ID(+)
    and a.test_id             = vt2.test_id(+)
    AND TO_CHAR(A.TGL,'YYYY') = MIT.TAHUN(+)
    AND A.TEST_ID             = MIT.TEST_ID(+)
    AND mit.mitenid           = tmi.mitenid(+)
    AND A.TGL                >= '1 JAN 2017';



Dummy testing

SELECT
    P.OUTLET_PBI
  , P.NAME CABANG
  , A.TGL
  , TO_CHAR(A.TGL,'YYYY') TAHUN
  , TO_CHAR(A.TGL,'MM')   MONTH
  , r.name                REGION
  , A.REFEREE_ID
  , C.NAME                REFEREE
  , C.COMPANY_SUBGROUP_ID SUBGROUP_ID
  , CS.NAME               SUBGROUP
  , C.COMPANY_GROUP_ID    GROUP_ID
  , CG.NAME               COMPANY_GROUP
  , CC.CC_GROUP_ID
  , CCG.NAME CONTRACT_GROUP
  , CC.CT_GROUP_ID
  , CCT.NAME CONTRACT_TYPE
  , A.DOCTOR_ID
  , DECODE(D.NAME, 'APD-CS','APD-CS', '-','APD-CS', D.NAME)                                          DOCTOR
  , DECODE(D.NAME, 'APD-CS','N/A', '-','N/A', D.SPECIALTY_ID)                                           SPECIALTY
  , DECODE(D.NAME, 'APD-CS','N/A', '-','N/A', D.ABBR)                                                SPECIALTY_ABBR
  , DECODE(D.NAME, 'APD-CS','N/A', '-','N/A', d.specialty_group_ID)                                   SPECIALTY_GROUP
  , DECODE(CCG.CC_GROUP_ID,'10', DECODE(A.DOCTOR_ID, '00000','01','02'),CCG.CC_GROUP_ID)             SEGMEN_ID
  , DECODE(CCG.CC_GROUP_ID,'10', DECODE(D.NAME, 'APD-CS','APD-CS', '-','APD-CS', 'APD'),CCG.NAME)    SEGMEN
  , DECODE(CCG.CC_GROUP_ID,'10', DECODE(D.NAME, 'APD-CS','APD-CS', '-','APD-CS', 'APD'),CCG.SEGMENT) SEGMENTASI_MKT
  , A.TEST_ID
  , T.NAME                                                TEST
  , vt2.kelompok                                               KELOMPOK
  , vt2.sub_kelompok                                          SUB_KELOMPOK
  ,sgp.name                                                subgroup_test
  , gp.name                                                 group_test
  , vt.covid_ID                                              COVID_TEST
  , DECODE(I.INTENSIFIKASI, NULL,'FALSE',I.INTENSIFIKASI) INTENSIFIKASI
  , tmi.name                                              INTENSIF
  , VT.FPP_ID                                                FPP
  , A.JUAL
  , A.RETUR
  , A.JUAL - A.RETUR VOLUME_TEST
  , A.BRUTO
  , A.DISKON
  , A.NETTO
  , A.RETUR_NETTO
  , A.NETTO - A.RETUR_NETTO TOTAL
  , A.OUTLET_ID
  , MO.NAME                                                                           OUTLET
  , DECODE(TO_CHAR(SYSDATE,'YYYY'),TO_CHAR(A.TGL,'YYYY'), A.NETTO   - A.RETUR_NETTO, 0) TAHUN_0
  , DECODE(TO_CHAR(SYSDATE,'YYYY')-1,TO_CHAR(A.TGL,'YYYY'),A.NETTO  - A.RETUR_NETTO, 0) TAHUN_1
  , DECODE(TO_CHAR(SYSDATE,'YYYY')-2,TO_CHAR(A.TGL,'YYYY'), A.NETTO - A.RETUR_NETTO, 0) TAHUN_2
  , DECODE(TO_CHAR(SYSDATE,'YYYY')-3,TO_CHAR(A.TGL,'YYYY'), A.NETTO - A.RETUR_NETTO, 0) TAHUN_3
  , DECODE(TO_CHAR(SYSDATE,'YYYY')-4,TO_CHAR(A.TGL,'YYYY'), A.NETTO - A.RETUR_NETTO, 0) TAHUN_4
  , DECODE(TO_CHAR(SYSDATE,'YYYY')-5,TO_CHAR(A.TGL,'YYYY'), A.NETTO - A.RETUR_NETTO, 0) TAHUN_5
  , DECODE(TO_CHAR(SYSDATE,'YYYY'),TO_CHAR(A.TGL,'YYYY'), A.JUAL - A.RETUR, 0) VOLUME_TAHUN_0
  , DECODE(TO_CHAR(SYSDATE,'YYYY')-1,TO_CHAR(A.TGL,'YYYY'), A.JUAL - A.RETUR, 0) VOLUME_TAHUN_1
  , DECODE(TO_CHAR(SYSDATE,'YYYY')-2,TO_CHAR(A.TGL,'YYYY'), A.JUAL - A.RETUR, 0) VOLUME_TAHUN_2
  , DECODE(TO_CHAR(SYSDATE,'YYYY')-3,TO_CHAR(A.TGL,'YYYY'), A.JUAL - A.RETUR, 0) VOLUME_TAHUN_3
  , DECODE(TO_CHAR(SYSDATE,'YYYY')-4,TO_CHAR(A.TGL,'YYYY'), A.JUAL - A.RETUR, 0) VOLUME_TAHUN_4
  , DECODE(TO_CHAR(SYSDATE,'YYYY')-5,TO_CHAR(A.TGL,'YYYY'), A.JUAL - A.RETUR, 0) VOLUME_TAHUN_5
FROM
    RPT_MARKETING_SALES_2       A
  , OUTLET_PBI_DET              O
  , OUTLET_PBI                  P
  , TBL_REGION_ERP      R
  , COMPANY                     C
  , COMPANY_SUBGROUP            CS
  , COMPANY_GROUP               CG
  , COMPANY_CONTRACT            CC
  , TBL_COMPANY_CONTRACT_GROUP  CCG
  , COMPANY_CONTRACT_TYPE       CCT
  , DOCTOR_ARIS                 D
  , TEST               T
  , TEST_ISOTERIK      E
  , TEST_INTENSIFIKASI I
  , OUTLET              MO
  , TBL_TEST_MKT        VT
  , test_mkt_new_ARIS  VT2
  , test_subgroup      sgp
  , test_group          gp
  , TBL_TEST_INTENS    MIT
  , TBL_TEST_MINTENT   TMI
WHERE
    A.OUTLET_ID               = O.OUTLET_ID(+)
    AND O.OUTLET_PBI          = P.OUTLET_PBI(+)
    AND P.REGION_ID           = R.PBI_REGION_ID(+)
    AND A.REFEREE_ID          = C.COMPANY_ID(+)
    AND C.COMPANY_SUBGROUP_ID = CS.COMPANY_SUBGROUP_ID(+)
    AND C.COMPANY_GROUP_ID    = CG.COMPANY_GROUP_ID(+)
    AND A.REFEREE_ID          = CC.COMPANY_ID(+)
    AND CC.CC_GROUP_ID        = CCG.CC_GROUP_ID(+)
    AND CC.CT_GROUP_ID        = CCT.CT_GROUP_ID(+)
    AND A.DOCTOR_ID           = D.DOCTOR_ID(+)
    AND A.TEST_ID             = T.TEST_ID(+)
    AND t.test_subgroup_id    = sgp.test_subgroup_id(+)
    AND t.test_group_id       = gp.test_group_id    (+)
    AND A.TEST_ID             = E.TEST_ID(+)
    AND A.TEST_ID             = I.TEST_ID(+)
    AND A.OUTLET_ID           = MO.OUTLET_ID(+)
    AND A.TEST_ID             = VT.TEST_ID(+)
    and a.test_id             = vt2.test_id(+)
    AND TO_CHAR(A.TGL,'YYYY') = MIT.TAHUN(+)
    AND A.TEST_ID             = MIT.TEST_ID(+)
    AND mit.mitenid           = tmi.mitenid(+)
    AND A.TGL                >= '1 JAN 2017';
