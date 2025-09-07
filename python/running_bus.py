import pymysql
import requests
import xml.etree.ElementTree as ET # XML 파싱을 위한 라이브러리
import pymysql
def update():
    mydb = pymysql.connect( #mysql 연결
    host="114.201.252.142",
    user="allahuakbar",
    database="testdg",
    charset='utf8')

    cursor = mydb.cursor()

    cursor.execute("DELETE FROM buses")
    bus_stops_id = ['164000610','164000611','164000569','164000037','164000706','164000433','164000039','164000338','164000608','164000609','164000042','164000337','164000045','164000046','164000366','164000384']
    bus_stops_name = ['민방위교육장(38610)','민방위교육장(38611)','동춘동차고지','동춘동종점','동춘롤러경기장','동막역(3번출구)','동막역(1번출구)','동막역(4번출구)','인천박문초등학교(38608)','인천박문초등학교(38609)','무지개아파트(동남아파트)','동남아파트(무지개아파트)','동춘2동행정복지센터(38045)','동춘2동행정복지센터(38046)','무지개아파트','서면초등학교']

    routes_id =['165000310','165000004','165000007','165000008','165000012','165000033','165000034','168000016','164000004','164000005','161000007','165000520','165000045','165000046','165000442','166000010','161000008','165000056','165000216','165000180','165000058','165000219','165000389','165000509','165000085']
    routes_num = ['3-2','4','6','6-1','8','34','35','인천e음45','순환46','55','58','63','65','65-1','81','급행91','급행99','103','103-1','111-2','112','303','304','330','523']

    bstop_arrivalinfo_url = 'http://apis.data.go.kr/6280000/busArrivalService/getAllRouteBusArrivalList'
    index = 0

    for bstopname in bus_stops_id:
        params = {'serviceKey' : 'E1tRf5X6H70xnDO5bR1A5diHzR5bc9ySfodn4fyekz/y46+EXesTJes3lTS6IlSPTU50RJUvTqEwPC5WlwYoRA==', 'pageNo' : '1', 'numOfRows' : '30', 'bstopId' : bstopname}
        response = requests.get(bstop_arrivalinfo_url, params=params)
        root = ET.fromstring(response.content) #XML 파싱

        for itemList in root.iter('itemList'): 
            arrival_estimate_time_element = itemList.find('ARRIVALESTIMATETIME')
            bus_route_id_element = itemList.find('ROUTEID')
            ARRIVAL_ESTIMATE_TIME = arrival_estimate_time_element.text #도착 예정 시간
            BUS_ROUTE_ID = bus_route_id_element.text
        
            ARRIVAL_ESTIMATE_TIME = int(ARRIVAL_ESTIMATE_TIME)
            if ARRIVAL_ESTIMATE_TIME > 59:
                ARRIVAL_MIN = ARRIVAL_ESTIMATE_TIME // 60
                ARRIVAL_SEC = ARRIVAL_ESTIMATE_TIME % 60
                ARRIVAL_ESTIMATE_TIME = f'{ARRIVAL_MIN}분 {ARRIVAL_SEC}초'
            else:
                ARRIVAL_ESTIMATE_TIME = f'{ARRIVAL_ESTIMATE_TIME}초'

            if BUS_ROUTE_ID in routes_id:
                cursor.execute("INSERT INTO buses (stop, bus, time) VALUES (%s, %s,%s)", (bus_stops_name[index], routes_num[routes_id.index(BUS_ROUTE_ID)],ARRIVAL_ESTIMATE_TIME))
                mydb.commit()

        index += 1

    mydb.close()
