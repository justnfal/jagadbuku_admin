import 'package:flutter/material.dart';
import 'package:jagadbuku_admin/app/modules/components/jagad_log.dart';
import 'package:jagadbuku_admin/app/modules/components/my_button.dart';
import 'package:jagadbuku_admin/app/modules/components/my_button2.dart';
import 'package:jagadbuku_admin/app/modules/components/my_textfield.dart';
import 'package:jagadbuku_admin/app/modules/components/splashlog.dart';
import 'package:jagadbuku_admin/app/modules/components/squere_tile.dart';
import 'package:get/get.dart';
// import 'package:jagadbuku_admin/app/modules/register/views/register_view.dart';

import '../../../routes/app_pages.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);

  void signUserIn(){}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFD0E2E5),
      body : SingleChildScrollView(
          child: Form(
            key: controller.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),

                //logo
                Jagadlog(imagePath: 'lib/app/assets/logo/logo4.2.png'),
                // const Icon(
                //   Icons.lock,
                //   size: 100,
                // ),

                const SizedBox(height: 50),

                //welcome back, you've been missed
                Text(
                  'Sign-In',
                  style: TextStyle(color: Color(0xFF0098DA),
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Masukkan username dan password',
                  style: TextStyle(color: Color(0xFF0098DA),
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 50),
                //Login Form
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Form(
                    child: Column(
                      children: [
                        //username
                        TextFormField(
                          controller: controller.usernameController,
                          decoration: const InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue)
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue)
                              ),
                              labelText: 'username',
                              labelStyle: TextStyle(color: Colors.blue)
                          ),
                          validator: (value) {
                            if (value!.length < 2) {
                              return "username tidak boleh kosong";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 15,),
                        //password
                        TextFormField(
                          controller: controller.passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue)
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue)
                            ),
                            labelText: 'Password',
                            labelStyle: TextStyle(color: Colors.blue),
                            // suffixIcon: IconButton(
                            //   icon: Icon(passwordObsecured ? Icons.visibility_off: Icons.visibility),
                            //   onPressed: (){
                            //     setState(() {
                            //       passwordObsecured = !passwordObsecured;
                            //     });
                            //   },
                            // )
                          ),
                          validator: (value) {
                            if (value!.length < 2) {
                              return "password tidak boleh kosong";
                            }
                            return null;
                          },
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 25),

                //sign in button
                GestureDetector(
                  onTap: () {
                    if (!controller.loading.value) {
                      controller.login();
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(25),
                    margin: const EdgeInsets.symmetric(horizontal: 25),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: controller.loading.value
                          ? CircularProgressIndicator()
                          : Text(
                        "Sign In",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
                // MyButton(
                //   onTap: signUserIn,
                //
                // ),
                const SizedBox(height: 50),

                const SizedBox(height: 50),

                //not a remember? register now
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Text(
                //       'Belum memiliki akun ?',
                //       style: TextStyle(color: Color(0xFF0098DA)),
                //     ),
                //     const SizedBox(width: 4),
                //     InkWell(onTap: ()=>Get.toNamed(Routes.REGISTER),
                //         child: Text("Sign-Up",
                //           style: TextStyle(
                //               color: Color(0xFF00DA16),
                //               fontWeight: FontWeight.bold
                //           ),
                //         )),
                //     // InkWell(
                //     //   onTap: (){
                //     //     Navigator.push(context,
                //     //         MaterialPageRoute(builder: (context)=>RegisterView()));
                //     //   },
                //     //   child: Text(
                //     //     'Sign-Up',
                //     //     style: TextStyle(
                //     //         color: Color(0xFF00DA16),
                //     //         fontWeight: FontWeight.bold
                //     //     ),
                //     //   ),
                //     // ),
                //   ],
                //   // 00DA16
                // ),
              ],
            ),
          )
      ),
    );
  }
}
