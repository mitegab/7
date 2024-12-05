import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';
import 'package:client/client.dart';

import 'blocs/feed/feed_bloc.dart';
import 'repositories/post_repository.dart';
import 'screens/feed_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final dependencies = setupDependencies();
  runApp(MyApp(dependencies: dependencies));
}

class Dependencies {
  final PostRepository postRepository;

  Dependencies({required this.postRepository});
}

Dependencies setupDependencies() {
  final client = Client('http://localhost:8080/')
    ..connectivityMonitor = FlutterConnectivityMonitor();

  final postRepository = PostRepository(client: client);
  return Dependencies(postRepository: postRepository);
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.dependencies,
  });

  final Dependencies dependencies;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: dependencies.postRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => FeedBloc(postRepository: dependencies.postRepository)
              ..add(const FeedLoadEvent()),
          ),
        ],
        child: MaterialApp(
          title: 'X Clone with Flutter and Serverpod',
          theme: _buildAppTheme(),
          initialRoute: '/feed',
          routes: {
            '/feed': (context) => const FeedScreen(),
          },
        ),
      ),
    );
  }

  ThemeData _buildAppTheme() {
    return ThemeData(
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: Color(0xFFe3e2e6),
      ),
      colorScheme: SeedColorScheme.fromSeeds(
        brightness: Brightness.dark,
        primaryKey: const Color(0xFF4A98E9),
        secondaryKey: const Color(0xFF000000),
        tones: FlexTones.vivid(Brightness.dark),
      ),
      useMaterial3: true,
    );
  }
}
