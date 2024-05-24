import 'package:teslo_app/features/auth/domain/domain.dart';
import 'package:teslo_app/features/auth/infrastructure/infrastructure.dart';

class AuthRepositoryImpl extends AuthRepository{

  final AuthDataSource dataSource;
  AuthRepositoryImpl(
    AuthDataSource? dataSource
  ) : dataSource = dataSource ?? AuthDataSourceImpl();

  @override
  Future<User> checkAuthStatus(String token) {
    return dataSource.checkAuthStatus(token);
  }

  @override
  Future<User> login(String email, String password) {
    return dataSource.login(email, password);
  }

  @override
  Future<User> register(String name, String email, String password) {
    return dataSource.register(name, email, password);
  }

}