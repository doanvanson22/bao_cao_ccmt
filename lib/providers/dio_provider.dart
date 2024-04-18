// in order to connect to database// để kết nối với cơ sở dữ liệu
// we have to create dio provider first// trước tiên chúng ta phải tạo nhà cung cấp dio
// to post/get data from laravel database// để đăng/lấy dữ liệu từ cơ sở dữ liệu laravel
// and API Token needed for getting data// và API Token cần thiết để lấy dữ liệu
// and thus, JWT used in this video// và do đó, JWT được sử dụng trong video này

// now, let's build dio provider and get token from database// bây giờ, hãy xây dựng nhà cung cấp dio và nhận mã thông báo từ cơ sở dữ liệu

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer';

// https://a4fb-1-55-202-123.ngrok-free.app
class DioProvider{
  //get token
  Future<dynamic> getToken(String email, String password) async{
    try{
    var response = await Dio().post('https://a4fb-1-55-202-123.ngrok-free.app/api/login',
      data: {'email':email, 'password': password});

      // if request successfully, then return token// nếu yêu cầu thành công thì trả về token
      if (response.statusCode == 200 && response.data != ''){
        //store returned token into share preferences// lưu trữ mã thông báo được trả về vào tùy chọn chia sẻ
        //for get other data later// để lấy dữ liệu khác sau
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', response.data);
        return true;
      }else {
        return false;
      }
    }catch(error){
      return error;
    }
  }
  
  // the url "https://a4fb-1-55-202-123.ngrok-free.app" is local database// url "https://a4fb-1-55-202-123.ngrok-free.app" là cơ sở dữ liệu cục bộ
  // and "api/login" is the end point that will be set later in Laravel// và "api/login" là điểm cuối sẽ được đặt sau trong Laravel

  // get user data// lấy dữ liệu người dùng
  Future<dynamic> getUser(String token) async {
    try{
      var user = await Dio().get('https://a4fb-1-55-202-123.ngrok-free.app/api/user', options: Options(headers: {'Authorization' : 'Bearer $token'}));

    // if request successfully, then erturn user data // nếu yêu cầu thành công thì trả lại dữ liệu người dùng   
    if (user.statusCode == 200 && user.data != ''){
      log(json.encode(user.data)+ 'Sơn');
        return json.encode(user.data);
      }
    }catch(error){
      return error;
    }
  }


  
  // register new user
  Future<dynamic> registerUser(String username, String email, String password) async {
    try{
      var user = await Dio().post('https://a4fb-1-55-202-123.ngrok-free.app/api/register', 
      data: {'name': username, 'email':email, 'password': password});
    // if register successfully, return true   
    if (user.statusCode == 201 && user.data != ''){
        return true;
      }else{
        return false;
      }
    }catch(error){
      return error;
    }
  }

  //store booking details
  Future<dynamic> bookAppointment(
      String date, String day, String time, int doctor , String token) async {
    try{
      var respone = await Dio().post('https://a4fb-1-55-202-123.ngrok-free.app/api/book', 
      data: {'date': date, 'day':day, 'time': time, 'doctor_id': doctor},
      options: Options(headers: {'Authorization' : 'Bearer $token'}));
 
    if (respone.statusCode == 200 && respone.data != ''){  // should not be empty
        return respone.statusCode;
      }else{
        return 'Error';
      }
    }catch(error){
      return error;
    }
  }

  //retrieve booking details
  Future<dynamic> getAppointments(String token) async {
    try{
      var respone = await Dio().get('https://a4fb-1-55-202-123.ngrok-free.app/api/appointments', 
      options: Options(headers: {'Authorization' : 'Bearer $token'}));
 
    if (respone.statusCode == 200 && respone.data != ''){
        return json.encode(respone.data);
      }else{
        return 'Error';
      }
    }catch(error){
      return error;
    }
  }

  //store rating details
  Future<dynamic> storeReviews(
      String reviews, double ratings, int id, int doctor , String token) async {
    try{
      var respone = await Dio().post('https://a4fb-1-55-202-123.ngrok-free.app/api/reviews', 
      data: {'ratings': ratings, 'reviews':reviews, 'appointment_id': id, 'doctor_id': doctor},
      options: Options(headers: {'Authorization' : 'Bearer $token'}));
 
    if (respone.statusCode == 200 && respone.data != ''){  // should not be empty
        return respone.statusCode;
      }else{
        return 'Error';
      }
    }catch(error){
      return error;
    }
  }

  //store fav doctor
  // update the fav list into database// cập nhật danh sách yêu thích vào cơ sở dữ liệu
  Future<dynamic> storeFavDoc(
      String reviews, double ratings, int id, int doctor , String token) async {
    try{
      var respone = await Dio().post('https://a4fb-1-55-202-123.ngrok-free.app/api/reviews', 
      data: {'ratings': ratings, 'reviews':reviews, 'appointment_id': id, 'doctor_id': doctor},
      options: Options(headers: {'Authorization' : 'Bearer $token'}));
 
    if (respone.statusCode == 200 && respone.data != ''){  // should not be empty
        return respone.statusCode;
      }else{
        return 'Error';
      }
    }catch(error){
      return error;
    }
  }
  
  //logout
  Future<dynamic> logout(String token) async {
    try{
      var respone = await Dio().post('https://a4fb-1-55-202-123.ngrok-free.app/api/logout', 
      options: Options(headers: {'Authorization' : 'Bearer $token'}));
 
    if (respone.statusCode == 200 && respone.data != ''){  
        return respone.statusCode;
      }else{
        return 'Error';
      }
    }catch(error){
      return error;
    }
  }
}



// class DioProvider {
//   final Dio _dio = Dio();

//   Future<String?> getToken(String email, String password) async {
//     try {
//       final response = await _dio.post('https://a4fb-1-55-202-123.ngrok-free.app/api/login',
//           data: {'email': email, 'password': password});

//       if (response.statusCode == 200) {
//         if (response.data != null) {
//           return response.data.toString();
//         } else {
//           throw Exception('Không có dữ liệu trả về từ máy chủ.');
//         }
//       } else {
//         throw Exception('Yêu cầu không thành công. Mã lỗi: ${response.statusCode}');
//       }
//     } catch (error) {
//       throw error;
//     }
//   }

//   Future<String?> getUser(String token) async {
//     try {
//       final response = await _dio.get('https://a4fb-1-55-202-123.ngrok-free.app/api/user',
//           options: Options(headers: {'Authorization': 'Bearer $token'}));

//       if (response.statusCode == 200) {
//         if (response.data != null) {
//           return json.encode(response.data);
//         } else {
//           throw Exception('Không có dữ liệu trả về từ máy chủ.');
//         }
//       } else {
//         throw Exception('Yêu cầu không thành công. Mã lỗi: ${response.statusCode}');
//       }
//     } catch (error) {
//       throw error;
//     }
//   }
// }

// as you can see at termial, a generated token is well received// như bạn có thể thấy tại terminal, mã thông báo được tạo sẽ được đón nhận nồng nhiệt
// now, use this token to get user data// bây giờ, hãy sử dụng mã thông báo này để lấy dữ liệu người dùng
// first, let me show the result without token// trước tiên, hãy để tôi hiển thị kết quả mà không cần mã thông báo

// as you can see, the user data has been fetched from database// như bạn có thể thấy, dữ liệu người dùng đã được lấy từ cơ sở dữ liệu
// add inserted into app// thêm vào ứng dụng
// now let's create register page// bây giờ hãy tạo trang đăng ký
