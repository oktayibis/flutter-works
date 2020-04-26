import 'result_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../components/reusuable_card.dart';
import '../components/two_column.dart';
import '../constants.dart';
import '../components/bottom_button.dart';
import '../components/circle_icon.dart';
import 'package:bmi_calculator/calcultor_brain.dart';

//degisitirlmesini istemedigimi ve tek bir temel degerle calisan degiskenin basina const gelir.

enum Gender {
  male,
  female
} //enum olustarak verilerin dogrulugunu kontrol edebilir. Boylece okumasi daha kolay olur. Burada ve asagidaki metod bu orneklenmistir. Boylece gender male mi female mi oldugu rahatca kontrol edilir. benzer mantik fluter icerisinde isimlendirilmis olarak cok fazla kullanilmaktadir. MainAxisAllignment.center gibi.... if else / swich on gibi condition durumlarda cok ise yarar.

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  Color maleCardColor = kInactiveCardColor;
  Color femaleCardColor = kInactiveCardColor;
  Gender selectedGender; // cinsiyet secimi icin kullaniyoruz

  int height = 180;
  int weight = 70;
  int age = 25;

//
//  void updateColor(Gender gender) {
//
//
////    if (gender == Gender.male) {
////      //male pressed
////      if (maleCardColor == inactiveCardColor) {
////        maleCardColor = activeCardColor;
////        femaleCardColor = inactiveCardColor;
////      } else {
////        maleCardColor = inactiveCardColor;
////      }
////    }
////    if (gender == Gender.female) {
////      //female pressed
////      if (femaleCardColor == inactiveCardColor) {
////        femaleCardColor = activeCardColor;
////        maleCardColor = inactiveCardColor;
////      } else {
////        femaleCardColor = inactiveCardColor;
////      }
////    }
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI CALCULATOR'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            //first row choosing sex
            child: Row(
              children: <Widget>[
                Expanded(
                  //male

                  child: ReusuableCard(
                    color: selectedGender == Gender.male
                        ? kActiveCardColor
                        : kInactiveCardColor,
                    child: TwoColumn(
                      icon: FontAwesomeIcons.mars,
                      size: 80,
                      color: Color(0xff8C8D98),
                      text: 'MALE',
                    ),
                    onTap: () {
                      setState(() {
                        selectedGender = Gender.male;
                      });
                    },
                  ),
                ),
                Expanded(
                  //female

                  child: ReusuableCard(
                    color: selectedGender == Gender.female
                        ? kActiveCardColor
                        : kInactiveCardColor,
                    child: TwoColumn(
                      icon: FontAwesomeIcons.venus,
                      size: 80,
                      color: Color(0xff8C8D98),
                      text: 'FEMALE',
                    ),
                    onTap: () {
                      setState(() {
                        selectedGender = Gender.female;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            //second row : choosing height
            child: new ReusuableCard(
              color: Color(0xFF0F1327),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'HEIGHT',
                    style: kLabelTextStyle,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment
                        .baseline, //burasi baseline olursa textbaseline porperty side kullanilmalidir
                    mainAxisAlignment: MainAxisAlignment.center,
                    textBaseline: TextBaseline.alphabetic,
                    children: <Widget>[
                      Text(
                        height.toString(),
                        style: kSliderTextStyle,
                      ),
                      Text(
                        'cm',
                        style: kLabelTextStyle,
                      ),
                    ],
                  ),
                  SliderTheme(
                    data: sliderThemeData(context),
                    child: Slider(
                      value: height.toDouble(),
                      min: 120.0,
                      max: 220.0,
                      onChanged: (double newValue) {
                        setState(() {
                          height = newValue.toInt();
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            //third row : weight age
            child: Row(
              children: <Widget>[
                Expanded(
                  // choosing weight
                  child: ReusuableCard(
                    color: Color(0xFF0F1327),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'WEIGHT',
                          style: kLabelTextStyle,
                        ),
                        Text(
                          weight.toString(),
                          style: kSliderTextStyle,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          children: <Widget>[
                            CircleIconButton(
                              icon: FontAwesomeIcons.plus,
                              clicked: () {
                                setState(() {
                                  weight++;
                                });
                              },
                            ),
                            CircleIconButton(
                              icon: FontAwesomeIcons.minus,
                              clicked: () {
                                setState(() {
                                  weight--;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  //choosing age
                  child: ReusuableCard(
                    color: Color(0xFF0F1327),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'AGE',
                          style: kLabelTextStyle,
                        ),
                        Text(
                          age.toString(),
                          style: kSliderTextStyle,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          children: <Widget>[
                            CircleIconButton(
                              icon: FontAwesomeIcons.plus,
                              clicked: () {
                                setState(() {
                                  age++;
                                });
                              },
                            ),
                            CircleIconButton(
                              icon: FontAwesomeIcons.minus,
                              clicked: () {
                                setState(() {
                                  age--;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          new BottomButton(
            onTap: () {
              CalculatorBrain calc =
                  CalculatorBrain(weight: weight, height: height);
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ResultPage(
                  bmi: calc.calculateBMI(),
                  interpretion: calc.getInterpretion(),
                  bmiresult: calc.getResult(),
                );
              }));
            },
            buttonLabel: 'CALCULATE BMI',
          ),
        ],
      ),
    );
  }
}
