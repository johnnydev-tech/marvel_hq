import 'dart:convert';
import 'package:crypto/crypto.dart';

class API {
  //Substitua a publicKEy por sua Chave gerada
  static String publicKey ="x";
    //Substitua a privateKey por sua Chave gerada
  static String privateKey ="x";
  
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


