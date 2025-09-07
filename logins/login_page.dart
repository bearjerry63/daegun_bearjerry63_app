import 'dart:developer';

import 'package:daegun/list/manager.dart';
import 'package:daegun/mainpage.dart';
import 'package:daegun/moving.dart';
import 'package:flutter/material.dart';
import 'login_api.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Future googleSignIn() async {
    try {
      final user = await GoogleSignInService.login();
      await user?.authentication;
      log(user!.displayName.toString());
      log(user.email);
      if(!user.email.contains("idg.icehs.kr")){
        if (context.mounted) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('학교 계정이 아닙니다.'),duration: Duration(seconds: 3),));
        }
        googleSignOut();
        return;
      }
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            duration: Duration(seconds: 2),
            content: Column(
              children: [
                Text(
                    "Name: ${user.displayName}\nEmail: ${user.email}"),
                Image.network(user.photoUrl.toString()),
              ],
            )));
      }
      Navigator.pushReplacement(
        context,

        MaterialPageRoute(builder: (context) => mainpage()),
      );
    } catch (exception) {
      log(exception.toString());
    }
  }

  Future googleSignOut() async {
    try {
      await GoogleSignInService.logout();
      log('로그아웃 되었습니다.');
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('로그아웃 되었습니다.'),duration: Duration(seconds: 2),));
      }
    } catch (exception) {
      log(exception.toString());
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('로그아웃에 실패했습니다.'),duration: Duration(seconds: 2),));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    googleSignOut();
    return Scaffold(
      appBar: AppBar(
        title: OutLineText(text: '구글 로그인 화면',color1: Colors.white,color2: Colors.black,fontSize: 25),
        backgroundColor: Color.fromARGB(255, 70, 70, 70),
      ),
      body: Center(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/image/logo_w.png",width: 164,height: 39,scale: 0.5,), //대건고 로고

            SizedBox(height: 120,child: OutLineText(text : '\n학교 계정으로 로그인해주세요.\n(OOOOO@idg.icehs.kr)',color1: Colors.white,color2: Colors.black,fontSize: 25),), //대건고등학교
            
            ImageSlider(),

            Container( //버튼
              margin: const EdgeInsetsDirectional.symmetric(vertical: 80, horizontal: 0),
              height: 50,
              width: 320,
              child: ElevatedButton(
                onPressed: googleSignIn,
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero, // 직사각형 모양으로 변경
                      )
                  ),
                  backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 102, 31, 255)),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 0), // 왼쪽 패딩 추가
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start, // 자식 위젯들을 왼쪽에 배치
                    children: [
                      Image.asset('assets/image/google_logo.png', height: 24,width: 30,),
                      SizedBox(width: 60),
                      const Text('구글 로그인',style: TextStyle(fontSize: 22,fontFamily: '기본폰트', color: Colors.white,fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
