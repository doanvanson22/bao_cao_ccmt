import 'dart:convert';
//import 'dart:html';

import 'package:app_hello/components/appointment_card.dart';
import 'package:app_hello/components/doctor_card.dart';
import 'package:app_hello/models/auth_model.dart';
import 'package:app_hello/providers/dio_provider.dart';
import 'package:app_hello/untils/config.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget{
  const HomePage({Key? key}): super(key: key);

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage>{
  Map<String, dynamic> user = {};
  Map<String, dynamic> doctor = {};
  //List<dynamic> favList = [];
  List<Map<String, dynamic>> medCat = [
    {
      "icon":FontAwesomeIcons.userDoctor,
      "category":"Tổng quát",
    },
    {
      "icon":FontAwesomeIcons.heartPulse,
      "category":"Khoa tim",
    },
    {
      "icon":FontAwesomeIcons.lungs,
      "category":"Hô hấp",
    },
    {
      "icon":FontAwesomeIcons.hand,
      "category":"Da liễu",
    },
    {
      "icon":FontAwesomeIcons.personPregnant,
      "category":"Phụ khoa",
    },
    {
      "icon":FontAwesomeIcons.teeth,
      "category":"Nha khoa",
    },
  ];

  Future<void> getData() async{
    //get token from share preferences// nhận mã thông báo từ tùy chọn chia sẻ
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';

    if (token.isNotEmpty && token != ''){
      //get user data
      final response = await DioProvider().getUser(token);
      if(response != null){
        setState(() {
          //json decode// giải mã json
          user = json.decode(response);

          for(var doctorData in user['doctor']){
            if(doctorData['appointments'] != null){
              doctor = doctorData;
            }
          }
        });
      }
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    Config().init(context);
    // user = Provider.of<AuthModel>(context, listen: false).getUser;
    // doctor = Provider.of<AuthModel>(context, listen: false).getAppointment;
    // favList = Provider.of<AuthModel>(context, listen: false).getFav;

    // print('user data is: $user');
    // print('favorite liste is: $favList');

    // now, let check out the data
    return Scaffold(
      //if user is empty, then return progress indication// nếu người dùng trống thì trả về chỉ báo tiến trình
      body: user.isEmpty
      ? const Center(
        child: CircularProgressIndicator(),
      ) 
      : Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 15,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:  <Widget>[
                    Text(
                      user ['name'],
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      child: CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage('assets/profile1.jpg'), // insert image here
                      ),
                    )
                  ],
                ),
                Config.spaceMedium,
                //category listing//danh sach danh muc
                const Text(
                      'category', 
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Config.spaceSmall,
                    //build category list//xay dung danh sach danh muc
                    SizedBox(
                      height: Config.heightSize *0.05,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: List<Widget>.generate(medCat.length, (index){
                          return Card(
                            margin: const EdgeInsets.only(right: 20),
                            color: Config.primaryColor,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  FaIcon(
                                    medCat[index]['icon'],
                                    color:Colors.white,
                                  ),
                                  const SizedBox(width: 20,),
                                  Text(
                                  medCat[index]['category'],
                                  style:const TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                                ],
                              ), 
                            ), 
                          );
                        }),
                      ),
                    ),
                    Config.spaceSmall,
                    const Text(
                      'Lịch hẹn ngay hôm nay', 
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Config.spaceSmall,
                    // display appoinment card here // hien thi the hen o day
                    // let's create appoinment card widget // hay tao the tien ich cuoc hen
                    doctor.isNotEmpty
                      ? AppointmentCard(
                        doctor: doctor,
                        color: Config.primaryColor,
                      )
                      : Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Center(
                          child: Padding(
                            padding: EdgeInsets.all(20),
                            child: Text(
                              'Không có lịch hẹn ngay hôm nay',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    Config.spaceSmall,
                    const Text(
                      'Bác sĩ hàng đầu', 
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // list of top doctors
                    // let's build doctor card
                    Config.spaceSmall,
                    Column(
                      children: List.generate(user['doctor'].length, (index){
                        return DoctorCard(
                          route: 'doc_details',
                          doctor: user['doctor'][index],
                        );
                      }),
                    )
              ],
            ),
          ),
        ),
      )
    );
  }
}


//now as debug console shown, the user's data is returned//bây giờ khi bảng điều khiển gỡ lỗi hiển thị, dữ liệu của người dùng được trả về
//as well as doctor details// cũng như thông tin chi tiết về bác sĩ
//you may insert some doctor data, before you reach this step//bạn có thể chèn một số dữ liệu bác sĩ trước khi đến bước này

// and, as you can see, there is an error while waiting user data returned
// và như bạn thấy, đã xảy ra lỗi trong khi chờ dữ liệu người dùng được trả về

//that is because the 'user' is Null, while waiting respone form database
//aand yoy may set a circular progress indicator while waiting respone
// đó là vì 'người dùng' là Null, trong khi chờ cơ sở dữ liệu biểu mẫu phản hồi
//và bạn có thể đặt chỉ báo tiến trình vòng tròn trong khi chờ phản hồi

// and now let's list oit all doctor on home page
// và bây giờ hãy liệt kê tất cả các bác sĩ trên trang chủ

// today, working on the doctor dashboard// hôm nay, làm việc trên bảng thông tin bác sĩ
//displaying the total uncomping appointment, total patients and rating/reviews//hiển thị tổng số cuộc hẹn chưa được tính, tổng số bệnh nhân và xếp hạng/đánh giá