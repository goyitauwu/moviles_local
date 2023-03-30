import 'package:flutter/material.dart';
import 'package:pmsna1/firebase/firebase_auth.dart';
import 'package:pmsna1/widgets/loading_modal_widget.dart';
import 'package:social_login_buttons/social_login_buttons.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool isLoading = false;
  EmailAuth emailAuth = EmailAuth();

  TextEditingController c_email = TextEditingController();
  TextEditingController c_password = TextEditingController();

  final spaceHorizontal = SizedBox(height: 10,);

  

  final btnGoogle = SocialLoginButton(
    buttonType: SocialLoginButtonType.google, 
    onPressed: () {},
  );

  final btnFacebook = SocialLoginButton(
    buttonType: SocialLoginButtonType.facebook, 
    onPressed: (){}
  );

  final btnGitHub = SocialLoginButton(
    buttonType: SocialLoginButtonType.github, 
    onPressed: (){}
  );

  final imgLogo = Image.asset('assets/logo_itc.png', height: 200,);

  @override
  Widget build(BuildContext context) {
    final txtEmail = TextFormField(
    controller: c_email,
    decoration: const InputDecoration(
      label: Text('Email User'),
      border: OutlineInputBorder()
    ),
  );

  final txtPass  = TextFormField(
    controller: c_password,
    decoration: const InputDecoration(
      label: Text('Password User'),
      border: OutlineInputBorder()
    ),
  );

    final txtRegister = Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: TextButton(
        onPressed: () {
          Navigator.pushNamed(context, '/register');
        }, 
        child: const Text('Crear cuenta :)', 
          style: TextStyle( fontSize: 18, 
          decoration: TextDecoration.underline)
        ),
      ),
    );

    final btnEmail = SocialLoginButton(
      buttonType: SocialLoginButtonType.generalLogin, 
      onPressed: () {
        isLoading = true;
        setState(() {});
        //Future.delayed(Duration(milliseconds: 4000)).then((value){
          emailAuth.signInWithEmailAndPassword(email: c_email.text, password: c_password.text).then((value){
            if (value) {
              Navigator.pushNamed(context, '/dash');
            }else{
              //SnackBar error
            }
          });
          isLoading = false;
          setState(() {});
          Navigator.pushNamed(context, '/dash');
        });
      /*},
    );*/

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                opacity: .4,
                fit: BoxFit.cover,
                image: AssetImage('assets/fondo_itcelaya.jpeg')
              )
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      txtEmail,
                      spaceHorizontal,
                      txtPass,
                      spaceHorizontal,
                      btnEmail,
                      spaceHorizontal,
                      btnGoogle,
                      spaceHorizontal,
                      btnFacebook,
                      spaceHorizontal,
                      btnGitHub,
                      spaceHorizontal,
                      txtRegister
                    ],
                  ),
                  Positioned(
                    top: 100,
                    child: imgLogo,
                  )
                ],
              ),
            ),
          ),
          isLoading ? const LoadingModalWidget() : Container()
        ],
      ),
    );
  }
}