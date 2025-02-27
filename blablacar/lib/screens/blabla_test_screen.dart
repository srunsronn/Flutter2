import 'package:flutter/material.dart';
import 'package:week_3_blabla_project/widgets/actions/blabla_button.dart';

class BlaButtonTestScreen extends StatelessWidget {
  const BlaButtonTestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test BlaButton Variations'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Primary Button
            BlablaButton(
              text: "Request to book",
              icon: Icons.calendar_month,
              isPrimary: true,
              onPressed: () {},
            ),
            const SizedBox(
              height: 20,
            ),

            //secondary button
            BlablaButton(
              text: "Contact Volodia",
              icon: Icons.chat,
              isPrimary: false,
              onPressed: () {},
            ),
            const SizedBox(
              height: 20,
            ),

            //disabled button
            BlablaButton(
              text: "Request to book",
              icon: Icons.calendar_month,
              isDisabled: true,
              isPrimary: false,
              onPressed: () {},
            ),
            const SizedBox(
              height: 20,
            ),
            //button without icon
            BlablaButton(
              text: "Request to book",
              isPrimary: true,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
