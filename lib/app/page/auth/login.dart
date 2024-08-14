import 'package:app_api/app/config/const.dart';
import 'package:app_api/app/data/api.dart';
import 'package:app_api/app/model/forgetpassw.dart';
import 'package:app_api/app/page/auth/forgetpass.dart';
import '../register.dart';
import 'package:app_api/mainpage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import '../../data/sharepre.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController accountController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  login() async {
    String accountId = accountController.text;
    String password = passwordController.text;
    //lấy token (lưu share_preference)

    // validate login
    if (accountId == null || accountId.isEmpty) {
      _showErrorDialog(context, "Vui lòng điền tài khoản");
      return null; // Add this line
    }
    if (password == null || password.isEmpty) {
      _showErrorDialog(context, "Vui lòng điền mật khẩu");
      return null; // Add this line
    }
    try {
      String token = await APIRepository()
          .login(accountController.text, passwordController.text);
      var user = await APIRepository().current(token);
      // save share
      saveUser(user);
      //
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Mainpage()));
      return token;
    } catch (ex) {
      _showErrorDialog(context, "Tài khoản hoặc mật khẩu không đúng");
      return null; // Add this line
    }
  }

  // show error dialog
  void _showErrorDialog(BuildContext context, String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Lỗi đăng nhập'),
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

  @override
  void initState() {
    super.initState();
    // autoLogin();
  }

  autoLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('user') != null) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Mainpage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                children: [
                  Image.asset(
                    urlLogo,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.image),
                  ),
                  // const Text(
                  //   "LOGIN INFORMATION",
                  //   style: TextStyle(fontSize: 24, color: Colors.blue),
                  // ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: accountController,
                    decoration: const InputDecoration(
                      labelText: "Account",
                      icon: Icon(Icons.person),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: "Password",
                      icon: Icon(Icons.password),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ForgetPass()));
                        // Add your forgot password function here
                      },
                      child: Text('Quên mật khẩu ?'),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: ElevatedButton(
                        style:ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.blue)
                      
                           ),
                        onPressed: login,
                        child: const Text("Đăng nhập", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                          )
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                          child: ElevatedButton(
                            style:ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.blue)
                      
                           ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Register()));
                        },
                        child: const Text("Đăng ký", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                      )),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
