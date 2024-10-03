import 'package:flutter/material.dart';

class PokemonsPlaceholder extends StatelessWidget {
  const PokemonsPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('No pokemon match the search criteria'),
    );
  }
}
