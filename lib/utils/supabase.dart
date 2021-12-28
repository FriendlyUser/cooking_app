import 'package:cooking_app/models/recipe.dart';
import 'package:flutter/material.dart';
import 'package:supabase/supabase.dart';
import 'dart:async';

class AuthProvider {
  static const supabaseUrl = String.fromEnvironment('supabaseUrl', defaultValue: 'supabaseUrl');
  static const supabaseKey = String.fromEnvironment('supabaseKey', defaultValue: 'supabaseKey');
  final client = SupabaseClient(supabaseUrl, supabaseKey);

  Session? userSession;

  Future<Session?> getUserSession() async {
    if (userSession != null) {
      return userSession;
    }

    final session = client.auth.session();
    if (session != null) {
      userSession = session;
      return session;
    }

    return null;
  }

  SupabaseClient getClient() {
    return client;
  }

  Future<Session?> signUp(String email, String password) async {
    final response = await client.auth.signUp(
        email,
        password);
    if (response.error != null) {
      // Error
      debugPrint('Error: ${response.error?.message}');
      throw response.error!.message;
    } else {
      // Success
      final session = response.data;
      userSession = response.data;
      return session;
    }
  }

  // Future<Recipe?> getRecipe(String id) async {
  //   final response = await client.recipes.get(id);
  //   if (response.error != null) {
  //     // Error
  //     debugPrint('Error: ${response.error?.message}');
  //     throw response.error!.message;
  //   } else {
  //     // Success
  //     final recipe = response.data;
  //     return recipe;
  //   }
  // }

  static void showAlert(BuildContext context, String text) {
    var alert = AlertDialog(
      content: Row(
        children: <Widget>[Text(text)],
      ),
      actions: <Widget>[
        FlatButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
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
