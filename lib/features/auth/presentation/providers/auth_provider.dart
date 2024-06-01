
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_app/features/auth/infrastructure/infrastructure.dart';

import '../../domain/domain.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {

  final authRepository = AuthRepositoryImpl();
  return AuthNotifier(
    authRepository: authRepository
  );
});

class AuthNotifier extends StateNotifier<AuthState> {

  final AuthRepository authRepository;

  AuthNotifier({
    required this.authRepository
  }): super( AuthState() );

  Future<void> loginUser(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 500));

    try{
      final user = await authRepository.login(email, password);
      _setLoggedUser(user);
    }on WrongCredentials{
      logout('Credenciales incorrectas');
    }catch(e){
      logout('Error no controlado');
    }
  }

  void registerUser(String fullName, String email, String password) async {
    // await Future.delayed(const Duration(milliseconds: 500));

    // try{

    // }on {
      
    // }catch(e){

    // }
  }

  void checkAuthStatus() async{

  }

  _setLoggedUser(User user){
    //TODO: Guardar el token en el dispositivo

    state = state.copyWith(
      user: user,
      authStatus: AuthStatus.authenticated,
    );
  }

  Future<void> logout(String? errorMessage) async {
    //TODO: Limpiar el token del dispositivo
    state = state.copyWith(
      user: null,
      authStatus: AuthStatus.notAuthenticated,
      erroMessage: errorMessage
    );
  }
  
}

enum AuthStatus { checking, authenticated, notAuthenticated }
class AuthState{
  final AuthStatus authStatus;
  final User? user;
  final String erroMessage;

  AuthState({
    this.authStatus = AuthStatus.checking, 
    this.user, 
    this.erroMessage = ''
    });

  AuthState copyWith({
    AuthStatus? authStatus,
    User? user,
    String? erroMessage
  }) => AuthState(
    authStatus: authStatus ?? this.authStatus,
    user: user ?? this.user,
    erroMessage: erroMessage ?? this.erroMessage
  );
  
}