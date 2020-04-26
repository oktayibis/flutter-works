import 'package:flutter/material.dart';
import '../constants.dart';
import '../components/reusuable_card.dart';
import '../components/bottom_button.dart';

class ResultPage extends StatelessWidget {
  final String bmiresult;
  final String interpretion;
  final String bmi;

  ResultPage(
      {@required this.bmiresult,
      @required this.interpretion,
      @required this.bmi});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Your Result'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'Your Result is:',
                  style: kResultScreenTitle,
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: ReusuableCard(
                color: kInactiveCardColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      bmiresult.toUpperCase(),
                      style: kResultTextColor,
                    ),
                    Text(
                      bmi,
                      style: kBMIResultTextStyle,
                    ),
                    Text(
                      interpretion,
                      style: kBMIExplainTextStyle,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            BottomButton(
              onTap: () {
                Navigator.pop(context);
              },
              buttonLabel: 'RE-CALCULATE BMI',
            ),
          ],
        ));
  }
}
