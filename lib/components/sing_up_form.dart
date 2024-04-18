import 'package:app_hello/components/button.dart';
import 'package:app_hello/main.dart';
import 'package:app_hello/models/auth_model.dart';
import 'package:app_hello/providers/dio_provider.dart';
import 'package:app_hello/untils/config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SingUpForm extends StatefulWidget {
  const SingUpForm({super.key});

  @override
  State<SingUpForm> createState() => _SingUpFormState();
}

class _SingUpFormState extends State<SingUpForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameContronller = TextEditingController();
  final _emailContronller = TextEditingController();
  final _passContronller = TextEditingController();
  bool obsecurePass = true;
  @override
  Widget build(BuildContext context) {
    return  Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            controller: _nameContronller,
            keyboardType: TextInputType.text,
            cursorColor: Config.primaryColor,
            decoration: const InputDecoration(
              hintText: 'UserName',
              labelText: 'UserName',
              alignLabelWithHint: true,
              prefixIcon: Icon(Icons.person_outlined),
              prefixIconColor: Config.primaryColor,
            ),
          ),
          SizedBox(height: 2),
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
          SizedBox(height: 2),
          TextFormField(
            controller: _passContronller,
            keyboardType: TextInputType.visiblePassword,
            cursorColor: Config.primaryColor,
            obscureText: obsecurePass,
            decoration: InputDecoration(
              hintText: 'Password',
              labelText: 'Password',
              alignLabelWithHint: true,
              prefixIcon: const Icon(Icons.lock_outline),
              prefixIconColor: Config.primaryColor,
              suffixIcon: IconButton(
                onPressed: () {
                  obsecurePass = !obsecurePass;
                }, 
                icon: obsecurePass
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
          SizedBox(height: 2),
          //login button
          // wrap this button with Consumer
          Consumer<AuthModel>(
            builder: (context, auth, child) {
              return Button(
              width: double.infinity, 
              title: "Sign Up", 
              onPressed: () async{
                //let's try sign in manually // hãy thử đăng nhập thủ công
                // login here
                final userRegistrantion = await DioProvider().registerUser(
                  _nameContronller.text,
                  _emailContronller.text,
                  _passContronller.text);

                // if register success, proceed to login// nếu đăng ký thành công, tiến hành đăng nhập
                if(userRegistrantion){
                  final token = await DioProvider().getToken(_emailContronller.text, _passContronller.text);
          
                  if(token){
                    // ignore sign up first
                    auth.loginSuccess();// update login status
                    //rediret to main page
                    MyApp.navigatorKey.currentState!.pushNamed('main');
                  }
                }else {
                  print('register not successful');
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

//Bingo, as you can see, the new user has been registered succesfully//Bingo, như bạn thấy, người dùng mới đã được đăng ký thành công

//up next, will continue about insert doctor details and booking process in to database//tiếp theo, sẽ tiếp tục chèn thông tin chi tiết về bác sĩ và quy trình đăng ký vào cơ sở dữ liệu
// as well getting all info from database// đồng thời lấy tất cả thông tin từ database

// now, let's get all doctor details and display on Mobile screen
// bây giờ, hãy lấy tất cả thông tin chi tiết về bác sĩ và hiển thị trên màn hình Di động