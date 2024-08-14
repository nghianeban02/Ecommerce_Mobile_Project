import 'dart:convert';
import 'package:app_api/app/page/auth/changepass.dart';
import 'package:app_api/app/page/auth/updateprofile.dart';
import 'package:flutter/material.dart';
import '../model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Detail extends StatefulWidget {
  const Detail({super.key});

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  // khi dùng tham số truyền vào phải khai báo biến trùng tên require
  User user = User.userEmpty();
  getDataUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String strUser = pref.getString('user')!;

    user = User.fromJson(jsonDecode(strUser));
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataUser();
  }

  TextStyle mystyle = const TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );
  @override
  Widget build(BuildContext context) {
    // create style
    TextStyle mystyle = const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.black45,
    );
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Center(
              child: Stack(
                children: [
                  Container(
                    width: 130,
                    height: 130,
                    decoration: BoxDecoration(
                      border: Border.all(width: 4, color: Colors.white),
                      boxShadow: [
                        BoxShadow(
                            spreadRadius: 2,
                            blurRadius: 10,
                            color: Colors.black.withOpacity(0.1))
                      ],
                      shape: BoxShape.circle,
                      image: const DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            'https://scontent.fsgn8-3.fna.fbcdn.net/v/t39.30808-6/331014206_930540588307330_1234298021932295004_n.jpg?_nc_cat=109&ccb=1-7&_nc_sid=5f2048&_nc_ohc=PvZJB_wDbFUQ7kNvgEPHCO3&_nc_ht=scontent.fsgn8-3.fna&oh=00_AfCUcONMyEvEPKx_4EL_HgNH4LHm-i9hM5dtiHyLBHT7mw&oe=66380E3F'),
                      ),
                    ),
                  ),
                  Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 4,
                            color: Colors.white,
                          ),
                          color: Colors.blue,
                        ),
                        child: const Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                      ))
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Card(
                  margin: EdgeInsets.all(10),
                  child: ListTile(
                    title: Text("ID: ${user.idNumber}", style: mystyle),
                  ),
                ),
                Card(
                  margin: EdgeInsets.all(10),
                  child: ListTile(
                    title: Text("Họ và tên: ${user.fullName}", style: mystyle),
                  ),
                ),
                Card(
                  margin: EdgeInsets.all(10),
                  child: ListTile(
                    title: Text("Số điện thoại: ${user.phoneNumber}",
                        style: mystyle),
                  ),
                ),
                Card(
                  margin: EdgeInsets.all(10),
                  child: ListTile(
                    title: Text("Giới tính: ${user.gender}", style: mystyle),
                  ),
                ),
                Card(
                  margin: EdgeInsets.all(10),
                  child: ListTile(
                    title: Text("Ngày sinh: ${user.birthDay}", style: mystyle),
                  ),
                ),
                Card(
                  margin: EdgeInsets.all(10),
                  child: ListTile(
                    title: Text("Năm học: ${user.schoolYear}", style: mystyle),
                  ),
                ),
                Card(
                  margin: EdgeInsets.all(10),
                  child: ListTile(
                    title: Text("Khoá: ${user.schoolKey}", style: mystyle),
                  ),
                ),
                Card(
                  margin: EdgeInsets.all(10),
                  child: ListTile(
                    title:
                        Text("Ngày tạo: ${user.dateCreated}", style: mystyle),
                  ),
                ),
              ],
            ),
             Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const UpdateProfile()));
                      },
                      child: Text('Cập nhật thông tin', style: TextStyle(color: Colors.white)),
                      style: TextButton.styleFrom(backgroundColor: Colors.blue),


                      ),
                          SizedBox(width: 20), // Tạo khoảng cách giữa hai nút
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ChangePass()));
                      },
                      child: Text('Đổi mật khẩu', style: TextStyle(color: Colors.white)),
                      style: TextButton.styleFrom(backgroundColor: Colors.blue),

                      ),
                ],
              ),
          ]),
        ),
        
      ),
    );
  }
}
