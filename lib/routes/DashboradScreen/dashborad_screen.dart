import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:machine_test/routes/DashboradScreen/inside_widgets/cart_widget.dart';
import 'package:machine_test/routes/DashboradScreen/inside_widgets/categories_widget.dart';
import 'package:machine_test/routes/DashboradScreen/inside_widgets/deals_widget.dart';
import 'package:machine_test/routes/DashboradScreen/inside_widgets/home_widget.dart';
import 'package:machine_test/routes/DashboradScreen/inside_widgets/profile_widget.dart';
import 'package:machine_test/utils/api_adress/api_adress.dart';

class DashboradScreen extends StatefulWidget {
  const DashboradScreen({super.key});

  @override
  State<DashboradScreen> createState() => _DashboradScreenState();
}

class _DashboradScreenState extends State<DashboradScreen> {
  dynamic allData;
  List<dynamic> bannerList = [];
  List<dynamic> categoryList = [];
  List<dynamic> categoriesListing = [];
  List<dynamic> allProducts = [];
  List<dynamic> myBrowsingHistory = [];
  List<dynamic> laptopBanner = [];
  List<dynamic> featuredLaptop = [];
  List<dynamic> upcomingMobiles = [];

  int pageIndex = 0;
  PageController pageController = PageController();

  void onChanged(var index) {
    setState(() {
      pageIndex = index;
    });
  }

  void onPageChange(var i) {
    pageController.jumpToPage(i);
    setState(() {});
  }

  Future<void> getFecthProduct() async {
    String url = "$baseURL$fecthProductEndPoint";
    Uri uri = Uri.parse(url);
    var response = await http.get(uri);
    var decode = jsonDecode(response.body);
    if (response.statusCode == 200) {
      allData = decode["data"];
      bannerList = decode["data"]["banner_one"];
      categoryList = decode["data"]["category"];
      categoriesListing = decode["data"]['categories_listing'];
      allProducts = decode["data"]["products"];
      myBrowsingHistory = decode["data"]["my_browsing_history"];
      laptopBanner = decode["data"]["banner_three"];
      featuredLaptop = decode["data"]["featured_laptop"];

      upcomingMobiles = decode["data"]["upcoming_laptops"];

      setState(() {});
    }
  }

  @override
  void initState() {
    getFecthProduct();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        elevation: 3,
        shadowColor: Colors.black,
        leading: Builder(
          builder: (context) {
            return GestureDetector(
              onTap: () =>
                  Scaffold.of(context).openDrawer(), // Opens the drawer
              child: const Icon(
                CupertinoIcons.line_horizontal_3,
                size: 30,
              ),
            );
          },
        ),
        title: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: const Color.fromARGB(255, 216, 216, 216),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    "assets/images/icon.png",
                    scale: 16,
                  ),
                ),
              ),
              const Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Serach here",
                    suffixIcon: Icon(Icons.search_rounded),
                  ),
                ),
              ),
            ],
          ),
        ),
        titleSpacing: 5,
        actions: [
          SizedBox(width: MediaQuery.sizeOf(context).width * 0.02),
          const Icon(
            Icons.notifications_none,
            size: 30,
          ),
          SizedBox(width: MediaQuery.sizeOf(context).width * 0.038),
        ],
      ),
      drawer: const Drawer(),
      body: PageView(
        controller: pageController,
        onPageChanged: onChanged,
        children: <Widget>[
          HomeWidget(
            allData: allData,
            bannerList: bannerList,
            categoryList: categoryList,
            categoriesListing: categoriesListing,
            allProducts: allProducts,
            myBrowsingHistory: myBrowsingHistory,
            laptopBanner: laptopBanner,
            featuredLaptop: featuredLaptop,
            upcomingMobiles: upcomingMobiles,
          ),
          const CategoriesWidget(),
          const DealsWidget(),
          const CartWidget(),
          const ProfileWidget(),
        ],
      ),
      floatingActionButton: pageIndex == 0
          ? FloatingActionButton.extended(
              onPressed: () {},
              shape: const StadiumBorder(),
              backgroundColor: Colors.red,
              label: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    CupertinoIcons.chat_bubble_text,
                    size: 20,
                    color: Colors.white,
                  ),
                  SizedBox(width: 5),
                  Text(
                    "Chat",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            )
          : const SizedBox(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: pageIndex,
        onTap: (value) {
          onPageChange(value);
          setState(() {});
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.red,
        showSelectedLabels: true,
        unselectedItemColor: Colors.grey,
        selectedFontSize: 12,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.dashboard_customize_rounded),
              label: "Categories"),
          BottomNavigationBarItem(
              icon: Icon(Icons.local_offer), label: "Deals"),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_outlined), label: "Cart"),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_outlined), label: "Profile"),
        ],
      ),
    );
  }
}
