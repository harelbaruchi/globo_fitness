import 'package:flutter/material.dart';
import 'package:globo_fitness/shared/menu_bottom.dart';
import 'package:globo_fitness/shared/menu_drawer.dart';

class BmiScreen extends StatefulWidget {
  const BmiScreen({super.key});

  @override
  State<BmiScreen> createState() => _BmiScreenState();
}

class _BmiScreenState extends State<BmiScreen> {
  final TextEditingController txtHeight = TextEditingController();
  final TextEditingController txtWeight = TextEditingController();
  @override
  String result = '';
  final double fontSize = 18;
  bool isMetric = true;
  bool isImperial = false;
  double? height;
  double? width;
  late List<bool> isSelected;
  String heightMessage = '';
  String weightMessage = '';

  @override
  void initState() {
    // TODO: implement initState
    isSelected = [isImperial, isMetric];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    heightMessage =
        'please enter your height in ' + ((isMetric) ? 'meters' : 'inches');
    weightMessage =
        'please enter your weight in ' + ((isMetric) ? 'kilos' : 'pounds');
    return Scaffold(
      appBar: AppBar(title: const Text('BMI Calculator')),
      bottomNavigationBar: MenuBottom(),
      drawer: MenuDrawer(),
      body: Column(children: [
        ToggleButtons(children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text('Metric', style: TextStyle(fontSize: fontSize)),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text('Imperial', style: TextStyle(fontSize: fontSize)),
          ),
        ], isSelected: isSelected, onPressed: toggleMeasure),
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: TextField(
            controller: txtHeight,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(hintText: heightMessage),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: TextField(
            controller: txtWeight,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(hintText: weightMessage),
          ),
        ),
        ElevatedButton(
          child:Text('calculate BMI',
          style: TextStyle(
            fontSize: fontSize
          )
        ),
        onPressed:findBMI,
        ),
        Text(result,
        style:TextStyle(
          fontSize: fontSize
        ))
      ]),
    );
  }

  void toggleMeasure(value) {
    if (value == 0) {
      isMetric = true;
      isImperial = false;
    } else {
      isMetric = false;
      isImperial = true;
    }
    setState(() {
      isSelected = [isMetric, isImperial];
    });
  }


  void findBMI(){
    double bmi=0;
    double height= double.tryParse(txtHeight.text) ?? 0;
    double weight= double.tryParse(txtWeight.text) ?? 0;
    if(isMetric){
      bmi=weight/(height*height);
    }else {
      bmi=weight*703/(weight*height);
    }
    setState(() {
      result= 'your BMI is ' + bmi.toStringAsFixed(2);
    });
  }
}
