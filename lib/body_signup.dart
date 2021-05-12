import 'package:flutter/material.dart';
import 'tela_login.dart';
import 'or_divider.dart';
import 'social_icon.dart';
import 'already_have_an_account_acheck.dart';
import 'rounded_button.dart';
import 'constants.dart';
import 'text_field_container.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'perfil_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Body extends StatefulWidget {
  @override
  _Body createState() => _Body();
}

class _Body extends State<Body> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  String _email;
  String _pass;
  String nameUser;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: AppBar(
          centerTitle: true,
          title: Text(
            'Inscrever-se',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 36,
                shadows: [
                  Shadow(
                    blurRadius: 10.0,
                    color: Color(0xFF0FA086),
                    offset: Offset(5.0, 5.0),
                  ),
                ],
                fontFamily: 'Monda'),
          ),
          elevation: 5,
          flexibleSpace: Image(
            image: AssetImage('images/appbar.png'),
            fit: BoxFit.cover,
          ),
          backgroundColor: Colors.transparent,
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView(children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    "images/quiron_logo.png",
                    width: 250,
                    height: 200,
                  ),
                  SizedBox(height: size.height * 0.03),
                  // Campo para digitar o Nome Completo
                  TextFieldContainer(
                    child: TextField(
                      keyboardType: TextInputType.emailAddress,
                      style:
                          TextStyle(color: Colors.black54, fontFamily: 'Monda'),
                      onChanged: (value) {
                        nameUser = value;
                      },
                      cursorColor: kPrimaryColor,
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.person,
                          color: kPrimaryColor,
                        ),
                        hintText: "Nome Completo",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  // Campo para digitar o E-Mail
                  TextFieldContainer(
                    child: TextField(
                      keyboardType: TextInputType.emailAddress,
                      style:
                          TextStyle(color: Colors.black54, fontFamily: 'Monda'),
                      onChanged: (value) {
                        _email = value;
                      },
                      cursorColor: kPrimaryColor,
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.person,
                          color: kPrimaryColor,
                        ),
                        hintText: "Digite um e-mail",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  // Campo para digitar a senha
                  TextFieldContainer(
                    child: TextField(
                      obscureText: true,
                      style:
                          TextStyle(color: Colors.black54, fontFamily: 'Monda'),
                      onChanged: (value) {
                        _pass = value;
                      },
                      cursorColor: kPrimaryColor,
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.lock,
                          color: kPrimaryColor,
                        ),
                        hintText: "Digite uma Senha",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  RoundedButton(
                    text: "Inscrever-se",
                    press: () async {
                      _firestore.collection('usuarios').add(
                        {
                          'nameUser': nameUser,
                          'emailUser': _email,
                        },
                      );
                      print(_email);
                      print(_pass);
                      try {
                        final newUser =
                            await _auth.createUserWithEmailAndPassword(
                                email: _email, password: _pass);
                        if (newUser != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return PerfilScreen();
                              },
                            ),
                          );
                        }
                      } catch (e) {
                        print(e);
                      }
                    },
                  ),
                  SizedBox(height: size.height * 0.03),
                  AlreadyHaveAnAccountCheck(
                    login: false,
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return LoginPage();
                          },
                        ),
                      );
                    },
                  ),
                  OrDivider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // SocalIcon(
                      //   iconSrc: "images/icons/facebook.svg",
                      //   press: () {},
                      // ),
                      // SocalIcon(
                      //   iconSrc: "images/icons/twitter.svg",
                      //   press: () {},
                      // ),
                      // SocalIcon(
                      //   iconSrc: "images/icons/google-plus.svg",
                      //   press: () {},
                      // ),
                    ],
                  )
                ],
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
