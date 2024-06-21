import 'package:go_router/go_router.dart';
import 'package:teslo_app/features/auth/auth.dart';
import 'package:teslo_app/features/products/products.dart';

final appRouter = GoRouter(
  initialLocation: '/splash',
  routes: [

    //* Primera Pantalla
    GoRoute(  
      path: '/splash',
      builder: (context, state) => const CheckAuthStatusScreen(),
    ),
    //* Auth Routes
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    //*Register Routes
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),
    //*Product Routes
    GoRoute(
      path: '/products',
      builder: (context, state) => const ProductsScreen(),
    ),
  ]
  //! TODO: Bloquear si no se está autenticado de alguna manera
);