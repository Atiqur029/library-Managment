String validateEmail(String value) {
  RegExp regExp = RegExp(r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$');
  if (value.isEmpty) {
    return 'Please enter Email Address';
  } else if (!regExp.hasMatch(value)) {
    return 'Please enter valid email Address';
  }
  return "";
}
