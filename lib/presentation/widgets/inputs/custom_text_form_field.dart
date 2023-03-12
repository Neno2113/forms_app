import 'package:flutter/material.dart';



class CustomTextFormField extends StatelessWidget {

  final String? label;
  final String? hint;
  final String? errorMessage;
  final Function(String)? onChange;
  final String? Function(String?)? validator;
  final bool? obscureText;

  const CustomTextFormField({
    super.key, 
    this.label, 
    this.hint, 
    this.errorMessage, 
    this.onChange, 
    this.validator, 
    this.obscureText
  });

  @override
  Widget build(BuildContext context) {

    final colors = Theme.of(context).colorScheme;

    final border = OutlineInputBorder(
      // borderSide: BorderSide(color: colors.primary),
      borderRadius: BorderRadius.circular(40)
    );

    return TextFormField(
      onChanged: onChange,
      validator: validator,
      obscureText: obscureText != null ? obscureText! : false ,
      decoration: InputDecoration(
        enabledBorder: border,
        focusedBorder: border.copyWith( borderSide: BorderSide( color: colors.primary )),
        errorBorder: border.copyWith( borderSide: BorderSide( color: Colors.red.shade800 )),
        focusedErrorBorder: border.copyWith( borderSide: BorderSide( color: Colors.red.shade800 )),

        isDense: true,
        label: label != null ? Text( label!) : null,
        hintText: hint,
        focusColor: colors.primary,
        errorText: errorMessage //'Algo mal sucedio' 
        // icon: Icon(Icons.supervised_user_circle, color: colors.primary),
        // prefixIcon: Icon(Icons.supervised_user_circle, color: colors.primary),
        // suffixIcon: Icon(Icons.supervised_user_circle, color: colors.primary,)
      ),
    );
  }
}