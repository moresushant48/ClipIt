import 'package:clipit/utilities/utility.dart';

class CustomValidators {
  static String? validateEmail(String? value) {
    if (Utility.isNullEmptyOrFalse(value)) return "Email cannot be empty.";
    return null;
  }

  static String? validatePassword(String? value) {
    if (Utility.isNullEmptyOrFalse(value)) return "Password cannot be empty.";
    return null;
  }

  static String? validateMobileNo(String? value) {
    if (Utility.isNullEmptyOrFalse(value)) {
      return "Mobile No cannot be empty.";
    } else if (value?.length != 10) {
      return "Please enter valid mobile no.";
    }
    return null;
  }
}
