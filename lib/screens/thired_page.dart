import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../model/exercise.dart';
import '../widget/spinkit.dart';
import 'home_screen.dart';


class ThiredPage extends StatefulWidget {
  final Exercise? exercise;
  int? second;

   ThiredPage({Key? key,this.exercise,this.second}) : super(key: key);

  @override
  State<ThiredPage> createState() => _ThiredPageState();
}

class _ThiredPageState extends State<ThiredPage> {
  late Timer timer;
  int startSound = 0;
  @override
  void initState() {
    // TODO: implement initState
    timer=Timer.periodic(const Duration(seconds: 1), (timer) {
      if(timer.tick==widget.second){
        timer.cancel();
        setState(() {
          showToast("Workout Successfully Completed");
          Future.delayed(const Duration(seconds: 3),(){
            Navigator.of(context).pop();
          });
          
        });


      }
      setState(() {
        startSound=timer.tick;
      });


    });


    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0A0C23).withOpacity(0.7),
      appBar: AppBar(
        title: const Text("Fitness App"),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          CachedNetworkImage(
              width: double.infinity,
              imageUrl: "${widget.exercise!.gif}",
            height: double.infinity,
            placeholder: (context, url) => spinkit,
            errorWidget: (context, url, error) => const Icon(Icons.error),

          ),
          Positioned(
              top: 60,
              left: 20,
              right: 20,

              child: Center(
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                        height: 80,
                        width: 80,
                      decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.orange,
                        boxShadow: [BoxShadow(
                          offset: Offset.fromDirection(2.0, 4.0),
                          blurRadius: 3,
                          color: Colors.black.withOpacity(0.6),
                        ),],),
                      child: Text("${startSound}",style: myStyle(40, Colors.white, FontWeight.w600)),




                    ),
                    Text("Timer On", style: myStyle(25, Colors.white, FontWeight.w600)),

                  ],


                ),
              )),
          Positioned(
              left: 0,
              right: 0,
              bottom: 100,
              child: Center(child: Text("${widget.exercise!.title}",style: myStyle(25, Colors.white, FontWeight.w700)))),



        ],

      ),
    );
  }
}
