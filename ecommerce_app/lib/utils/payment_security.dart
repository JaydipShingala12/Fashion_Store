import 'dart:convert';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/foundation.dart';

class PaymentSecurity {
  // Encryption key - in a real app, this would be securely stored or retrieved from a secure server
  static final _key = encrypt.Key.fromLength(32); // 256-bit key
  static final _iv = encrypt.IV.fromLength(16); // 128-bit IV
  static final _encrypter = encrypt.Encrypter(encrypt.AES(_key));

  // Encrypt payment data
  static String encryptPaymentData(Map<String, dynamic> paymentData) {
    try {
      final jsonData = jsonEncode(paymentData);
      final encrypted = _encrypter.encrypt(jsonData, iv: _iv);
      return encrypted.base64;
    } catch (e) {
      if (kDebugMode) {
        print('Encryption error: $e');
      }
      return '';
    }
  }

  // Decrypt payment data
  static Map<String, dynamic> decryptPaymentData(String encryptedData) {
    try {
      final encrypted = encrypt.Encrypted.fromBase64(encryptedData);
      final decrypted = _encrypter.decrypt(encrypted, iv: _iv);
      return jsonDecode(decrypted) as Map<String, dynamic>;
    } catch (e) {
      if (kDebugMode) {
        print('Decryption error: $e');
      }
      return {};
    }
  }

  // Mask credit card number
  static String maskCardNumber(String cardNumber) {
    if (cardNumber.length < 8) return cardNumber;
    final visiblePart = cardNumber.substring(cardNumber.length - 4);
    return 'XXXX-XXXX-XXXX-$visiblePart';
  }

  // Generate a secure transaction ID
  static String generateTransactionId() {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final random = DateTime.now().microsecond;
    return 'TXN-$timestamp-$random';
  }

  // Validate UPI ID format
  static bool isValidUpiId(String upiId) {
    // Basic UPI ID validation - should contain @ symbol
    return upiId.contains('@') && upiId.length > 3;
  }
} 