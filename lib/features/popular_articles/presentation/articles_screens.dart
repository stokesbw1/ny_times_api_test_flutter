import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ny_times_api_test_flutter/core/utils/show_toast.dart';
import 'package:ny_times_api_test_flutter/features/popular_articles/presentation/cubit/article_cubit.dart';
import 'package:ny_times_api_test_flutter/features/popular_articles/presentation/widgets/article_item.dart';
import 'package:ny_times_api_test_flutter/injection_container.dart';

class ArticlesScreen extends StatelessWidget {
  final ShowToast showToast;

  const ArticlesScreen({Key? key, required this.showToast}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ArticleCubit>(
        create: (context) => sl(),
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'NY Times Articles',
              style: GoogleFonts.poppins(
                textStyle: Theme.of(context).textTheme.displayMedium,
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
            ),
            elevation: 0,
            backgroundColor: const Color(0xff47e4c1), // appbar color.
          ),
          body: BlocListener<ArticleCubit, ArticleState>(
            listener: (context, state) {
              if (state is ArticleInitial) {
                context.read<ArticleCubit>().getArticles();
              }

              if (state is ArticleErrorLoadingBrowser) {
                showToast.showToast(message: " Could not launch ${state.url}");
              }
            },
            child: BlocBuilder<ArticleCubit, ArticleState>(
              builder: (context, state) {
                if (state is ArticleInitial) {
                  context.read<ArticleCubit>().getArticles();
                }
                if (state is ArticleLoading || state is ArticleInitial) {
                  return const Center(
                    child: Text("Loading..."),
                  );
                }
                if (state is ArticleError) {
                  return const Center(
                    child: Text("Reload"),
                  );
                }

                var successState = state as ArticleSuccess;

                return ListView.builder(
                  itemCount: successState.articles.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        context.read<ArticleCubit>().launchArticleInBrowser(
                            url: successState.articles[index].url);
                      },
                      child:  ArticleItem(article: successState.articles[index], isConnected: successState.isConnected),);
                  },
                );
              },
            ),
          ),
        ));
  }
}
