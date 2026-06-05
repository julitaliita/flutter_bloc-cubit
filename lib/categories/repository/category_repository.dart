import 'dart:convert';

import 'package:http/http.dart' as http;
import '../models/category_model.dart';

class CategoryRepository {
  final http.Client httpClient;

  CategoryRepository({
    required this.httpClient,
  });

  static const String baseUrl =
      'https://api.ppb.widiarrohman.my.id/api/categories';

  // =======================
  // READ
  // =======================
  Future<List<CategoryModel>> getCategories({
    required String token,
  }) async {
    var response = await httpClient.get(
      Uri.parse(baseUrl),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    print(
      "STATUS CODE : ${response.statusCode}",
    );
    print(
      "BODY : ${response.body}",
    );

    if (response.statusCode == 200) {
      final json =
          jsonDecode(response.body);

      // CEK DATA PERTAMA
      print(
        "DATA PERTAMA : ${json['data'][0]}",
      );

      final List data =
          json['data'];

      return data
          .map(
            (e) =>
                CategoryModel.fromJson(e),
          )
          .toList();
    }

    throw Exception(
      'Gagal mengambil category',
    );
  }

  // =======================
  // CREATE
  // =======================
  Future<CategoryModel> createCategory({
    required String token,
    required String name,
    required String description,
  }) async {
    final response = await httpClient.post(
      Uri.parse(baseUrl),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type':
            'application/json',
      },
      body: jsonEncode({
        "data": {
          "name": name,
          "description":
              description,
        }
      }),
    );

    print(
      "CREATE STATUS : ${response.statusCode}",
    );
    print(
      "CREATE BODY : ${response.body}",
    );

    if (response.statusCode == 200 ||
        response.statusCode == 201) {
      final json =
          jsonDecode(response.body);

      return CategoryModel.fromJson(
        json['data'],
      );
    }

    throw Exception(
      'Gagal membuat category',
    );
  }

  // =======================
  // UPDATE
  // =======================
  Future<CategoryModel> updateCategory({
    required String token,
    required int id,
    required String name,
    required String description,
  }) async {
    final response = await httpClient.put(
      Uri.parse('$baseUrl/$id'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type':
            'application/json',
      },
      body: jsonEncode({
        "data": {
          "name": name,
          "description":
              description,
        }
      }),
    );

    print(
      "UPDATE STATUS : ${response.statusCode}",
    );
    print(
      "UPDATE BODY : ${response.body}",
    );

    if (response.statusCode == 200) {
      final json =
          jsonDecode(response.body);

      return CategoryModel.fromJson(
        json['data'],
      );
    }

    throw Exception(
      'Gagal update category',
    );
  }

  // =======================
  // DELETE
  // =======================
  Future<void> deleteCategory({
    required String token,
    required String documentId,
  }) async {
    final response =
        await httpClient.delete(
      Uri.parse(
        '$baseUrl/$documentId',
      ),
      headers: {
        'Authorization':
            'Bearer $token',
      },
    );

    print(
      "DELETE STATUS : ${response.statusCode}",
    );
    print(
      "DELETE BODY : ${response.body}",
    );

    if (response.statusCode != 200) {
      throw Exception(
        'Gagal hapus category',
      );
    }
  }
}