import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart%20%20';
import 'package:forms_app/presentation/blocs/register/register_cubit.dart';
import 'package:forms_app/presentation/widgets/widgets.dart';


class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nuevo Usuarios'),
      ),
      body: BlocProvider(
        create: (context) => RegisterCubit(),
        child: const _RegisterView(),
      ) ,
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

  @override
  Widget build(BuildContext context) {
    final registerCubit = context.watch<RegisterCubit>();


    return Form(
      key: _formKey,
      child: Column(
        children: [

          CustomTextFormField(
            label: 'Nombre de Usuario',
            onChange: ( value ){
              registerCubit.userNameChanged(value);
              _formKey.currentState?.validate();
            },
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
            onChange: ( value ){
              registerCubit.emailChanged(value);
              _formKey.currentState?.validate();
            },
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
            onChange: ( value ){
              registerCubit.passwordChanged(value);
              _formKey.currentState?.validate();
            },
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

              registerCubit.onSubmit();
              // print('$userName, $email, $password');
            }, 
            icon: const Icon(Icons.save),
            label: const Text('Crear Usuario')
          ),

        ],
      ) 

    );
  }
}