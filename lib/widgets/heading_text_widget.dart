import 'package:flutter/material.dart';

class HeadingText extends StatelessWidget {
  const HeadingText({
    required this.currentQuestionIndex,
    this.backgroundColor = Colors.brown,
    this.textColor = Colors.white,
    this.padding = const EdgeInsets.all(10),
    Key? key,
  }) : super(key: key);

  final int currentQuestionIndex;
  final Color backgroundColor;
  final Color textColor;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                backgroundColor,
                backgroundColor.withOpacity(0.8),
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 4,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Padding(
            padding: padding,
            child: Text(
              'QUESTION: ${currentQuestionIndex + 1}',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: textColor,
                letterSpacing: 1,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}
