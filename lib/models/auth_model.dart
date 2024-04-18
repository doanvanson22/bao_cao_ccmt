import 'dart:convert';

import 'package:flutter/material.dart';

class AuthModel extends ChangeNotifier{
  bool _isLogin = false;
  // Map<String, dynamic> user = {};// update user details when login
  // Map<String, dynamic> appointment = {};// update upcoming appointment when login
  // List<Map<String, dynamic>> favDoc = [];// get latest favorite doctor
  // List<dynamic> _fav = [];

  bool get isLogin{
    return _isLogin;
  }

  // List<dynamic> get getFav{
  //   return _fav;
  // }

  // Map<String, dynamic> get getUser{
  //   return  user;
  // } 

  // Map<String, dynamic> get getAppointment{
  //   return  appointment;
  // } 

  //this is to update latest favorite list and notfily all widget// đây là để cập nhật danh sách yêu thích mới nhất và thông báo tất cả các widget
  // void setFavList(List<dynamic> list){
  //   _fav = list;
  //   notifyListeners();
  // }

  // // and this to return latest favorite doctor list// và cái này để trả về danh sách bác sĩ yêu thích mới nhất
  // List<Map<String, dynamic>> get getFavDoc{
  //   favDoc.clear();// clear all previous record before get latest list// xóa tất cả bản ghi trước đó trước khi lấy danh sách mới nhất
    
  //   // list out doctor list according to favorite list
  //   // liệt kê danh sách bác sĩ theo danh sách yêu thích
  //   for(var num in _fav){
  //     for (var doc in user['doctor']){
  //       if (num == doc['doc_id']){
  //         favDoc.add(doc);
  //       }
  //     }
  //   }
  //   return favDoc;
  // }
  // //when login success, update the status// khi đăng nhập thành công, cập nhật trạng thái
  // void loginSuccess(
  //   Map<String, dynamic> userData, Map<String, dynamic> appointmentInfo){
  //   _isLogin = true;

  //   //update all these data when login//cập nhật tất cả dữ liệu này khi đăng nhập
  //   user = userData;
  //   appointment = appointmentInfo;

  //   // sorry, i forgot to check if the fav list is return null
  //   // because initially the fav list is Null
  //   if(user['details']['fav'] != null){
  //     _fav = json.decode(user['details']['fav']);// the details are rrturn form user controller// các chi tiết được trả về từ bộ điều khiển người dùng
  //   notifyListeners();
  //   }
    
  // }
  void loginSuccess(){
    _isLogin = true;
    notifyListeners();
  }
}

// and now, we have to change this auth model
// so that we can update the user details and doctor list during login
// and pass down the data to all wiget tree
// và bây giờ, chúng ta phải thay đổi mô hình xác thực này
// để chúng tôi có thể cập nhật chi tiết người dùng và danh sách bác sĩ trong khi đăng nhập
// và truyền dữ liệu tới tất cả cây tóc giả