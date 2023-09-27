import 'dart:convert';
import 'dart:developer';

import 'package:crud/src/posts/model/posts_model.dart';
import 'package:http/http.dart' as http;

class PostsRepo {
  static Future<List<PostsModel>> fetchPosts() async {
    var client = http.Client();
    List<PostsModel> posts = [];
    try {
      var response = await client
          .get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

      List result = jsonDecode(response.body);

      for (int i = 0; i < result.length; i++) {
        PostsModel post = PostsModel.fromMap(result[i] as Map<String, dynamic>);
        posts.add(post);
      }

      return posts;
    } catch (e) {
      log(e.toString());
      return [];
    }
  }

  static Future<PostsModel> addPosts({
    required String userId,
    required String title,
    required String body,
}) async {
    var client = http.Client();

    try {
      var response = await client
          .post(Uri.parse('https://jsonplaceholder.typicode.com/posts'),
          body: {
        "title": title,
        "body": body,
        "userId": userId
      });

      if (response.statusCode >= 200 && response.statusCode < 300) {
        Map<String, dynamic> jsonResponse = json.decode(response.body);

        PostsModel postsModel = PostsModel(
          userId: int.parse(jsonResponse['userId'].toString()),
          id: int.parse(jsonResponse['id'].toString()),
          title: jsonResponse['title'].toString(),
          body: jsonResponse['body'].toString(),
        );

        return postsModel;
      } else {
        return PostsModel(body: '', title: '', id: 0, userId: 0);
      }
    } catch (e) {
      log(e.toString());
      return PostsModel(body: '', title: '', id: 0, userId: 0);
    }
  }

  static Future<PostsModel> updatePosts({
    required String id,
    required String userId,
    required String title,
    required String body,
  }) async {
    var client = http.Client();

    try {
      int parsedId = int.parse(id);
      if(parsedId > 100){
        PostsModel postsModel = PostsModel(
          id: parsedId,
          userId: int.parse(userId),
          body: body,
          title: title,

        );
          return postsModel;
      }
      var response = await client
          .put(Uri.parse('https://jsonplaceholder.typicode.com/posts/$id'),
          body: {
            "title": title,
            "body": body,
            "userId": userId
          });

      if (response.statusCode >= 200 && response.statusCode < 300) {
        Map<String, dynamic> jsonResponse = json.decode(response.body);

        PostsModel postsModel = PostsModel(
          userId: int.parse(jsonResponse['userId'].toString()),
          id: int.parse(jsonResponse['id'].toString()),
          title: jsonResponse['title'].toString(),
          body: jsonResponse['body'].toString(),
        );

        return postsModel;
      } else {
        return PostsModel(body: '', title: '', id: 0, userId: 0);
      }
    } catch (e) {
      log(e.toString());
      return PostsModel(body: '', title: '', id: 0, userId: 0);
    }
  }

  static Future<int> deletePosts({
    required String id,
  }) async {
    var client = http.Client();

    try {
      int parsedId = int.parse(id);
      if(parsedId > 100){
        return parsedId;
      }
      var response = await client
          .delete(Uri.parse('https://jsonplaceholder.typicode.com/posts/$id'));

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return parsedId;
      } else {
        return 0;
      }
    } catch (e) {
      log(e.toString());
      return 0;
    }
  }
}