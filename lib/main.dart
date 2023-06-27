import 'package:dairycalculations/module1.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dairy Calculations',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Dairy daily calculations'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final fieldTextControllerRow1Field1 = TextEditingController();
  final fieldTextControllerRow1Field4 = TextEditingController();

  final fieldTextControllerRow2Field1 = TextEditingController();
  final fieldTextControllerRow2Field2 = TextEditingController();
  final fieldTextControllerRow2Field3 = TextEditingController();
  final fieldTextControllerRow2Field4 = TextEditingController();
  final fieldTextControllerRow2Field5 = TextEditingController();

  final fieldTextControllerRow4Field1 = TextEditingController();
  final fieldTextControllerRow4Field4 = TextEditingController();

  final fieldTextControllerRow5Field1 = TextEditingController();
  final fieldTextControllerRow5Field2 = TextEditingController();
  final fieldTextControllerRow5Field3 = TextEditingController();
  final fieldTextControllerRow5Field4 = TextEditingController();
  final fieldTextControllerRow5Field5 = TextEditingController();

  final fieldTextControllerRow6Field1 = TextEditingController();
  final fieldTextControllerRow6Field2 = TextEditingController();
  final fieldTextControllerRow6Field3 = TextEditingController();
  final fieldTextControllerRow6Field4 = TextEditingController();

  String row1value1 = "";
  String row1value4 = "";
  String row1value5 = "00";

  String row2value1 = "";
  String row2value2 = "";
  String row2value3 = "";
  String row2value4 = "";
  String row2value5 = "00";

  String row3value1 = "";
  String row3value5 = "00";

  String row4value1 = "";
  String row4value4 = "";
  String row4value5 = "00";

  String row5value1 = "";
  String row5value4 = "";
  String row5value5 = "00";

  String row6value1 = "";
  String row6value2 = "";
  String row6value3 = "";
  String row6value4 = "";
  String row6value5 = "00";

  String row7value1 = "";
  String row7value2 = "";
  String row7value3 = "";
  String row7value4 = "";
  String row7value5 = "Total";

  void _calculateFinalRowFields() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Calculating"),
    ));

    double row1value1temp = double.parse(row1value1);
    double row1value4temp = double.parse(row1value4);
    setState(() {
      row1value5 = (row1value1temp * row1value4temp).toStringAsFixed(0);
    });

    double row2value1temp = double.parse(row2value1);
    setState(() {
      row3value1 = (row1value1temp + row2value1temp).toString();
    });

    double row2value4temp = double.parse(row2value4);
    setState(() {
      row2value5 = (row2value1temp * row2value4temp).toStringAsFixed(0);
    });

    double row3value1temp = double.parse(row3value1);
    double row1value5temp = double.parse(row1value5);
    double row2value5temp = double.parse(row2value5);
    setState(() {
      row3value5 = (row1value5temp + row2value5temp).toStringAsFixed(0);
    });

    double row4value1temp = double.parse(row4value1);
    double row4value4temp = double.parse(row4value4);
    setState(() {
      row4value5 = (row4value1temp * row4value4temp).toStringAsFixed(0);
    });

    setState(() {
      row5value1 = (row3value1temp - row4value1temp).toString();
    });

    double row5value1temp = double.parse(row5value1);
    double row3value5temp = double.parse(row3value5);
    double row4value5temp = double.parse(row4value5);
    setState(() {
      row5value5 = (row3value5temp - row4value5temp).toStringAsFixed(0);
    });

    double row6value1temp = double.parse(row6value1);
    double row6value4temp = double.parse(row6value4);
    setState(() {
      row6value5 = (row6value1temp * row6value4temp).toStringAsFixed(0);
    });

    setState(() {
      row7value1 = (row6value1temp - row5value1temp).toStringAsFixed(2);
    });

    double row6value5temp = double.parse(row6value5);
    double row5value5temp = double.parse(row5value5);
    setState(() {
      row7value5 = (row6value5temp - row5value5temp).toStringAsFixed(0);
    });
  }

  void _setRow1Value1(String value) {
    setState(() {
      row1value1 = value;
    });
  }

  void _setRow1Value4(String value) {
    setState(() {
      row1value4 = value;
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

  void _setRow2Value3(String value) {
    setState(() {
      row2value3 = value;
    });
  }

  void _setRow2Value4(String value) {
    setState(() {
      row2value4 = value;
    });
  }

  void _setRow4Value1(String value) {
    setState(() {
      row4value1 = value;
    });
  }

  void _setRow4Value4(String value) {
    setState(() {
      row4value4 = value;
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

  void _setRow6Value3(String value) {
    setState(() {
      row6value3 = value;
    });
  }

  void _setRow6Value4(String value) {
    setState(() {
      row6value4 = value;
    });
  }

  void _clearAll() {
    fieldTextControllerRow1Field1.clear();
    fieldTextControllerRow1Field4.clear();

    fieldTextControllerRow2Field1.clear();
    fieldTextControllerRow2Field2.clear();
    fieldTextControllerRow2Field3.clear();
    fieldTextControllerRow2Field4.clear();

    fieldTextControllerRow4Field1.clear();
    fieldTextControllerRow4Field4.clear();

    fieldTextControllerRow5Field1.clear();
    fieldTextControllerRow5Field2.clear();
    fieldTextControllerRow5Field3.clear();
    fieldTextControllerRow5Field4.clear();

    fieldTextControllerRow6Field1.clear();
    fieldTextControllerRow6Field2.clear();
    fieldTextControllerRow6Field3.clear();
    fieldTextControllerRow6Field4.clear();

    setState(() {
      row1value5 = "00";
      row3value1 = "";
      row6value1 = "";

      row2value5 = "00";
      row3value5 = "00";

      row4value5 = "00";

      row5value1 = "";
      row5value5 = "00";
      row6value5 = "00";

      row7value1 = "";
      row7value5 = "Total";
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
        scrollDirection: Axis.horizontal,
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      elevetedButtonWidget('Clear All', _clearAll),
                      elevetedButtonWidget(
                          'Calculate', _calculateFinalRowFields),
                      dateTextField(),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      labelTextField('Shillak Stock', TextAlign.left),
                      rowInputField('litres', fieldTextControllerRow1Field1,
                          _setRow1Value1),
                      textField('', TextAlign.center),
                      textField('', TextAlign.center),
                      rowInputField('Rs/litre', fieldTextControllerRow1Field4,
                          _setRow1Value4),
                      textField(row1value5, TextAlign.right)
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      labelTextField('Collection', TextAlign.left),
                      rowInputField('litres', fieldTextControllerRow2Field1,
                          _setRow2Value1),
                      rowInputField(
                          '', fieldTextControllerRow2Field2, _setRow2Value2),
                      rowInputField(
                          '', fieldTextControllerRow2Field3, _setRow2Value3),
                      rowInputField('Rs/litre', fieldTextControllerRow2Field4,
                          _setRow2Value4),
                      textField(row2value5, TextAlign.right),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      subLabelTextField(
                          'Shillak Stock Calculation', TextAlign.left),
                      textField(row3value1, TextAlign.right),
                      textField('', TextAlign.center),
                      textField('', TextAlign.center),
                      textField('', TextAlign.center),
                      textField(row3value5, TextAlign.right),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      labelTextField('Second Stock', TextAlign.left),
                      rowInputField('litres', fieldTextControllerRow4Field1,
                          _setRow4Value1),
                      textField('', TextAlign.center),
                      textField('', TextAlign.center),
                      rowInputField('Rs/litre', fieldTextControllerRow4Field4,
                          _setRow4Value4),
                      textField(row4value5, TextAlign.right)
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      labelTextField('Today Collection', TextAlign.left),
                      textField(row5value1, TextAlign.right),
                      textField('', TextAlign.center),
                      textField('', TextAlign.center),
                      textField('', TextAlign.center),
                      textField(row5value5, TextAlign.right),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      labelTextField('Tanker', TextAlign.left),
                      rowInputField('litres', fieldTextControllerRow6Field1,
                          _setRow6Value1),
                      rowInputField(
                          '', fieldTextControllerRow6Field2, _setRow6Value2),
                      rowInputField(
                          '', fieldTextControllerRow6Field3, _setRow6Value3),
                      rowInputField('Rs/litre', fieldTextControllerRow6Field4,
                          _setRow6Value4),
                      textField(row6value5, TextAlign.right),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      labelTextField('Total', TextAlign.left),
                      textField(row7value1, TextAlign.right),
                      textField('', TextAlign.center),
                      textField('', TextAlign.center),
                      textField('', TextAlign.center),
                      textField(row7value5, TextAlign.right),
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
