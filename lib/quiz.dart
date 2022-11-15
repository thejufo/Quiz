import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuizScreen extends StatelessWidget {
  QuizScreen({Key? key, required this.questions}) : super(key: key);

  final List questions;
  final PageController controller = PageController();

  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Color(0xFFFFB800),
      body: PageView.builder(
        controller: controller,
        physics: NeverScrollableScrollPhysics(),
        itemCount: questions.length,
        itemBuilder: (ctx, index) {
          final question = questions[index];
          return buildQuestion(context, question);
        },
      ),
    );
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
                  title: Text(option, style: TextStyle(
                    fontWeight: selectedOption.value == index ? FontWeight.bold : FontWeight.normal,
                    color: selectedOption.value == index ? Colors.blue : Colors.black
                  ),),
                );
              });
            },
          ),
        ),
        MaterialButton(
          onPressed: () {
            if (selectedOption.value == -1) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Please select an option!'))
              );
            } else {
              controller.jumpToPage(++currentPage);
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
