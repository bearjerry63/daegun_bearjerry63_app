import 'package:daegun/list/manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';

class Meal extends StatefulWidget {
  @override
  _MealState createState() => _MealState();
}

class _MealState extends State<Meal> {
  Future<List<ResultRow>> fetchData() async {
    final connSettings = ConnectionSettings(
      host: 'ip',
      user: 'username',
      db: 'testdg',
    );

    var conn = await MySqlConnection.connect(connSettings);
    var results = await conn.query('SELECT day, lunch, dinner FROM meals');
    await conn.close();

    return results.toList();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: bar(),
      body: FutureBuilder<List<ResultRow>>(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            var data = snapshot.data!;
            if (data.length < 7) {
              return Text('Not enough data');
            } else {
              var Row = data;
              return ListView(
                children: [
                  for (var i = 0; i < Row.length; i++)
                    Container(child: OutLineText(text: '날짜: ${Row[i][0]}\n점심: ${Row[i][1]}\n저녁: ${Row[i][2]}', color1: Colors.black, color2: Colors.white,fontSize: 21 ,),decoration: BoxDecoration(
                      border: Border.all(color: Colors.white,
                        width: 3.0
                    ),),)

                ],
              );
            }
          }
        },
      ),
    );
  }
}
