import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timer/quiz.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final questions = [];

  void loadQuestions() async {
    String result = await DefaultAssetBundle.of(context).loadString('assets/quiz.json');
    questions.addAll(jsonDecode(result));
  }

  @override
  void initState() {
    super.initState();
    loadQuestions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFB800),
      body: Column(
        children: [
          Spacer(),
          Image.asset('assets/images/img.png'),
          Spacer(),
          const Text(
            'Welcome to Kasmaal',
            style: TextStyle(fontSize: 24),
          ),

          SizedBox(height: 32),

          MaterialButton(
            onPressed: () {
              Get.to(QuizScreen(questions: questions));
            },
            color: Colors.white,
            minWidth: 250,
            height: 50,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Text(
              'Start Quiz',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400
              ),
            ),
          ),
          SizedBox(height: 88),
        ],
      ),
    );
  }
}
