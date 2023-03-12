import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:forms_app/infrastructure/inputs/inputs.dart';
import 'package:formz/formz.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterFormState> {
  RegisterCubit() : super(const RegisterFormState());

  void onSubmit(){
    emit(
      state.copyWith(
        formStatus: FormStatus.validating,
        userName: UserName.dirty( state.userName.value ),
        password: Password.dirty( state.password.value ),
        email: Email.dirty( state.email.value ),

        isValid: Formz.validate([ 
          state.userName, 
          state.password ,
          state.email,
        ])
      )
    );

    print('Cubit Submit: $state');
  }

  void userNameChanged( String value ){
    final userName = UserName.dirty(value);

    emit(
      state.copyWith(
        userName: userName,
        isValid: Formz.validate([ userName, state.password, state.email])
       )
    );
  }
  void emailChanged( String value ){
    final email = Email.dirty(value);
    emit(
      state.copyWith(
        email: email,
        isValid: Formz.validate([ email, state.userName, state.password ])

       )
    );
  }
  void passwordChanged( String value ){
    final password = Password.dirty(value);
    emit(
      state.copyWith(
        password: password,
        isValid: Formz.validate([ state.userName, password, state.email])
       )
    );
  }
}
