import 'package:flutter/material.dart';
//burada constanlari tutuyoruz. ozellikle tasarimda cok  sik derecede kullanilan bir yontem
//bu sayfayi, kullancagimiz yere import etmemiz buradaki bilgilere ulasmamiz icin yeterli olcaktir.
//kDegiskenAdi seklinde olusturulur. her zaman 'k' ile baslar degisken olusturma kurallari ile devam eder

const kLabelTextStyle = TextStyle(
  color: Color(0xff8C8D98),
  fontSize: 18.0,
  letterSpacing: 2.0,
  fontWeight: FontWeight.bold,
);

const kSliderTextStyle = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: 50.0,
    letterSpacing: 4.0);

const kActiveCardColor = Color(0xFFEA1455);
const kInactiveCardColor = Color(0xFF1C1E33);
const kActiveSliderColor = Color(0xFFFFFFFF);
const kInactiveSlidercolor = Color(0xFF888993);
const kSliderPointColor = Color(0xFFEA1455);
const kButtonBackgroundColor = Color(0xFF1B1E32);
//bu main.dart iceisinde MaterialApp icerisine koyabilir.. ama burasi daha iyi
SliderThemeData sliderThemeData(BuildContext context) {
  return SliderTheme.of(context).copyWith(
    activeTrackColor: kActiveSliderColor,
    inactiveTrackColor: kInactiveSlidercolor,
    thumbColor: kSliderPointColor,
    thumbShape: RoundSliderThumbShape(
      enabledThumbRadius: 16.0,
    ),
    overlayColor: kSliderPointColor.withOpacity(0.3),
    overlayShape: RoundSliderOverlayShape(overlayRadius: 30),
  );
}

const kResultScreenTitle =
    TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold, letterSpacing: 2.0);
const kResultTextColor = TextStyle(
    color: Color(0xFF24D876), fontSize: 40.0, fontWeight: FontWeight.bold);

const kBMIResultTextStyle = TextStyle(
    color: Colors.white, fontSize: 100.0, fontWeight: FontWeight.bold);

const kBMIExplainTextStyle =
    TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 25.0);
