import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:users_management_flutter_app/Pages/LogInPage.dart';
import 'package:users_management_flutter_app/Pages/UsersPage.dart';
import '../Utils/Global.dart';
import '../Widgets/button_widget.dart';
import '../Widgets/select_widget.dart';
import '../Widgets/textfield_widget.dart';

var admin = false;

class SignUpPage extends StatelessWidget {
  SignUpPage({Key? key}) : super(key: key);

  final TextEditingController _controllerTxtName = TextEditingController();
  final TextEditingController _controllerTxtLastName = TextEditingController();
  final TextEditingController _controllerTxtEmail = TextEditingController();
  final TextEditingController _controllerTxtPassword = TextEditingController();

  var name = '';
  var lastName = '';
  var email = '';
  var password = '';

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          leadingWidth: 40.0,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                  icon: Image.network(
                      'https://cdn.discordapp.com/attachments/956669281813299230/989678001845334087/unknown.png'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  });
            },
          ),
          backgroundColor: Global.colorBack,
          foregroundColor: Global.colorBase,
        ),
        backgroundColor: Global.colorBack,
        body: ListView(children: [
          Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Text(
              "Sign Up",
              style: TextStyle(
                  height: 1,
                  fontSize: 23,
                  color: Global.colorBase,
                  fontWeight: FontWeight.bold),
            ),
            const Padding(
                padding: EdgeInsets.only(top: 30.0, bottom: 20.0),
                child: Image(
                  image: NetworkImage(
                      'https://cdn.discordapp.com/attachments/956669281813299230/989685249262907403/add-contact.png'),
                  height: 120.0,
                )),
            TextFieldWidget(
                isPrefixIcon: false,
                isSuffixIcon: false,
                isMyControllerActivated: true,
                controller: _controllerTxtName,
                onChanged: (value) {
                  name = value;
                },
                hintText: "Firstname"),
            TextFieldWidget(
                isPrefixIcon: false,
                isSuffixIcon: false,
                isMyControllerActivated: true,
                controller: _controllerTxtLastName,
                onChanged: (value) {
                  lastName = value;
                },
                hintText: "Lastname"),
            TextFieldWidget(
                isPrefixIcon: false,
                isSuffixIcon: false,
                isMyControllerActivated: true,
                controller: _controllerTxtEmail,
                onChanged: (value) {
                  email = value;
                },
                hintText: "E-mail"),
            TextFieldWidget(
                obscureText: true,
                isPrefixIcon: false,
                isSuffixIcon: false,
                isMyControllerActivated: true,
                controller: _controllerTxtPassword,
                onChanged: (value) {
                  password = value;
                },
                hintText: "Password"),
            definir(),
            ButtonWidget(
                colorButton: Global.colorBase,
                color: Global.colorBack,
                title: "Sign Up",
                hasColor: false,
                onPressed: () {
                  var isNotEmpty = true;
                  if (_controllerTxtName.text.isEmpty &&
                      _controllerTxtLastName.text.isEmpty &&
                      _controllerTxtEmail.text.isEmpty &&
                      _controllerTxtPassword.text.isEmpty) {
                    isNotEmpty = false;
                  }
                  if (isNotEmpty) {
                    users
                        .add({
                          'name': name,
                          'lastname': lastName,
                          'email': email,
                          'password': password,
                          'admin': admin
                        })
                        .then((value) => print('User Added'))
                        .catchError(
                            (error) => print('Failed to add user: $error'));
                    if (userAdmin) {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => UsersPage()));
                    } else {
                      Navigator.of(context).pop();
                    }
                  } else {
                    CoolAlert.show(
                      backgroundColor: Global.colorBack,
                      confirmBtnColor: Global.colorBase,
                      context: context,
                      type: CoolAlertType.warning,
                      text: 'Empty fields',
                    );
                  }
                })
          ]),
        ]));
  }
}

Widget definir() {
  if (userAdmin) {
    return SelectWidget();
  } else {
    return Text("");
  }
}
