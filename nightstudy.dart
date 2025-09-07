
import 'package:daegun/list/manager.dart';
import 'package:daegun/logins/login_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';


class NightStudy extends StatelessWidget {
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
                  QrImageView(
                    data: DateTime.now().year.toString() + DateTime.now().month.toString().padLeft(2, '0') + DateTime.now().day.toString().padLeft(2, '0') + GoogleSignInService.mail,
                    version: QrVersions.auto,
                    size: 200.0,
                    foregroundColor: Colors.white,
                  ),
                  OutLineText(text: '만료일: ${DateTime.now().year.toString()+DateTime.now().month.toString().padLeft(2, '0') +DateTime.now().day.toString().padLeft(2, '0')}',
                    color1: Colors.black,
                    color2: Colors.white,
                    fontSize: 30 ,),
                 OutLineText(text: 'QR코드를 스캔해주세요',
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
