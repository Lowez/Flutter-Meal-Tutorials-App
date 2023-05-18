// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';

import '../models/meal.dart';

class MealDetailScreen extends StatelessWidget {
  final Function(Meal) onToggleFavorite;
  final Function(Meal) isFavorite;

  const MealDetailScreen(this.onToggleFavorite, this.isFavorite);

  Widget _createSectionTitle(BuildContext context, String title) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }

  Widget _createSectionContainer(Widget child) {
    return Container(
      width: 330,
      height: 250,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10)),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final meal = ModalRoute.of(context)?.settings.arguments as Meal;

    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 250,
                  width: double.infinity,
                  child: Image.network(
                    meal.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.fromLTRB(300, 190, 10, 0),
                //   child: FloatingActionButton(
                //     child: Icon(Icons.star),
                //     onPressed: () {
                //       Navigator.of(context).pop();
                //     },
                //   ),
                // ),
              ],
            ),
            _createSectionTitle(context, 'Ingredientes'),
            _createSectionContainer(ListView.builder(
              itemCount: meal.ingredients.length,
              itemBuilder: (ctx, index) {
                return Card(
                  color: Theme.of(context).colorScheme.secondary,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 10,
                    ),
                    child: Text(meal.ingredients[index]),
                  ),
                );
              },
            )),
            _createSectionTitle(context, 'Passos'),
            _createSectionContainer(ListView.builder(
              itemCount: meal.steps.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        child: Text('${index + 1}'),
                      ),
                      title: Text(meal.steps[index]),
                    ),
                    const Divider(),
                  ],
                );
              },
            )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.primary,
        onPressed: () {
          onToggleFavorite(meal);
        },
        child: Icon(isFavorite(meal) ? Icons.favorite : Icons.favorite_border),
      ),
    );
  }
}
