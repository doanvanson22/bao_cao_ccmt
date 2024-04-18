import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

// this basically is to convert date/day/time from calendar to string// về cơ bản việc này là chuyển đổi ngày/ngày/giờ từ lịch sang chuỗi
class DateConverted {
  static String getDate(DateTime date) {
    initializeDateFormatting("vi_VN", null);
    return DateFormat.yMd("vi_VN").format(date);
  }

  static String getDay(int day){
    switch(day){
      case 1:
        return 'Thứ 2';
      case 2:
        return 'Thứ 3';
      case 3:
        return 'Thứ 4';
      case 4:
        return 'Thứ 5';
      case 5:
        return 'Thứ 6';
      case 6:
        return 'Thứ 7';
      case 7:
        return 'Chủ nhật';
      default:
        return 'Chủ nhật';           
    }
  }

  static String getTime(int time){
    switch(time){
      case 1:
        return '9:00 AM';
      case 2:
        return '10:00 AM';
      case 3:
        return '11:00 AM';
      case 4:
        return '12:00 AM';
      case 5:
        return '13:00 PM';
      case 6:
        return '14:00 PM';
      case 7:
        return '15:00 PM';
      default:
        return '9:00 AM';
    }
  }
}