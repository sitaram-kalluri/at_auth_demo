import 'package:atsign_login_app/model/contact_info.dart';
import 'package:atsign_login_app/model/personal_info.dart';
import 'package:atsign_login_app/screens/login_page.dart';
import 'package:flutter/material.dart';

import '../services/authentication_service.dart';

class DataSharedScreen extends StatefulWidget {
  final AuthenticationService authenticationService;

  const DataSharedScreen(this.authenticationService, {super.key});

  @override
  _DataSharedScreen createState() => _DataSharedScreen();
}

class _DataSharedScreen extends State<DataSharedScreen> {
  PersonalInfo personalInfo = PersonalInfo();
  ContactInfo contactInfo = ContactInfo();

  @override
  void initState() {
    super.initState();
    getInfoDetails();
  }

  Future<void> getInfoDetails() async {
    contactInfo = await widget.authenticationService.getContactInfoSharedBy();
    personalInfo = await widget.authenticationService.getPersonalInfoSharedBy();
    print(personalInfo);
    print(contactInfo);
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: const Text('Data Shared Page'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.power_settings_new,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => LoginPage()));
            },
          )
        ],
      ),
      body:  ListView(
        padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 30.0),
        children: <Widget>
      [
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Welcome ${widget.authenticationService.atSign}',style: const TextStyle(color: Colors.black,fontSize: 25.0,),),
                const SizedBox(height: 10,),
                const Text('***Data Shared To you***',style: TextStyle(color: Colors.black,fontSize: 20.0,),),
                const SizedBox(height: 20.0,),
                const SizedBox(height: 10,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Personal Info    ',style: TextStyle(color: Colors.black,fontSize: 20.0,),),
                    // ElevatedButton(
                    //   style: ElevatedButton.styleFrom(
                    //     primary: Colors.orange[100], // background
                    //     onPrimary: Colors.black, // foreground
                    //   ),
                    //   onPressed: () async {
                    //     personalInfo =
                    //     await widget.authenticationService.getPersonalInfoSharedBy();
                    //     print(personalInfo);
                    //     setState(() {});
                    //   },
                    //   child: const Text('Get Personal Info'),
                    // ),
                  ],
                ),
                const SizedBox(height: 20.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text("First Name",style: TextStyle(fontSize: 20.0),),
                    SizedBox(width: 10,),
                    Container(
                        width: 200,
                        height: 50,
                        child:
                        TextField(
                          readOnly: true,
                          controller: TextEditingController(text: personalInfo.firstName),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'firstName',
                          ),
                        ),
                        // ElevatedButton(
                        //   style: ElevatedButton.styleFrom(
                        //     primary: Colors.orange[100], // background
                        //     onPrimary: Colors.black, // foreground
                        //   ),
                        //   onPressed: () async {
                        //     personalInfo =
                        //     await widget.authenticationService.getPersonalInfoSharedBy();
                        //     setState(() {});
                        //   },
                        //   child: const Text('firstname'),
                        // )
                    )
                  ],
                ),
                const SizedBox(height: 10.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text("Last Name",style: TextStyle(fontSize: 20.0),),
                    SizedBox(width: 10,),
                    Container(
                        width: 200,
                        height: 50,
                        child:
                        TextField(
                          readOnly: true,
                          controller: TextEditingController(text: personalInfo.lastName),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'lastName',
                          ),
                        ),
                    )
                  ],
                ),
                const SizedBox(height: 10.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text("Age",style: TextStyle(fontSize: 20.0),),
                    SizedBox(width: 67,),
                    Container(
                        width: 200,
                        height: 50,
                        child:
                        TextField(
                          readOnly: true,
                          controller: TextEditingController(text: personalInfo.age.toString()),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'age',
                          ),
                        ),
                    )
                  ],
                ),
                const SizedBox(height: 10.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text("Gender",style: TextStyle(fontSize: 20.0),),
                    SizedBox(width: 40,),
                    Container(
                        width: 200,
                        height: 50,
                        child:
                        TextField(
                          readOnly: true,
                          controller: TextEditingController(text: personalInfo.gender),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'gender',
                          ),
                        ),
                    )
                  ],
                ),
                const SizedBox(height: 20,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Contact Info    ',style: TextStyle(color: Colors.black,fontSize: 20.0,),),
                    // ElevatedButton(
                    //   style: ElevatedButton.styleFrom(
                    //     primary: Colors.orange[100], // background
                    //     onPrimary: Colors.black, // foreground
                    //   ),
                    //   onPressed: () async {
                    //     contactInfo =
                    //     await widget.authenticationService.getContactInfoSharedBy();
                    //     print(contactInfo);
                    //     setState(() {});
                    //   },
                    //   child: const Text('Get Contact Info'),
                    // ),
                  ],
                ),
                const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text("Email",style: TextStyle(fontSize: 20.0),),
                    SizedBox(width: 15,),
                    Container(
                        width: 200,
                        height: 50,
                        child:
                        TextField(
                          readOnly: true,
                          controller: TextEditingController(text: contactInfo.email),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'email',
                          ),
                        ),
                    )
                  ],
                ),
                const SizedBox(height: 10.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text("Phone",style: TextStyle(fontSize: 20.0),),
                    SizedBox(width: 10,),
                    Container(
                        width: 200,
                        height: 50,
                        child:
                        TextField(
                          readOnly: true,
                          controller: TextEditingController(text: contactInfo.phoneNumber),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'phone',
                          ),
                        ),
                    )
                  ],
                ),
                const SizedBox(height: 20.0,),
                Container(
                    width: 250,
                    height: 50,
                    child:ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.orange[100], // background
                        onPrimary: Colors.black, // foreground
                      ),
                      onPressed: () { },
                      child: const Text('Sign Up'),
                    )
                ),

              ],
            ),
          ),
        ]
      ),
    );
  }
}
