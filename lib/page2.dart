import 'package:dairycalculations/module1.dart';
import 'package:flutter/material.dart';

class MyPage2 extends StatefulWidget {
  const MyPage2({super.key, required this.title});

  final String title;

  @override
  State<MyPage2> createState() => _Page2State();
}

class _Page2State extends State<MyPage2> {
  final fieldTextControllerRow1Field1 = TextEditingController();
  final fieldTextControllerRow1Field2 = TextEditingController();
  final fieldTextControllerRow1Field3 = TextEditingController();

  final fieldTextControllerRow2Field1 = TextEditingController();
  final fieldTextControllerRow2Field2 = TextEditingController();
  final fieldTextControllerRow2Field3 = TextEditingController();

  final fieldTextControllerRow3Field1 = TextEditingController();
  final fieldTextControllerRow3Field2 = TextEditingController();
  final fieldTextControllerRow3Field3 = TextEditingController();

  final fieldTextControllerRow4Field1 = TextEditingController();
  final fieldTextControllerRow4Field2 = TextEditingController();
  final fieldTextControllerRow4Field3 = TextEditingController();

  final fieldTextControllerRow5Field1 = TextEditingController();
  final fieldTextControllerRow5Field2 = TextEditingController();
  final fieldTextControllerRow5Field3 = TextEditingController();

  final fieldTextControllerRow6Field1 = TextEditingController();
  final fieldTextControllerRow6Field2 = TextEditingController();
  final fieldTextControllerRow6Field3 = TextEditingController();

  final fieldTextControllerRow7Field1 = TextEditingController();
  final fieldTextControllerRow7Field2 = TextEditingController();
  final fieldTextControllerRow7Field3 = TextEditingController();

  final fieldTextControllerRow8Field1 = TextEditingController();
  final fieldTextControllerRow8Field2 = TextEditingController();
  final fieldTextControllerRow8Field3 = TextEditingController();

  final fieldTextControllerRow9Field1 = TextEditingController();
  final fieldTextControllerRow9Field2 = TextEditingController();
  final fieldTextControllerRow9Field3 = TextEditingController();

  final fieldTextControllerRow10Field1 = TextEditingController();
  final fieldTextControllerRow10Field2 = TextEditingController();
  final fieldTextControllerRow10Field3 = TextEditingController();

  String row1value1 = "";
  String row1value2 = "";
  String row1value3 = "";

  String row2value1 = "";
  String row2value2 = "";
  String row2value3 = "";

  String row3value1 = "";
  String row3value2 = "";
  String row3value3 = "";

  String row4value1 = "";
  String row4value2 = "";
  String row4value3 = "";

  String row5value1 = "";
  String row5value2 = "";
  String row5value3 = "";

  String row6value1 = "";
  String row6value2 = "";
  String row6value3 = "";

  String row7value1 = "";
  String row7value2 = "";
  String row7value3 = "";

  String row8value1 = "";
  String row8value2 = "";
  String row8value3 = "";

  String row9value1 = "";
  String row9value2 = "";
  String row9value3 = "";

  String row10value1 = "";
  String row10value2 = "";
  String row10value3 = "";

  String row11value1 = "";
  String row11value2 = "";
  String row11value3 = "";

  void _setRow1Value1(String value) {
    setState(() {
      row1value1 = value;
    });
  }

  void _setRow1Value2(String value) {
    setState(() {
      row1value2 = value;
    });
  }

  void _setRow2Value1(String value) {
    setState(() {
      row2value1 = value;
    });
  }

  void _setRow2Value2(String value) {
    setState(() {
      row2value2 = value;
    });
  }

  void _setRow3Value1(String value) {
    setState(() {
      row3value1 = value;
    });
  }

  void _setRow3Value2(String value) {
    setState(() {
      row3value2 = value;
    });
  }

  void _setRow4Value1(String value) {
    setState(() {
      row4value1 = value;
    });
  }

  void _setRow4Value2(String value) {
    setState(() {
      row4value2 = value;
    });
  }

  void _setRow5Value1(String value) {
    setState(() {
      row5value1 = value;
    });
  }

  void _setRow5Value2(String value) {
    setState(() {
      row5value2 = value;
    });
  }

  void _setRow6Value1(String value) {
    setState(() {
      row6value1 = value;
    });
  }

  void _setRow6Value2(String value) {
    setState(() {
      row6value2 = value;
    });
  }

  void _setRow7Value1(String value) {
    setState(() {
      row7value1 = value;
    });
  }

  void _setRow7Value2(String value) {
    setState(() {
      row7value2 = value;
    });
  }

  void _setRow8Value1(String value) {
    setState(() {
      row8value1 = value;
    });
  }

  void _setRow8Value2(String value) {
    setState(() {
      row8value2 = value;
    });
  }

  void _setRow9Value1(String value) {
    setState(() {
      row9value1 = value;
    });
  }

  void _setRow9Value2(String value) {
    setState(() {
      row9value2 = value;
    });
  }

  void _setRow10Value1(String value) {
    setState(() {
      row10value1 = value;
    });
  }

  void _setRow10Value2(String value) {
    setState(() {
      row10value2 = value;
    });
  }

  void _clearAll() {
    fieldTextControllerRow1Field1.clear();
    fieldTextControllerRow1Field2.clear();
    fieldTextControllerRow2Field1.clear();
    fieldTextControllerRow2Field2.clear();
    fieldTextControllerRow3Field1.clear();
    fieldTextControllerRow3Field2.clear();
    fieldTextControllerRow4Field1.clear();
    fieldTextControllerRow4Field2.clear();
    fieldTextControllerRow5Field1.clear();
    fieldTextControllerRow5Field2.clear();
    fieldTextControllerRow6Field1.clear();
    fieldTextControllerRow6Field2.clear();
    fieldTextControllerRow7Field1.clear();
    fieldTextControllerRow7Field2.clear();
    fieldTextControllerRow8Field1.clear();
    fieldTextControllerRow8Field2.clear();
    fieldTextControllerRow9Field1.clear();
    fieldTextControllerRow9Field2.clear();
    fieldTextControllerRow10Field1.clear();
    fieldTextControllerRow10Field2.clear();

    setState(() {
      row1value1 = "";
      row1value2 = "";
      row1value3 = "";

      row2value1 = "";
      row2value2 = "";
      row2value3 = "";

      row3value1 = "";
      row3value2 = "";
      row3value3 = "";

      row4value1 = "";
      row4value2 = "";
      row4value3 = "";

      row5value1 = "";
      row5value2 = "";
      row5value3 = "";

      row6value1 = "";
      row6value2 = "";
      row6value3 = "";

      row7value1 = "";
      row7value2 = "";
      row7value3 = "";

      row8value1 = "";
      row8value2 = "";
      row8value3 = "";

      row9value1 = "";
      row9value2 = "";
      row9value3 = "";

      row10value1 = "";
      row10value2 = "";
      row10value3 = "";

      row11value1 = "";
      row11value2 = "";
      row11value3 = "";
    });
  }

  void _calculateFinalRowFields() {
    double row1value1temp = double.parse(row1value1);
    double row1value2temp = double.parse(row1value2);
    setState(() {
      row1value3 = (row1value1temp * row1value2temp).toStringAsFixed(2);
    });

    double row2value1temp = double.parse(row2value1);
    double row2value2temp = double.parse(row2value2);
    setState(() {
      row2value3 = (row2value1temp * row2value2temp).toStringAsFixed(2);
    });

    double row3value1temp = double.parse(row3value1);
    double row3value2temp = double.parse(row3value2);
    setState(() {
      row3value3 = (row3value1temp * row3value2temp).toStringAsFixed(2);
    });

    double row4value1temp = double.parse(row4value1);
    double row4value2temp = double.parse(row4value2);
    setState(() {
      row4value3 = (row4value1temp * row4value2temp).toStringAsFixed(2);
    });

    double row5value1temp = double.parse(row5value1);
    double row5value2temp = double.parse(row5value2);
    setState(() {
      row5value3 = (row5value1temp * row5value2temp).toStringAsFixed(2);
    });

    double row6value1temp = double.parse(row6value1);
    double row6value2temp = double.parse(row6value2);
    setState(() {
      row6value3 = (row6value1temp * row6value2temp).toStringAsFixed(2);
    });

    double row7value1temp = double.parse(row7value1);
    double row7value2temp = double.parse(row7value2);
    setState(() {
      row7value3 = (row7value1temp * row7value2temp).toStringAsFixed(2);
    });

    double row8value1temp = double.parse(row8value1);
    double row8value2temp = double.parse(row8value2);
    setState(() {
      row8value3 = (row8value1temp * row8value2temp).toStringAsFixed(2);
    });

    double row9value1temp = double.parse(row9value1);
    double row9value2temp = double.parse(row9value2);
    setState(() {
      row9value3 = (row9value1temp * row9value2temp).toStringAsFixed(2);
    });

    double row10value1temp = double.parse(row10value1);
    double row10value2temp = double.parse(row10value2);
    setState(() {
      row10value3 = (row10value1temp * row10value2temp).toStringAsFixed(2);
    });

    double row1value3temp = double.parse(row1value3);
    double row2value3temp = double.parse(row2value3);
    double row3value3temp = double.parse(row3value3);
    double row4value3temp = double.parse(row4value3);
    double row5value3temp = double.parse(row5value3);
    double row6value3temp = double.parse(row6value3);
    double row7value3temp = double.parse(row7value3);
    double row8value3temp = double.parse(row8value3);
    double row9value3temp = double.parse(row9value3);
    double row10value3temp = double.parse(row10value3);

    setState(() {
      row11value1 = (row1value1temp +
              row2value1temp +
              row3value1temp +
              row4value1temp +
              row5value1temp +
              row6value1temp +
              row7value1temp +
              row8value1temp +
              row9value1temp +
              row10value1temp)
          .toStringAsFixed(2);
    });

    setState(() {
      row11value3 = (row1value3temp +
              row2value3temp +
              row3value3temp +
              row4value3temp +
              row5value3temp +
              row6value3temp +
              row7value3temp +
              row8value3temp +
              row9value3temp +
              row10value3temp)
          .toStringAsFixed(2);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(
      //backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      //title: Text(widget.title),
      //),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      elevetedButtonWidget('Clear All', _clearAll),
                      elevetedButtonWidget(
                          'Calculate', _calculateFinalRowFields),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      textFieldColumn1('1.', TextAlign.left),
                      rowInputFieldPage2(
                          '', fieldTextControllerRow1Field1, _setRow1Value1),
                      rowInputFieldPage2(
                          '', fieldTextControllerRow1Field2, _setRow1Value2),
                      textField(row1value3, TextAlign.right),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      textFieldColumn1('2.', TextAlign.left),
                      rowInputFieldPage2(
                          '', fieldTextControllerRow2Field1, _setRow2Value1),
                      rowInputFieldPage2(
                          '', fieldTextControllerRow2Field2, _setRow2Value2),
                      textField(row2value3, TextAlign.right),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      textFieldColumn1('3.', TextAlign.left),
                      rowInputFieldPage2(
                          '', fieldTextControllerRow3Field1, _setRow3Value1),
                      rowInputFieldPage2(
                          '', fieldTextControllerRow3Field2, _setRow3Value2),
                      textField(row3value3, TextAlign.right),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      textFieldColumn1('4.', TextAlign.left),
                      rowInputFieldPage2(
                          '', fieldTextControllerRow4Field1, _setRow4Value1),
                      rowInputFieldPage2(
                          '', fieldTextControllerRow4Field2, _setRow4Value2),
                      textField(row4value3, TextAlign.right),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      textFieldColumn1('5.', TextAlign.left),
                      rowInputFieldPage2(
                          '', fieldTextControllerRow5Field1, _setRow5Value1),
                      rowInputFieldPage2(
                          '', fieldTextControllerRow5Field2, _setRow5Value2),
                      textField(row5value3, TextAlign.right),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      textFieldColumn1('6.', TextAlign.left),
                      rowInputFieldPage2(
                          '', fieldTextControllerRow6Field1, _setRow6Value1),
                      rowInputFieldPage2(
                          '', fieldTextControllerRow6Field2, _setRow6Value2),
                      textField(row6value3, TextAlign.right),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      textFieldColumn1('7.', TextAlign.left),
                      rowInputFieldPage2(
                          '', fieldTextControllerRow7Field1, _setRow7Value1),
                      rowInputFieldPage2(
                          '', fieldTextControllerRow7Field2, _setRow7Value2),
                      textField(row7value3, TextAlign.right),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      textFieldColumn1('8.', TextAlign.left),
                      rowInputFieldPage2(
                          '', fieldTextControllerRow8Field1, _setRow8Value1),
                      rowInputFieldPage2(
                          '', fieldTextControllerRow8Field2, _setRow8Value2),
                      textField(row8value3, TextAlign.right),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      textFieldColumn1('9.', TextAlign.left),
                      rowInputFieldPage2(
                          '', fieldTextControllerRow9Field1, _setRow9Value1),
                      rowInputFieldPage2(
                          '', fieldTextControllerRow9Field2, _setRow9Value2),
                      textField(row9value3, TextAlign.right),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      textFieldColumn1('10.', TextAlign.left),
                      rowInputFieldPage2(
                          '', fieldTextControllerRow10Field1, _setRow10Value1),
                      rowInputFieldPage2(
                          '', fieldTextControllerRow10Field2, _setRow10Value2),
                      textField(row10value3, TextAlign.right),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      textFieldColumn1('Total', TextAlign.left),
                      textField(row11value1, TextAlign.left),
                      textField('', TextAlign.center),
                      textField(row11value3, TextAlign.right),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
