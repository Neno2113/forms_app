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


class _RegisterForm extends StatelessWidget {
  const _RegisterForm();

  @override
  Widget build(BuildContext context) {
    final registerCubit = context.watch<RegisterCubit>();
    final userName = registerCubit.state.userName;
    final password = registerCubit.state.password;
    final email = registerCubit.state.email;


    return Form(
      child: Column(
        children: [

          CustomTextFormField(
            label: 'Nombre de Usuario',
            onChange: registerCubit.userNameChanged,
            errorMessage: userName.errorMessage,
          ),

          const SizedBox(height: 10,),

          CustomTextFormField(
            label: 'Correo electronico',
            onChange: registerCubit.emailChanged,
            errorMessage: email.errorMessage,
          ),
          const SizedBox(height: 10,),

          CustomTextFormField(
            label: 'Password',
            onChange: registerCubit.passwordChanged,
            obscureText: true,
            errorMessage: password.errorMessage,
          ),


          const SizedBox(height: 20,),

          FilledButton.tonalIcon(
            onPressed: () {
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