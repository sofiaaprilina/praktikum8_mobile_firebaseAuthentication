import 'package:flutter/material.dart';
import 'sign_in.dart';
import 'first_screen.dart';
import 'email_screen.dart';
import 'input_email.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [Colors.blue[50], Colors.blue[400]],
        ),
      ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlutterLogo(size: 80),
              SizedBox(height: 20),
              _emailSignIn(),
              SizedBox(height: 10),
              _registerEmail(),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Divider(thickness: 1,color: Colors.white,),
                  ),
                  SizedBox(width: 20),
                  Text('OR',style: TextStyle(color: Colors.white),),
                  SizedBox(width: 20),
                  Expanded(
                    child: Divider(thickness: 1, color: Colors.white,),
                  ),
                ],
              ),
              _signInButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _signInButton() {
    return Container(
      padding: EdgeInsets.only(top: 20),
      width: double.infinity,
      child: OutlineButton(
      splashColor: Colors.grey,
      onPressed: () {
        signInWithGoogle().then((result) {
          if (result != null) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return FirstScreen();
                },
              ),
            );
          }
        });
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage("assets/google_logo.png"), height: 25.0),
            SizedBox(width: 20),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Sign in with Google',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    ),
    );
  }

  Widget _emailSignIn() {
    return Container(
      padding: EdgeInsets.all(8),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: 'Email',
                fillColor: Colors.white,
                filled: true,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.white),
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 4, horizontal: 16),
              ),
            ),
            SizedBox(height: 8),
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Password',
                fillColor: Colors.white,
                filled: true,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.white),
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 4, horizontal: 16),
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: double.infinity,
              child: RaisedButton(
                onPressed: () async {
                  signInWithEmail(
                    _emailController.text,
                    _passwordController.text)
                  .then((result) {
                    if (result != null) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return EmailScreen();
                          },
                        ),
                      );
                    }
                    ;
                  });
                },
                child: Text(
                  'Sign In', style: TextStyle(color: Colors.white),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                color: Colors.blue,
                elevation: 0,
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _registerEmail() {
    return Container(
      alignment: Alignment.bottomCenter,
      margin: EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            'Don\’t have account ?',
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(width: 5),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => InputEmail()));
            },
            child: Text(
              'Sign Up',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }
}
