// recipe list widget
import 'package:cooking_app/utils/supabase.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cooking_app/screens/fade_animation.dart';
import 'package:cooking_app/screens/widgets/recipe_card.dart';
import 'package:cooking_app/models/recipe.dart';
import 'package:supabase/supabase.dart';

class RecipeListPage extends StatefulWidget {
  const RecipeListPage({Key? key}) : super(key: key);

  @override
  _RecipeListState createState() => _RecipeListState();
}

class _RecipeListState extends State<RecipeListPage> {

  late Future<Recipe> futureRecipes;
  final provider = AuthProvider();

  @override
  void initState() {
    super.initState();
    var client = provider.getClient();
    final response = client.from('recipes').select().order('created_at', ascending: true)
      .execute();
    if (kDebugMode) {
      print(response);
    }
    futureRecipes = response.then((value) => Recipe.fromJson(value));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        // leading: IconButton(
        //   onPressed: () {
        //     Navigator.pop(context);
        //   },
        //   icon: const Icon(
        //     Icons.arrow_back_ios,
        //     size: 20,
        //     color: Colors.black,
        //   ),
        // ),
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
                children: const <Widget>[
                  RecipeCard(
                    title: 'My recipe',
                    rating: '4.9',
                    cookTime: '30 min',
                    thumbnailUrl: 'https://lh3.googleusercontent.com/ei5eF1LRFkkcekhjdR_8XgOqgdjpomf-rda_vvh7jIauCgLlEWORINSKMRR6I6iTcxxZL9riJwFqKMvK0ixS0xwnRHGMY4I5Zw=s360',
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
