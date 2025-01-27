import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class MoblieCategory extends StatefulWidget {
  final dynamic upcomingMobiles;
  final dynamic moblies1;
  final dynamic moblies2;

  const MoblieCategory({
    super.key,
    required this.upcomingMobiles,
    required this.moblies1,
    required this.moblies2,
  });

  @override
  State<MoblieCategory> createState() => _MoblieCategoryState();
}

class _MoblieCategoryState extends State<MoblieCategory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mobiles"),
        backgroundColor: const Color.fromARGB(255, 110, 80, 180),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CarouselSlider.builder(
              itemCount: widget.upcomingMobiles.length,
              itemBuilder: (context, index, realIndex) {
                return widget.upcomingMobiles.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : Padding(
                        padding: const EdgeInsets.only(
                            top: 12.0, right: 6.0, left: 6.0, bottom: 12.0),
                        child: Image.network(
                          "${widget.upcomingMobiles[index]!["icon"]}",
                          fit: BoxFit.fill,
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
            Stack(
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 320,
                      child: Row(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              itemCount: widget.moblies1.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: const EdgeInsets.all(10.0),
                                  padding: const EdgeInsets.all(12.0),
                                  width: 180,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.grey,
                                        blurRadius: 4,
                                        spreadRadius: 0.3,
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Stack(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(height: 28),
                                          Center(
                                            child: Image.network(
                                              widget.moblies1[index]["icon"],
                                              scale: 0.8,
                                            ),
                                          ),
                                          const Spacer(),
                                          const Text("Rs : ₹"),
                                          Text(
                                            widget.moblies1[index]["label"] ??
                                                "",
                                          )
                                        ],
                                      ),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: Container(
                                          padding: const EdgeInsets.all(4.0),
                                          decoration: BoxDecoration(
                                            color: Colors.green,
                                            borderRadius:
                                                BorderRadius.circular(4.0),
                                          ),
                                          child: Text(
                                            "${widget.moblies1[index]["offer"]} off",
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
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
            const Divider(),
            Stack(
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 320,
                      child: Row(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              itemCount: widget.moblies2.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: const EdgeInsets.all(10.0),
                                  padding: const EdgeInsets.all(12.0),
                                  width: 180,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.grey,
                                        blurRadius: 4,
                                        spreadRadius: 0.3,
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Stack(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(height: 28),
                                          Center(
                                            child: Image.network(
                                              widget.moblies2[index]["icon"],
                                              scale: 0.8,
                                            ),
                                          ),
                                          const Spacer(),
                                          const Text("Rs : ₹"),
                                          Text(
                                            widget.moblies2[index]["label"] ??
                                                "",
                                          )
                                        ],
                                      ),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: Container(
                                          padding: const EdgeInsets.all(4.0),
                                          decoration: BoxDecoration(
                                            color: Colors.green,
                                            borderRadius:
                                                BorderRadius.circular(4.0),
                                          ),
                                          child: Text(
                                            "${widget.moblies2[index]["offer"]} off",
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
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
          ],
        ),
      ),
    );
  }
}
