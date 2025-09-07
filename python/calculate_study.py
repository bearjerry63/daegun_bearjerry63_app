import pymysql
import csv
import datetime
import time

def findid(cursor, num, study, today):
    # 쿼리문 실행
    cursor.execute("SELECT * FROM studytime WHERE id = %s", (num,))
    rows = cursor.fetchall()

    if rows:  # 데이터가 존재하면
        row = rows[0]  # 첫 번째 행을 가져옵니다.
        new_study = int(row[1]) + study  # 새로운 데이터
        dates = row[2].split(',') if row[2] else []  # 날짜 리스트

        if today not in dates:  # 오늘 날짜가 없으면 추가
            dates.append(str(today))
        
        # 업데이트 쿼리 실행
        cursor.execute("UPDATE studytime SET study = %s, dates = %s WHERE id = %s", (new_study, ','.join(dates), num))
    else:  # 데이터가 없으면 새로 추가
        cursor.execute("INSERT INTO studytime (id, study, dates) VALUES (%s, %s, %s)", (num, study, str(today)))

# MySQL 연결
db = pymysql.connect(host='ip', port=3306, user='username', passwd='', db='testdg', charset='utf8')
cursor = db.cursor()

dic_yazatime = {}
now = datetime.datetime.now()

while 16 <= now.hour <= 23:
    full = input()
    today = datetime.date.today()
    id = full[8:13]
    
    if dic_yazatime.get(id) is None:
        dic_yazatime[id] = [int(time.time()), today]
    else:
        time2 = int(time.time())
        study = time2 - dic_yazatime.get(id)[0]

        findid(cursor, id, study, today)

        db.commit()  # 변경 사항을 커밋합니다.

        del dic_yazatime[id]  # 딕셔너리에서 삭제

dic_yazatime = {}

# MySQL 연결 종료
db.close()
