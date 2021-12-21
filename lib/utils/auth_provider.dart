import 'package:flutter/material.dart';
import 'package:supabase/supabase.dart';
import 'dart:async';

class AuthProvider {
  final client = SupabaseClient('supabaseUrl', 'supabaseKey');

  Future<Session?> signUp(String email, String password) async {
    final response = await client.auth.signUp(
        email,
        password);
    debugPrint(response.toString());
    if (response.error != null) {
      // Error
      debugPrint('Error: ${response.error?.message}');
      return null;
    } else {
      // Success
      final session = response.data;
      return session;
    }
  }

  static void showAlert(BuildContext context, String text) {
    var alert = new AlertDialog(
      content: Container(
        child: Row(
          children: <Widget>[Text(text)],
        ),
      ),
      actions: <Widget>[
        new FlatButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "OK",
              style: TextStyle(color: Colors.white),
            ))
      ],
    );

    showDialog(
        context: context,
        builder: (_) {
          return alert;
        });
  }
}
