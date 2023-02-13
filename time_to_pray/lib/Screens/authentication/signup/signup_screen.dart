import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:time_to_pray/Screens/authentication/login/login_screen.dart';
import 'package:time_to_pray/components/database.dart';
import '../../main_home.dart';

class MySignUpScreen extends StatefulWidget {
  const MySignUpScreen({Key? key}) : super(key: key);

  @override
  _MySignUpScreenState createState() => _MySignUpScreenState();
}

class _MySignUpScreenState extends State<MySignUpScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _contactNoController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();
  final TextEditingController _cnicController = TextEditingController();
  bool _isLoding = false;
  final _formKey = GlobalKey<FormState>();
  bool key = false;
  bool key2 = false;

  regesteration() async {
    setState(() {
      _isLoding = true;
    });

    if (_formKey.currentState!.validate()) {
      String res = await Database().signUpWithEmailAndPassword(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        contactNo: _contactNoController.text.trim(),
        password: _passwordController.text.trim(),
        cnic: _cnicController.text.trim(),
        status: "normal",
      );
      if (res == "success") {
        setState(() {
          _isLoding = false;
        });
        Fluttertoast.showToast(msg: "Account Created successfully");
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const MyHomePage()));
      } else {
        setState(() {
          _isLoding = false;
        });
        Fluttertoast.showToast(msg: res.toString());
      }
    } else {
      setState(() {
        _isLoding = false;
      });
      Fluttertoast.showToast(msg: "Please fill the required fields");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/m11.jpeg'), fit: BoxFit.cover),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: Stack(
            children: [
              Container(
                padding: const EdgeInsets.only(left: 35, top: 10),
                // child: const Text(
                //   'Create\n    Account',
                //   style: TextStyle(
                //       color: Colors.white,
                //       fontWeight: FontWeight.w600,
                //       fontSize: 33),
                // ),
              ),
              _isLoding
                  ? Container(
                      height: 150,
                      child: const Center(
                          child: CircularProgressIndicator(
                        strokeWidth: 6.0,
                        color: Colors.white,
                      )),
                    )
                  : Container(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.25),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin:
                                  const EdgeInsets.only(left: 35, right: 35),
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    TextFormField(
                                      controller: _nameController,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white),
                                      decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                              color: Colors.white,
                                              width: 2.0,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                              color: Colors.black,
                                            ),
                                          ),
                                          hintText: "Name",
                                          hintStyle: const TextStyle(
                                              color: Colors.white),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          )),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "required field";
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      controller: _emailController,
                                      keyboardType: TextInputType.emailAddress,
                                      style:
                                          const TextStyle(color: Colors.white),
                                      decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                              color: Colors.white,
                                              width: 2.0,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                              color: Colors.black,
                                            ),
                                          ),
                                          hintText: "Email",
                                          hintStyle: const TextStyle(
                                              color: Colors.white),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          )),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "required field";
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      controller: _contactNoController,
                                      keyboardType: TextInputType.number,
                                      style:
                                          const TextStyle(color: Colors.white),
                                      decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                              color: Colors.white,
                                              width: 2.0,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                              color: Colors.black,
                                            ),
                                          ),
                                          hintText: "Contact No",
                                          hintStyle: const TextStyle(
                                              color: Colors.white),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          )),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "required field";
                                        } else if (value.length != 11) {
                                          return "Incorrect Number";
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      controller: _cnicController,
                                      keyboardType: TextInputType.number,
                                      style:
                                          const TextStyle(color: Colors.white),
                                      decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                              color: Colors.white,
                                              width: 2.0,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                              color: Colors.black,
                                            ),
                                          ),
                                          hintText: "Cnic No",
                                          hintStyle: const TextStyle(
                                              color: Colors.white),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          )),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "required field";
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      controller: _passwordController,
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      style:
                                          const TextStyle(color: Colors.white),
                                      obscureText: key,
                                      decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                              width: 2.0,
                                              color: Colors.white,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                              color: Colors.black,
                                            ),
                                          ),
                                          suffixIcon: IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  key = !key;
                                                });
                                              },
                                              icon: key
                                                  ? Icon(Icons.visibility)
                                                  : Icon(Icons.visibility_off)),
                                          hintText: "Password",
                                          hintStyle: const TextStyle(
                                              color: Colors.white),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          )),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "required field";
                                        } else if (value.length <= 7) {
                                          return "password must be 8 character or more";
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      controller: _confirmController,
                                      style:
                                          const TextStyle(color: Colors.white),
                                      obscureText: key2,
                                      decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                              width: 2.0,
                                              color: Colors.white,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                              color: Colors.black,
                                            ),
                                          ),
                                          suffixIcon: IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  key2 = !key2;
                                                });
                                              },
                                              icon: key
                                                  ? Icon(Icons.visibility)
                                                  : Icon(Icons.visibility_off)),
                                          hintText: "Confirm-Password",
                                          hintStyle: const TextStyle(
                                              color: Colors.white),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          )),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "required field";
                                        } else if (_confirmController.text !=
                                            _passwordController.text) {
                                          return "pasword not match!";
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'Sign Up',
                                          style: TextStyle(
                                              color: Colors.black,
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
                                                regesteration();
                                              },
                                              icon: const Icon(
                                                Icons.arrow_forward,
                                              )),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pushReplacement(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const MyLoginScreen()));
                                          },
                                          child: const Text(
                                            'Sign In',
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                decoration:
                                                    TextDecoration.underline,
                                                color: Colors.black,
                                                fontSize: 18),
                                          ),
                                          style: const ButtonStyle(),
                                        ),
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
      ),
    );
  }
}
