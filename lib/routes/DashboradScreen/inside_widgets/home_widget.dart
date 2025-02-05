import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:machine_test/routes/DashboradScreen/inside_widgets/categories/laptopcategory.dart';
import 'package:machine_test/routes/DashboradScreen/inside_widgets/categories/mobliecategory.dart';

class HomeWidget extends StatefulWidget {
  final dynamic allData;
  final List<dynamic> bannerList;
  final List<dynamic> categoryList;
  final List<dynamic> categoriesListing;
  final List<dynamic> allProducts;
  final List<dynamic> myBrowsingHistory;
  final List<dynamic> laptopBanner;
  final List<dynamic> featuredLaptop;

  final List<dynamic> upcomingMobiles;

  const HomeWidget({
    super.key,
    required this.allData,
    required this.bannerList,
    required this.categoryList,
    required this.categoriesListing,
    required this.allProducts,
    required this.myBrowsingHistory,
    required this.laptopBanner,
    required this.featuredLaptop,
    required this.upcomingMobiles,
  });

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  @override
  Widget build(BuildContext context) {
    
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          CarouselSlider.builder(
            itemCount: widget.bannerList.length,
            itemBuilder: (BuildContext context, int index, int realIndex) {
              return widget.bannerList.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : Padding(
                      padding: const EdgeInsets.only(
                          top: 12.0, right: 6.0, left: 6.0, bottom: 12.0),
                      child: Image.network(
                        "${widget.bannerList[index]!["banner"]}",
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
          Container(
            padding: const EdgeInsets.all(10.0),
            margin: const EdgeInsets.only(right: 12, left: 12),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              gradient: const LinearGradient(
                colors: <Color>[
                  Color.fromARGB(255, 163, 130, 195),
                  Color.fromARGB(255, 110, 80, 180),
                ],
              ),
            ),
            child: Column(
              children: <Widget>[
                const Text(
                  "KYC Pending",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                  "You need to provide to the requried",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const Text(
                  "documents for your account activation",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {},
                  child: const Text(
                    "Click Here",
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 110,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: widget.categoryList.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: GestureDetector(
                        onTap: () {
                          if (index == 0) {
                            Navigator.of(context).push<dynamic>(
                              MaterialPageRoute<dynamic>(
                                builder: (BuildContext context) =>
                                    MoblieCategory(
                                  upcomingMobiles: widget.upcomingMobiles,
                                  moblies1: widget.categoriesListing,
                                  moblies2: widget.myBrowsingHistory,
                                ),
                              ),
                            );
                          } else if (index == 1) {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => LaptopCategory(
                                  laptopBanner: widget.laptopBanner,
                                  featuredLaptop: widget.featuredLaptop,
                                ),
                              ),
                            );
                          }
                        },
                        child: Column(
                          children: <Widget>[
                            Image.network(widget.categoryList[index]["icon"]),
                            const SizedBox(height: 5),
                            Text(
                              widget.categoryList[index]["label"] ?? "",
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 106, 205, 255),
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
                            "EXCULUSIVE FOR YOU",
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
                      height: 320,
                      child: Row(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              itemCount: widget.categoriesListing.length,
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
                                  child: Stack(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(height: 28),
                                          Center(
                                            child: Image.network(
                                              widget.categoriesListing[index]
                                                  ["icon"],
                                              scale: 0.8,
                                            ),
                                          ),
                                          const Spacer(),
                                          const Text("Rs : ₹"),
                                          Text(
                                            widget.categoriesListing[index]
                                                    ["label"] ??
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
                                            "${widget.categoriesListing[index]["offer"]} off",
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
          ),
          widget.allData == null
              ? const SizedBox()
              : Container(
                  padding: const EdgeInsets.all(10.0),
                  margin: const EdgeInsets.all(12.0),
                  width: double.infinity,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.grey,
                    image: DecorationImage(
                      image: NetworkImage(
                        widget.allData!["banner_two"][0]["banner"],
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
          Container(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 183, 106, 255),
            ),
            // height: 300,
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
                            "ALL PRODUCTS",
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
                      height: 250,
                      child: Row(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              itemCount: widget.allProducts.length,
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
                                  child: Stack(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(height: 28),
                                          Center(
                                            child: Image.network(
                                              widget.allProducts[index]["icon"],
                                              scale: 0.8,
                                            ),
                                          ),
                                          const Spacer(),
                                          const Text("Rs : ₹"),
                                          Text(
                                            widget.allProducts[index]
                                                    ["label"] ??
                                                "",
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          widget.allProducts[index]
                                                      ["Sublabel"] ==
                                                  null
                                              ? const SizedBox()
                                              : Text(
                                                  widget.allProducts[index]
                                                      ["Sublabel"],
                                                ),
                                          widget.allProducts[index]
                                                      ["SubLabel"] ==
                                                  null
                                              ? const SizedBox()
                                              : Text(
                                                  widget.allProducts[index]
                                                      ["SubLabel"],
                                                ),
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
                                            "${widget.allProducts[index]["offer"]} off",
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
          ),
          Container(
            margin: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 43, 82, 101),
                borderRadius: BorderRadius.circular(10.0)),
            // height: 300,
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
                            "MY BROWSING HISTORY",
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
                      height: 320,
                      child: Row(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              itemCount: widget.myBrowsingHistory.length,
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
                                  child: Stack(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(height: 28),
                                          Center(
                                            child: Image.network(
                                              widget.myBrowsingHistory[index]
                                                  ["icon"],
                                              scale: 0.8,
                                            ),
                                          ),
                                          const Spacer(),
                                          const Text("Rs : ₹"),
                                          Text(
                                            widget.myBrowsingHistory[index]
                                                    ["label"] ??
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
                                            "${widget.myBrowsingHistory[index]["offer"]} off",
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Image.network(
                                        widget.myBrowsingHistory[index]
                                            ["brandIcon"],
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
    );
  }
}
