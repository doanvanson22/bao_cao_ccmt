import 'package:app_hello/components/doctor_card.dart';
import 'package:flutter/material.dart';

class FavPage extends StatefulWidget {
  const FavPage({Key? key}) : super(key: key);

  @override
  State<FavPage> createState() => _FavPageState();
}

class _FavPageState extends State<FavPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
        child: Column(
          children: [
            const Text(
              'My Favorite Doctors',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index){
                  return DoctorCard(route: 'doc_details', doctor: {});
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//now, let's build favorite page

// as you can see, the list view is demostrating the list of favorite doctors
// later will be replaced by consumer(provider) for instantly update latest farvorite list
// and now, let's working on profile page

// now, let's insert new column into user detalis
// bây giờ, hãy chèn cột mới vào chi tiết người dùng
// insert a column named'fav', to store favorite doctor id// chèn một cột có tên'fav', để lưu id bác sĩ yêu thích
// and then display favorite doctor at favorite screen// và sau đó hiển thị bác sĩ yêu thích tại màn hình yêu thích