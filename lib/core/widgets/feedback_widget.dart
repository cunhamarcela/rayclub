import 'package:flutter/material.dart';

class FeedbackWidget extends StatelessWidget {
  final String message;
  final bool isError;

  const FeedbackWidget({
    Key? key,
    required this.message,
    this.isError = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: isError ? Colors.red[100] : Colors.green[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        message,
        style: TextStyle(
          color: isError ? Colors.red[900] : Colors.green[900],
        ),
      ),
    );
  }
} 