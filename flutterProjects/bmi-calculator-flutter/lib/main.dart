import 'package:flutter/material.dart';
import 'screens/input_page.dart';

void main() => runApp(BMICalculator());

class BMICalculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        primaryColor: Color(
            0xff090B22), //# yerine 0xff kouyarak hex kodu kullanibilir hale getiriyoruz
        scaffoldBackgroundColor: Color(
          0xff090B22,
        ),
      ),
      home: InputPage(),
    );
  }
}
