
import 'package:daegun/list/manager.dart';
import 'package:daegun/logins/login_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';


class OnGoing extends StatelessWidget {
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
            flex: 7,
            child: Container(
              child: ListView(
                children: [
                  OutLineText(text: '개발중',
                    color1: Colors.black,
                    color2: Colors.white,
                    fontSize: 27 ,),
                ],
              ),
            ),)
        ],
      ),
    );
  }
}
