

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../functions.dart';
import 'AuthenticationRepository.dart';
import 'profile_menu.dart';
import 'update_profile.dart';



class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.back(),
            icon:Icon(Icons.navigate_before_rounded)),
        title: Text(General().tProfile, style: Theme.of(context).textTheme.headlineMedium),
        actions: [IconButton(
            onPressed: () {},
            icon: Icon(isDark ? Icons.brightness_6 : Icons.bedtime_sharp))],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          height: General.tDefaultSize(context).height,
          child: Column(
            children: [

              /// -- IMAGE
              Stack(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image(image: AssetImage(General.tProfileImage)))
                    ,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: General.tPrimaryColor),
                      child: Icon(
                        Icons.create_outlined,
                        color: General().redColor,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text(General().tProfileHeading, style: Theme.of(context).textTheme.headlineMedium),
              Text(General().tProfileSubHeading, style: Theme.of(context).textTheme.bodyMedium),
              SizedBox(height: 20),

              /// -- BUTTON
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () => Get.to(() => UpdateProfileScreen()),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: General.tPrimaryColor, side: BorderSide.none, shape: StadiumBorder()),
                  child:  Text(General().tEditProfile, style: TextStyle(color: General.tDarkColor)),
                ),
              ),
              const SizedBox(height: 30),
              const Divider(),
              const SizedBox(height: 10),

              /// -- MENU
              ProfileMenuWidget(title: "Settings", icon: (Icons.settings), onPress: () {}),
              ProfileMenuWidget(title: "Billing Details", icon: (Icons.wallet), onPress: () {}),
              ProfileMenuWidget(title: "User Management", icon: (Icons.manage_accounts_sharp), onPress: () {}),
              Divider(),
              SizedBox(height: 10),
              ProfileMenuWidget(title: "Information", icon: Icons.info, onPress: () {}),
              ProfileMenuWidget(
                  title: "Logout",
                  icon: (Icons.logout),
                  textColor: Colors.black,
                  endIcon: false,
                  onPress: () {
                    Get.defaultDialog(
                      title: "LOGOUT",
                      titleStyle: const TextStyle(fontSize: 20),
                      content: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 15.0),
                        child: Text("Are you sure, you want to Logout?"),
                      ),
                      confirm: Expanded(
                        child: ElevatedButton(
                          onPressed: () => AuthenticationRepository.instance.logout(),
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.purpleAccent, side: BorderSide.none),
                          child: const Text("Yes"),
                        ),
                      ),
                      cancel: OutlinedButton(onPressed: () => Get.back(), child: Text("No")),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}