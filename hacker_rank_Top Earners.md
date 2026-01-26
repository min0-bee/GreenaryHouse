https://www.hackerrank.com/challenges/earnings-of-employees/problem?isFullScreen=true


모든 직원 중
1. 최대 총 수입
2. 그 최대 수입을 받는 직원 수

# 1단계 : 각 직원의 총 수입 계산
```sql
SELECT salary * months AS total_earning
FROM Employee;
```

# 2단계 : 총 수입별 직원 수 집계
```sql
SELECT salary * months AS total_earning, count(*)
FROM Employee
GROUP BY total_earning;
```

<img width="119" height="258" alt="image" src="https://github.com/user-attachments/assets/c688ebd1-84df-4560-aea1-38536bfd90bb" />

# 3단계 : 최대 총 수입만 선택
- 내림차순 DESC 후 LIMIT 1

```sql
SELECT salary * months AS total_earning, count(*)
FROM Employee
GROUP BY total_earning
ORDER BY total_earning DESC
LIMIT 1;
```

- ✅ SQL에서 ORDER BY는 기본값이 ASC (오름차순)
