import 'package:teslo_app/features/auth/domain/entities/user.dart';

abstract class AuthDataSource{

  Future<User> login(String email, String password);
  Future<User> register(String name, String email, String password);
  Future<User> checkAuthStatus(String token);

}