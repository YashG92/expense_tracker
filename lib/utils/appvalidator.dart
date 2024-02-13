class AppValidator {
  String? validateUsername(value) {
    if (value!.isEmpty) {
      return 'Please enter an username';
    }
    RegExp usernameRegExp = RegExp(r'^[a-zA-Z][a-zA-Z0-9_.-]*$');
    if (!usernameRegExp.hasMatch(value)) {
      return 'Please enter a valid username';
    }
    return null;
  }

  String? validateEmail(value) {
    if (value!.isEmpty) {
      return 'Please enter an email';
    }
    RegExp emailRegExp =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!emailRegExp.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? validatePhoneNumber(value) {
    if (value!.isEmpty) {
      return 'Please enter a phone number';
    }
    if (value.length != 10) {
      return 'Please enter a 10-digit phone number';
    }
    return null;
  }

  String? validatePassword(value) {
    if (value!.isEmpty) {
      return 'Please enter a password';
    }
    RegExp passwordRegExp = RegExp(
      r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d@$!%*?&]{8,}$',
    );
    if (!passwordRegExp.hasMatch(value)) {
      return 'Enter a valid password';
    }
    return null;
  }
}
