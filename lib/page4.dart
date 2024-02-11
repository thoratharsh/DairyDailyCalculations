import 'package:dairycalculations/module1.dart';
import 'package:flutter/material.dart';

class MyPage4 extends StatefulWidget {
  const MyPage4({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyPage4> createState() => _Page4State();
}

class _Page4State extends State<MyPage4> {
  List<List<TextEditingController>> controllers = [];
  List<List<String>> rowValues = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 34; i++) {
      controllers.add([
        TextEditingController(),
        TextEditingController(),
        TextEditingController(),
      ]);
      rowValues.add(["", "", ""]);
    }
  }

  void _setRow1Value1(String value) {
    setState(() {
      rowValues[0][0] = value;
    });
  }

  void _setRow1Value2(String value) {
    setState(() {
      rowValues[0][1] = value;
    });
  }

  void _setRow2Value1(String value) {
    setState(() {
      rowValues[1][0] = value;
    });
  }

  void _setRow2Value2(String value) {
    setState(() {
      rowValues[1][1] = value;
    });
  }

  void _setRow3Value1(String value) {
    setState(() {
      rowValues[2][0] = value;
    });
  }

  void _setRow3Value2(String value) {
    setState(() {
      rowValues[2][1] = value;
    });
  }

  void _setRow4Value1(String value) {
    setState(() {
      rowValues[3][0] = value;
    });
  }

  void _setRow4Value2(String value) {
    setState(() {
      rowValues[3][1] = value;
    });
  }

  void _setRow5Value1(String value) {
    setState(() {
      rowValues[4][0] = value;
    });
  }

  void _setRow5Value2(String value) {
    setState(() {
      rowValues[4][1] = value;
    });
  }

  void _setRow6Value1(String value) {
    setState(() {
      rowValues[5][0] = value;
    });
  }

  void _setRow6Value2(String value) {
    setState(() {
      rowValues[5][1] = value;
    });
  }

  void _setRow7Value1(String value) {
    setState(() {
      rowValues[6][0] = value;
    });
  }

  void _setRow7Value2(String value) {
    setState(() {
      rowValues[6][1] = value;
    });
  }

  void _setRow8Value1(String value) {
    setState(() {
      rowValues[7][0] = value;
    });
  }

  void _setRow8Value2(String value) {
    setState(() {
      rowValues[7][1] = value;
    });
  }

  void _setRow9Value1(String value) {
    setState(() {
      rowValues[8][0] = value;
    });
  }

  void _setRow9Value2(String value) {
    setState(() {
      rowValues[8][1] = value;
    });
  }

  void _setRow10Value1(String value) {
    setState(() {
      rowValues[9][0] = value;
    });
  }

  void _setRow10Value2(String value) {
    setState(() {
      rowValues[9][1] = value;
    });
  }

  void _setRow11Value1(String value) {
    setState(() {
      rowValues[10][0] = value;
    });
  }

  void _setRow11Value2(String value) {
    setState(() {
      rowValues[10][1] = value;
    });
  }

  void _setRow12Value1(String value) {
    setState(() {
      rowValues[11][0] = value;
    });
  }

  void _setRow12Value2(String value) {
    setState(() {
      rowValues[11][1] = value;
    });
  }

  void _setRow13Value1(String value) {
    setState(() {
      rowValues[12][0] = value;
    });
  }

  void _setRow13Value2(String value) {
    setState(() {
      rowValues[12][1] = value;
    });
  }

  void _setRow14Value1(String value) {
    setState(() {
      rowValues[13][0] = value;
    });
  }

  void _setRow14Value2(String value) {
    setState(() {
      rowValues[13][1] = value;
    });
  }

  void _setRow15Value1(String value) {
    setState(() {
      rowValues[14][0] = value;
    });
  }

  void _setRow15Value2(String value) {
    setState(() {
      rowValues[14][1] = value;
    });
  }

  void _setRow16Value1(String value) {
    setState(() {
      rowValues[15][0] = value;
    });
  }

  void _setRow16Value2(String value) {
    setState(() {
      rowValues[15][1] = value;
    });
  }

  void _setRow17Value1(String value) {
    setState(() {
      rowValues[16][0] = value;
    });
  }

  void _setRow17Value2(String value) {
    setState(() {
      rowValues[16][1] = value;
    });
  }

  void _setRow18Value1(String value) {
    setState(() {
      rowValues[17][0] = value;
    });
  }

  void _setRow18Value2(String value) {
    setState(() {
      rowValues[17][1] = value;
    });
  }

  void _setRow19Value1(String value) {
    setState(() {
      rowValues[18][0] = value;
    });
  }

  void _setRow19Value2(String value) {
    setState(() {
      rowValues[18][1] = value;
    });
  }

  void _setRow20Value1(String value) {
    setState(() {
      rowValues[19][0] = value;
    });
  }

  void _setRow20Value2(String value) {
    setState(() {
      rowValues[19][1] = value;
    });
  }

  void _setRow21Value1(String value) {
    setState(() {
      rowValues[20][0] = value;
    });
  }

  void _setRow21Value2(String value) {
    setState(() {
      rowValues[20][1] = value;
    });
  }

  void _setRow22Value1(String value) {
    setState(() {
      rowValues[21][0] = value;
    });
  }

  void _setRow22Value2(String value) {
    setState(() {
      rowValues[21][1] = value;
    });
  }

  void _setRow23Value1(String value) {
    setState(() {
      rowValues[22][0] = value;
    });
  }

  void _setRow23Value2(String value) {
    setState(() {
      rowValues[22][1] = value;
    });
  }

  void _setRow24Value1(String value) {
    setState(() {
      rowValues[23][0] = value;
    });
  }

  void _setRow24Value2(String value) {
    setState(() {
      rowValues[23][1] = value;
    });
  }

  void _setRow25Value1(String value) {
    setState(() {
      rowValues[24][0] = value;
    });
  }

  void _setRow25Value2(String value) {
    setState(() {
      rowValues[24][1] = value;
    });
  }

  void _setRow26Value1(String value) {
    setState(() {
      rowValues[25][0] = value;
    });
  }

  void _setRow26Value2(String value) {
    setState(() {
      rowValues[25][1] = value;
    });
  }

  void _setRow27Value1(String value) {
    setState(() {
      rowValues[26][0] = value;
    });
  }

  void _setRow27Value2(String value) {
    setState(() {
      rowValues[26][1] = value;
    });
  }

  void _setRow28Value1(String value) {
    setState(() {
      rowValues[27][0] = value;
    });
  }

  void _setRow28Value2(String value) {
    setState(() {
      rowValues[27][1] = value;
    });
  }

  void _setRow29Value1(String value) {
    setState(() {
      rowValues[28][0] = value;
    });
  }

  void _setRow29Value2(String value) {
    setState(() {
      rowValues[28][1] = value;
    });
  }

  void _setRow30Value1(String value) {
    setState(() {
      rowValues[29][0] = value;
    });
  }

  void _setRow30Value2(String value) {
    setState(() {
      rowValues[29][1] = value;
    });
  }

  void _setRow31Value1(String value) {
    setState(() {
      rowValues[30][0] = value;
    });
  }

  void _setRow31Value2(String value) {
    setState(() {
      rowValues[30][1] = value;
    });
  }

  void _setRow32Value1(String value) {
    setState(() {
      rowValues[31][0] = value;
    });
  }

  void _setRow32Value2(String value) {
    setState(() {
      rowValues[31][1] = value;
    });
  }

  void _setRow33Value1(String value) {
    setState(() {
      rowValues[32][0] = value;
    });
  }

  void _setRow33Value2(String value) {
    setState(() {
      rowValues[32][1] = value;
    });
  }

  void _clearAll() {
    setState(() {
      for (int i = 0; i < controllers.length; i++) {
        for (int j = 0; j < 2; j++) {
          controllers[i][j].clear();
          rowValues[i][j] = "";
        }
        rowValues[i][2] = "";
      }
    });
  }

  void _calculateFinalRowFields() {
    List<List<String>> rowValuesTemp = rowValues;
    double sumRow3 = 0;
    double sumRow1 = 0;

    for (int i = 0; i < 33; i++) {
      rowValuesTemp[i][2] = "";
      try {
        double value1temp = double.parse(rowValues[i][0]);

        sumRow1 += value1temp;
        double value2temp = double.parse(rowValues[i][1]);
        sumRow3 += value1temp * value2temp;

        rowValuesTemp[i][2] = (value1temp * value2temp).toStringAsFixed(2);
      } catch (e) {
        print(e);
      }
    }
    rowValuesTemp[33][2] = sumRow3.toStringAsFixed(2);
    rowValuesTemp[33][0] = sumRow1.toStringAsFixed(2);

    setState(() {
      rowValues = rowValuesTemp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      rowInputFieldPage2('', controllers[0][0], _setRow1Value1),
                      rowInputFieldPage2('', controllers[0][1], _setRow1Value2),
                      textFieldPage2(rowValues[0][2], TextAlign.right),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      textFieldColumn1('2.', TextAlign.left),
                      rowInputFieldPage2('', controllers[1][0], _setRow2Value1),
                      rowInputFieldPage2('', controllers[1][1], _setRow2Value2),
                      textFieldPage2(rowValues[1][2], TextAlign.right),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      textFieldColumn1('3.', TextAlign.left),
                      rowInputFieldPage2('', controllers[2][0], _setRow3Value1),
                      rowInputFieldPage2('', controllers[2][1], _setRow3Value2),
                      textFieldPage2(rowValues[2][2], TextAlign.right),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      textFieldColumn1('4.', TextAlign.left),
                      rowInputFieldPage2('', controllers[3][0], _setRow4Value1),
                      rowInputFieldPage2('', controllers[3][1], _setRow4Value2),
                      textFieldPage2(rowValues[3][2], TextAlign.right),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      textFieldColumn1('5.', TextAlign.left),
                      rowInputFieldPage2('', controllers[4][0], _setRow5Value1),
                      rowInputFieldPage2('', controllers[4][1], _setRow5Value2),
                      textFieldPage2(rowValues[4][2], TextAlign.right),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      textFieldColumn1('6.', TextAlign.left),
                      rowInputFieldPage2('', controllers[5][0], _setRow6Value1),
                      rowInputFieldPage2('', controllers[5][1], _setRow6Value2),
                      textFieldPage2(rowValues[5][2], TextAlign.right),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      textFieldColumn1('7.', TextAlign.left),
                      rowInputFieldPage2('', controllers[6][0], _setRow7Value1),
                      rowInputFieldPage2('', controllers[6][1], _setRow7Value2),
                      textFieldPage2(rowValues[6][2], TextAlign.right),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      textFieldColumn1('8.', TextAlign.left),
                      rowInputFieldPage2('', controllers[7][0], _setRow8Value1),
                      rowInputFieldPage2('', controllers[7][1], _setRow8Value2),
                      textFieldPage2(rowValues[7][2], TextAlign.right),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      textFieldColumn1('9.', TextAlign.left),
                      rowInputFieldPage2('', controllers[8][0], _setRow9Value1),
                      rowInputFieldPage2('', controllers[8][1], _setRow9Value2),
                      textFieldPage2(rowValues[8][2], TextAlign.right),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      textFieldColumn1('10.', TextAlign.left),
                      rowInputFieldPage2(
                          '', controllers[9][0], _setRow10Value1),
                      rowInputFieldPage2(
                          '', controllers[9][1], _setRow10Value2),
                      textFieldPage2(rowValues[9][2], TextAlign.right),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      textFieldColumn1('11.', TextAlign.left),
                      rowInputFieldPage2(
                          '', controllers[10][0], _setRow11Value1),
                      rowInputFieldPage2(
                          '', controllers[10][1], _setRow11Value2),
                      textFieldPage2(rowValues[10][2], TextAlign.right),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      textFieldColumn1('12.', TextAlign.left),
                      rowInputFieldPage2(
                          '', controllers[11][0], _setRow12Value1),
                      rowInputFieldPage2(
                          '', controllers[11][1], _setRow12Value2),
                      textFieldPage2(rowValues[11][2], TextAlign.right),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      textFieldColumn1('13.', TextAlign.left),
                      rowInputFieldPage2(
                          '', controllers[12][0], _setRow13Value1),
                      rowInputFieldPage2(
                          '', controllers[12][1], _setRow13Value2),
                      textFieldPage2(rowValues[12][2], TextAlign.right),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      textFieldColumn1('14.', TextAlign.left),
                      rowInputFieldPage2(
                          '', controllers[13][0], _setRow14Value1),
                      rowInputFieldPage2(
                          '', controllers[13][1], _setRow14Value2),
                      textFieldPage2(rowValues[13][2], TextAlign.right),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      textFieldColumn1('15.', TextAlign.left),
                      rowInputFieldPage2(
                          '', controllers[14][0], _setRow15Value1),
                      rowInputFieldPage2(
                          '', controllers[14][1], _setRow15Value2),
                      textFieldPage2(rowValues[14][2], TextAlign.right),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      textFieldColumn1('16.', TextAlign.left),
                      rowInputFieldPage2(
                          '', controllers[15][0], _setRow16Value1),
                      rowInputFieldPage2(
                          '', controllers[15][1], _setRow16Value2),
                      textFieldPage2(rowValues[15][2], TextAlign.right),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      textFieldColumn1('17.', TextAlign.left),
                      rowInputFieldPage2(
                          '', controllers[16][0], _setRow17Value1),
                      rowInputFieldPage2(
                          '', controllers[16][1], _setRow17Value2),
                      textFieldPage2(rowValues[16][2], TextAlign.right),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      textFieldColumn1('18.', TextAlign.left),
                      rowInputFieldPage2(
                          '', controllers[17][0], _setRow18Value1),
                      rowInputFieldPage2(
                          '', controllers[17][1], _setRow18Value2),
                      textFieldPage2(rowValues[17][2], TextAlign.right),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      textFieldColumn1('19.', TextAlign.left),
                      rowInputFieldPage2(
                          '', controllers[18][0], _setRow19Value1),
                      rowInputFieldPage2(
                          '', controllers[18][1], _setRow19Value2),
                      textFieldPage2(rowValues[18][2], TextAlign.right),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      textFieldColumn1('20.', TextAlign.left),
                      rowInputFieldPage2(
                          '', controllers[19][0], _setRow20Value1),
                      rowInputFieldPage2(
                          '', controllers[19][1], _setRow20Value2),
                      textFieldPage2(rowValues[19][2], TextAlign.right),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      textFieldColumn1('21.', TextAlign.left),
                      rowInputFieldPage2(
                          '', controllers[20][0], _setRow21Value1),
                      rowInputFieldPage2(
                          '', controllers[20][1], _setRow21Value2),
                      textFieldPage2(rowValues[20][2], TextAlign.right),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      textFieldColumn1('22.', TextAlign.left),
                      rowInputFieldPage2(
                          '', controllers[21][0], _setRow22Value1),
                      rowInputFieldPage2(
                          '', controllers[21][1], _setRow22Value2),
                      textFieldPage2(rowValues[21][2], TextAlign.right),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      textFieldColumn1('23.', TextAlign.left),
                      rowInputFieldPage2(
                          '', controllers[22][0], _setRow23Value1),
                      rowInputFieldPage2(
                          '', controllers[22][1], _setRow23Value2),
                      textFieldPage2(rowValues[22][2], TextAlign.right),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      textFieldColumn1('24.', TextAlign.left),
                      rowInputFieldPage2(
                          '', controllers[23][0], _setRow24Value1),
                      rowInputFieldPage2(
                          '', controllers[23][1], _setRow24Value2),
                      textFieldPage2(rowValues[23][2], TextAlign.right),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      textFieldColumn1('25.', TextAlign.left),
                      rowInputFieldPage2(
                          '', controllers[24][0], _setRow25Value1),
                      rowInputFieldPage2(
                          '', controllers[24][1], _setRow25Value2),
                      textFieldPage2(rowValues[24][2], TextAlign.right),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      textFieldColumn1('26.', TextAlign.left),
                      rowInputFieldPage2(
                          '', controllers[25][0], _setRow26Value1),
                      rowInputFieldPage2(
                          '', controllers[25][1], _setRow26Value2),
                      textFieldPage2(rowValues[25][2], TextAlign.right),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      textFieldColumn1('27.', TextAlign.left),
                      rowInputFieldPage2(
                          '', controllers[26][0], _setRow27Value1),
                      rowInputFieldPage2(
                          '', controllers[26][1], _setRow27Value2),
                      textFieldPage2(rowValues[26][2], TextAlign.right),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      textFieldColumn1('28.', TextAlign.left),
                      rowInputFieldPage2(
                          '', controllers[27][0], _setRow28Value1),
                      rowInputFieldPage2(
                          '', controllers[27][1], _setRow28Value2),
                      textFieldPage2(rowValues[27][2], TextAlign.right),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      textFieldColumn1('29.', TextAlign.left),
                      rowInputFieldPage2(
                          '', controllers[28][0], _setRow29Value1),
                      rowInputFieldPage2(
                          '', controllers[28][1], _setRow29Value2),
                      textFieldPage2(rowValues[28][2], TextAlign.right),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      textFieldColumn1('30.', TextAlign.left),
                      rowInputFieldPage2(
                          '', controllers[29][0], _setRow30Value1),
                      rowInputFieldPage2(
                          '', controllers[29][1], _setRow30Value2),
                      textFieldPage2(rowValues[29][2], TextAlign.right),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      textFieldColumn1('31.', TextAlign.left),
                      rowInputFieldPage2(
                          '', controllers[30][0], _setRow31Value1),
                      rowInputFieldPage2(
                          '', controllers[30][1], _setRow31Value2),
                      textFieldPage2(rowValues[30][2], TextAlign.right),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      textFieldColumn1('32.', TextAlign.left),
                      rowInputFieldPage2(
                          '', controllers[31][0], _setRow32Value1),
                      rowInputFieldPage2(
                          '', controllers[31][1], _setRow32Value2),
                      textFieldPage2(rowValues[31][2], TextAlign.right),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      textFieldColumn1('33.', TextAlign.left),
                      rowInputFieldPage2(
                          '', controllers[32][0], _setRow33Value1),
                      rowInputFieldPage2(
                          '', controllers[32][1], _setRow33Value2),
                      textFieldPage2(rowValues[32][2], TextAlign.right),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      textFieldColumn1('Total', TextAlign.left),
                      textField(rowValues[33][0], TextAlign.left),
                      textField('', TextAlign.center),
                      textField(rowValues[33][2], TextAlign.right),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      elevetedButtonWidget('Clear All', _clearAll),
                      elevetedButtonWidget(
                          'Calculate', _calculateFinalRowFields),
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
