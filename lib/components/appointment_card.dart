import 'package:app_hello/main.dart';
import 'package:app_hello/providers/dio_provider.dart';
import 'package:app_hello/untils/config.dart';
import 'package:flutter/material.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
class AppointmentCard extends StatefulWidget{
  const AppointmentCard({Key? key, required this.doctor, required this.color}): super(key: key);

  final Map<String, dynamic> doctor;
  final Color color;

  @override
  State<AppointmentCard> createState() => AppointmentCardState();
}

class AppointmentCardState extends State<AppointmentCard>{
  @override
  Widget build(BuildContext context){
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: widget.color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Material(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              // insert Row here
              // add 1 const
              Row(
                children: [
                  // CircleAvatar(
                  //   backgroundImage: 
                  //   NetworkImage("https://9c44-1-55-202-187.ngrok-free.app${widget.doctor['doctor_profile']}"), // insert doctor frofile
                  // ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Dr ${widget.doctor['doctor_name']}",
                        style:const TextStyle(color: Colors.white),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Text(
                        widget.doctor['category'],
                        style: const TextStyle(color: Colors.black),
                      )
                    ],
                  )
                ],
              ),
              Config.spaceSmall,
              //Schedule info here // thong tin lich trinh tai day    
             ScheduleCard(
              appointment: widget.doctor['appointments'],
             ),   
              Config.spaceSmall,
              //action button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {},
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                      // add rating dialong here
                      // before that, add a new dio provider
                      onPressed: () {
                        showDialog(
                          context: context, 
                          builder: (context){
                            return RatingDialog(
                              initialRating: 1.0,
                              title: const Text(
                                'Rate the Doctor',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              message: const Text(
                                'Please help us to rate our Doctor',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                              image: const FlutterLogo(size: 100,),
                              submitButtonText: 'Submit',
                              commentHint: 'Your Reviews',
                              onSubmitted: (response) async{
                                final SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                                final token =
                                  prefs.getString('token') ?? '';
                                final rating = await DioProvider()
                                  .storeReviews(
                                    response.comment,
                                    response.rating,
                                    widget.doctor['appointments']['id'],// this is appointments id
                                    widget.doctor['doc_id'],
                                    token
                                  );
                                // if successful, then refresh
                                if (rating == 200 && rating != ''){
                                  MyApp.navigatorKey.currentState!
                                    .pushNamed('main');
                                }  
                              });
                            
                          });
                      },
                      child: const Text(
                        'Completed',
                        style: TextStyle(color: Colors.white),
                      ),
                      
                    ),
                  )
                ],
              )     
            ],
          ),
        ),
      ),
    );
  }
}

// Schedule Widget// len lich cho tien ich
class ScheduleCard extends StatelessWidget{
  const ScheduleCard({Key? key, required this.appointment}): super(key: key);

  final Map<String, dynamic> appointment;

  @override
  Widget build(BuildContext context){
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(10),
      ),
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Icon(Icons.calendar_today,
          color: Colors.white,
          size: 15,
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            '${appointment['day']}, ${appointment['date']}',
            style:const TextStyle(color: Colors.white),
          ),
          const SizedBox(width: 20,),
          const Icon(Icons.access_alarm,
          color: Colors.white,
          size: 17
          ),
          const SizedBox(width: 5,),
          Flexible(
            child: Text(
              appointment['time'], 
              style: const TextStyle(color: Colors.white),
              ))
        ],
      ),
    );
  }
}

// Appointment Card is done
// the information here will be replaced by API data after database setup // thông tin ở đây sẽ được thay thế bằng dữ liệu API sau khi thiết lập cơ sở dữ liệu

// as you can see, new rating/review has been added// như bạn có thể thấy, xếp hạng/đánh giá mới đã được thêm vào
// however, the appointment still there// tuy nhiên, cuộc hẹn vẫn còn đó
// maybe some error at controller// có thể có lỗi ở bộ điều khiển

// for appointments card state management, you may use streamBuilder// để quản lý trạng thái thẻ cuộc hẹn, bạn có thể sử dụng streamingBuilder
// so that it can listen status, and chande the state instantly// để nó có thể nghe trạng thái và thay đổi trạng thái ngay lập tức
// up text, will continue add in user profile editing and favorite doctor list// lên văn bản, sẽ tiếp tục thêm vào phần chỉnh sửa hồ sơ người dùng và danh sách bác sĩ yêu thích