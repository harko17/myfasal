import 'dart:convert';

//import 'package:fasal/function.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:myfasal_2/screen/result.dart';

class CropPredictionPage extends StatefulWidget {
  @override
  _CropPredictionPageState createState() => _CropPredictionPageState();
}

double _nitrogen = 0;
double _phosphorus = 0;
double _potassium = 0;
double _temperature = 0;
double _humidity = 0;
double _ph = 0;
double _rainfall = 0;

class _CropPredictionPageState extends State<CropPredictionPage> {
  final _formKey = GlobalKey<FormState>();
  String url = "";
  var data;
  String _predictedCrop = '';
  bool load = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        SingleChildScrollView(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [0.3, 1],
                    colors: [Colors.green, Colors.blue])),
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 16,bottom: 16,left: 8,right: 8),
                      child: GridView.builder(
                        physics: ScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 7, // Number of items in the grid
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // 2 items per row
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 15,
                          childAspectRatio: 0.6, // To keep the containers square
                        ),
                        itemBuilder: (context, index) {
                          String label;
                          String imagePath;

                          switch (index) {
                            case 0:
                              label = "Nitrogen";
                              imagePath = "assets/n.png";
                              break;
                            case 1:
                              label = "Phosphorus";
                              imagePath = "assets/p.png";
                              break;
                            case 2:
                              label = "Potassium";
                              imagePath = "assets/k.png";
                              break;
                            case 6:
                              label = "Temperature (°C)";
                              imagePath = "assets/temp.png";
                              break;
                            case 4:
                              label = "Humidity (%)";
                              imagePath = "assets/hum.png";
                              break;
                            case 5:
                              label = "Rainfall (mm)";
                              imagePath = "assets/rain.png";
                              break;
                            case 3:
                              label = "pH";
                              imagePath = "assets/ph.png";
                              break;
                            default:
                              label = "Unknown";
                              imagePath = "assets/logo.png";
                              break;
                          }

                          return Padding(
                            padding: const EdgeInsets.only(left: 8,right: 8),
                            child: CustomC(label,
                                imagePath), // Pass the label and image path
                          );
                        },
                      ),
                    ),

                    /*Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 200, // Adjust height to make it square
                        width: 200,  // Adjust width to make it square
                        decoration: BoxDecoration(
                          color: Color(0xFFF5F5F5), // Milky white color
                          borderRadius: BorderRadius.circular(20), // Rounded corners
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 10,
                              spreadRadius: 2,
                              offset: Offset(2, 5),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // CircleAvatar for the image
                              CircleAvatar(
                                radius: 40,
                                backgroundColor: Colors.transparent,
                                child: Image.asset("assets/logo.png"), // Your image here
                              ),
                              SizedBox(height: 10),

                              // Form for entering Nitrogen value
                              Form(

                                child: TextFormField(
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    labelText: 'Nitrogen',
                                    //alignLabelWithHint: true,
                                    filled: true,
                                    fillColor: Colors.white, // White background for input
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                  keyboardType: TextInputType.number,

                                  onChanged: (value) {

                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Nitrogen'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a value for Nitrogen';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      _nitrogen = double.parse(value!);
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Phosphorus'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a value for Phosphorus';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      _phosphorus = double.parse(value!);
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Potassium'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a value for Potassium';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      _potassium = double.parse(value!);
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Temperature (°C)'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a value for Temperature';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      _temperature = double.parse(value!);
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Humidity (%)'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a value for Humidity';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      _humidity = double.parse(value!);
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'pH'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a value for pH';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      _ph = double.parse(value!);
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Rainfall (mm)'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a value for Rainfall';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      _rainfall = double.parse(value!);
                    },
                  ),*/
                    SizedBox(height: 16.0),
                    ElevatedButton(
                      child: const Text('Predict'),
                      onPressed: () {
                        showModalBottomSheet<void>(
                          backgroundColor: Colors.transparent,

                          context: context,
                          builder: (BuildContext context) {
                            return SizedBox(
                              height: double.infinity,
                              child: Padding(
                                padding: const EdgeInsets.all(88.0),
                                child: Center(child: Image.asset("assets/loader.gif")),
                              ),
                            );
                          },
                        );
                        Future.delayed(Duration(seconds: 3)).whenComplete(() {
                          setState(() {
                            Navigator.pop(context);
                          });
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Result()));
                        });
                      },

                    ),
                    /*ElevatedButton(
                      onPressed: () {
                        setState(() {
                          load = true;
                          Future.delayed(Duration(seconds: 3)).whenComplete(() {
                            setState(() {
                              load=false;
                            });
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Result()));
                          });


                        });
                      },
                      child: Text('Predict Crop'),
                    ),*/
                    /*ElevatedButton(
                    onPressed: () async{
                      if (_formKey.currentState!.validate()) {
                        // If the form is valid, display a snackbar. In the real world,
                        // you'd often call a server or save the information in a database.
                        url = "https://harko17.pythonanywhere.com/api?nn="+_nitrogen.toString()+""
                            "&pp="+_phosphorus.toString()+"&kk="+_potassium.toString()+"&tt="+_temperature.toString()+
                            "&hh="+_humidity.toString()+"&pp="+_ph.toString()+"&rr="+_rainfall.toString();
                        print(url);

                        //data=await fetchdata(url);

                        var decoded = jsonDecode(data);

                        setState(() {
                          _predictedCrop=decoded['output'];

                        });
                      }
                      else
                      {
                        setState(() {
                          _predictedCrop="";
                        });

                      }


                    },
                    child: Text('Predict Crop'),
                  ),*/
                    SizedBox(height: 16.0),
                    if (_predictedCrop.isNotEmpty &&
                        _formKey.currentState!.validate())
                      Text(
                        _predictedCrop,
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
          if(load)
          Padding(
          padding: const EdgeInsets.all(88.0),
          child: Center(child: Image.asset("assets/farmer.gif")),
        ),
      ]),
    );
  }

  Widget CustomC(String title, String image) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        //color: Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            spreadRadius: 2,
            offset: Offset(2, 5),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.transparent,
              child: Image.asset(image), // Your image here
            ),
            SizedBox(height: 10),
            // Form for entering values
            TextFormField(
              textAlign: TextAlign.center,
              decoration: InputDecoration(

                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
              keyboardType: TextInputType.number,
            ),
            Text("$title",style: TextStyle(fontSize: 20),),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

//http://127.0.0.1:5000/api?nn=10&pp=10&kk=10&tt=30&hh=78&pp=5&rr=100
