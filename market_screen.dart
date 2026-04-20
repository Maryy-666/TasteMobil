import 'package:flutter/material.dart';

enum RecipeStatus { live, pending, draft }

class MyRecipe {
  final String emoji;
  final Color color;
  final String title;
  final RecipeStatus status;
  final double price;
  final String salesLabel;

  const MyRecipe({
    required this.emoji,
    required this.color,
    required this.title,
    required this.status,
    required this.price,
    required this.salesLabel,
  });

  String get formattedPrice => '₺${price.toStringAsFixed(0)}';

  String get statusLabel {
    switch (status) {
      case RecipeStatus.live: return 'Yayında';
      case RecipeStatus.pending: return 'İncelemede';
      case RecipeStatus.draft: return 'Taslak';
    }
  }

  Color get statusBg {
    switch (status) {
      case RecipeStatus.live: return const Color(0xFFE8F8EF);
      case RecipeStatus.pending: return const Color(0xFFFDF6EE);
      case RecipeStatus.draft: return const Color(0xFFF7F7F7);
    }
  }

  Color get statusText {
    switch (status) {
      case RecipeStatus.live: return const Color(0xFF1A7A44);
      case RecipeStatus.pending: return const Color(0xFF7A5A1E);
      case RecipeStatus.draft: return const Color(0xFF888888);
    }
  }
}

class Transaction {
  final String message;
  final String boldPart;
  final String time;
  final bool isRead;
  final bool isEarning;
  final double? amount;

  const Transaction({
    required this.message,
    required this.boldPart,
    required this.time,
    this.isRead = false,
    this.isEarning = false,
    this.amount,
  });
}

class AppNotification {
  final String message;
  final String boldPart;
  final String time;
  final bool isRead;

  const AppNotification({
    required this.message,
    required this.boldPart,
    required this.time,
    this.isRead = false,
  });
}

// ---- Sabit örnek veriler ----
class MyRecipeData {
  static List<MyRecipe> getAll() => [
    const MyRecipe(
      emoji: '🥘',
      color: Color(0xFFFDF0EF),
      title: 'Osmanlı Usulü Kuzu Güveç',
      status: RecipeStatus.live,
      price: 89,
      salesLabel: '142 satış',
    ),
    const MyRecipe(
      emoji: '🍮',
      color: Color(0xFFFDF6EE),
      title: 'Kazandibi Kadayıf Buluşması',
      status: RecipeStatus.live,
      price: 65,
      salesLabel: '98 satış',
    ),
    const MyRecipe(
      emoji: '🫕',
      color: Color(0xFFE8F8EF),
      title: 'Ezogelin Çorbası Pro Versiyon',
      status: RecipeStatus.pending,
      price: 45,
      salesLabel: 'İncelemede',
    ),
    const MyRecipe(
      emoji: '🥗',
      color: Color(0xFFF0F4FF),
      title: 'Yeni Deniz Mahsüllü Risotto',
      status: RecipeStatus.draft,
      price: 79,
      salesLabel: 'Taslak',
    ),
  ];
}

class TransactionData {
  static List<Transaction> getAll() => const [
    Transaction(
      message: ' "Osmanlı Kuzu Güveç" satın aldı',
      boldPart: 'Mehmet E.',
      time: '2 dakika önce',
      isEarning: true,
      amount: 89,
    ),
    Transaction(
      message: ' tarafından kazanç aktarıldı',
      boldPart: 'Şef Turu',
      time: '5 dakika önce',
      isEarning: true,
      amount: 89,
    ),
    Transaction(
      message: ' tarifinizi 5 yıldız değerlendirdi',
      boldPart: 'Fatma K.',
      time: '1 saat önce',
    ),
    Transaction(
      message: ' "Ezogelin Çorbası" satın aldı',
      boldPart: 'Garson Mutfağı Ltd.',
      time: '3 saat önce',
      isEarning: true,
      amount: 45,
      isRead: true,
    ),
    Transaction(
      message: 'Aylık kazanç raporunuz hazır',
      boldPart: '',
      time: 'Dün',
      isRead: true,
    ),
  ];
}

class NotificationData {
  static List<AppNotification> getAll() => const [
    AppNotification(
      message: ' sizi takip etmeye başladı',
      boldPart: 'Chef Zeynep K.',
      time: '10 dk önce',
    ),
    AppNotification(
      message: '"Kuzu Güveç" tarifin haftanın önerisi seçildi!',
      boldPart: '',
      time: '2 saat önce',
    ),
    AppNotification(
      message: 'Ödemeniz hesabınıza aktarıldı: ',
      boldPart: '₺1.240',
      time: 'Dün',
      isRead: true,
    ),
    AppNotification(
      message: 'Yeni yorum: "Harika tarif, kesinlikle tavsiye ederim"',
      boldPart: '',
      time: '2 gün önce',
      isRead: true,
    ),
  ];
}
