import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:time_to_pray/Screens/main_home.dart';
import 'package:time_to_pray/components/database.dart';
import '../signup/signup_screen.dart';

class MyLoginScreen extends StatefulWidget {
  const MyLoginScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MyLoginScreenState createState() => _MyLoginScreenState();
}

class _MyLoginScreenState extends State<MyLoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool passHide = true;
  bool isload = false;

  loginUser() async {
    setState(() {
      isload = true;
    });
    if (_formKey.currentState!.validate()) {
      String res = await Database()
          .login(_emailController.text, _passwordController.text);
      if (res == "success") {
        setState(() {
          isload = false;
        });
        Fluttertoast.showToast(msg: "User Login Successfuly");

        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const MyHomePage()));
      } else {
        setState(() {
          isload = false;
        });
        Fluttertoast.showToast(msg: res.toString());
      }
    } else {
      Fluttertoast.showToast(msg: "Invalid");
      setState(() {
        isload = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage(
              'assets/images/m11.jpeg',
            ),
            fit: BoxFit.fill),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(),
            Container(
              padding: const EdgeInsets.only(left: 25, top: 135),
              // child: const Text(
              //   'Welcome To\n     Time To Pray',
              //   style: TextStyle(
              //       color: Colors.white,
              //       fontWeight: FontWeight.w600,
              //       fontSize: 33),
              // ),
            ),
            SingleChildScrollView(
              child: isload
                  ? Container(
                      height: 500,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Colors.blueGrey,
                          strokeWidth: 6.0,
                        ),
                      ),
                    )
                  : Container(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 35, right: 35),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  TextFormField(
                                    controller: _emailController,
                                    style: const TextStyle(color: Colors.black),
                                    decoration: InputDecoration(
                                        fillColor: Colors.grey.shade100,
                                        filled: true,
                                        hintText: "Email",
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        )),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "required email";
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  TextFormField(
                                    controller: _passwordController,
                                    style: const TextStyle(),
                                    obscureText: true,
                                    decoration: InputDecoration(
                                        fillColor: Colors.grey.shade100,
                                        filled: true,
                                        hintText: "Password",
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        )),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "required password";
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 40,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'Sign in',
                                        style: TextStyle(
                                            fontSize: 27,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      CircleAvatar(
                                        radius: 30,
                                        backgroundColor:
                                            const Color(0xff4c505b),
                                        child: IconButton(
                                            color: Colors.white,
                                            onPressed: () {
                                              loginUser();
                                            },
                                            icon: const Icon(
                                              Icons.arrow_forward,
                                            )),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 40,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const MySignUpScreen()));
                                        },
                                        // ignore: sort_child_properties_last
                                        child: const Text(
                                          'Sign Up',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              decoration:
                                                  TextDecoration.underline,
                                              color: Color(0xff4c505b),
                                              fontSize: 18),
                                        ),
                                        style: const ButtonStyle(),
                                      ),
                                      TextButton(
                                          onPressed: () {
                                            Navigator.of(context)
                                                .pushReplacement(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const MyHomePage()));
                                          },
                                          child: const Text(
                                            'Log IN As Demo',
                                            style: TextStyle(
                                              decoration:
                                                  TextDecoration.underline,
                                              color: Color(0xff4c505b),
                                              fontSize: 18,
                                            ),
                                          )),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
