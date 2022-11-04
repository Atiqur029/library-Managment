import 'package:flutter/material.dart';

bool validationAndSave(GlobalKey<FormState> fromkey) {
  final form = fromkey.currentState;
  if (form!.validate()) {
    form.save();
    return true;
  }
  return false;
}
