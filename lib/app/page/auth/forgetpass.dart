import 'package:flutter/material.dart';
import 'package:app_api/app/data/api.dart';
import 'package:app_api/app/model/forgetpassw.dart';
import 'package:app_api/app/page/auth/login.dart';

class ForgetPass extends StatefulWidget {
  const ForgetPass({super.key});

  @override
  State<ForgetPass> createState() => _ForgetPassState();
}

class _ForgetPassState extends State<ForgetPass> {
  final TextEditingController _accountController = TextEditingController();
  final TextEditingController _numberIDController = TextEditingController();
  final TextEditingController _newPass = TextEditingController();
  String temp = '';

  Future<String> forgetpass() async {
    return await APIRepository().forgetPass(forgetpassw(
        accountID: _accountController.text,
        numberID: _numberIDController.text,
        newPass: _newPass.text));

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
                    'Cập nhật lại mật khẩu',
                    style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                  ),
                ),
                ForgetPassWidget(),
                const SizedBox(height: 16),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          String respone = await forgetpass();
                          if (respone == "ok") {
                            showDialog(
                              context: context,
                              builder: (context) => _DialogSuccess(),
                            );
                          } else {
                            print(respone);
                          }
                        },
                        child: const Text(
                          'Cập nhật', style: TextStyle(color: Colors.white,
                          fontWeight:FontWeight.bold,
                          fontSize: 18
                          )
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.blue),
                        ),
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

  Widget textField(
      TextEditingController controller, String label, IconData icon) {
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
            errorText: controller.text.trim().isEmpty ? 'Please enter' : null,
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

  Widget ForgetPassWidget() {
    return Column(
      children: [
        textField(_accountController, "Account", Icons.person),
        textField(_numberIDController, "NumberID", Icons.key),
        textField(_newPass, "New Password", Icons.password),
      ],
    );
  }
  //
  
 void _showErrorDialog(BuildContext context, String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Lỗi cập nhật'),
          content: Text(errorMessage),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
  Widget _DialogSuccess() {
    return AlertDialog(
      //title: Text('Thành công'),
      content: Text(
        'Cập nhật mật khẩu thành công',
        style: TextStyle(
            fontSize: 24, color: Colors.black, fontWeight: FontWeight.bold),
      ),
      actions: [
        TextButton(
            onPressed: () async {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()));
            },
            child: Center(
              child: Text(
                'Hoàn thành',
                style: TextStyle(color: Colors.black),
              ),
            ))
      ],
    );
  }
}
