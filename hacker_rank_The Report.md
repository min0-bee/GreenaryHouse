https://www.hackerrank.com/challenges/the-report/problem?isFullScreen=true
level : basic join

# 문제 조건
Marks로 Grade 매칭
- Students.Marks가 Grades.Min_Mark ~ Max_Mark 사이면 그 Grade
- 출력 컬럼은 3개
Name, Grade, Marks
- Grade < 8이면 이름 숨김
- Grade가 1~7인 학생들은 Name을 출력하지 말고 NULL로 출력
정렬 규칙
- 전체는 Grade 내림차순
- Grade가 8~10인 학생들끼리는 Name 오름차순(알파벳순)
- Grade가 1~7인 학생들끼리는 Marks 오름차순
(이때 Name은 NULL)


### 오답
```sql
SELECT s.Name, s.Mark, g.Grade
FROM STUDENTS.s
JOIN GRADES.g ON ( 
    SELECT *
    FROM GRADES
    WHERE s.Marks >= Min_Mark AND s.Marks <= Max_Mark) as
    
```
- JOIN ON에는 SELECT가 아니라 비교 조건이 와야 한다. => 서브쿼리 올 수 없음
- 혹은 `ON s.Marks >= g.Min_Mark AND s.Marks <= g.Max_Mark` 로 적어야함

# 1단계 :Students와 Grades를 점수 범위로 JOIN 

```sql
SELECT
  CASE WHEN g.Grade >= 8 THEN s.Name ELSE NULL END AS Name,
  g.Grade,
  s.Marks
FROM Students s
JOIN Grades g
  ON s.Marks BETWEEN g.Min_Mark AND g.Max_Mark
```
<img width="206" height="245" alt="image" src="https://github.com/user-attachments/assets/280c2bfd-8a0b-4aa6-ae07-30e2bfe38446" />

- Students와 Grades를 점수 범위로 JOIN
- Grade < 8 인 학생은 Name을 NULL로 변환

# 2단계 : 문제의 정렬 규칙을 적용하자
- 전체 Grade 내림차순
- Grade ≥ 8 → Name 알파벳순
- Grade < 8 → Marks 오름차순

```sql
SELECT
  CASE WHEN g.Grade >= 8 THEN s.Name ELSE NULL END AS Name,
  g.Grade,
  s.Marks
FROM Students s
JOIN Grades g
  ON s.Marks BETWEEN g.Min_Mark AND g.Max_Mark
ORDER BY
    g.Grade DESC,
    CASE WHEN g.Grade >= 8 THEN s.NAME END ASC,
    CASE WHEN g.Grade < 8 THEN s.Marks END ASC;
```
<img width="206" height="337" alt="image" src="https://github.com/user-attachments/assets/a458de52-19c1-4e70-9a03-1e536a15ac24" />

