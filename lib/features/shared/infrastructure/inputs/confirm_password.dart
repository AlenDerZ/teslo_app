import 'package:formz/formz.dart';

// Define input validation errors
enum ConfirmPasswordError { empty, notMatch }

// Extend FormzInput and provide the input type and error type.
class ConfirmPassword extends FormzInput<String, ConfirmPasswordError> {


  static final RegExp passwordRegExp = RegExp(
    r'(?:(?=.*\d)|(?=.*\W+))(?![.\n])(?=.*[A-Z])(?=.*[a-z]).*$',
  );

  // Call super.pure to represent an unmodified form input.
  const ConfirmPassword.pure({ this.password = '' }) : super.pure('');

  // Call super.dirty to represent a modified form input.
  const ConfirmPassword.dirty({ required this.password, String value = '' }) : super.dirty(value);


  String? get errorMessage {
    if ( isValid || isPure ) return null;

    if ( displayError == ConfirmPasswordError.empty) return 'El campo es requerido';
    if ( displayError == ConfirmPasswordError.notMatch ) return 'Las contraseñas no coinciden';

    return null;
  }

  final String password;
  // Override validator to handle validating a given input value.
  @override
  ConfirmPasswordError? validator(String value) {

    if ( value.isEmpty || value.trim().isEmpty ) return ConfirmPasswordError.empty;
    if ( password != value ) return ConfirmPasswordError.notMatch;

    return null;
  }
}