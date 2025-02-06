import 'package:flutter/material.dart';

class FormBody extends StatelessWidget {
  const FormBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //TODO: MAKE UR OWN FORM BODY CONTENT
          Text("FORM BODY CONTENT")
        ],
      ),
    );
  }
}