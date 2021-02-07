import 'dart:convert';
import 'package:crypto/crypto.dart';

class API {
  static String publicKey ="b4307c53b57550d1f534898e32c84e6b";
  static String privateKey ="e4714e5cbd33d703f5123aad07c652620c401278";
  static String urlFinal;
  var url = "http://gateway.marvel.com/v1/public/";
  var timeStamp = DateTime.now().millisecondsSinceEpoch.toString();
  var hash;

  String generateMd5(String input){
    return md5.convert(utf8.encode(input)).toString();
  }
  gerarHash(){
    hash = generateMd5(timeStamp + privateKey +  publicKey);
  }

  String gerarURL(String assunto){
    gerarHash();
    urlFinal = "$url$assunto?ts=$timeStamp&apikey=$publicKey&hash=$hash";
    print(urlFinal);
    return urlFinal;
  }
}


