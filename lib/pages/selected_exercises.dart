import 'package:fitness_apps/model/model_class.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class SelectedExercises extends StatefulWidget {
  SelectedExercises({Key? key, this.exercisesModel}) : super(key: key);
  ExercisesModel? exercisesModel;

  @override
  State<SelectedExercises> createState() => _SelectedExercisesState();
}

class _SelectedExercisesState extends State<SelectedExercises> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Image.network(
          "${widget.exercisesModel!.thumbnail}",
          height: double.infinity,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        Positioned(
          bottom: 30,
          left: 0,
          right: 0,
          child: Column(
            children: [
              SleekCircularSlider(
                innerWidget: (value) {
                  return Container(
                    //color: Colors.black12,
                    alignment: Alignment.center,
                    child: Text("${setTime?.toInt()} Mins",
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.w500)),
                  );
                },
                // innerWidget: (value) {
                //   return Container(
                //     alignment: Alignment.center,
                //     child: Text("${second.toStringAsFixed(0)} S"),
                //   );
                // },
                appearance: CircularSliderAppearance(
                    //spinnerMode: true,
                    customWidths: CustomSliderWidths(progressBarWidth: 10)),

                min: 3,
                max: 20,
                initialValue: 3,
                onChange: (value) {
                  setState(() {
                    setTime = value;
                  });
                },
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.amber,
                ),
                onPressed: () {},
                child: Text("Start",
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.black,
                        fontWeight: FontWeight.w500)),
              )
            ],
          ),
        ),
      ]),
    );
  }

  double? setTime;
}
