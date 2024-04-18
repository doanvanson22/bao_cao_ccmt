import 'package:app_hello/untils/config.dart';
import 'package:flutter/material.dart';

// change this to stateless
class DoctorCard extends StatelessWidget{
  const DoctorCard({Key? key, required this.route, required this.doctor}): super(key: key);
  
   // recevice doctor details// nhận thông tin chi tiết về bác sĩ
  final String route;
  final Map<String, dynamic> doctor;
  
  @override
  Widget build(BuildContext context){
    Config().init(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      height: 150,
      child: GestureDetector(
        child: Card(
        elevation: 5,
        color: Colors.white,
        child: Row(
          children: [
            SizedBox(
              width: Config.widthSize *0.33,
              child: Image.network(
                "https://a4fb-1-55-202-123.ngrok-free.app${doctor['doctor_profile']}",
                fit: BoxFit.fill,
              ),
            ),
            Flexible(
              child: Padding(
              padding: 
                const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget> [
                  Text(
                    "Dr ${doctor['doctor_name']}",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "${doctor['category']}",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const <Widget> [
                        Icon(Icons.star_border, color: Colors.yellow, size: 16,),
                        Spacer(flex: 1,),
                        Text('4,5'),
                        Spacer(flex: 1,),
                        Text('Reviews'),
                        Spacer(flex: 1,),
                        Text('(20)'),
                        Spacer(flex: 7,),
                      ],
                    )
                ],
              ),
            ))
          ],
        ),
      ),
      onTap: () {
        // redirect to doctor datails page//chuyển hướng đến trang dữ liệu bác sĩ
        //redirect to doctor details//chuyển hướng đến chi tiết bác sĩ
        //pass the details to details pade//chuyển chi tiết tới trang chi tiết
        Navigator.of(context).pushNamed(route, arguments: doctor);
      }, 
      )
      
    );
  }
}