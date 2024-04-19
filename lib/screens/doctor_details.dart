import 'package:app_hello/components/button.dart';
import 'package:app_hello/untils/config.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../components/custom_appbar.dart';

class DoctorDetails extends StatefulWidget{
  const DoctorDetails({Key? key, }): super(key: key);


  @override
  State<DoctorDetails> createState() => _DoctorDetailsState();
}

class _DoctorDetailsState extends State<DoctorDetails>{
  bool isFav = false;
  @override
  Widget build(BuildContext context){
    // get arguments passed from doctor card// lấy đối số được truyền từ thẻ bác sĩ
    final doctor = ModalRoute.of(context)!.settings.arguments as Map;
    return Scaffold(//create a custom app bar widget// tạo tiện ích thanh ứng dụng tùy chỉnh
       appBar: CustomAppBar(
        appTitle: 'Chi tiết bác sĩ',
        icon: const FaIcon(Icons.arrow_back_ios,),
        actions: [
          //Favarite Button
          IconButton(
            onPressed: (){
              setState(() {
                isFav = !isFav;
              });
            },
            icon: 
              FaIcon(isFav ?  Icons.favorite_rounded: Icons.favorite_outline,
              color: Colors.red,
          ),
          )
        ], iconSize: 20,
      ), 
      body: SafeArea(
        child: Column(
          children: <Widget> [
            //pass doctor details here
            //build doctor avatar and intro here// xây dựng avatar và giới thiệu bác sĩ tại đây
            AboutDoctor(doctor: doctor,),
            //details of the doctor// chi tiết của bác sĩ
            DetailBody(doctor: doctor,),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Button(
                width: double.infinity,
                title: 'Đặt lịch hẹn',
                onPressed: (){
                  //navigate to booking page//điều hướng đến trang đặt phòng
                  //let's create that//hãy tạo ra cái đó
                  //pas doctor id for booking process//chuyển id bác sĩ cho quá trình đặt chỗ
                  Navigator.of(context).pushNamed('booking_page',
                  arguments: {"doctor_id": doctor['doc_id']}
                );
                },
                disable: false,
              )
            )
          ],
        ),
      )
    );
  }
}

class AboutDoctor extends StatelessWidget{
  const AboutDoctor({Key? key, required this.doctor}) : super(key: key);

  final Map<dynamic, dynamic> doctor;

  @override
  Widget build(BuildContext context){
    Config().init(context);
    return Container(
      width: double.infinity,
      child: Column(
        children: <Widget>[
          CircleAvatar(
            radius: 65.0,
            backgroundImage: NetworkImage("https://b5a2-123-21-214-117.ngrok-free.app${doctor['doctor_profile']}"),
            backgroundColor: Colors.white,
          ),
          Config.spaceMedium,
          Text(
            "Dr ${doctor['doctor_name']}",
            style: const TextStyle(
              color: Colors.black,
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Config.spaceSmall,
          SizedBox(
            width: Config.widthSize *0.75,
            child: const Text(
              'MBBS (Đại học Y khoa Quốc tế Việt Nam), MRCP (Trường Cao đẳng Bác sĩ Hoàng gia, Vương quốc Anh)',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 15,
              ),
              softWrap: true,
              textAlign: TextAlign.center,
            ),
          ),Config.spaceSmall,
          SizedBox(
            width: Config.widthSize *0.75,
            child: const Text(
              'Bệnh viện Đa khoa',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
              softWrap: true,
              textAlign: TextAlign.center,
            ),
          ),Config.spaceSmall,
        ],
      ),
    );
  }
}

class DetailBody extends StatelessWidget{
  const DetailBody ({Key? key, required this.doctor}) :super(key: key);

  final Map<dynamic, dynamic> doctor;

  @override
  Widget build(BuildContext context){
    Config().init(context);
    return Container(
      padding: const EdgeInsets.all(10),
      //margin: const EdgeInsets.only(bottom: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Config.spaceSmall,
          //doctor exp, patient and rating// bác sĩ kinh nghiệm, bệnh nhân và đánh giá
          DoctorInfo(
            patients: doctor['patients'],
            exp: doctor['experience'],
          ),
          Config.spaceMedium,
            const Text(
              'Thông tin bác sĩ',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
            ),
            Config.spaceSmall,
            Text(
              "Dr ${doctor['doctor_name']}  dfhgdf ${doctor['category']} sdgsdgfsd",
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                height: 1.5,
              ),
              softWrap: true,
              textAlign: TextAlign.justify,
            )
        ],
      ),
    );
  }
}

class DoctorInfo extends StatelessWidget{
  const DoctorInfo ({Key? key, required this.patients, required this.exp}) :super(key: key);

  final int patients;
  final int exp;

  @override
  Widget build(BuildContext context){
    return Row(
      children:  <Widget>[
        //lets extract to another class// cho phép trích xuất sang lớp khác
        InfoCard(
          label: 'Người bệnh',
          value: '$patients',
        ),
        const SizedBox(
          width: 15,
        ),
        InfoCard(
          label: 'Kinh nghiệm',
          value: '$exp',
        ),
        const SizedBox(
          width: 15,
        ),
        const InfoCard(
          label: 'Xếp hạng',
          value: '4.6',
        ),
      ],
    );
  }
}

class InfoCard extends StatelessWidget{
  const InfoCard({ Key? key, required this.label, required this.value}) : super(key: key);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context){
    return Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Config.primaryColor,
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 15,
            ),
            child: Column(
              children: <Widget> [
                Text(
                  label ,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  value,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
        );
  }
}