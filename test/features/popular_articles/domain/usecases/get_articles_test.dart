import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:ny_times_api_test_flutter/core/error/failures.dart';
import 'package:ny_times_api_test_flutter/features/popular_articles/domain/entities/arcticle.dart';
import 'package:ny_times_api_test_flutter/features/popular_articles/domain/repositories/article_repository.dart';
import 'package:ny_times_api_test_flutter/features/popular_articles/domain/usecases/get_articles.dart';

import 'get_articles_test.mocks.dart';

@GenerateNiceMocks([MockSpec<ArticleRepository>()])
void main() {
  late GetArticles usecase;
  late MockArticleRepository mockArticleRepository;

  setUp(() {
    mockArticleRepository = MockArticleRepository();
    usecase = GetArticles(repository: mockArticleRepository);
  });

  var tArticles = [
    Article(
      uri: "nyt://article/25bfc8fb-0081-5105-a9b7-e8dd8ff991df",
      url:
          "https://www.nytimes.com/2022/11/12/science/cat-talking-owners-voice-dog.html",
      id: 100000008632049,
      assertId: 100000008632049,
      source: "New York Times",
      section: "Science",
      nytdsection: "science",
      byline: "By Anthony Ham",
      title: "Your Cat Might Not Be Ignoring You When You Speak",
      heroImage:
          "https://static01.nyt.com/images/2022/11/10/science/00tb-cats1/00tb-cats1-thumbStandard.jpg",
    )
  ];

  const failure = ServerFailure();

  test('Should get articles from repository', () async {
    // Arrange
    when(mockArticleRepository.getArticles())
        .thenAnswer((_) async =>  Right(tArticles));

    // Act
    var actual = await usecase(const NoParams());

    // Assert
    expect(actual,  Right(tArticles));
    verify(mockArticleRepository.getArticles());
    verifyNoMoreInteractions(mockArticleRepository);
  });

  test('Should get articles from repository', () async {
    // Arrange
    when(mockArticleRepository.getArticles())
        .thenAnswer((_) async =>  Right(tArticles));

    // Act
    var actual = await usecase(const NoParams());

    // Assert
    expect(actual,  Right(tArticles));
    verify(mockArticleRepository.getArticles());
    verifyNoMoreInteractions(mockArticleRepository);
  });
}
