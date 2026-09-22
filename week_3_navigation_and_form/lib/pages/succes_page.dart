// import 'package:flutter/material.dart';
// import 'package:week_3_navigation_and_form/pages/home_page.dart';

// class SuccesPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Ini Halaman Succes'),
//       ),

//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(
//                   Icons.check_circle, color: Colors.green, size: 100,
//                 ),
//                 Text(
//                   'Sukses Data Disimpan',
//                   style: TextStyle(
//                     fontSize: 30,
//                     fontWeight: FontWeight.w600
//                   ),
//                 )
//               ],
//             ),
//             SizedBox(height: 40,),

//             ElevatedButton(
//               onPressed: () {
//                 Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
//               }, 
//               child: Text(
//                 'Exit'
//               ))
//           ],
//         ),
//       ),
//     );
//   }
// }