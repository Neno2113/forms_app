import 'package:flutter/material.dart';
import 'package:forms_app/presentation/widgets/widgets.dart';


class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nuevo Usuarios'),
      ),
      body: const _RegisterView() ,
    );
  }
}


class _RegisterView extends StatelessWidget {
  const _RegisterView();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10 ),
        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.end,
            children: const [
              
              FlutterLogo(size: 100,),

              _RegisterForm(),
    
              SizedBox(height: 20,)
            ],
          ),
        ),
      ),
    );
  }
}


class _RegisterForm extends StatefulWidget {
  const _RegisterForm();

  @override
  State<_RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<_RegisterForm> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String userName = '';
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [

          CustomTextFormField(
            label: 'Nombre de Usuario',
            onChange: (value) => userName = value,
            validator: (value) {
                if( value == null || value.isEmpty ) return 'Campo requerido';
                if( value.trim().isEmpty ) return 'Campo requerido';
                if( value.length < 3  ) return 'El usuario debe tener mas de 6 letras';
                return null;
            },
          ),
          const SizedBox(height: 10,),
          CustomTextFormField(
            label: 'Correo electronico',
            onChange: (value) => email = value,
              validator: (value) {
                if( value == null || value.isEmpty ) return 'Campo requerido';
                if( value.trim().isEmpty ) return 'Campo requerido';
                final emailRegExp = RegExp(
                  r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                );

                if( !emailRegExp.hasMatch(value) ) return 'Debe digitar un correo';

                return null;
            },
          ),
          const SizedBox(height: 10,),

          CustomTextFormField(
            label: 'Password',
            onChange: (value) => password = value,
            obscureText: true,
              validator: (value) {
                if( value == null || value.isEmpty ) return 'Campo requerido';
                if( value.trim().isEmpty ) return 'Campo requerido';
                if( value.length < 6  ) return 'El usuario debe tener mas de 6 letras';
                return null;
            },
          ),


          const SizedBox(height: 20,),

          FilledButton.tonalIcon(
            onPressed: () {

              final isValid = _formKey.currentState!.validate();
              if( !isValid ) return;

              print('$userName, $email, $password');
            }, 
            icon: const Icon(Icons.save),
            label: const Text('Crear Usuario')
          ),

        ],
      ) 

    );
  }
}