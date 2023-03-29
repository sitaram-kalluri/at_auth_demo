import 'package:flutter/material.dart';

import 'login_page.dart';


class SignUpScreen extends StatefulWidget{
  const SignUpScreen({super.key});
  @override
  State<StatefulWidget> createState() => _SignUpScreen();
}

class _SignUpScreen extends State<SignUpScreen>{


  bool loading = false;

  // text field state
  String email = '';
  String password = '';
  String error = '';
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
     appBar: AppBar(
       backgroundColor: Colors.brown[400],
       elevation: 0.0,
       title: const Text("Login Page",style: TextStyle(color: Colors.white),
           textDirection: TextDirection.ltr),
         actions: [
           TextButton.icon(
               style: TextButton.styleFrom(
               primary: Colors.orange[100],
           ),
               icon: Icon(Icons.person),
               label:Text('Logout'), onPressed: () {  },
           )
         ]
     ),
      body: ListView(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          children: <Widget>
          [
            Form(
              child: Column(
                children: <Widget>[

                  Image.asset('images/logo.jpg'),

                  SizedBox(height: 20.0),

                  Container(
                    width: 350,
                    height: 50,
                    child:ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.orange[100], // background
                        onPrimary: Colors.black, // foreground
                      ),
                      onPressed: () { },
                      child: const Text('Register'),
                    )
                  ),

                  const SizedBox(height: 20.0),

                  Container(
                      width: 350,
                      height: 50,
                      child:ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.orange[100], // background
                          onPrimary: Colors.black, // foreground
                        ),
                        onPressed: () { },
                        child: const Text('Login'),
                      )
                  ),


                  SizedBox(height: 12.0),

                  Text(
                    error,
                    style: TextStyle(color: Colors.red, fontSize: 14.0),
                  )

                ],
              ),
            ),
            SizedBox(height: 50.0),
            Divider(color: Colors.black,thickness: 1,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text("Sign up with",style: TextStyle(fontSize: 20.0),),
                TextButton(
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                LoginPage()),
                      );
                    },
                    child: const Text('@sign',style: TextStyle(color: Colors.lightBlue,fontSize: 20.0),)
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text("Sign up with",style: TextStyle(fontSize: 20.0),),
                TextButton(
                    onPressed: (){

                    },
                    child: const Text('GMAIL',style: TextStyle(color: Colors.lightBlue,fontSize: 20.0),)
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text("Sign up with",style: TextStyle(fontSize: 20.0),),
                TextButton(
                    onPressed: (){
                    },
                    child: const Text('Facebook',style: TextStyle(color: Colors.lightBlue,fontSize: 20.0),)
                )
              ],
            )
          ]
      ),
    );
  }
}