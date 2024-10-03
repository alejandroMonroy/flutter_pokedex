import 'package:flutter/material.dart';
import 'package:flutter_pokedex/services/sqflite_service.dart';
import 'package:flutter_pokedex/views/pokemons_view.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SqfliteService.initDatabase();
  runApp(const Pokedex());
}

class Pokedex extends StatelessWidget {
  const Pokedex({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Pokédex Code Challenge',
      theme: ThemeData(
        colorSchemeSeed: Colors.red,
        useMaterial3: true,
      ),
      defaultTransition: Transition.noTransition,
      home: const PokemonsView(),
    );
  }
}
