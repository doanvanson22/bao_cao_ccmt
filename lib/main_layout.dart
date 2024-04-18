import 'package:app_hello/screens/appointment_page.dart';
import 'package:app_hello/screens/fav_page.dart';
import 'package:app_hello/screens/home_page.dart';
import 'package:app_hello/screens/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainLayout extends StatefulWidget{
  const MainLayout({Key? key}): super(key: key);

  @override
  State<MainLayout> createState() => MainLayoutState();
}

class MainLayoutState extends State<MainLayout>{
  // variable declaration
  int currentPage =0;
  final PageController _page = PageController();
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: PageView(
        controller: _page,
        onPageChanged: ((value){
          setState(() {
            // update page index when tab pressed/switch page
            currentPage = value;
          });
        }),
        children: <Widget>[
          const HomePage(),
          FavPage(),
          const AppointmentPage(),
          ProfilePage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentPage,
        onTap: (page){
          setState(() {
            currentPage = page;
            _page.animateToPage(
              page,
              duration: const Duration(microseconds: 500), 
              curve: Curves.easeInOut,
              );
          });
        },
        items: const <BottomNavigationBarItem> [
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.houseChimneyCrack),
            label: 'Home'
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.solidHeart),
            label: 'Favorite'
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.solidCalendarCheck),
            label: 'Appointments'
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.solidUser),
            label: 'Profile'
          ),
        ],
      ),
    );
  }
}

// let's build home page and appointment page
// as you can see, page view has done
// and there are two main pages show
// let's coplete the home page

// add favorite doctor and profile page here
// thêm trang hồ sơ và bác sĩ yêu thích tại đây