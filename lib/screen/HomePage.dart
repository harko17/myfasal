import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:myfasal_2/screen/CropPrediction.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.3, 1],
                  colors: [Colors.green, Colors.blue])
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Padding(
                padding: const EdgeInsets.only(left: 50,right: 50),
                child: Image.asset("assets/logo.png"),
              ),
              SizedBox(height: 20,),
              Text("MyFasal",style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold,letterSpacing: 5),),
              SizedBox(height: 20,),
              ElevatedButton(onPressed: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CropPredictionPage())),
                style: ElevatedButton.styleFrom(

                  shadowColor: Colors.greenAccent,
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0)),
                  maximumSize: const Size(200, 150), //////// HERE
                ),
                child: Text("Begin Predicting",style: TextStyle(color: Colors.green,fontSize: 20),),
              ),
             CircleAvatar(
               radius: 50,
               backgroundColor: Colors.transparent,
               child: Image.asset("assets/loader.gif"),
             ),
            ],
          ),
        ),
      ),
    );
  }
}
