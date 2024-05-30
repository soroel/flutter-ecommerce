import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../functions.dart';
import 'profile_controller.dart';




class UpdateProfileScreen extends StatelessWidget {
  const UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () => Get.back(), icon: const Icon(Icons.navigate_before_rounded)),
        title: Text(General().tEditProfile, style: Theme.of(context).textTheme.headlineMedium),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              // -- IMAGE with ICON
              Stack(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image(image: AssetImage(General.tProfileImage))),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(100), color: General.tPrimaryColor),
                      child: Icon(Icons.create_sharp, color: Colors.black, size: 20),

                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50),

              // -- Form Fields
              Form(
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                          label: Text(General().tFullName), prefixIcon: Icon(Icons.account_circle_sharp)),
                    ),
                    SizedBox(height: General.tFormHeight - 20),
                    TextFormField(
                      decoration: InputDecoration(
                          label: Text(General().tEmail), prefixIcon: Icon(Icons.email)),
                    ),
                    SizedBox(height: General.tFormHeight - 20),
                    TextFormField(
                      decoration: InputDecoration(
                          label: Text(General().tPhoneNo), prefixIcon: Icon(Icons.phone)),
                    ),
                    SizedBox(height: General.tFormHeight - 20),
                    TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        label: Text(General().tPassword),
                        prefixIcon: const Icon(Icons.fingerprint),
                        suffixIcon:
                        IconButton(icon: Icon(Icons.visibility_off_sharp), onPressed: () {}),
                      ),
                    ),
                    SizedBox(height: General.tFormHeight),

                    // -- Form Submit Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => Get.to(() => const UpdateProfileScreen()),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: General.tPrimaryColor,
                            side: BorderSide.none,
                            shape: StadiumBorder()),
                        child: Text(General().tEditProfile, style: TextStyle(color: General.tDarkColor)),
                      ),
                    ),
                    SizedBox(height: General.tFormHeight),

                    // -- Created Date and Delete Button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text.rich(
                          TextSpan(
                            text: General().GetJoined,
                            style: TextStyle(fontSize: 12),
                            children: [
                              TextSpan(
                                  text: General().tJoinedAt,
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.purpleAccent.withOpacity(0.1),
                              elevation: 0,
                              foregroundColor: Colors.purple,
                              shape: const StadiumBorder(),
                              side: BorderSide.none),
                          child: Text(General().tDelete),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}