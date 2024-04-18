import 'package:app_hello/main.dart';
import 'package:app_hello/providers/dio_provider.dart';
import 'package:app_hello/untils/config.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 4,
          child: Container(
            width: double.infinity,
            color: Config.primaryColor,
            child: Column(
              children: const <Widget>[
                SizedBox(
                  height: 110,
                ),
                CircleAvatar(
                  radius: 65.0,
                  backgroundImage: AssetImage('assets/profile1.jpg'),
                  backgroundColor: Colors.white,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'DOAN SON',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  '21 tuoi',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: Container(
            color: Colors.grey[200],
            child: Center(
              child: Card(
                margin: const EdgeInsets.fromLTRB(0, 45, 0, 0),
                child: Container(
                  width: 300,
                  height: 250,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: [
                        const Text('Profile', style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                        ),),
                        Divider(color: Colors.grey[300],),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.person, color: Colors.blueGrey[400], size: 35,),
                            const SizedBox(width: 20,),
                            TextButton(
                              onPressed: () {},
                              child: const Text(
                                "Profile",
                                style: TextStyle(
                                  color: Config.primaryColor,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Config.spaceSmall,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.history, color: Colors.yellowAccent[400], size: 35,),
                            const SizedBox(width: 20,),
                            TextButton(
                              onPressed: () {},
                              child: const Text(
                                "History",
                                style: TextStyle(
                                  color: Config.primaryColor,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Config.spaceSmall,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.logout_outlined, color: Colors.lightGreen[400], size: 35,),
                            const SizedBox(width: 20,),
                            TextButton(
                              onPressed: ()async{
                                final SharedPreferences prefs = 
                                  await SharedPreferences.getInstance();
                                final token = prefs.getString('token') ?? '';

                                if(token.isNotEmpty && token != ''){
                                  //logout here
                                  final response = await DioProvider().logout(token);
                                  if (response == 200){
                                    //if successfully delete access token
                                    //then delete token saved at Shared Preference as well
                                    await prefs.remove('token');
                                    setState(() {
                                      //redirect to login page
                                      MyApp.navigatorKey.currentState!.pushReplacementNamed('/');
                                    });
                                  }
                                }
                              },
                              child: const Text(
                                "Logout",
                                style: TextStyle(
                                  color: Config.primaryColor,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

// i have done both favorite and profile UI
// tôi đã thực hiện cả giao diện người dùng yêu thích và hồ sơ
// now, let's complete favorite page with connecting to database// bây giờ, hãy hoàn thành trang yêu thích bằng cách kết nối với cơ sở dữ liệu
// in order to logout, remember MUST delete the token saved in shared preference// để đăng xuất, hãy nhớ PHẢI xóa mã thông báo đã lưu trong tùy chọn chia sẻ
// and also database// và cả cơ sở dữ liệu
// now the login token id is 124, later we try to log out and delete the access token