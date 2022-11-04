// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class TextInputForm extends StatelessWidget {
  final String hintext;
  final String intialvalue;
  //final TextEditingController controller;

  final TextInputType keabordtype;
  final Function(String?)? onsave;
  //final bool? enabled;

  final String? Function(String?)? validator;
  const TextInputForm({
    Key? key,
    required this.hintext,
    required this.intialvalue,
    required this.keabordtype,
    //required this.controller,
    this.onsave,
    this.validator,
    //this.enabled,
    //this.enabled = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Container(
      height: 65,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      child: TextFormField(
        //controller: controller,
        initialValue: intialvalue,
        keyboardType: keabordtype,
        decoration: InputDecoration(
            filled: true,
            // enabled: enabled!,
            fillColor: Colors.grey[200],
            hintText: hintext,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: const BorderSide())),
        onSaved: onsave,
        validator: validator,
      ),
    ));
  }
}
