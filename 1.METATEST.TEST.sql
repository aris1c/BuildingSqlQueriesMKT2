SELECT
   T.TEST_ID,
   T.NAME,
   T.NAME_E,
   T.NAME_INTERN,
   T.ABBR,
   T.TEST_GROUP_ID,
   T.TEST_SUBGROUP_ID,
   T.TEST_TYPE_ID,
   T.ACTIVE,
   T.SEX_ID,
   T.ITEM_TYPE_ID
FROM
   TEST T
JOIN
   TEST_GROUP TG ON TG.TEST_GROUP_ID = T.TEST_GROUP_ID
JOIN
   TEST_PARAMETER TP ON TP.PARAMETER_ID = T.PARAMETER_ID
JOIN
   TEST_SUBGROUP TS ON TS.TEST_SUBGROUP_ID = T.TEST_SUBGROUP_ID
WHERE ROWNUM <= 10000;