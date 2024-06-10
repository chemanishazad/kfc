import 'package:flutter/material.dart';
import 'package:kfc/model/category_nodel.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:kfc/model/product_model.dart';
import 'package:kfc/pages/details/details_page.dart';
import 'package:kfc/pages/home/widgets/categories_widget.dart';
import 'package:kfc/pages/home/widgets/home_app_bar.dart';
import 'package:kfc/widgets/top_oval_clipper.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final PageController _textSlideController = PageController();
  PageController _imageSlideController = PageController(viewportFraction: 0.52);

  void onCategorySelected(CategoryModel selectedCategory) {
    setState(() {
      for (var category in categories) {
        category.selected = category == selectedCategory;
      }
      selectedProducts = selectedCategory.products;
      _imageSlideController.dispose();
      _imageSlideController = PageController(viewportFraction: 0.52);
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {
          _imageSlideController.jumpToPage(0);
        });
      }
    });
  }

  final List<ProductModel> freshJuiceProducts = [
    ProductModel(
        name: "Orange Juice", price: 80.00, image: "assets/icons/shake/13.png"),
    ProductModel(
        name: "Pineapple Juice",
        price: 75.00,
        image: "assets/icons/shake/14.png"),
    ProductModel(
        name: "Mango Juice", price: 75.00, image: "assets/icons/shake/15.png"),
    ProductModel(
        name: "Water Melon", price: 50.00, image: "assets/icons/shake/3.png"),
  ];

  final List<ProductModel> milkShakeProducts = [
    ProductModel(
        name: "Strawberry Shake",
        price: 85.00,
        image: "assets/icons/shake/2.png"),
    ProductModel(
        name: "Kiwi Shake", price: 90.00, image: "assets/icons/shake/4.png"),
    ProductModel(
        name: "Vanilla Shake", price: 90.00, image: "assets/icons/shake/5.png"),
    ProductModel(
        name: "Chocolate Shake",
        price: 80.00,
        image: "assets/icons/shake/6.png"),
    ProductModel(
        name: "Mixed Fruit Shake",
        price: 80.00,
        image: "assets/icons/shake/7.png"),
    ProductModel(
        name: "Butterscotch Shake",
        price: 80.00,
        image: "assets/icons/shake/9.png"),
    ProductModel(
        name: "Ice cream Shake",
        price: 80.00,
        image: "assets/icons/shake/10.png"),
  ];

  final List<ProductModel> iceCreamProducts = [
    ProductModel(
        name: "Chocolate Ice Cream",
        price: 55.00,
        image: "assets/icons/shake/12.png"),
    ProductModel(
        name: "Vanilla Ice Cream",
        price: 72.50,
        image: "assets/icons/shake/20.png"),
    ProductModel(
        name: "Strawberry Ice Cream",
        price: 62.50,
        image: "assets/icons/shake/17.png"),
    ProductModel(
        name: "Mixed Ice Cream",
        price: 82.50,
        image: "assets/icons/shake/19.png"),
  ];

  final List<ProductModel> coolDrinksProducts = [
    ProductModel(
        name: "Coca Cola", price: 40.00, image: "assets/icons/shake/c1.png"),
    ProductModel(
        name: "Pepsi", price: 45.00, image: "assets/icons/shake/c5.png"),
    ProductModel(
        name: "Coke With Ice",
        price: 45.00,
        image: "assets/icons/shake/c2.png"),
    ProductModel(
        name: "Pepsi Can", price: 70.00, image: "assets/icons/shake/c4.png"),
    ProductModel(
        name: "Sprite Can", price: 70.00, image: "assets/icons/shake/c6.png"),
  ];

  late List<CategoryModel> categories;
  List<ProductModel> selectedProducts = [];

  @override
  void initState() {
    super.initState();

    categories = [
      CategoryModel(
          name: "Fresh Juice",
          icon: "assets/json/juice.json",
          products: freshJuiceProducts),
      CategoryModel(
          name: "Milk Shake",
          icon: "assets/json/milk_shake.json",
          products: milkShakeProducts),
      CategoryModel(
          name: "Ice Cream",
          icon: "assets/json/ice.json",
          products: iceCreamProducts),
      CategoryModel(
          name: "Cool Drinks",
          icon: "assets/json/drink.json",
          products: coolDrinksProducts),
    ];

    // Mark the first category as selected initially
    categories[0].selected = true;
    selectedProducts = categories[0].products;

    Future.delayed(const Duration(milliseconds: 300), () {
      _imageSlideController.animateToPage(1,
          duration: const Duration(milliseconds: 400), curve: Curves.linear);
    });
  }

  @override
  void dispose() {
    _imageSlideController.dispose();
    _textSlideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 234, 255, 180),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HomeAppBar(),
            Padding(
              padding: const EdgeInsets.only(left: 35, bottom: 1, top: 10),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                child: Image.asset('assets/logo.png'),
              ),
            ),
            Expanded(
              child: ClipPath(
                clipper: TopOvalClipper(),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 189, 1, 1),
                  ),
                  child: Stack(
                    children: [
                      CategoriesWidget(
                        categories: categories,
                        onCategorySelected: onCategorySelected,
                      ),
                      Positioned(
                        top: 130,
                        bottom: 0,
                        child: ClipPath(
                          clipper: TopOvalClipper(),
                          child: Container(
                            color: const Color.fromARGB(255, 235, 231, 7),
                            width: MediaQuery.of(context).size.width,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 140,
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: AnimatedBuilder(
                          animation: _imageSlideController,
                          builder: (context, child) {
                            return PageView.builder(
                              itemCount: selectedProducts.length,
                              controller: _imageSlideController,
                              onPageChanged: (page) {
                                _textSlideController.animateToPage(page,
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.linear);
                              },
                              itemBuilder: (context, index) {
                                double value = 0.0;

                                if (_imageSlideController
                                    .position.haveDimensions) {
                                  value = index.toDouble() -
                                      (_imageSlideController.page ?? 0);
                                  value = (value * 0.7).clamp(-1, 1);
                                }

                                return Align(
                                  alignment: Alignment.topCenter,
                                  child: Transform.translate(
                                    offset: Offset(0, 50 + (value.abs() * 200)),
                                    child: Transform.scale(
                                      scale: 1 - (value.abs() * 0.05),
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => DetailsPage(
                                                

                                                product:
                                                    selectedProducts[index],
                                              ),
                                            ),
                                          );
                                        },
                                        child: SizedBox(
                                          width: 280,
                                          height: 280,
                                          child: Stack(
                                            alignment: Alignment.bottomCenter,
                                            children: [
                                              Container(
                                                width: 180,
                                                height: 180,
                                                decoration: const BoxDecoration(
                                                  color: Color.fromARGB(
                                                      255, 190, 178, 2),
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                                              Positioned(
                                                bottom: 10,
                                                top: 0,
                                                child: Hero(
                                                  tag: selectedProducts[index]
                                                      .name,
                                                  child: Image.asset(
                                                    selectedProducts[index]
                                                        .image,
                                                    fit: BoxFit.cover,
                                                    height: 100,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                      Positioned(
                        bottom: 10,
                        left: 100,
                        right: 100,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 100,
                              child: PageView.builder(
                                itemCount: selectedProducts.length,
                                controller: _textSlideController,
                                scrollDirection: Axis.vertical,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        selectedProducts[index].name,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            fontSize: 18,
                                            height: 1.1,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        "₹ ${selectedProducts[index % selectedProducts.length].price.toStringAsFixed(2)}",
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                            SmoothPageIndicator(
                              controller: _imageSlideController,
                              count: selectedProducts.length,
                              effect: ScrollingDotsEffect(
                                spacing: 15.0,
                                radius: 8.0,
                                fixedCenter: true,
                                dotWidth: 5.0,
                                dotHeight: 5.0,
                                activeDotScale: 3,
                                dotColor: Colors.grey[400]!,
                                activeDotColor: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
