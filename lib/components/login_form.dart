import 'dart:convert';

import 'package:app_hello/components/button.dart';
import 'package:app_hello/main.dart';
import 'package:app_hello/models/auth_model.dart';
import 'package:app_hello/providers/dio_provider.dart';
import 'package:app_hello/untils/config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginForm extends StatefulWidget{
  const LoginForm({Key? key}): super(key: key);

  @override
  State<LoginForm> createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm>{
  final _formKey = GlobalKey<FormState>();
  final _emailContronller = TextEditingController();
  final _passContronller = TextEditingController();
  bool obscurePass  = true;
  @override
  Widget build(BuildContext context){
    return  Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            controller: _emailContronller,
            keyboardType: TextInputType.emailAddress,
            cursorColor: Config.primaryColor,
            decoration: const InputDecoration(
              hintText: 'Email Address',
              labelText: 'Email',
              alignLabelWithHint: true,
              prefixIcon: Icon(Icons.email_outlined),
              prefixIconColor: Config.primaryColor,
            ),
          ),
          
          TextFormField(
            controller: _passContronller,
            keyboardType: TextInputType.visiblePassword,
            cursorColor: Config.primaryColor,
            obscureText: obscurePass,
            decoration: InputDecoration(
              hintText: 'Password',
              labelText: 'Password',
              alignLabelWithHint: true,
              prefixIcon: const Icon(Icons.lock_outline),
              prefixIconColor: Config.primaryColor,
              suffixIcon: IconButton(
                onPressed: () {
                  obscurePass  = !obscurePass ;
                }, 
                icon: obscurePass 
                    ?const Icon(
                       Icons.visibility_off_outlined,
                       color: Colors.black38,
                    )
                    :const Icon(
                       Icons.visibility_off_outlined,
                       color: Config.primaryColor,
                    ),
                ),
            ),
          ),
          Config.spaceSmall,
          //login button
          // wrap this button with Consumer
          Consumer<AuthModel>(
            builder: (context, auth, child) {
              return Button(
              width: double.infinity, 
              title: "Sign In", 
              onPressed: () async{
                //let's try sign in manually // hãy thử đăng nhập thủ công
                // login here
                final token = await DioProvider().
                  getToken(_emailContronller.text, _passContronller.text);
          
                if(token){
                  auth.loginSuccess();// update login status
                  //rediret to main page

                  //grap user data here// lấy dữ liệu người dùng tại đây
                  // final SharedPreferences prefs = await SharedPreferences.getInstance();
                  // final tokenValue = prefs.getString('token') ?? '';

                  // if (tokenValue.isNotEmpty && tokenValue != ''){
                  //   //get user data
                  //   final response = await DioProvider().getUser(tokenValue);
                  //   if(response != null){
                  //     setState(() {
                  //       //json decode// giải mã json
                  //       Map<String, dynamic> appointment = {};
                  //       final user = json.decode(response);

                  //       for(var doctorData in user['doctor']){
                  //         if(doctorData['appointments'] != null){
                  //           appointment = doctorData;
                  //         }
                  //       }

                  //       auth.loginSuccess(user, appointment);
                  //       MyApp.navigatorKey.currentState!.pushNamed('main');
                  //       // after grab all user data, and update to auth model// sau khi lấy tất cả dữ liệu người dùng và cập nhật lên mô hình xác thực
                  //       // then we have to get user data from auth model// sau đó chúng ta phải lấy dữ liệu người dùng từ mô hình xác thực
                  //       // to all widget tree// tới tất cả cây widget
                  //     });
                  //   }
                  // }
                MyApp.navigatorKey.currentState!.pushNamed('main');  
                }
                // Navigator.of(context).pushNamed('main');
              }, 
              disable: false);
            },
          )
        ]
      ),
    );
  }
}

// now let's change something in Laravel
// bây giờ hãy thay đổi một cái gì đó trong Laravel

//Bingo user data has been successfully return//Dữ liệu người dùng Bingo đã được trả về thành công
//now, let complete the login process//bây giờ hãy hoàn tất quá trình đăng nhập
//let's create auth model and use provider to update the state// hãy tạo mô hình xác thực và sử dụng nhà cung cấp để cập nhật trạng thái