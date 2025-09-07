import 'package:daegun/logins/login_page.dart';
import 'package:daegun/mainpage.dart';
import 'package:flutter/material.dart';

class OutLineText extends StatelessWidget {
  final String text;
  final Color color1;
  final Color color2;
  final double fontSize;
  const OutLineText({Key? key, required this.text, this.color1 = Colors.white, this.color2 = Colors.black, this.fontSize = 12}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Text(
          text,
          style: TextStyle(
            fontFamily: '기본폰트',
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 3
              ..color = color1, // <-- Border color
          ),
        ),
        Text(
          text,
          style: TextStyle(
            fontFamily: '기본폰트',
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: color2, // <-- Inner color
          ),
        ),
      ],
    );
  }
}

class NormalButton extends StatelessWidget {
  final Color buttonColor;
  final Color textColor;
  final String buttonText;
  final double fontSize;
  final double widthRatio;
  final double heightRatio;
  final double borderRadius;
  final Text? text;
  final VoidCallback onPressed;
  const NormalButton({Key? key,this.text,this.borderRadius = 6,this.buttonColor = const Color.fromARGB(255, 81, 81, 81), this.textColor = Colors.white, this.buttonText = "", this.fontSize = 15, this.widthRatio =0.3, this.heightRatio = 0.04,required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return SizedBox(
      width: screenWidth * widthRatio,
      height: screenHeight * heightRatio,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius), // 직사각형 모양으로 변경
              )
          ),
          backgroundColor: MaterialStateProperty.all<Color>(buttonColor),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center, // 자식 위젯들을 왼쪽에 배치
          children: [
            text ?? Text(buttonText,style: TextStyle(fontSize: fontSize,fontFamily: '기본폰트', color: textColor,fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}

class bar extends StatelessWidget implements PreferredSizeWidget {
  const bar({super.key});
  @override
  Size get preferredSize => Size.fromHeight(56.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color.fromARGB(255, 70, 70, 70),
      title: GestureDetector(
        onTap: () {
          Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => mainpage()),
          );
        },
        child: Center(
          child: Image.asset('assets/image/logo_w.png', height: 32,),
        ),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.logout,color: Color.fromARGB(255, 150, 150, 150),),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
            );
          },
        ),
      ],
    );;
  }
}
