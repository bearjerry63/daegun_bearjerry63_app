
import 'package:daegun/buses.dart';
import 'package:daegun/list/manager.dart';
import 'package:daegun/logins/login_api.dart';
import 'package:daegun/nightstudy.dart';
import 'package:daegun/ongoing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'meal.dart';

class mainpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: bar(),
      body:
          Column(
            children: [
              Flexible(
                flex: 4,
                child: Container(
                color: Color.fromARGB(255, 41, 41, 41),
                  child: Column(
                    children: [
                      Padding(padding: EdgeInsets.only(top: screenHeight * 0.01)),
                      OutLineText(text: GoogleSignInService.name, color1: Colors.red, color2: Colors.white,fontSize: 18 ,),
                      Padding(padding: EdgeInsets.only(top: screenHeight * 0.17)),
                      NormalButton(buttonText: "버스 안내",fontSize: 15,buttonColor: Color.fromARGB(255, 102, 31, 255),widthRatio: 0.9,borderRadius: 6,onPressed: (){Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => Buses())
                      );}),
                      Padding(padding: EdgeInsets.only(top: screenHeight * 0.015)),
                      SizedBox(
                        width: screenWidth * 2,
                        height: screenHeight * 0.04,
                        child:
                          ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              Padding(padding: EdgeInsets.only(left: screenWidth * 0.05)),
                              NormalButton(buttonText: "오늘의 급식",fontSize: 15,buttonColor: Color.fromARGB(255, 81,81,81),widthRatio: 0.295,onPressed: (){Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => Meal())
                              );}),
                              Padding(padding: EdgeInsets.only(left: screenWidth * 0.02)),
                              NormalButton(buttonText: "분실물 안내",fontSize: 15,buttonColor: Color.fromARGB(255, 81,81,81),widthRatio: 0.295,onPressed: (){Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context) => OnGoing())
                              );}),
                              Padding(padding: EdgeInsets.only(left: screenWidth * 0.02)),
                              NormalButton(buttonText: "우산 대여",fontSize: 15,buttonColor: Color.fromARGB(255, 81,81,81),widthRatio: 0.27,onPressed: (){Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context) => OnGoing())
                              );}),
                              Padding(padding: EdgeInsets.only(left: screenWidth * 0.02)),
                              NormalButton(buttonText: "야간자율학습",fontSize: 15,buttonColor: Color.fromARGB(255, 81,81,81),widthRatio: 0.32,onPressed: (){Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context) => NightStudy())
                              );}),
                              Padding(padding: EdgeInsets.only(left: screenWidth * 0.05)),
                            ],
                          ),
                        ),
                    ]
                  )
              ),),
              Flexible(
                flex: 7,
                child: Container(
                  color: Colors.black,
                  child: ListView(
                  children: [
                    OutLineText(text: '알림창(개발중)', color1: Colors.red, color2: Colors.white,fontSize: 30 ,),
                  ],
                                ),
                ),)
            ],
          ),
    );
  }
}
