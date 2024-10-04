import 'package:flutter/material.dart';
import 'package:flutter_pokedex/views/pokedex_view.dart';
import 'package:get/get.dart';

class OpenPokeballButton extends StatelessWidget {
  const OpenPokeballButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => const PokedexView());
      },
      child: Image.asset(
        'assets/icons/pokeball.png',
        height: 24.0,
      ),
    );
  }
}
