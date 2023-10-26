import 'package:googleapis/drive/v3.dart' as drive;
import 'package:googleapis_auth/auth_io.dart';
import 'dart:io';

class GoogleDriveApi {
  static const _credentials = r'''
    {
      "type": "service_account",
      "project_id": "teste-27052004",
      "private_key_id": "470753843370e56ae84ee1e87b76f288d41a55cc",
      "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCaL34JdC4euiYv\nBxXOTxhqhflHLPzR9AYG4m+lDK2Gp2uZUu7DB1SbTEbQgGvzxhhClQKqsCpWF8fA\ng5GqnTazD4OFXgFahpkXou4y40IjG+/7mYb5ZDXt0gliQ09aUXCFNvyUpjXTtzod\nt3vVblhmcKl+x7pO5heqIp16A2u4tXmtPRSSM4Gp91bvDe1ij9Hc6VxcHqPnei3i\nK75puou7fYh4yUNoxuWd0gAueymyje5/YQac/pgSbZfziPKuL0w7gP/8JNb72A/P\nLxnSxa9EV7HwxJSOL4qUpuHl4HFEXsJUn+ZkygYZquWCDUKH3ndbblglPgk646zc\nclt1wcdTAgMBAAECggEABy2M1Y3WE9IgsvHGfxtJjLP9/eVHQ9LzcOCbx/hGH82t\nga7NtMCjnLM5XL2NyQSA3qCnRiD7Z5Sl1P2LC4FUKZPgUJYmw/seJ26LXk0cKBxF\n2NW15ehXZmHv0+ZETHUcIueDbLwsJ1YRW47OMgp4DRTTnzZXIxMtKNuBr0t3eVrO\n9qC96F0u6i1uFWuiXDEkhUTnvczTn0/7o6TfC3EhMIiKoQtaTwlSnha5Yfjy6L2R\n2ITGMlm47JvuJshHHb+MLzM+mtnW37hml6xqgbYXsGUjThuszkqeQnY3RESBuvvB\nZAWTU+I9oxLLAcN/e4fN47zqXiYWahZjQFsZe44/mQKBgQDIDn/FHmxJv6BhgraW\nH0EDaVIRbm3w+jdp6CIVoAi2oqs93GMgncXu3xIatDkyxoFC7A4OdG7eu5DpqXqh\nHvuyaVqOS9Elcmypx+UY8Vy7rlXDnOExLsoK5QGyECyXWa6Suqx58tZiRSfCqQTJ\nJfWzXJe4jacJN5kXWEPZyJEtDwKBgQDFTTTqq9IE3qXPLJh4lqtLxh6iN2WRGcO8\nCW8LhSDJzDyr+krWJz+WYqzPWgJ0+fAXuV2mQTyiEbwlICZ+ByH8bsS1ekDr45iu\nmgqjez62dfg5EW+FGyUDE9/G05+2t/e6Jn9vV+STsZImEs13iLvsj5gamCOUrmTn\nAu+BiaLJfQKBgQCh+QM/0HryVuD+Mfusng9gOLSGgncnBR86cwStp42GeTvV8Qqd\nDMCFvzwEPOiWkJt1WHOlBmYBlbElTd+IdfJpJ912mjHydKs/5yU4xapEFklAAFNf\nI7fXjESMK4Y+4BB0ogklDxS+KamgdIH4bfB5UL1SYfXcg5RCj2cX+8h2xwKBgQC4\nWapu9rpWqH5+9GlGi2lkdKqc4Wv6RvuXj6z9M5fuVfH+svAH50ZHys0zNSQEjqBi\nWmYBeQUhXbbRbZfpu9pqlkkgVCmi/tbjlbUJCZgQPmv/TqZH1ZQgqwo1Kfkabgx/\nF4eMzrAZvBoVjw4CeXU11PnHJ45fVw+atih5fdPntQKBgBIkoyF9G76WP/3w6PQq\nTXVUqpTUUSkWX7VnYMVEwJnWGrNpNl+t11ygw4c8lVDvFDrkLpYIjcDzsU/PZaIP\n9lzX80o1yNQgoeWSkRxFAAuPrHanShVwrgjsxmgp1mSeOsS2e/ocQHK9XCbbZ/pK\nr/0nAQQVnJhh0y6a69s00qwV\n-----END PRIVATE KEY-----\n",
      "client_email": "teste-2705@teste-27052004.iam.gserviceaccount.com",
      "client_id": "107960912260478492754",
      "auth_uri": "https://accounts.google.com/o/oauth2/auth",
      "token_uri": "https://oauth2.googleapis.com/token",
      "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
      "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/teste-2705%40teste-27052004.iam.gserviceaccount.com",
      "universe_domain": "googleapis.com"
    }
  ''';
  static const _folderId = "18O5yuNSPwUn3m67MKzNkrov0Q1qTWo2f";

  static Future<String> uploadVideoAndGetLink(String videoFileName) async {
    final credentials = ServiceAccountCredentials.fromJson(_credentials);
    final client = await clientViaServiceAccount(credentials, [drive.DriveApi.driveFileScope]);
    final drive.DriveApi driveApi = drive.DriveApi(client);

    try {
      var videoFile = File(videoFileName);
      var file = drive.File();
      file.parents = [_folderId];
      file.name = videoFile.path.split('/').last;

      var response = await driveApi.files.create(file, uploadMedia: drive.Media(videoFile.openRead(), videoFile.lengthSync()));

      print("Arquivo enviado com sucesso. ID: ${response.id}");
      return "https://drive.google.com/file/d/${response.id}/view";
    } catch (e) {
      print('Erro ao fazer o upload do arquivo de vídeo: $e');
      return '';
    } finally {
      client.close();
    }
  }
}
