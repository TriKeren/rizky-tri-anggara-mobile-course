import 'package:flutter/material.dart';
import 'package:week_3_navigation_and_form/studi_kasus/detail_lokasi.dart';

class HomeStud extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Wisata Kampus',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
        ),
        backgroundColor: const Color(0xFF0123FF),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                'assets/images/canva-ilustrasi-gedung-sekolah-MAHMGE_X0SY.webp',
                fit: BoxFit.cover,
              ),
              Text(
                'Selamat Datang!',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),

              Text(
                'Temukan Tempat Menarik Di Kampus Kami',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
              ),

              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DetailLokasi()));
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.park, size: 30),
                        SizedBox(width: 20),

                        Text(
                          'Taman Kampus',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(width: 50),

                        Icon(Icons.chevron_right),
                      ],
                    ),
                  ],
                ),
              ),

              ElevatedButton(
                onPressed: () {
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.park, size: 30),
                        SizedBox(width: 20),

                        Text(
                          'Perpustakaan',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(width: 50),

                        Icon(Icons.chevron_right),
                      ],
                    ),
                  ],
                ),
              ),

              ElevatedButton(
                onPressed: () {},
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.park, size: 30),
                        SizedBox(width: 20),

                        Text(
                          'Laboratorium',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(width: 50),

                        Icon(Icons.chevron_right),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
