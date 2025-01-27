import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class LaptopCategory extends StatefulWidget {
  final List<dynamic> laptopBanner;
  final List<dynamic> featuredLaptop;
 

  const LaptopCategory({
    super.key,
    required this.laptopBanner,
    required this.featuredLaptop,
    
  });

  @override
  State<LaptopCategory> createState() => _LaptopCategoryState();
}

class _LaptopCategoryState extends State<LaptopCategory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Laptops"),
        backgroundColor: const Color.fromARGB(255, 48, 116, 50),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CarouselSlider.builder(
              itemCount: widget.laptopBanner.length,
              itemBuilder: (context, index, realIndex) {
                return widget.laptopBanner.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : Padding(
                        padding: const EdgeInsets.only(
                            top: 12.0, right: 6.0, left: 6.0, bottom: 12.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            "${widget.laptopBanner[index]!["banner"]}",
                            fit: BoxFit.fill,
                          ),
                        ),
                      );
              },
              options: CarouselOptions(
                height: 170,
                aspectRatio: 16 / 9,
                viewportFraction: 0.85,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeFactor: 0.3,
                scrollDirection: Axis.horizontal,
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 50, 132, 96),
              ),
              child: Stack(
                children: [
                  Positioned(
                    right: -90,
                    bottom: -20,
                    child: Container(
                      height: 300,
                      width: 300,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(140, 160, 223, 255),
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.elliptical(
                            100,
                            100.0,
                          ),
                          top: Radius.elliptical(
                            160,
                            200,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: -110,
                    child: Container(
                      height: 300,
                      width: 300,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(127, 186, 232, 255),
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.elliptical(
                            100,
                            100.0,
                          ),
                          top: Radius.elliptical(
                            100,
                            200,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            const Text(
                              "FEATURED LAPTOPS",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                            const Spacer(),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 280,
                        child: Row(
                          children: [
                            Expanded(
                              child: ListView.builder(
                                itemCount: widget.featuredLaptop.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: const EdgeInsets.all(10.0),
                                    padding: const EdgeInsets.all(12.0),
                                    width: 180,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 28),
                                        Center(
                                          child: Image.network(
                                            widget.featuredLaptop[index]
                                                ["icon"],
                                            scale: 0.8,
                                          ),
                                        ),
                                        const Spacer(),
                                        const Text("Rs : ₹"),
                                        Text(
                                          widget.featuredLaptop[index]
                                                  ["label"] ??
                                              "",
                                        )
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
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
