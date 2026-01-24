https://www.hackerrank.com/challenges/weather-observation-station-20/problem?isFullScreen=true

# 1단계
### 왜 `SELECT 2 - (COUNT(*) % 2)` 의 결과가 1일까?

```sql
SELECT 2 - (COUNT(*) % 2)
FROM STATION;
```

### 결과
```sql
1
```

이 결과는 STATION 테이블의 전체 행 개수(COUNT(*))가 홀수라는 뜻이다.

| COUNT(*) | COUNT(*) % 2 | 의미   |
| -------- | ------------ | ---- |
| 짝수       | 0            | even |
| 홀수       | 1            | odd  |


# 2단계
- `offset` 함수로 중앙값 찾기
- OFFSET N = "정렬된 결과에서 앞의 N개 행을 건너뛰고 그 다음부터 가져와라"

```sql
SELECT (COUNT(*) - 1) / 2
FROM STATION;
```


```sql
(COUNT(*) - 1) / 2
```
- 중앙값이 시작되는 인덱스 위치

## OFFSET 계산식 `(COUNT(*) - 1) / 2` 는 왜 이렇게 생겼을까?

중앙값을 구하기 위해서는  
정렬된 데이터에서 **중앙값이 시작되는 위치(OFFSET)** 를 정확히 계산해야 한다.  

OFFSET은 **0번 인덱스 기준으로 앞에서 몇 개를 건너뛸지**를 의미한다.

---

###  1) 데이터 개수가 홀수일 때

예: COUNT = 5

| Index (0-base) | 값 |
|----------------|----|
| 0 | A |
| 1 | B |
| 2 | C ← 중앙값 |
| 3 | D |
| 4 | E |

우리가 원하는 OFFSET = **2**

계산식: (COUNT - 1) / 2
= (5 - 1) / 2
= 2


→ OFFSET 2  
→ 정확히 중앙 인덱스가 선택된다.

---

## 2) 데이터 개수가 짝수일 때

예: COUNT = 4

| Index (0-base) | 값 |
|----------------|----|
| 0 | A |
| 1 | B ← 중앙값 후보 1 |
| 2 | C ← 중앙값 후보 2 |
| 3 | D |

우리는 **B와 C 두 개를 선택**해야 중앙값을 구할 수 있다.  
따라서 **OFFSET = 1** 에서 시작해야 한다.

계산식:

(COUNT - 1) / 2
= (4 - 1) / 2
= 1.5


MySQL에서 OFFSET에 소수가 들어가면  
**자동으로 정수 부분만 사용 → OFFSET 1**

→ B부터 시작  
→ `LIMIT 2` 적용 시 B, C 선택  
→ 두 값의 평균 = 중앙값

# 3단계

```sql
SELECT LAT_N
FROM STATION
ORDER BY LAT_N
OFFSET 가운데로이동
LIMIT 몇개꺼낼지
```
- 정렬해서 가운데를 뽑는다


```sql
SELECT ROUND(AVG(LAT_N), 4) AS median_lat_n
FROM (
    SELECT LAT_N
    FROM STATION
    ORDER BY LAT_N
    OFFSET (SELECT (COUNT(*) - 1) / 2 FROM STATION)
    LIMIT (SELECT 2 - (COUNT(*) % 2) FROM STATION)
) AS sub;
```


---

