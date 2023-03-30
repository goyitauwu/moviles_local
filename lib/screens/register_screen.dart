import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  

  String selectedImagePath = '';

  final _textCorreo = TextEditingController();
  final _textNombre = TextEditingController();
  final _textPsswd = TextEditingController();
  bool _validateC = false;
  bool _validateN = false;
  bool _validateP = false;
  bool _validateF = false;
 
  @override
  void dispose() {
    _textNombre.dispose();
    _textCorreo.dispose();
    _textPsswd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    const spaceHorizontal = SizedBox(height: 10,);

    final txtNombre = TextFormField(
      controller: _textNombre,
      decoration: InputDecoration(
      label: Text('Introduce tu nombre'),
      errorText: _validateN ? 'El campo no puede ser vacio' : null,
      border: OutlineInputBorder()
      ),
    );

    final txtCorreo = TextFormField(
      controller: _textCorreo,
      decoration: InputDecoration(
      label: Text('Introduce tu correo'),
      errorText: _validateC ? 'El campo no puede ser vacio' : _validateF ? 'El formato de correo es incorrecto': null,
      border: OutlineInputBorder()
      ),
    );



    final txtPsswd = TextFormField(
      obscureText: true,
      controller: _textPsswd,
      decoration: InputDecoration(
      label: Text('Aquí pon una contraseña'),
      errorText: _validateP ? 'El campo no debe ser vacio' :  null,
      border: OutlineInputBorder()
      ),
    );

    
    final btnContinuar = FilledButton.tonal(child: const Text('Registrarse'),
       
      onPressed: () {
        setState(() {
          _textNombre.text.isEmpty ? _validateN = true : _validateN = false;
          _textCorreo.text.isEmpty ? _validateC = true : _validateC = false; 
          _textPsswd.text.isEmpty ? _validateP = true : _validateP = false;
          
          !_textCorreo.text.contains('@') ? _validateF = true : _validateF = false;
        
      });
    },);
    
    //final btnRegresar = FilledButton(child: const Text('Regresar'), onPressed: ()=> Get.to(LoginScreen));

    final btnImg = ElevatedButton(onPressed: () async {
      selectImage();
      setState(() {});
      },
      child: const Text('Seleccionar Imagen')
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                  opacity: 1,
                  fit: BoxFit.cover,
                  image: AssetImage('assets/fondo1.jpg')
                )
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Column(              
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      selectedImagePath == ''
                      ? Image.asset('assets/user.png', height: 200, width: 200, fit: BoxFit.fill,)
                      : Image.file(File(selectedImagePath), height: 200, width: 200, fit: BoxFit.fill,),
                      spaceHorizontal,
                      btnImg,
                      spaceHorizontal,
                      txtNombre,
                      spaceHorizontal,
                      txtCorreo,
                      spaceHorizontal,
                      txtPsswd,
                      spaceHorizontal,
                      btnContinuar,
                      spaceHorizontal,
                      //btnRegresar
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      )
  ); 
  }
  
  Future selectImage() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0)
          ),
          child: Container(
            height: 150,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Text('Selecciona una imagen',
                    style: TextStyle(
                      fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          selectedImagePath = await selectImageFromGallery();
                          print('Image_Path:-');
                          print(selectedImagePath);
                          if (selectedImagePath != '') {
                            Navigator.pop(context);
                            setState(() {});
                          } else {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text('No se selecciono imagen :('),
                                )
                              );
                            }
                        },
                        child: Card(
                          elevation: 5,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Image.asset('assets/gallery.png',
                                  height: 60,
                                  width: 60,
                                ),
                                Text('Galeria'),
                              ],
                            ),
                          )
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          selectedImagePath = await selectImageFromCamera();
                          print('Image_Path:-');
                          print(selectedImagePath);

                          if (selectedImagePath != '') {
                            Navigator.pop(context);
                            setState(() {});
                          } else {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text('No se tomo la foto :('),
                              )
                            );
                          }
                        },
                        child: Card(
                          elevation: 5,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Image.asset('assets/camera.png',
                                height: 60,
                                width: 60,
                                ),
                                Text('Camara'),
                              ],
                            ),
                          )
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      }
    );
  }
  
  selectImageFromGallery() async {
    XFile? file = await ImagePicker()
      .pickImage(source: ImageSource.gallery, imageQuality: 10);
    if (file != null) {
      return file.path;
    } else {
      return '';
    }
  }

  selectImageFromCamera() async {
    XFile? file = await ImagePicker()
      .pickImage(source: ImageSource.camera, imageQuality: 10);
    if (file != null) {
      return file.path;
    } else {
      return '';
    }
  }
  
}
