import 'dart:convert';
import 'dart:ui';

import 'package:fitness_apps/model/model_class.dart';
import 'package:fitness_apps/pages/selected_exercises.dart';
import 'package:fitness_apps/widgets/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ExercisesModel> alldata = [];

  String Link =
      "https://raw.githubusercontent.com/codeifitech/fitness-app/master/exercises.json";

  bool isLoading = false;

  fetchData() async {
    try {
      setState(() {
        isLoading = true;
      });
      var responce = await http.get(Uri.parse(Link));
      print("Responce Status Code is: ${responce.statusCode}");
      if (responce.statusCode == 200) {
        final item = jsonDecode(responce.body);
        for (var data in item["exercises"]) {
          ExercisesModel exercisesModel = ExercisesModel(
            id: data["id"],
            title: data["title"],
            thumbnail: data["thumbnail"],
            gif: data["gif"],
            seconds: data["seconds"],
          );
          setState(() {
            alldata.add(exercisesModel);
          });
        }
        print(alldata.length);
      } else {
        showTost("Something Worng");
      }
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print("Something Worng $e");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Color(0xffE0E0E0),
      appBar: AppBar(
          centerTitle: true,
          title: Text("It's time to get stronger",
              style: TextStyle(
                  fontSize: 28,
                  color: Colors.black87,
                  fontWeight: FontWeight.w700)),
          //elevation: 0,
          backgroundColor: Color(0xffDAD7D7)),
      body: ModalProgressHUD(
        inAsyncCall: isLoading == true,
        progressIndicator: spinkit,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: ListView.builder(
              itemCount: alldata.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SelectedExercises(
                              exercisesModel: alldata[index],
                            )));
                  },
                  child: Container(
                    height: 200,
                    margin: EdgeInsets.symmetric(horizontal: 9, vertical: 11),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: Stack(
                        children: [
                          Image.network(
                            "${alldata[index].thumbnail}",
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                height: 70,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        begin: Alignment.centerLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                      //Colors.black12,
                                      Colors.black26,
                                      //Colors.black38,
                                      Colors.black45,
                                      //Colors.black54,
                                      Colors.black87
                                    ])),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text("${alldata[index].title}",
                                      style: TextStyle(
                                          fontSize: 28,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w300)),
                                ),
                              ))
                        ],
                      ),
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
