import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NavigationBar extends StatelessWidget {
  final int pageNumber;
  final Function(int) switchPage;
  const NavigationBar({Key? key,required this.pageNumber,required this.switchPage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height:MediaQuery.of(context).size.height*0.08,
      margin: EdgeInsets.fromLTRB(
          MediaQuery.of(context).size.width*0.05,
          0,
          MediaQuery.of(context).size.width*0.05,
          MediaQuery.of(context).size.width*0.08
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(28.0),),
        child: BottomNavigationBar(
            currentIndex:pageNumber,
            onTap: (index)=>switchPage(index),
            elevation: 10,
            items:const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  label:"",
                  icon: FaIcon(FontAwesomeIcons.dashcube,size: 20,)
              ),
              BottomNavigationBarItem(
                  label: "Home",
                  icon: FaIcon(FontAwesomeIcons.calendar,size: 20,)
              ),
              BottomNavigationBarItem(
                  label: "Home",
                  icon: FaIcon(FontAwesomeIcons.feather,size: 20,)
              ),
              BottomNavigationBarItem(
                  label: "",
                  icon: FaIcon(FontAwesomeIcons.userAlt,size: 20,)
              ),
            ]
        ),
      ),
    );
  }
}


