import 'package:flutter/material.dart';

class Recipe {
  final int id;
  final String emoji;
  final Color color;
  final String title;
  final String chef;
  final String chefInitials;
  final String chefSub;
  final double price;
  final List<String> tags;
  final double rating;
  final String time;
  final int serves;
  final int sales;
  final bool isFeatured;
  final bool isNew;
  final String category;
  final List<String> ingredients;
  final List<String> steps;
  final String description;

  const Recipe({
    required this.id,
    required this.emoji,
    required this.color,
    required this.title,
    required this.chef,
    required this.chefInitials,
    required this.chefSub,
    required this.price,
    required this.tags,
    required this.rating,
    required this.time,
    required this.serves,
    required this.sales,
    this.isFeatured = false,
    this.isNew = false,
    required this.category,
    required this.ingredients,
    required this.steps,
    this.description = '',
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'] as int,
      emoji: json['emoji'] as String,
      color: Color(int.parse(json['color'].toString().replaceFirst('#', '0xFF'))),
      title: json['title'] as String,
      chef: json['chef'] as String,
      chefInitials: json['chefInitials'] as String,
      chefSub: json['chefSub'] as String,
      price: (json['price'] as num).toDouble(),
      tags: List<String>.from(json['tags'] as List),
      rating: (json['rating'] as num).toDouble(),
      time: json['time'] as String,
      serves: json['serves'] as int,
      sales: json['sales'] as int,
      isFeatured: json['isFeatured'] as bool? ?? false,
      isNew: json['isNew'] as bool? ?? false,
      category: json['category'] as String,
      ingredients: List<String>.from(json['ingredients'] as List),
      steps: List<String>.from(json['steps'] as List),
      description: json['description'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'emoji': emoji,
      'title': title,
      'chef': chef,
      'chefInitials': chefInitials,
      'chefSub': chefSub,
      'price': price,
      'tags': tags,
      'rating': rating,
      'time': time,
      'serves': serves,
      'sales': sales,
      'isFeatured': isFeatured,
      'isNew': isNew,
      'category': category,
      'ingredients': ingredients,
      'steps': steps,
      'description': description,
    };
  }

  String get formattedPrice => '₺${price.toStringAsFixed(0)}';
}

// ---- Sabit örnek veri (JSON simülasyonu) ----
class RecipeData {
  static List<Recipe> getAll() => [
    const Recipe(
      id: 1,
      emoji: '🥘',
      color: Color(0xFFFDF0EF),
      title: 'Osmanlı Usulü Kuzu Güveç',
      chef: 'Ayşe Koç',
      chefInitials: 'AK',
      chefSub: 'Türk Mutfağı Uzmanı · 4.9 puan',
      price: 89,
      tags: ['ana yemek', 'osmanlı'],
      rating: 4.9,
      time: '90 dk',
      serves: 6,
      sales: 142,
      isFeatured: true,
      category: 'ana yemek',
      ingredients: [
        '500g kuzu eti',
        '2 adet kuru soğan',
        '3 diş sarımsak',
        '2 adet domates',
        '1 adet sivri biber',
        '100g tereyağı',
        'Kimyon, kekik, defne yaprağı',
        'Tuz, karabiber',
      ],
      steps: [
        'Eti küp küp doğrayın ve yüksek ateşte tereyağında mühürleyin.',
        'Soğan ve sarımsağı ekleyip 5 dakika kavurun.',
        'Baharatları ve domatesleri ekleyip 10 dakika pişirin.',
        'Karışımı güvece alın, 180°C fırında 60 dakika pişirin.',
        '10 dakika dinlendirin ve sıcak servis edin.',
      ],
      description: 'Geleneksel Osmanlı mutfağından günümüze taşınan, zengin baharatlarla hazırlanan enfes bir güveç tarifi.',
    ),
    const Recipe(
      id: 2,
      emoji: '🍮',
      color: Color(0xFFFDF6EE),
      title: 'Kazandibi Kadayıf Buluşması',
      chef: 'Fatma Yıldız',
      chefInitials: 'FY',
      chefSub: 'Pastane Şefi · 4.8 puan',
      price: 65,
      tags: ['tatlı', 'geleneksel'],
      rating: 4.8,
      time: '45 dk',
      serves: 8,
      sales: 98,
      isNew: true,
      category: 'tatlı',
      ingredients: [
        '500ml tam yağlı süt',
        '100g toz şeker',
        '50g pirinç unu',
        '30g nişasta',
        '1 paket vanilin',
        'Tereyağı (tavaya sürmek için)',
      ],
      steps: [
        'Sütü, şeker, un ve nişastayı soğukken karıştırın.',
        'Kısık ateşte sürekli karıştırarak koyulaşana kadar pişirin.',
        'Yağlanmış tavada kısık ateşte yüzeyi hafif yakın (kazandibi efekti).',
        'Muhallebiyi dökün ve oda sıcaklığında soğutun.',
        'Servis tabağına ters çevirin, dilimleyin ve servis edin.',
      ],
      description: 'İki efsane tatlının buluşması: altı çıtır kazandibi, üstü yumuşak kadayıf tabakası.',
    ),
    const Recipe(
      id: 3,
      emoji: '🫕',
      color: Color(0xFFE8F8EF),
      title: 'Ezogelin Çorbası Pro Versiyon',
      chef: 'Mustafa Demir',
      chefInitials: 'MD',
      chefSub: 'Vegan Mutfağı Uzmanı · 4.7 puan',
      price: 45,
      tags: ['çorba', 'vegan'],
      rating: 4.7,
      time: '35 dk',
      serves: 4,
      sales: 211,
      category: 'çorba',
      ingredients: [
        '1 su bardağı kırmızı mercimek',
        '1 su bardağı pirinç',
        '2 yemek kaşığı bulgur',
        '1 adet kuru soğan',
        '1 çay kaşığı nane',
        'Pul biber, tuz, zeytinyağı',
      ],
      steps: [
        'Mercimek ve pirinci iyice yıkayın.',
        'Soğanı zeytinyağında altın renge kavurun.',
        'Tüm malzemeleri tencereye ekleyin, 1.5L su ile 25 dakika pişirin.',
        'Blenderdan geçirerek pürüzsüz hale getirin.',
        'Servis öncesi nane ve pul biberli tereyağı ile tatlandırın.',
      ],
      description: 'Geleneksel ezogelin çorbasının daha kremsi ve lezzetli pro versiyonu.',
    ),
    const Recipe(
      id: 4,
      emoji: '🥗',
      color: Color(0xFFF0F4FF),
      title: 'Akdeniz Vegan Tabağı',
      chef: 'Zeynep Arslan',
      chefInitials: 'ZA',
      chefSub: 'Sağlıklı Yaşam Koçu · 5.0 puan',
      price: 55,
      tags: ['vegan', 'sağlıklı'],
      rating: 5.0,
      time: '20 dk',
      serves: 2,
      sales: 67,
      isNew: true,
      category: 'vegan',
      ingredients: [
        'Mevsim yeşillikleri (roka, marul)',
        '200g kiraz domates',
        '1 adet salatalık',
        '50g siyah zeytin',
        '2 yemek kaşığı nar ekşisi',
        '3 yemek kaşığı sızma zeytinyağı',
        'Taze nane, tuz',
      ],
      steps: [
        'Tüm sebzeleri iyice yıkayın.',
        'Domatesleri ikiye, salatalığı küp küp doğrayın.',
        'Geniş bir kaseye yeşillikleri yayın, üstüne sebzeleri ekleyin.',
        'Nar ekşisi ve zeytinyağını çırparak sos hazırlayın.',
        'Sosu üzerine döküp hafifçe karıştırın, taze nane ile süsleyin.',
      ],
      description: 'Akdeniz\'in en taze tatlarını bir arada sunan, hafif ve doyurucu vegan tabağı.',
    ),
    const Recipe(
      id: 5,
      emoji: '🌮',
      color: Color(0xFFFEF9EC),
      title: 'Türk Usulü Et Dürüm',
      chef: 'Ali Kaya',
      chefInitials: 'AK',
      chefSub: 'Street Food Uzmanı · 4.6 puan',
      price: 39,
      tags: ['fast food', 'et'],
      rating: 4.6,
      time: '25 dk',
      serves: 4,
      sales: 334,
      category: 'fast food',
      ingredients: [
        '500g dana kıyma',
        '4 adet lavaş',
        '2 adet yeşil sivri biber',
        '2 adet domates',
        '1 adet kuru soğan',
        'Sumak, kırmızı biber, tuz',
        'Maydanoz',
      ],
      steps: [
        'Kıymayı soğan ve baharatlarla iyice yoğurun.',
        'Adana köfte şekli vererek şişe veya ızgaraya alın.',
        'Yüksek ateşte her iki tarafı ızgara yapın (8-10 dk).',
        'Lavaşı 1 dakika ızgarada ısıtın.',
        'Eti, domates ve yeşillikleri lavaşa sarın, sumakla servis edin.',
      ],
      description: 'Sokak lezzetinin ustasından, ev yapımı baharatlarla hazırlanan nefis et dürüm tarifi.',
    ),
    const Recipe(
      id: 6,
      emoji: '🍜',
      color: Color(0xFFF5EEFF),
      title: 'Sebzeli Erişte Çorbası',
      chef: 'Hülya Şahin',
      chefInitials: 'HŞ',
      chefSub: 'Ev Yemekleri Ustası · 4.5 puan',
      price: 35,
      tags: ['çorba', 'vegan'],
      rating: 4.5,
      time: '30 dk',
      serves: 6,
      sales: 89,
      category: 'çorba',
      ingredients: [
        '200g ev yapımı erişte',
        '2 adet havuç',
        '1 adet patates',
        '1 adet kuru soğan',
        'Taze dereotu',
        'Tavuk veya sebze suyu (1.5L)',
        'Tuz, karabiber',
      ],
      steps: [
        'Sebzeleri küp küp doğrayın.',
        'Soğanı kavurun, sebzeleri ekleyip 3 dakika soteleyin.',
        'Tavuk suyunu ekleyin ve kaynamaya bırakın.',
        'Erişteleri ekleyin, 8-10 dakika pişirin.',
        'Dereotu ile süsleyip sıcak servis edin.',
      ],
      description: 'Anne usulü sıcacık erişte çorbası, soğuk günlerin vazgeçilmezi.',
    ),
  ];

  static List<String> get categories => [
    'Tümü', 'Ana Yemek', 'Tatlı', 'Çorba', 'Vegan', 'Fast Food',
  ];
}
