import 'package:app_hello/components/button.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';//you may use your own lottie file//bạn có thể sử dụng file xổ số của riêng bạn

class AppointmentBooked extends StatelessWidget {
  const AppointmentBooked({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 3,
              //you may donwload your favorite lottile file, and insert here
              child: Lottie.asset('assets/success.json'),
            ),
            const Spacer(),
            //back to home page//quay lại trang chủ
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: Button(
                width: double.infinity,
                title: 'Back to Home Page',
                onPressed: () => Navigator.of(context).pushNamed('main'),
                disable: false,
              ), 
            )
          ],
        ),
      ),
    );
  }
}

//if you cant load lottile asset, just terminate application
//and run again
//as far, i have done Doctor Details page
//and also booking page
// nếu bạn không thể tải tài sản lớn, chỉ cần chấm dứt ứng dụng
// và chạy lại
// cho đến nay tôi đã hoàn thành trang Chi tiết bác sĩ
//và cả trang đặt phòng
// up next, will start to do Laravel setup and configuration
// tiếp theo, sẽ bắt đầu thiết lập và cấu hình Laravel
// let's create new Laravel project via terminal
// hãy tạo dự án Laravel mới thông qua terminal