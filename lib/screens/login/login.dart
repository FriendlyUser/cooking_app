import 'package:cooking_app/screens/recipes/recipe_list.dart';
import 'package:cooking_app/utils/supabase.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cooking_app/screens/fade_animation.dart';
import 'package:cooking_app/screens/login/signup.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormBuilderState>();
  final _emailFieldKey = GlobalKey<FormBuilderFieldState>();
  final provider = AuthProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      FadeAnimation(
                          1,
                          const Text(
                            "Login",
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          )),
                      const SizedBox(
                        height: 20,
                      ),
                      FadeAnimation(
                          1.2,
                          Text(
                            "Login to your account",
                            style: TextStyle(
                                fontSize: 15, color: Colors.grey[700]),
                          )),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: FormBuilder(
                          key: _formKey,
                          // autovalidateMode: AutovalidateMode.onUserInteraction,
                          child: Column(
                            children: [
                              const SizedBox(height: 10),
                              FormBuilderTextField(
                                key: _emailFieldKey,
                                name: 'email',
                                decoration:
                                    const InputDecoration(labelText: 'Email'),
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(context),
                                  FormBuilderValidators.email(context),
                                ]),
                              ),
                              const SizedBox(height: 10),
                              FormBuilderTextField(
                                name: 'password',
                                decoration: const InputDecoration(
                                    labelText: 'Password'),
                                obscureText: true,
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(context),
                                  FormBuilderValidators.minLength(context, 6),
                                ]),
                              ),
                              const SizedBox(height: 10)
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  FadeAnimation(
                      1.4,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Container(
                          padding: const EdgeInsets.only(top: 3, left: 3),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: const Border(
                                bottom: BorderSide(color: Colors.black),
                                top: BorderSide(color: Colors.black),
                                left: BorderSide(color: Colors.black),
                                right: BorderSide(color: Colors.black),
                              )),
                          child: MaterialButton(
                            minWidth: double.infinity,
                            height: 60,
                            onPressed: () async {
                              if (_formKey.currentState?.saveAndValidate() ??
                                  false) {
                                if (true) {
                                  // Either invalidate using Form Key
                                  // _formKey.currentState?.invalidateField(
                                  //     name: 'email',
                                  //     errorText: 'Email already taken.');
                                  // OR invalidate using Field Key
                                  // _emailFieldKey.currentState?.invalidate('Email already taken.');
                                }
                                debugPrint('Valid');
                                var provider = AuthProvider();
                                var email =
                                    _formKey.currentState?.value["email"];
                                var password =
                                    _formKey.currentState?.value["password"];
                                try {
                                  var result =
                                      await provider.signIn(email, password);
                                  if (kDebugMode) {
                                    print("What is going on here");
                                    print(result);
                                  }
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const RecipeListPage()),
                                  );
                                } catch (e) {
                                  debugPrint(e.toString());
                                    _formKey.currentState?.invalidateField(
                                      name: 'password',
                                      errorText: e.toString(),
                                    );
                                }
                              } else {
                                debugPrint('Invalid');
                              }
                              debugPrint(
                                  _formKey.currentState?.value.toString());
                            },
                            color: Colors.greenAccent,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50)),
                            child: const Text(
                              "Login",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 18),
                            ),
                          ),
                        ),
                      )),
                  FadeAnimation(
                      1.5,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Text("Don't have an account?"),
                          InkWell(
                            onTap: () async {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SignupForm()));
                            },
                            child: const Text(
                              "Sign up",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 18),
                            ),
                          ),
                        ],
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
