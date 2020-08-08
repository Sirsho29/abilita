import 'package:abilita/screens/auth/auth_service.dart';
import 'package:abilita/screens/product_detail_screen.dart';
import 'package:abilita/screens/products_overview_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:passwordfield/passwordfield.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login-screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _showSpinner = false;

  String email;
  String password;
  String username;

  bool _signed = true;

  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: Padding(
        //   padding: const EdgeInsets.all(3.0),
        //   child: Builder(
        //     builder: (ctx) => RaisedButton(
        //         shape: RoundedRectangleBorder(
        //             borderRadius: BorderRadius.circular(5),
        //             side: BorderSide(
        //               width: 3,
        //               color: Color.fromRGBO(160, 160, 160, 1),
        //             )),
        //         color: Color.fromRGBO(57, 57, 57, 1),
        //         padding: EdgeInsets.all(0),
        //         hoverColor: Colors.lightBlue,
        //         child: Icon(
        //           Icons.apps,
        //           color: Color.fromRGBO(249, 249, 249, 1),
        //           size: 25,
        //         ),
        //         onPressed: () {
        //           Scaffold.of(ctx).openDrawer();
        //         }),
        //   ),
        // ),
        title: Container(width: 150, child: Image.asset('assets/logoBig.png')),
        backgroundColor: Color.fromRGBO(57, 57, 57, 1),
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RaisedButton(
                  color: Color.fromRGBO(57, 57, 57, 1),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                      side: BorderSide(
                        width: 3,
                        color: Color.fromRGBO(160, 160, 160, 1),
                      )),
                  onPressed: () {},
                  child: Text(
                    'Explore',
                    style: GoogleFonts.comfortaa(
                        color: Colors.white, fontSize: 20),
                  ),
                  hoverColor: Colors.lightBlue,
                ),
                SizedBox(
                  width: 15,
                ),
                RaisedButton(
                  hoverColor: Colors.lightBlue,
                  color: Color.fromRGBO(57, 57, 57, 1),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                      side: BorderSide(
                        width: 3,
                        color: Color.fromRGBO(160, 160, 160, 1),
                      )),
                  onPressed: () {},
                  child: Text(
                    'Seller',
                    style: GoogleFonts.comfortaa(
                        color: Colors.white, fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ],
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Row(
        children: [
          Container(
            height: double.infinity,
            decoration: BoxDecoration(
                color: Color.fromRGBO(57, 57, 57, 1),
                border: Border.all(
                  width: 0,
                  color: Color.fromRGBO(57, 57, 57, 1),
                )),
            width: MediaQuery.of(context).size.width * 0.25,
            child: Container(
                width: 150, child: Image.asset('assets/logoSmall.png')),
          ),
          Container(
            padding: EdgeInsets.all(0),
            width: MediaQuery.of(context).size.width * 0.75,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                //crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Center(
                    child: Text(
                      (_signed) ? 'Login ...' : 'Sign up ...',
                      style: GoogleFonts.comfortaa(
                          color: Color.fromRGBO(57, 57, 57, 1), fontSize: 50),
                    ),
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 3,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 8.0, bottom: 8.0, right: 8.0, left: 17),
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            email = value;
                          });
                        },
                        keyboardType: TextInputType.emailAddress,
                        // controller: _textEditingController,
                        cursorColor: Color.fromRGBO(57, 57, 57, 1),
                        textAlign: TextAlign.start,
                        showCursor: true,
                        cursorRadius: Radius.circular(5),
                        cursorWidth: 2,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          focusColor: Colors.white,
                          labelStyle: GoogleFonts.comfortaa(
                            color: Color.fromRGBO(57, 57, 57, 0.8),
                            fontWeight: FontWeight.bold,
                          ),
                          labelText: "Email ID",
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 0,
                                color: Color.fromRGBO(57, 57, 57, 0.8)),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 0,
                                color: Color.fromRGBO(57, 57, 57, 0.8)),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 0,
                                color: Color.fromRGBO(57, 57, 57, 0.8)),
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        textCapitalization: TextCapitalization.none,
                        style: GoogleFonts.comfortaa(
                          color: Color.fromRGBO(57, 57, 57, 0.8),
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 3,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 8.0, bottom: 8.0, right: 8.0, left: 17),
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            password = value;
                          });
                        },

                        keyboardType: TextInputType.emailAddress,
                        obscureText: (_showPassword) ? false : true,
                        // controller: _textEditingController,
                        cursorColor: Color.fromRGBO(57, 57, 57, 1),
                        textAlign: TextAlign.start,
                        showCursor: true,
                        cursorRadius: Radius.circular(5),
                        cursorWidth: 2,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                              icon: Icon(
                                FontAwesomeIcons.eye,
                                color:
                                    (_showPassword) ? Colors.blue : Colors.grey,
                              ),
                              onPressed: () {
                                setState(() {
                                  _showPassword = !_showPassword;
                                });
                              }),
                          fillColor: Colors.white,
                          focusColor: Colors.white,
                          labelStyle: GoogleFonts.comfortaa(
                            color: Color.fromRGBO(57, 57, 57, 0.8),
                            fontWeight: FontWeight.bold,
                          ),
                          labelText: "Password",
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 0,
                                color: Color.fromRGBO(57, 57, 57, 0.8)),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 0,
                                color: Color.fromRGBO(57, 57, 57, 0.8)),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 0,
                                color: Color.fromRGBO(57, 57, 57, 0.8)),
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        textCapitalization: TextCapitalization.none,
                        style: GoogleFonts.comfortaa(
                          color: Color.fromRGBO(57, 57, 57, 0.8),
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                  (_signed)
                      ? Container()
                      : Container(
                          width: MediaQuery.of(context).size.width / 3,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 8.0, bottom: 8.0, right: 8.0, left: 17),
                            child: TextField(
                              onChanged: (value) {
                                setState(() {
                                  username = value;
                                });
                              },
                              keyboardType: TextInputType.text,
                              // controller: _textEditingController,
                              cursorColor: Color.fromRGBO(57, 57, 57, 1),
                              textAlign: TextAlign.start,
                              showCursor: true,
                              cursorRadius: Radius.circular(5),
                              cursorWidth: 2,
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                focusColor: Colors.white,
                                labelStyle: GoogleFonts.comfortaa(
                                  color: Color.fromRGBO(57, 57, 57, 0.8),
                                  fontWeight: FontWeight.bold,
                                ),
                                labelText: "Name",
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 2, horizontal: 20),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 0,
                                      color: Color.fromRGBO(57, 57, 57, 0.8)),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 0,
                                      color: Color.fromRGBO(57, 57, 57, 0.8)),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 0,
                                      color: Color.fromRGBO(57, 57, 57, 0.8)),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                              textCapitalization: TextCapitalization.words,
                              style: GoogleFonts.comfortaa(
                                color: Color.fromRGBO(57, 57, 57, 0.8),
                                fontSize: 17,
                              ),
                            ),
                          ),
                        ),
                  SizedBox(
                    height: 24.0,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: (_showSpinner)
                        ? CircularProgressIndicator(
                            strokeWidth: 1,
                          )
                        : MaterialButton(
                            onPressed: () async {
                              setState(() {
                                _showSpinner = true;
                              });
                              try {
                                (_signed)
                                    ? context
                                        .read<FirebaseAuthService>()
                                        .signInWithEmail(email, password)
                                        .then((value) {
                                        if (value != null) {
                                          Navigator.of(context).pushNamed(
                                              ProductOverviewScreen.routeName);
                                        }
                                        setState(() {
                                          _showSpinner = false;
                                        });
                                      })
                                    : context
                                        .read<FirebaseAuthService>()
                                        .signUpWithEmail(
                                            email, password, username)
                                        .then((user) {
                                        Firestore.instance
                                            .collection('users')
                                            .document()
                                            .setData({
                                          'uid': user.uid,
                                          'email': user.email,
                                          'name': username,
                                        });
                                      }).whenComplete(() {
                                        Navigator.of(context).pushNamed(
                                            ProductOverviewScreen.routeName);

                                        setState(() {
                                          _showSpinner = false;
                                        });
                                      });
                              } catch (e) {
                                print(e);
                              }
                            },
                            minWidth: 200.0,
                            height: 42.0,
                            hoverColor: Colors.lightBlue,
                            color: Color.fromRGBO(57, 57, 57, 1),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                                side: BorderSide(
                                  width: 3,
                                  color: Color.fromRGBO(160, 160, 160, 1),
                                )),
                            child: Text(
                              (_signed) ? 'Login' : 'Sign Up',
                              style: GoogleFonts.comfortaa(
                                  color: Colors.white, fontSize: 20),
                            ),
                          ),
                  ),
                  FlatButton(
                    onPressed: () {
                      setState(() {
                        _signed = !_signed;
                      });
                    },
                    child: Text(
                      (_signed)
                          ? 'Don\'t have an account ?'
                          : 'Already have an account ?',
                      style: GoogleFonts.comfortaa(
                          color: Colors.blue, fontSize: 20),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 5,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: MaterialButton(
                        onPressed: () async {
                          setState(() {
                            _showSpinner = true;
                          });
                          try {
                            context
                                .read<FirebaseAuthService>()
                                .signInWithGoogle()
                                .then((user) async {
                              Firestore.instance
                                  .collection('users')
                                  .document()
                                  .setData({
                                'uid': user.uid,
                                'email': user.email,
                                'name': user.displayName,
                                'wishes': FieldValue.arrayUnion([]),
                                'cart': FieldValue.arrayUnion([]),
                              });
                              if (user != null) {
                                Navigator.of(context)
                                    .pushNamed(ProductOverviewScreen.routeName);
                              }
                              setState(() {
                                _showSpinner = false;
                              });
                            });
                          } catch (e) {
                            print(e);
                          }
                        },
                        minWidth: 200.0,
                        height: 42.0,
                        hoverColor: Colors.lightBlue,
                        color: Color.fromRGBO(57, 57, 57, 1),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                            side: BorderSide(
                              width: 3,
                              color: Color.fromRGBO(160, 160, 160, 1),
                            )),
                        child: (MediaQuery.of(context).size.width > 900)
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(
                                    FontAwesomeIcons.google,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    'Continue with Google',
                                    style: GoogleFonts.comfortaa(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                ],
                              )
                            : Center(
                                child: Icon(
                                  FontAwesomeIcons.google,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
