import 'package:flutter/material.dart';

class General{
  final redColor=Colors.black;
  final tProfile='my profile';
  static tDefaultSize(BuildContext context){
    Size size=MediaQuery.of(context).size;
    return size;
  }
  //Color tPrimaryColor=Colors.purpleAccent;
  final tPassword='password';
  final tPhoneNo='07xxxxxxxx';
  final tEmail='joe@gmail.com';
  final tEditProfile='edit profile';
  //Color tDarkColor = Colors.black;
  final tProfileHeading= 'profile heading';
  final tProfileSubHeading='Profile SubHeading';

  static const Color tPrimaryColor = Colors.purpleAccent;
  static const Color tDarkColor = Colors.black;
  static const Color tAccentColor = Colors.black;
  //static const String tProfileImage = 'assets/images/default_profile.png';
  static const tProfileImage = 'assets/images/avator_image.jpg';
  final String tFullName='Full Name';
  final tJoined='';
  final tJoinedAt='';
  final GetJoined='';
  final tDelete='Delete';
  static const double tFormHeight = 20.0;
}