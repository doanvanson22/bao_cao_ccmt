import 'package:app_hello/main_layout.dart';
import 'package:app_hello/models/auth_model.dart';
import 'package:app_hello/screens/auth_page.dart';
import 'package:app_hello/screens/booking_page.dart';
import 'package:app_hello/screens/doctor_details.dart';
import 'package:app_hello/screens/success_booked.dart';
import 'package:app_hello/untils/config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final navigatorKey = GlobalKey<NavigatorState>();

  // This widget is the root of your application.// Widget này là thư mục gốc của ứng dụng của bạn.
  @override
  Widget build(BuildContext context) {
    // define ThemeData here
    return ChangeNotifierProvider<AuthModel>(
      create: (context) => AuthModel(),
      child: MaterialApp(
        navigatorKey: navigatorKey,
        title: 'Flutter Doctor App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          //pre-define input decoration
          inputDecorationTheme: const InputDecorationTheme(
            focusColor: Config.primaryColor ,
            border: Config.outlinedBorder,
            focusedBorder: Config.focusBorder,
            errorBorder: Config.errorBorder,
            enabledBorder: Config.outlinedBorder,
            floatingLabelStyle: TextStyle(color: Config.primaryColor),
            prefixIconColor: Colors.black38,
          ),
          scaffoldBackgroundColor: Colors.white,
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: Config.primaryColor,
            selectedItemColor: Colors.white,
            showSelectedLabels: true,
            showUnselectedLabels: false,
            unselectedItemColor: Colors.grey.shade700,
            elevation: 10,
            type: BottomNavigationBarType.fixed,
          ),
    
    
          // This is the theme of your application.
          //
          // TRY THIS: Try running your application with "flutter run". You'll see
          // the application has a blue toolbar. Then, without quitting the app,
          // try changing the seedColor in the colorScheme below to Colors.green
          // and then invoke "hot reload" (save your changes or press the "hot
          // reload" button in a Flutter-supported IDE, or press "r" if you used
          // the command line to start the app).
          //
          // Notice that the counter didn't reset back to zero; the application
          // state is not lost during the reload. To reset the state, use hot
          // restart instead.
          //
          // This works for code too, not just values: Most code changes can be
          // tested with just a hot reload.
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: '/',
        routes: {
          //this is initial route of the app// đây là lộ trình ban đầu của ứng dụng
          //which is auth page (login and sign up)// đó là trang xác thực (đăng nhập và đăng ký)
          '/':(context) => const AuthPage(),
          //this is for main layout after login// đây là bố cục chính sau khi đăng nhập
          'main':(context) => const MainLayout(),
          'doc_details': (context) => const DoctorDetails(),
          'booking_page': (context) =>  BookingPage(),
          'success_booking' : (context) => const AppointmentBooked(),
        },
      ),
    );
  }
}


// now lets build login componet
// and page view
