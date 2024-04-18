// import 'package:app_hello/untils/config.dart';
// import 'package:flutter/material.dart';

// class ScoialButton extends StatelessWidget{
//   const ScoialButton({Key? key, required this.social}): super(key: key);

//   final String social;

//   @override
//   Widget build(BuildContext context){
//     Config().init(context);
//     return OutlinedButton(
//       style: OutlinedButton.styleFrom(
//         padding: const EdgeInsets. symmetric(vertical: 15),
//         side: const BorderSide(width: 1, color: Colors.black),
//       ),
//       onPressed: () {},
//       child: SizedBox(
//         width: Config.widthSize * 0.4,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: <Widget>[
//             Image.asset(
//               'assets/$social.png', // dowload social icon
//               width: 30,
//               height: 30,
//             ),
//             Text(
//               social.toUpperCase(),
//               style: const TextStyle(
//                 color: Colors.black,
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }