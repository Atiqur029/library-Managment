String validateMobile(String value) {
  RegExp regExp = RegExp(r'^[0-9]{10}$');
  if (value.isEmpty) {
    return "Required Phone Number";
  } else if (value.length > 10) {
    return "Phone Number Length 11";
  } else if (!regExp.hasMatch(value)) {
    return 'Please enter valid email Address';
  }
  return "";
}
