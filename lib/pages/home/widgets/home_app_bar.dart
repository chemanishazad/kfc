import 'package:flutter/material.dart';
import 'package:kfc/styles.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [Icon(Icons.shopping_cart)],
      ),
    );
  }
}
