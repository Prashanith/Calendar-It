import 'package:calendar_it/bloc/authBLOC/auth_bloc.dart';
import 'package:calendar_it/bloc/authBLOC/auth_state.dart';
import 'package:calendar_it/constants/theme_file.dart';
import 'package:calendar_it/routes/error_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/src/provider.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const ErrorPage();
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return const Home();
        }
        return const Scaffold(
          body:Center(
            child: CircularProgressIndicator(
              color: Colors.black87,
            ),
          ),
        );
      },
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  static const appStyle=TextStyle(
    color: Colors.black87,
    fontWeight: FontWeight.bold,
    fontSize: 30
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child:Scaffold(
          body:BlocListener<AuthenticationBloc,AuthenticationState>(
              listener:(context,state){
                if(state is Authenticated){
                  Navigator.of(context).pushNamed('/home',);
                  print("-----------------------------");
                }
                else if(state is UnAuthenticated){
                  Navigator.of(context).pushNamed('/login');
                  print("-----------------------------");

                }
              },
              child: Center(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Image(
                          image:const AssetImage("assets/images/time.png"),
                          width: MediaQuery.of(context).size.width*0.4,
                        ),
                        const SizedBox(height: 30,),
                        const Text("Calendar It",style:appStyle,),
                      ],
                    ),
                    Column(
                      children: [
                        // const Text("Now tasks made easier with calendar it",
                        //   style: TextStyle(fontWeight: FontWeight.w700),
                        // ),
                        // const SizedBox(height: 20,),
                        OutlinedButton.icon(
                            onPressed: ()=>{
                              Navigator.of(context).pushNamed("/login")
                            },
                            icon:const Text(
                              "continue",
                              style: TextStyle(fontSize: 20),
                            ),
                            label:const Icon(FontAwesomeIcons.arrowRight,size: 15,),
                            style: ButtonStyle(
                                padding:MaterialStateProperty.all(
                                    const EdgeInsets.symmetric(
                                        horizontal: 20,
                                        vertical:10
                                    )
                                ),
                                backgroundColor:MaterialStateProperty.all(LightTheme.primary),
                                foregroundColor: MaterialStateProperty.all(LightTheme.quaternary),
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                        side: const BorderSide(color: Colors.red)
                                    )
                                )
                            )
                        )
                      ],
                    ),
                  ],
                ),
              ),
          )
        )
    );
  }
}

