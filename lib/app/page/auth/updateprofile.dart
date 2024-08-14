import 'dart:ffi';
import 'package:app_api/app/data/sharepre.dart';
import 'package:app_api/app/page/detail.dart';
import 'package:app_api/mainpage.dart';
import 'package:flutter/material.dart';
import 'package:app_api/app/model/updateprofile.dart';
import 'package:app_api/app/data/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({super.key});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  int _gender = 0;
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _numberIDController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _schoolKeyController = TextEditingController();
  final TextEditingController _schoolYearController = TextEditingController();
  final TextEditingController _birthDayController = TextEditingController();
  final TextEditingController _imageURL = TextEditingController();
  String gendername = 'None';
  String temp = '';
  String token = '';
  getcurrenttoken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String strToken = pref.getString('token')!;
    token = strToken;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getcurrenttoken();
  }

  Future<String> updateprofile() async {
    return await APIRepository().updateProfile(
        token,
        UpdateProfileM(
            numberID: _numberIDController.text,
            fullName: _fullNameController.text,
            phoneNumber: _phoneNumberController.text,
            gender: getGender(),
            birthDay: _birthDayController.text,
            schoolKey: _schoolKeyController.text,
            schoolYear: _schoolYearController.text,
            imageUrl: _imageURL.text));
  }

  getGender() {
    if (_gender == 1) {
      return "Nam";
    } else if (_gender == 2) {
      return "Nữ";
    }
    return "Khác";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  child: const Text(
                    'Profile Info',
                    style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                  ),
                ),
                updateWidget(),
                const SizedBox(height: 16),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () async {
                          String respone = await updateprofile();
                           
                          if (respone == "ok") {
                            // ignore: use_build_context_synchronously
                            showDialog(
                              context: context,
                              builder: (context) => showDiaglogSuccess(),
                            );
                          } else {
                            print(respone);
                          }
                        },
                        child: const Text('Done'),
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget textField(
  //     TextEditingController controller, String label, IconData icon) {
  //   return Container(
  //     margin: const EdgeInsets.symmetric(vertical: 10),
  //     child: TextFormField(
  //       controller: controller,
  //       obscureText: label.contains('word'),
  //       onChanged: (value) {
  //         setState(() {
  //           temp = value;
  //         });
  //       },
  //       decoration: InputDecoration(
  //           labelText: label,
  //           icon: Icon(icon),
  //            border: const OutlineInputBorder(),
             
  //         errorText: controller.text.trim().length < 10 && label == "NumberID" ? 'NumberID must be 10 characters' : null,
          
  //         focusedErrorBorder: controller.text.isEmpty
  //           ? const OutlineInputBorder(
  //               borderSide: BorderSide(color: Colors.red))
  //           : null,
  //         errorBorder: controller.text.isEmpty
  //           ? const OutlineInputBorder(
  //               borderSide: BorderSide(color: Colors.red))
  //           : null),
  //     ),
  //   );
  // }
  Widget textField(TextEditingController controller, String label, IconData icon) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 10),
    child: TextFormField(
      controller: controller,
      obscureText: label.contains('word'),
      onChanged: (value) {
        setState(() {
          temp = value;
        });
      },
      decoration: InputDecoration(
          labelText: label,
          icon: Icon(icon),
          border: const OutlineInputBorder(),
          errorText: controller.text.trim().isEmpty 
            ? 'Please enter' 
            : controller.text.trim().length < 10 && label == "NumberID" 
              ? 'NumberID must be 10 characters' 
              : null,
          focusedErrorBorder: controller.text.isEmpty
            ? const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red))
            : null,
          errorBorder: controller.text.isEmpty
            ? const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red))
            : null),
    ),
  );
}

  Widget updateWidget() {
    return Column(
      children: [
        textField(_fullNameController, "Full Name", Icons.text_fields_outlined),
        textField(_numberIDController, "NumberID", Icons.key),
        textField(_phoneNumberController, "PhoneNumber", Icons.phone),
        textField(_birthDayController, "BirthDay", Icons.date_range),
        textField(_schoolYearController, "SchoolYear", Icons.school),
        textField(_schoolKeyController, "SchoolKey", Icons.school),
        const Text("Giới tính của bạn"),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: ListTile(
                contentPadding: const EdgeInsets.all(0),
                title: const Text("Nam"),
                leading: Transform.translate(
                    offset: const Offset(16, 0),
                    child: Radio(
                      value: 1,
                      groupValue: _gender,
                      onChanged: (value) {
                        setState(() {
                          _gender = value!;
                        });
                      },
                    )),
              ),
            ),
            Expanded(
              child: ListTile(
                  contentPadding: const EdgeInsets.all(0),
                  title: const Text("Nữ"),
                  leading: Transform.translate(
                    offset: const Offset(16, 0),
                    child: Radio(
                      value: 2,
                      groupValue: _gender,
                      onChanged: (value) {
                        setState(() {
                          _gender = value!;
                        });
                      },
                    ),
                  )),
            ),
            Expanded(
                child: ListTile(
              contentPadding: const EdgeInsets.all(0),
              title: const Text("Khác"),
              leading: Transform.translate(
                  offset: const Offset(16, 0),
                  child: Radio(
                    value: 3,
                    groupValue: _gender,
                    onChanged: (value) {
                      setState(() {
                        _gender = value!;
                      });
                    },
                  )),
            )),
          ],
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _imageURL,
          decoration: const InputDecoration(
            labelText: "Image URL",
            icon: Icon(Icons.image),
          ),
        ),
      ],
    );
  }
  Widget showDiaglogSuccess() {
    return AlertDialog(
      //title: Text('Thành công'),
      content:const Text(
        'Cập nhật thông tin thành công',
        style: TextStyle(
            fontSize: 24, color: Colors.black, fontWeight: FontWeight.bold),
      ),
      actions: [
        TextButton(
            onPressed: () async {
              var user = await APIRepository().current(token);
              saveUser(user);
              setState(() {
              });
              // ignore: use_build_context_synchronously
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Mainpage()));
            },
            child: const Center(
              child: Text(
                'Hoàn thành',
                style: TextStyle(color: Colors.black),
              ),
            ))
      ],
    );
  }
}

