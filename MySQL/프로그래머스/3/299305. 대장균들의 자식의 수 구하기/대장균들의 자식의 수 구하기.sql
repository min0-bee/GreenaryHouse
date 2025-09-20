-- 코드를 작성해주세요
-- 상관 서브쿼리
# SELECT 
#     p.ID,
#     (SELECT COUNT(*) 
#      FROM ECOLI_DATA c 
#      WHERE c.PARENT_ID = p.ID) AS CHILD_COUNT
# FROM ECOLI_DATA p
# ORDER BY p.ID;

-- 셀프 조인으로도 풀 수 있다고 함

SELECT p.ID, COUNT(c.ID) AS CHILD_COUNT
FROM ECOLI_DATA p
LEFT JOIN ECOLI_DATA c ON p.ID = c.PARENT_ID
-- self join시 하나의 부모 아이디에 여러개의 자식이 매치될 수 있기에 group by를 해준다.
GROUP BY p.ID
ORDER BY p.ID ASC;