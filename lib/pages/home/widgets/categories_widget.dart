import 'package:flutter/material.dart';
import 'package:kfc/model/category_nodel.dart';
import 'package:lottie/lottie.dart';

class CategoriesWidget extends StatelessWidget {
  final List<CategoryModel> categories;
  final Function(CategoryModel) onCategorySelected;

  const CategoriesWidget(
      {required this.categories, required this.onCategorySelected, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 200,
      child: Stack(
        children: [
          for (var i = 0; i < categories.length; i++)
            Positioned(
              top: categories.length / 2 > i
                  ? 110 - (i * 35)
                  : 110 - ((categories.length - 1 - i) * 35),
              left: (i * MediaQuery.of(context).size.width) / categories.length,
              child: GestureDetector(
                onTap: () => onCategorySelected(categories[i]),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / categories.length,
                  height: 90,
                  child: Column(
                    children: [
                      Container(
                        width: 65,
                        height: 65,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: categories[i].selected
                              ? Colors.white
                              : const Color.fromARGB(255, 255, 248, 183),
                          boxShadow: categories[i].selected
                              ? [
                                  const BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 10,
                                    spreadRadius: 1,
                                  )
                                ]
                              : [],
                        ),
                        child: Center(
                          child: Lottie.asset(
                            categories[i].icon,
                            width: 60,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        categories[i].name,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 10,
                          color: categories[i].selected
                              ? Colors.black
                              : Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
