import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timer/home.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({Key? key, required this.score}) : super(key: key);

  final int score;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.offAll(HomeScreen()),
          icon: Icon(CupertinoIcons.clear, color: Colors.black),
        ),
      ),
      backgroundColor: Color(0xFFFFB800),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: double.infinity),
          Text('Result', style: TextStyle(fontSize: 32),),
          SizedBox(height: 24),
          Text('%$score', style: TextStyle(fontSize: 52),),

          SizedBox(height: 44),
          Text(score > 50 ?'Nice Work 👍🏿' : 'Try Again 👎🏿', style: TextStyle(fontSize: 24, color: Colors.green),),

          SizedBox(height: 82),
          MaterialButton(
            onPressed: () {
              Get.offAll(HomeScreen());
            },
            color: Colors.white,
            minWidth: 250,
            height: 50,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Text(
              'Restart',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
            ),
          ),
        ],
      ),
    );
  }
}
