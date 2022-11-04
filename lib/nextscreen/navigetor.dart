import 'package:flutter/material.dart';

void gotoNextScreen(BuildContext context, Widget nextScreen) {
  Navigator.of(context).push(MaterialPageRoute(builder: (_) => nextScreen));
}
