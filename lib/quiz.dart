import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timer/result.dart';

class QuizScreen extends StatefulWidget {
  QuizScreen({Key? key, required this.questions}) : super(key: key);

  final List questions;

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final PageController controller = PageController();

  final currentPage = 0.obs;

  late Timer timer;
  final countDown = 30.obs;

  int correctAnswers = 0;
  int score = 0;

  void onNextClick(bool isCorrect) {
    resetTimer();
    if (isCorrect) {
      ++correctAnswers;
      score = (correctAnswers * 100) ~/ widget.questions.length;
    }

    if ((currentPage.value + 1) == widget.questions.length) {
      timer.cancel();
      Get.to(ResultScreen(score: score));
    } else {
      controller.jumpToPage(++currentPage.value);
    }
  }

  void resetTimer() {
    countDown.value = 30;
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (countDown.value == 0) {
        onNextClick(false);
      }
      --countDown.value;
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          toolbarHeight: 88,
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(CupertinoIcons.clear, color: Colors.black),
          ),
          actions: [
            Center(
              child: Container(
                width: 52,
                height: 52,
                margin: EdgeInsets.only(right: 24),
                decoration: BoxDecoration(
                    border: Border.all(width: 3, color: Colors.white),
                    shape: BoxShape.circle),
                child: Center(
                  child: Obx(() {
                    return Text(
                      countDown.value.toString(),
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black
                      ),
                    );
                  })
                ),
              ),
            )
          ],
        ),
        backgroundColor: Color(0xFFFFB800),
        body: Column(
          children: [
            Obx(() {
              return LinearProgressIndicator(
                value: (currentPage.value + 1) / widget.questions.length,
                color: Colors.white,
                backgroundColor: Colors.transparent,
              );
            }),
            SizedBox(height: 24),
            Expanded(
              child: PageView.builder(
                controller: controller,
                physics: NeverScrollableScrollPhysics(),
                itemCount: widget.questions.length,
                itemBuilder: (ctx, index) {
                  final question = widget.questions[index];
                  return buildQuestion(context, question);
                },
              ),
            ),
          ],
        ));
  }

  buildQuestion(BuildContext context, Map question) {
    final options = question['options'];

    final selectedOption = (-1).obs;

    return Column(
      children: [
        Text(
          question['question'],
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16),
        Expanded(
          child: ListView.builder(
            itemCount: options.length,
            itemBuilder: (ctx, index) {
              final option = options[index];
              return Obx(() {
                return RadioListTile(
                  value: index,
                  groupValue: selectedOption.value,
                  onChanged: (val) {
                    selectedOption.value = val!;
                  },
                  title: Text(
                    option,
                    style: TextStyle(
                        fontWeight: selectedOption.value == index
                            ? FontWeight.bold
                            : FontWeight.normal,
                        color: selectedOption.value == index
                            ? Colors.blue
                            : Colors.black),
                  ),
                );
              });
            },
          ),
        ),
        MaterialButton(
          onPressed: () {
            if (selectedOption.value == -1) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Please select an option!')));
            } else {
              final answer = question['answer'];
              bool isCorrect = selectedOption.value == answer;
              onNextClick(isCorrect);
            }
          },
          color: Colors.white,
          minWidth: 250,
          height: 50,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Text(
            'Check',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
          ),
        ),
        SizedBox(height: 72),
      ],
    );
  }
}
