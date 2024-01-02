import 'package:filesharing/colors.dart';
import 'package:flutter/material.dart';

class GiveFeedback extends StatefulWidget {
  const GiveFeedback({super.key});

  @override
  State<GiveFeedback> createState() => _GiveFeedbackState();
}

class _GiveFeedbackState extends State<GiveFeedback> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Your feedback is important, it can help us to improve our app!',
        style: TextStyle(
          color: MyColors().textColor,
          fontSize: 20,
        ),
      ),
      content: TextField(
        maxLines: 10,
        controller: controller,
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: MyColors().primary),
              borderRadius: BorderRadius.circular(18),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1.5, color: MyColors().primary),
              borderRadius: BorderRadius.circular(18),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2.5, color: MyColors().primary),
              borderRadius: BorderRadius.circular(18),
            )),
      ),
      actions: [
        TextButton(onPressed: (){
          Navigator.pop(context);
        }, child: const Text('Close')),
        TextButton(onPressed: (){
          //TODO: upload feedback to database
        }, child: const Text('Send'))
      ],
    );
  }
}
