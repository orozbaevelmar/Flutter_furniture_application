import 'package:flutter/material.dart';
import 'package:furniture_application/custDropDown.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 40,
      decoration: BoxDecoration(
          color: Colors.green,
          border: Border.all(),
          borderRadius: BorderRadius.circular(12)),
      child: CustDropDown(
        items: const [
          CustDropdownMenuItem(
            value: 0,
            child: Text("Day"),
          ),
          CustDropdownMenuItem(
            value: 0,
            child: Text("Week"),
          )
        ],
        hintText: "DropDown",
        borderRadius: 20,
        onChanged: (val) {
          print(val);
        },
      ),
    );
  }
}
