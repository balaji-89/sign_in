
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SignIn with ChangeNotifier {
  String emailErrorText;
  String passwordErrorText;

  bool passwordInvisible = true;

  bool isLoading = false;

  void changePasswordVisibility() {
    passwordInvisible = !passwordInvisible;
    notifyListeners();
  }

  Future<dynamic> signIn(emailAddress, password,context) async {
    emailErrorText = null;
    passwordErrorText = null;
    isLoading = true;
    notifyListeners();
    try {
      http.Response response=await http.post('https://innercircle.caapidsimplified/api/login');
      var dartMapResponse = jsonDecode(response.body);
      return dartMapResponse["data"];
    }  catch (error) {
      isLoading = false;
      notifyListeners();
      var errorMessage = error.message;
       if (errorMessage.contains('email') ||
          (errorMessage.contains('User')) ||
          (errorMessage.contains('Invalid Credentials'))) {
        emailErrorText = errorMessage;
        passwordErrorText = null;
      }

      notifyListeners();
    }
  }


  // Future<void> sendTheLink(String emailAddress) async {
  //   emailErrorText = null;
  //   try {
  //     isLoading = true;
  //     notifyListeners();
  //     String response = await User().forgotPassword(emailAddress);
  //     isLoading = false;
  //     notifyListeners();
  //   } on ErrorResponse catch (error) {
  //     isLoading = false;
  //     emailErrorText = error.message;
  //     notifyListeners();
  //     throw error;
  //   }
  // }
}
