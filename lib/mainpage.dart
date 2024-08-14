import 'dart:convert';
import 'package:app_api/app/model/user.dart';
import 'package:app_api/app/page/cart/cart_screen.dart';
import 'package:app_api/app/page/category/category_list.dart';
import 'package:app_api/app/page/detail.dart';
import 'package:app_api/app/page/history/history_screen.dart';
import 'package:app_api/app/page/home/home_screen.dart';
import 'package:app_api/app/page/product/product_list.dart';
import 'package:app_api/app/route/page3.dart';
import 'package:flutter/material.dart';
import 'app/page/defaultwidget.dart';
import 'app/data/sharepre.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Mainpage extends StatefulWidget {
  const Mainpage({super.key});

  @override
  State<Mainpage> createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  User user = User.userEmpty();
  int _selectedIndex = 0;

  getDataUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String strUser = pref.getString('user')!;

    user = User.fromJson(jsonDecode(strUser));
    setState(() { });
  }

  @override
  void initState() {
    super.initState();
    getDataUser();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  _loadWidget(int index) {
    var nameWidgets = "Home";
    switch (index) {
      case 0:
       {
        return HomeBuilder();
       }
      case 1:
        {
          return HistoryScreen();
        }
      case 2:
        {
          return CartScreen();
        }
      case 3:
        {
          return const Detail();
        }
      default:
        nameWidgets = "None";
        break;
    }
    return DefaultWidget(title: nameWidgets);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("HL Mobile",style: TextStyle(color:Colors.blue, fontWeight: FontWeight.bold),),
      ),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 243, 152, 33),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // user.imageURL!.length < 5
                  //     ? const SizedBox()
                  //     : const CircleAvatar(
                  //         radius: 40, 
                  //         backgroundImage: NetworkImage('https://scontent-hkg1-1.xx.fbcdn.net/v/t39.30808-6/331014206_930540588307330_1234298021932295004_n.jpg?_nc_cat=109&ccb=1-7&_nc_sid=5f2048&_nc_ohc=tguHcEGYKxAQ7kNvgF5-7MS&_nc_ht=scontent-hkg'
                  //     ),
                  //   ),       // backgroundImage: AssetImage('assets/images/avt.jpeg'),                          ),
                  // const SizedBox(
                  //   height: 8,
                  // ),
                   Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      border: Border.all(width: 4, color: Colors.white),
                      boxShadow: [
                        BoxShadow(
                            spreadRadius: 2,
                            blurRadius: 10,
                            color: Colors.black.withOpacity(0.1))
                      ],
                      shape: BoxShape.circle,
                      image: const DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            'https://scontent.fsgn8-3.fna.fbcdn.net/v/t39.30808-6/331014206_930540588307330_1234298021932295004_n.jpg?_nc_cat=109&ccb=1-7&_nc_sid=5f2048&_nc_ohc=PvZJB_wDbFUQ7kNvgEPHCO3&_nc_ht=scontent.fsgn8-3.fna&oh=00_AfCUcONMyEvEPKx_4EL_HgNH4LHm-i9hM5dtiHyLBHT7mw&oe=66380E3F'),
                      ),
                    ),
                  ),
                   const SizedBox(
                    height: 8,
                  ),
                  Text(user.fullName!),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
                _selectedIndex = 0;
                setState(() {});
              },
            ),
            ListTile(
              leading: const Icon(Icons.contact_mail),
              title: const Text('History'),
              onTap: () {
                Navigator.pop(context);
                _selectedIndex = 1;
                setState(() {});
              },
            ),
            ListTile(
              leading: const Icon(Icons.contact_mail),
              title: const Text('Cart'),
              onTap: () {
                Navigator.pop(context);
                _selectedIndex = 2;
                setState(() {});
              },
            ),
            ListTile(
              leading: const Icon(Icons.pages),
              title: const Text('Category'),
              onTap: () {
                Navigator.pop(context);
                _selectedIndex = 0;
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const CategoryList()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.pages),
              title: const Text('Product'),
              onTap: () {
                Navigator.pop(context);
                _selectedIndex = 0;
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const ProductList()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.pages),
              title: const Text('Page3'),
              onTap: () {
                Navigator.pop(context);
                _selectedIndex = 0;
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Page3()));
              },
            ),
            const Divider(
              color: Colors.black,
            ),
            user.accountId == ''
                ? const SizedBox()
                : ListTile(
                    leading: const Icon(Icons.exit_to_app),
                    title: const Text('Logout'),
                    onTap: () {
                      logOut(context);
                    },
                  ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shop),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'User',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
      body: _loadWidget(_selectedIndex),
    );
  }
}
