import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:pie_chart/pie_chart.dart';
import '../service/gemini_service.dart';
import '../service/globals.dart';
import 'lib/service/gemini_service.dart';

class Result extends StatefulWidget {
  const Result({super.key});

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  Map<String, double> dataMap = {
    "Apples": 18.47,
    "Pumpkin": 17.70,
    "Rice": 4.25,
    "Barley": 3.51,
    "Tobaco": 2.83,
  };

  // Colors for each segment
  bool _isLoading = false;

  Future<void> _getRiskRemedy() async {
    setState(() => _isLoading = true);
    await GeminiService.fetchRiskAndRemedy("Apples");
    setState(() => _isLoading = false);
  }
  // of the pie chart
  List<Color> colorList = [
    const Color(0xffD95AF3),
    const Color(0xff3EE094),
    const Color(0xff3398F6),
    const Color(0xffFA4A42),
    const Color(0xffFE9539)
  ];

  // List of gradients for the
  // background of the pie chart

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 40,
              ),
              PieChart(
                // Pass in the data for
                // the pie chart
                dataMap: dataMap,
                // Set the colors for the
                // pie chart segments
                colorList: colorList,
                // Set the radius of the pie chart
                chartRadius: MediaQuery.of(context).size.width / 2,
                // Set the center text of the pie chart
                centerText: "Crops",
                centerTextStyle: TextStyle(fontSize: 25),
                // Set the width of the
                // ring around the pie chart
                ringStrokeWidth: 24,
                // Set the animation duration of the pie chart
                animationDuration: const Duration(seconds: 3),
                // Set the options for the chart values (e.g. show percentages, etc.)
                chartValuesOptions: const ChartValuesOptions(
                    showChartValues: true,
                    showChartValuesOutside: true,
                    showChartValuesInPercentage: true,
                    showChartValueBackground: false),
                // Set the options for the legend of the pie chart
                legendOptions: const LegendOptions(
                    showLegends: true,
                    legendShape: BoxShape.rectangle,
                    legendTextStyle: TextStyle(fontSize: 15),
                    legendPosition: LegendPosition.bottom,
                    showLegendsInRow: true),
                // Set the list of gradients for
                // the background of the pie chart
              ),
              SizedBox(
                height: 35,
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text("Let's Grow Apples",style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold),),
              ),
              Padding(
                padding: const EdgeInsets.only(left:150.0,top:0,bottom: 0,right: 150),
                child: Center(child: Image.asset("assets/farmer.gif")),
              ),

              SizedBox(
                height: 35,
              ),
              ElevatedButton(
                child: const Text('Show Risk and Remedy'),
                onPressed: () async {
                  if (!_isLoading) {
                    await _getRiskRemedy(); // Call the function
                    showModalBottomSheet<void>(
                      context: context,
                      backgroundColor: Colors.white,
                      builder: (BuildContext context) {
                        return _buildBottomSheet(); // extracted for clarity (see below)
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
        width: double.infinity,
      ),
    );
  }
}
Widget _buildBottomSheet() {
  return SingleChildScrollView(
    child: SizedBox(
      height: 800,
      child: Center(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(18.0),
              child: Text(
                "Cultivating Apples",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Risk", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Card(
                    color: Colors.red,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        riskText,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text("Remedy", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Card(
                    color: Colors.green,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        remedyText,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
