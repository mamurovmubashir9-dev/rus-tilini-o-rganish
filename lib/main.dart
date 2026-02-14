// MUHIM! pubspec.yaml fayliga quyidagilarni qo'shing:
// dependencies:
//   flutter:
//     sdk: flutter
//   shared_preferences: ^2.2.2
//   connectivity_plus: ^5.0.2

import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';
import 'dart:ui';
// import 'package:shared_preferences/shared_preferences.dart'; // Uncomment bu qatorni!
import 'package:connectivity_plus/connectivity_plus.dart';

void main() {
  runApp(const RusTiliApp());
}

class RusTiliApp extends StatelessWidget {
  const RusTiliApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rus Tilini O\'rganamiz',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}

// Progress Ma'lumotlari - SharedPreferences bilan
class ProgressData {
  static int totalLetters = 33;
  static int totalWords = 210; // Kundalik gaplar - 210 ta!
  static int totalGames = 5; // 5 ta daraja!
  static int totalQuizzes = 53; // So'zlar testlari ko'paytirildi!
  static int totalPoems = 10; // She'rlar uchun - YANGI!
  static int totalWordTests = 50; // So'zlar testi - YANGI!

  static int learnedLetters = 0;
  static int learnedWords = 0;
  static int gamesPlayed = 0;
  static int quizzesPassed = 0;
  static int readPoems = 0; // O'qilgan she'rlar - YANGI!
  static int wordTestsPassed = 0; // To'g'ri javoblar - YANGI!

  static Set<String> viewedLetters = {};
  static Set<String> viewedWords = {};
  static Set<String> viewedPoems = {}; // Ko'rilgan she'rlar - YANGI!

  // SharedPreferences - Progressni saqlash
  // ESLATMA: shared_preferences paketini pubspec.yaml ga qo'shing!
  /*
  static Future<void> loadProgress() async {
    final prefs = await SharedPreferences.getInstance();
    learnedLetters = prefs.getInt('learnedLetters') ?? 0;
    learnedWords = prefs.getInt('learnedWords') ?? 0;
    gamesPlayed = prefs.getInt('gamesPlayed') ?? 0;
    quizzesPassed = prefs.getInt('quizzesPassed') ?? 0;
    readPoems = prefs.getInt('readPoems') ?? 0;
    wordTestsPassed = prefs.getInt('wordTestsPassed') ?? 0;
    
    viewedLetters = (prefs.getStringList('viewedLetters') ?? []).toSet();
    viewedWords = (prefs.getStringList('viewedWords') ?? []).toSet();
    viewedPoems = (prefs.getStringList('viewedPoems') ?? []).toSet();
  }

  static Future<void> saveProgress() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('learnedLetters', learnedLetters);
    await prefs.setInt('learnedWords', learnedWords);
    await prefs.setInt('gamesPlayed', gamesPlayed);
    await prefs.setInt('quizzesPassed', quizzesPassed);
    await prefs.setInt('readPoems', readPoems);
    await prefs.setInt('wordTestsPassed', wordTestsPassed);
    
    await prefs.setStringList('viewedLetters', viewedLetters.toList());
    await prefs.setStringList('viewedWords', viewedWords.toList());
    await prefs.setStringList('viewedPoems', viewedPoems.toList());
  }
  */

  static int getTotalProgress() {
    int letterProgress = ((learnedLetters / totalLetters) * 20).round();
    int wordProgress = ((learnedWords / totalWords) * 20).round();
    int gameProgress = ((gamesPlayed / totalGames) * 20).round();
    int quizProgress = ((quizzesPassed / totalQuizzes) * 20).round();
    int poemProgress = ((readPoems / totalPoems) * 20).round(); // YANGI!
    
    return letterProgress + wordProgress + gameProgress + quizProgress + poemProgress;
  }

  static Color getThemeColor() {
    int progress = getTotalProgress();
    
    if (progress < 25) {
      return Color(0xFF8B5CF6);
    } else if (progress < 50) {
      return Color(0xFF3B82F6);
    } else if (progress < 75) {
      return Color(0xFF10B981);
    } else {
      return Color(0xFFF59E0B);
    }
  }

  static List<Color> getGradientColors() {
    int progress = getTotalProgress();
    
    if (progress < 25) {
      return [Color(0xFF8B5CF6), Color(0xFFC084FC)];
    } else if (progress < 50) {
      return [Color(0xFF3B82F6), Color(0xFF60A5FA)];
    } else if (progress < 75) {
      return [Color(0xFF10B981), Color(0xFF34D399)];
    } else {
      return [Color(0xFFF59E0B), Color(0xFFFBBF24)];
    }
  }
}

// ========== SHE'RLAR BAZASI - YANGI! ==========
class PoemsDatabase {
  static final List<Map<String, String>> poems = [
    {
      'title': 'Наша Таня громко плачет',
      'author': 'Агния Барто',
      'russian': '''Наша Таня громко плачет:
Уронила в речку мячик.
— Тише, Танечка, не плачь:
Не утонет в речке мяч.''',
      'uzbek': '''Bizning Tanya baland yig'laydi:
Daryoga to'pni tushirdi.
— Jim bo'l, Tanyachka, yig'lama:
To'p daryoda cho'kib ketmaydi.''',
      'emoji': '⚽',
    },
    {
      'title': 'Идёт бычок, качается',
      'author': 'Агния Барто',
      'russian': '''Идёт бычок, качается,
Вздыхает на ходу:
— Ох, доска кончается,
Сейчас я упаду!''',
      'uzbek': '''Buzoqcha ketyapti, chayqalyapti,
Yurgancha xo'rsinyapti:
— Voy, taxta tugayapti,
Hozir yiqilib tushaman!''',
      'emoji': '🐂',
    },
    {
      'title': 'Зайку бросила хозяйка',
      'author': 'Агния Барто',
      'russian': '''Зайку бросила хозяйка —
Под дождём остался зайка.
Со скамейки слезть не мог,
Весь до ниточки промок.''',
      'uzbek': '''Quyonchani tashlab ketdi egasi —
Yomg'irda qoldi quyoncha.
Skameykadan tusha olmadi,
Butunlay ho'l bo'lib ketdi.''',
      'emoji': '🐰',
    },
    {
      'title': 'Мишка',
      'author': 'Агния Барто',
      'russian': '''Уронили мишку на пол,
Оторвали мишке лапу.
Всё равно его не брошу —
Потому что он хороший.''',
      'uzbek': '''Ayiqchani polga tushirishdi,
Ayiqchaning oyog'ini uzishdi.
Baribir uni tashlamayman —
Chunki u yaxshi.''',
      'emoji': '🧸',
    },
    {
      'title': 'Белая берёза',
      'author': 'Сергей Есенин',
      'russian': '''Белая береза
Под моим окном
Принакрылась снегом,
Точно серебром.''',
      'uzbek': '''Oq qayin daraxti
Mening derazam ostida
Qor bilan yopilgan,
Xuddi kumush kabi.''',
      'emoji': '🌲',
    },
    {
      'title': 'Зима',
      'author': 'Иван Суриков',
      'russian': '''Белый снег пушистый
В воздухе кружится
И на землю тихо
Падает, ложится.''',
      'uzbek': '''Oq qor mayin
Havoda aylanadi
Va yerga jimgina
Tushadi, yotadi.''',
      'emoji': '❄️',
    },
    {
      'title': 'Игрушки',
      'author': 'Агния Барто',
      'russian': '''Я люблю свою лошадку,
Причешу ей шёрстку гладко,
Гребешком приглажу хвостик
И верхом поеду в гости.''',
      'uzbek': '''Men otimni yaxshi ko'raman,
Uning yungini silliq tarashaman,
Taroq bilan dumini tekislayman
Va minib mehmon borishga boraman.''',
      'emoji': '🐴',
    },
    {
      'title': 'Самолёт',
      'author': 'Агния Барто',
      'russian': '''Самолёт построим сами,
Понесёмся над лесами.
Понесёмся над лесами,
А потом вернёмся к маме.''',
      'uzbek': '''Samolyotni o'zimiz quramiz,
O'rmonlar ustidan uchamiz.
O'rmonlar ustidan uchamiz,
Keyin onaga qaytamiz.''',
      'emoji': '✈️',
    },
    {
      'title': 'Кораблик',
      'author': 'Агния Барто',
      'russian': '''Матросская шапка,
Верёвка в руке,
Тяну я кораблик
По быстрой реке.''',
      'uzbek': '''Dengizchi shapkasi,
Qo'lda arqon,
Men kemani sudrayapman
Tez oqayotgan daryoda.''',
      'emoji': '⛵',
    },
    {
      'title': 'Солнышко',
      'author': 'Корней Чуковский',
      'russian': '''Солнце по небу гуляло
И за тучу забежало.
Глянул заинька в окно,
Стало заиньке темно.''',
      'uzbek': '''Quyosh osmon bo'ylab sayr qildi
Va bulut ortiga yugurdi.
Quyoncha derazadan qaradi,
Quyonchaga qorong'i bo'ldi.''',
      'emoji': '☀️',
    },
  ];

  static List<Map<String, String>> getAllPoems() {
    return poems;
  }

  static Map<String, String>? getPoemByTitle(String title) {
    try {
      return poems.firstWhere((poem) => poem['title'] == title);
    } catch (e) {
      return null;
    }
  }
}
// ========== SHE'RLAR BAZASI TUGADI ==========

// Tarjima lug'ati
class TranslationDictionary {
  static final Map<String, Map<String, String>> dictionary = {
    'привет': {'translation': 'salom', 'category': 'Salomlashish', 'emoji': '👋'},
    'здравствуйте': {'translation': 'assalomu alaykum', 'category': 'Salomlashish', 'emoji': '🙋'},
    'пока': {'translation': 'xayr', 'category': 'Xayrlashish', 'emoji': '👋'},
    'до свидания': {'translation': 'ko\'rishguncha', 'category': 'Xayrlashish', 'emoji': '👋'},
    'спасибо': {'translation': 'rahmat', 'category': 'Iltifot', 'emoji': '🙏'},
    'пожалуйста': {'translation': 'marhamat / iltimos', 'category': 'Iltifot', 'emoji': '🤝'},
    'извините': {'translation': 'kechirasiz', 'category': 'Iltifot', 'emoji': '🙇'},
    'мама': {'translation': 'ona', 'category': 'Oila', 'emoji': '👩'},
    'папа': {'translation': 'ota', 'category': 'Oila', 'emoji': '👨'},
    'брат': {'translation': 'aka/uka', 'category': 'Oila', 'emoji': '👦'},
    'сестра': {'translation': 'opa/singil', 'category': 'Oila', 'emoji': '👧'},
    'бабушка': {'translation': 'buvi', 'category': 'Oila', 'emoji': '👵'},
    'дедушка': {'translation': 'bobo', 'category': 'Oila', 'emoji': '👴'},
    'семья': {'translation': 'oila', 'category': 'Oila', 'emoji': '👨‍👩‍👧‍👦'},
    'дом': {'translation': 'uy', 'category': 'Joy', 'emoji': '🏠'},
    'школа': {'translation': 'maktab', 'category': 'Joy', 'emoji': '🏫'},
    'работа': {'translation': 'ish', 'category': 'Joy', 'emoji': '💼'},
    'магазин': {'translation': 'do\'kon', 'category': 'Joy', 'emoji': '🏪'},
    'больница': {'translation': 'kasalxona', 'category': 'Joy', 'emoji': '🏥'},
    'парк': {'translation': 'bog\'', 'category': 'Joy', 'emoji': '🌳'},
    'улица': {'translation': 'ko\'cha', 'category': 'Joy', 'emoji': '🛣️'},
    'сегодня': {'translation': 'bugun', 'category': 'Vaqt', 'emoji': '📅'},
    'вчера': {'translation': 'kecha', 'category': 'Vaqt', 'emoji': '📆'},
    'завтра': {'translation': 'ertaga', 'category': 'Vaqt', 'emoji': '📅'},
    'утро': {'translation': 'ertalab', 'category': 'Vaqt', 'emoji': '🌅'},
    'день': {'translation': 'kun / kunduzi', 'category': 'Vaqt', 'emoji': '☀️'},
    'вечер': {'translation': 'kechqurun', 'category': 'Vaqt', 'emoji': '🌆'},
    'ночь': {'translation': 'kecha / tun', 'category': 'Vaqt', 'emoji': '🌙'},
    'час': {'translation': 'soat', 'category': 'Vaqt', 'emoji': '⏰'},
    'минута': {'translation': 'daqiqa', 'category': 'Vaqt', 'emoji': '⏱️'},
    'хлеб': {'translation': 'non', 'category': 'Ovqat', 'emoji': '🍞'},
    'вода': {'translation': 'suv', 'category': 'Ichimlik', 'emoji': '💧'},
    'молоко': {'translation': 'sut', 'category': 'Ichimlik', 'emoji': '🥛'},
    'чай': {'translation': 'choy', 'category': 'Ichimlik', 'emoji': '☕'},
    'кофе': {'translation': 'kofe', 'category': 'Ichimlik', 'emoji': '☕'},
    'еда': {'translation': 'ovqat', 'category': 'Ovqat', 'emoji': '🍽️'},
    'мясо': {'translation': 'go\'sht', 'category': 'Ovqat', 'emoji': '🥩'},
    'рыба': {'translation': 'baliq', 'category': 'Ovqat', 'emoji': '🐟'},
    'яблоко': {'translation': 'olma', 'category': 'Meva', 'emoji': '🍎'},
    'банан': {'translation': 'banan', 'category': 'Meva', 'emoji': '🍌'},
    'красный': {'translation': 'qizil', 'category': 'Rang', 'emoji': '🔴'},
    'синий': {'translation': 'ko\'k', 'category': 'Rang', 'emoji': '🔵'},
    'зелёный': {'translation': 'yashil', 'category': 'Rang', 'emoji': '🟢'},
    'жёлтый': {'translation': 'sariq', 'category': 'Rang', 'emoji': '🟡'},
    'белый': {'translation': 'oq', 'category': 'Rang', 'emoji': '⚪'},
    'чёрный': {'translation': 'qora', 'category': 'Rang', 'emoji': '⚫'},
    'один': {'translation': 'bir', 'category': 'Son', 'emoji': '1️⃣'},
    'два': {'translation': 'ikki', 'category': 'Son', 'emoji': '2️⃣'},
    'три': {'translation': 'uch', 'category': 'Son', 'emoji': '3️⃣'},
    'четыре': {'translation': 'to\'rt', 'category': 'Son', 'emoji': '4️⃣'},
    'пять': {'translation': 'besh', 'category': 'Son', 'emoji': '5️⃣'},
    'десять': {'translation': 'o\'n', 'category': 'Son', 'emoji': '🔟'},
    'есть': {'translation': 'borlik / yemoq', 'category': 'Fe\'l', 'emoji': '✅'},
    'пить': {'translation': 'ichmoq', 'category': 'Fe\'l', 'emoji': '🥤'},
    'идти': {'translation': 'bormoq', 'category': 'Fe\'l', 'emoji': '🚶'},
    'спать': {'translation': 'uxlamoq', 'category': 'Fe\'l', 'emoji': '😴'},
    'говорить': {'translation': 'gapirmoq', 'category': 'Fe\'l', 'emoji': '💬'},
    'читать': {'translation': 'o\'qimoq', 'category': 'Fe\'l', 'emoji': '📖'},
    'писать': {'translation': 'yozmoq', 'category': 'Fe\'l', 'emoji': '✍️'},
    'смотреть': {'translation': 'qaramoq', 'category': 'Fe\'l', 'emoji': '👀'},
    'слушать': {'translation': 'eshitmoq/tinglamoq', 'category': 'Fe\'l', 'emoji': '👂'},
    'любить': {'translation': 'yoqtirmoq/sevmoq', 'category': 'Fe\'l', 'emoji': '❤️'},
    'хотеть': {'translation': 'xohlamoq', 'category': 'Fe\'l', 'emoji': '🙏'},
    'знать': {'translation': 'bilmoq', 'category': 'Fe\'l', 'emoji': '🧠'},
    'понимать': {'translation': 'tushunmoq', 'category': 'Fe\'l', 'emoji': '💡'},
    'хороший': {'translation': 'yaxshi', 'category': 'Sifat', 'emoji': '👍'},
    'плохой': {'translation': 'yomon', 'category': 'Sifat', 'emoji': '👎'},
    'большой': {'translation': 'katta', 'category': 'Sifat', 'emoji': '📏'},
    'маленький': {'translation': 'kichik', 'category': 'Sifat', 'emoji': '🔍'},
    'новый': {'translation': 'yangi', 'category': 'Sifat', 'emoji': '✨'},
    'старый': {'translation': 'eski', 'category': 'Sifat', 'emoji': '📜'},
    'красивый': {'translation': 'chiroyli', 'category': 'Sifat', 'emoji': '😍'},
    'холодный': {'translation': 'sovuq', 'category': 'Sifat', 'emoji': '❄️'},
    'горячий': {'translation': 'issiq', 'category': 'Sifat', 'emoji': '🔥'},
    'что': {'translation': 'nima', 'category': 'Savol', 'emoji': '❓'},
    'кто': {'translation': 'kim', 'category': 'Savol', 'emoji': '👤'},
    'где': {'translation': 'qayerda', 'category': 'Savol', 'emoji': '📍'},
    'когда': {'translation': 'qachon', 'category': 'Savol', 'emoji': '⏰'},
    'почему': {'translation': 'nega', 'category': 'Savol', 'emoji': '🤔'},
    'как': {'translation': 'qanday', 'category': 'Savol', 'emoji': '❔'},
    'сколько': {'translation': 'qancha/nechta', 'category': 'Savol', 'emoji': '🔢'},
    'да': {'translation': 'ha', 'category': 'Javob', 'emoji': '✅'},
    'нет': {'translation': 'yo\'q', 'category': 'Javob', 'emoji': '❌'},
    'может быть': {'translation': 'balki', 'category': 'Javob', 'emoji': '🤷'},
    'человек': {'translation': 'odam/inson', 'category': 'Umumiy', 'emoji': '👤'},
    'друг': {'translation': 'do\'st', 'category': 'Umumiy', 'emoji': '🤝'},
    'книга': {'translation': 'kitob', 'category': 'Buyum', 'emoji': '📚'},
    'телефон': {'translation': 'telefon', 'category': 'Buyum', 'emoji': '📱'},
    'компьютер': {'translation': 'kompyuter', 'category': 'Buyum', 'emoji': '💻'},
    'машина': {'translation': 'mashina', 'category': 'Transport', 'emoji': '🚗'},
    'деньги': {'translation': 'pul', 'category': 'Umumiy', 'emoji': '💰'},
    'время': {'translation': 'vaqt', 'category': 'Umumiy', 'emoji': '⏰'},
    'жизнь': {'translation': 'hayot', 'category': 'Umumiy', 'emoji': '🌟'},
    'любовь': {'translation': 'sevgi/muhabbat', 'category': 'His-tuyg\'u', 'emoji': '❤️'},
    
    // Tana a'zolari (20 ta)
    'голова': {'translation': 'bosh', 'category': 'Tana', 'emoji': '👤'},
    'волосы': {'translation': 'soch', 'category': 'Tana', 'emoji': '💇'},
    'лицо': {'translation': 'yuz', 'category': 'Tana', 'emoji': '😊'},
    'глаз': {'translation': 'ko\'z', 'category': 'Tana', 'emoji': '👁️'},
    'глаза': {'translation': 'ko\'zlar', 'category': 'Tana', 'emoji': '👀'},
    'ухо': {'translation': 'quloq', 'category': 'Tana', 'emoji': '👂'},
    'нос': {'translation': 'burun', 'category': 'Tana', 'emoji': '👃'},
    'рот': {'translation': 'og\'iz', 'category': 'Tana', 'emoji': '👄'},
    'зуб': {'translation': 'tish', 'category': 'Tana', 'emoji': '🦷'},
    'язык': {'translation': 'til', 'category': 'Tana', 'emoji': '👅'},
    'шея': {'translation': 'bo\'yin', 'category': 'Tana', 'emoji': '🧣'},
    'плечо': {'translation': 'yelka', 'category': 'Tana', 'emoji': '💪'},
    'рука': {'translation': 'qo\'l', 'category': 'Tana', 'emoji': '✋'},
    'палец': {'translation': 'barmoq', 'category': 'Tana', 'emoji': '👆'},
    'нога': {'translation': 'oyoq', 'category': 'Tana', 'emoji': '🦵'},
    'колено': {'translation': 'tizza', 'category': 'Tana', 'emoji': '🦵'},
    'спина': {'translation': 'orqa', 'category': 'Tana', 'emoji': '🧍'},
    'живот': {'translation': 'qorin', 'category': 'Tana', 'emoji': '🤰'},
    'сердце': {'translation': 'yurak', 'category': 'Tana', 'emoji': '❤️'},
    'кровь': {'translation': 'qon', 'category': 'Tana', 'emoji': '🩸'},
    
    // Hayvonlar (25 ta)
    'животное': {'translation': 'hayvon', 'category': 'Hayvon', 'emoji': '🐾'},
    'лошадь': {'translation': 'ot', 'category': 'Hayvon', 'emoji': '🐴'},
    'корова': {'translation': 'sigir', 'category': 'Hayvon', 'emoji': '🐄'},
    'овца': {'translation': 'qo\'y', 'category': 'Hayvon', 'emoji': '🐑'},
    'коза': {'translation': 'echki', 'category': 'Hayvon', 'emoji': '🐐'},
    'свинья': {'translation': 'cho\'chqa', 'category': 'Hayvon', 'emoji': '🐷'},
    'петух': {'translation': 'xo\'roz', 'category': 'Hayvon', 'emoji': '🐓'},
    'курица': {'translation': 'tovuq', 'category': 'Hayvon', 'emoji': '🐔'},
    'утка': {'translation': 'o\'rdak', 'category': 'Hayvon', 'emoji': '🦆'},
    'гусь': {'translation': 'g\'oz', 'category': 'Hayvon', 'emoji': '🦢'},
    'птица': {'translation': 'qush', 'category': 'Hayvon', 'emoji': '🐦'},
    'медведь': {'translation': 'ayiq', 'category': 'Hayvon', 'emoji': '🐻'},
    'волк': {'translation': 'bo\'ri', 'category': 'Hayvon', 'emoji': '🐺'},
    'лиса': {'translation': 'tulki', 'category': 'Hayvon', 'emoji': '🦊'},
    'слон': {'translation': 'fil', 'category': 'Hayvon', 'emoji': '🐘'},
    'тигр': {'translation': 'yo\'lbars', 'category': 'Hayvon', 'emoji': '🐯'},
    'лев': {'translation': 'arslon', 'category': 'Hayvon', 'emoji': '🦁'},
    'обезьяна': {'translation': 'maymun', 'category': 'Hayvon', 'emoji': '🐵'},
    'змея': {'translation': 'ilon', 'category': 'Hayvon', 'emoji': '🐍'},
    'лягушка': {'translation': 'qurbaqa', 'category': 'Hayvon', 'emoji': '🐸'},
    'мышь': {'translation': 'sichqon', 'category': 'Hayvon', 'emoji': '🐭'},
    'крыса': {'translation': 'kalamush', 'category': 'Hayvon', 'emoji': '🐀'},
    'верблюд': {'translation': 'tuya', 'category': 'Hayvon', 'emoji': '🐫'},
    'осёл': {'translation': 'eshak', 'category': 'Hayvon', 'emoji': '🫏'},
    'пчела': {'translation': 'asalari', 'category': 'Hasharot', 'emoji': '🐝'},
    
    // Tabiat (20 ta)
    'природа': {'translation': 'tabiat', 'category': 'Tabiat', 'emoji': '🌿'},
    'дерево': {'translation': 'daraxt', 'category': 'Tabiat', 'emoji': '🌳'},
    'лист': {'translation': 'barg', 'category': 'Tabiat', 'emoji': '🍃'},
    'цветок': {'translation': 'gul', 'category': 'Tabiat', 'emoji': '🌸'},
    'трава': {'translation': 'o\'t', 'category': 'Tabiat', 'emoji': '🌱'},
    'гора': {'translation': 'tog\'', 'category': 'Tabiat', 'emoji': '⛰️'},
    'река': {'translation': 'daryo', 'category': 'Tabiat', 'emoji': '🏞️'},
    'озеро': {'translation': 'ko\'l', 'category': 'Tabiat', 'emoji': '🏞️'},
    'море': {'translation': 'dengiz', 'category': 'Tabiat', 'emoji': '🌊'},
    'океан': {'translation': 'okean', 'category': 'Tabiat', 'emoji': '🌊'},
    'пляж': {'translation': 'plyaj', 'category': 'Tabiat', 'emoji': '🏖️'},
    'остров': {'translation': 'orol', 'category': 'Tabiat', 'emoji': '🏝️'},
    'лес': {'translation': 'o\'rmon', 'category': 'Tabiat', 'emoji': '🌲'},
    'поле': {'translation': 'dala', 'category': 'Tabiat', 'emoji': '🌾'},
    'пустыня': {'translation': 'cho\'l', 'category': 'Tabiat', 'emoji': '🏜️'},
    'земля': {'translation': 'yer', 'category': 'Tabiat', 'emoji': '🌍'},
    'небо': {'translation': 'osmon', 'category': 'Tabiat', 'emoji': '☁️'},
    'облако': {'translation': 'bulut', 'category': 'Tabiat', 'emoji': '☁️'},
    'ветер': {'translation': 'shamol', 'category': 'Tabiat', 'emoji': '💨'},
    'камень': {'translation': 'tosh', 'category': 'Tabiat', 'emoji': '🪨'},
    
    // Ob-havo (15 ta)
    'погода': {'translation': 'ob-havo', 'category': 'Ob-havo', 'emoji': '🌤️'},
    'дождь': {'translation': 'yomg\'ir', 'category': 'Ob-havo', 'emoji': '🌧️'},
    'снег': {'translation': 'qor', 'category': 'Ob-havo', 'emoji': '❄️'},
    'град': {'translation': 'do\'l', 'category': 'Ob-havo', 'emoji': '🧊'},
    'туман': {'translation': 'tuman', 'category': 'Ob-havo', 'emoji': '🌫️'},
    'молния': {'translation': 'chaqmoq', 'category': 'Ob-havo', 'emoji': '⚡'},
    'гром': {'translation': 'momaqaldiroq', 'category': 'Ob-havo', 'emoji': '⛈️'},
    'радуга': {'translation': 'kamalak', 'category': 'Ob-havo', 'emoji': '🌈'},
    'жара': {'translation': 'issiq', 'category': 'Ob-havo', 'emoji': '🥵'},
    'холод': {'translation': 'sovuq', 'category': 'Ob-havo', 'emoji': '🥶'},
    'температура': {'translation': 'harorat', 'category': 'Ob-havo', 'emoji': '🌡️'},
    'мороз': {'translation': 'ayoz', 'category': 'Ob-havo', 'emoji': '🧊'},
    'лёд': {'translation': 'muz', 'category': 'Ob-havo', 'emoji': '🧊'},
    'тепло': {'translation': 'issiq', 'category': 'Ob-havo', 'emoji': '☀️'},
    'прохладно': {'translation': 'salqin', 'category': 'Ob-havo', 'emoji': '😌'},
  };
  
  static String? translate(String word) {
    String normalizedWord = word.toLowerCase().trim();
    return dictionary[normalizedWord]?['translation'];
  }
  
  static Map<String, String>? getWordDetails(String word) {
    String normalizedWord = word.toLowerCase().trim();
    return dictionary[normalizedWord];
  }
  
  static List<String> getAllWords() {
    return dictionary.keys.toList();
  }
  
  static Map<String, List<String>> getWordsByCategory() {
    Map<String, List<String>> categorized = {};
    dictionary.forEach((word, details) {
      String category = details['category'] ?? 'Boshqa';
      if (!categorized.containsKey(category)) {
        categorized[category] = [];
      }
      categorized[category]!.add(word);
    });
    return categorized;
  }
}

class SimpleBackground extends StatelessWidget {
  const SimpleBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colors = ProgressData.getGradientColors();
    final screenHeight = MediaQuery.of(context).size.height;
    
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            colors[0].withOpacity(0.08),
            Colors.white,
            colors[1].withOpacity(0.05),
            Colors.white,
          ],
          stops: [0.0, 0.3, 0.7, 1.0],
        ),
      ),
      child: Stack(
        children: [
          // Top decorative circle
          Positioned(
            top: -100,
            right: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    colors[0].withOpacity(0.1),
                    colors[0].withOpacity(0.0),
                  ],
                ),
              ),
            ),
          ),
          // Bottom decorative circle
          Positioned(
            bottom: -150,
            left: -100,
            child: Container(
              width: 350,
              height: 350,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    colors[1].withOpacity(0.08),
                    colors[1].withOpacity(0.0),
                  ],
                ),
              ),
            ),
          ),
          // Middle decorative shapes
          Positioned(
            top: screenHeight * 0.3,
            left: -50,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colors[0].withOpacity(0.03),
              ),
            ),
          ),
          Positioned(
            top: screenHeight * 0.6,
            right: -80,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colors[1].withOpacity(0.04),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late AnimationController _fadeController;
  late AnimationController _rotateController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _rotateAnimation;

  @override
  void initState() {
    super.initState();
    
    // Scale animation
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.elasticOut),
    );

    // Fade animation
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeIn),
    );

    // Rotate animation
    _rotateController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _rotateAnimation = Tween<double>(begin: 0.0, end: 0.1).animate(
      CurvedAnimation(parent: _rotateController, curve: Curves.easeInOut),
    );

    _scaleController.forward();
    Future.delayed(Duration(milliseconds: 300), () {
      _fadeController.forward();
      _rotateController.forward();
    });

    // SharedPreferences ni yuklash (uncomment qiling)
    // ProgressData.loadProgress();

    // Internet tekshiruvi
    _checkInternetAndNavigate();
  }

  Future<void> _checkInternetAndNavigate() async {
    await Future.delayed(const Duration(milliseconds: 2500));
    
    // Internet ulanishini tekshirish
    var connectivityResult = await Connectivity().checkConnectivity();
    
    if (!mounted) return;
    
    if (connectivityResult == ConnectivityResult.none) {
      // Internet yo'q - ogohlantirish ekraniga o'tish
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const NoInternetScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
          transitionDuration: Duration(milliseconds: 500),
        ),
      );
    } else {
      // Internet bor - asosiy ekranga o'tish
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const HomeScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
          transitionDuration: Duration(milliseconds: 500),
        ),
      );
    }
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _fadeController.dispose();
    _rotateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = ProgressData.getGradientColors();
    
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              colors[0],
              colors[1],
              colors[0].withOpacity(0.8),
            ],
          ),
        ),
        child: Stack(
          children: [
            // Animated circles background
            ...List.generate(5, (index) {
              return Positioned(
                top: (index * 150.0) - 100,
                left: (index % 2 == 0) ? -50 : null,
                right: (index % 2 != 0) ? -50 : null,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.05),
                    ),
                  ),
                ),
              );
            }),
            
            // Main content
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo with animations
                  ScaleTransition(
                    scale: _scaleAnimation,
                    child: RotationTransition(
                      turns: _rotateAnimation,
                      child: Container(
                        width: 180,
                        height: 180,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(40),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 40,
                              offset: Offset(0, 20),
                              spreadRadius: 5,
                            ),
                            BoxShadow(
                              color: colors[0].withOpacity(0.5),
                              blurRadius: 20,
                              offset: Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'АБВ',
                                style: TextStyle(
                                  fontSize: 70,
                                  fontWeight: FontWeight.bold,
                                  foreground: Paint()
                                    ..shader = LinearGradient(
                                      colors: colors,
                                    ).createShader(Rect.fromLTWH(0, 0, 200, 70)),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 5),
                                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(colors: colors),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  'LEARN',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    letterSpacing: 3,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 50),
                  
                  // Title with fade
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: Column(
                      children: [
                        Text(
                          'Rus Tilini O\'rganamiz',
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                color: Colors.black.withOpacity(0.3),
                                offset: Offset(0, 4),
                                blurRadius: 10,
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 12),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.3),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.star, color: Colors.white, size: 18),
                              SizedBox(width: 8),
                              Text(
                                'Оддий ва қизиқарли',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  letterSpacing: 1.5,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(width: 8),
                              Icon(Icons.star, color: Colors.white, size: 18),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 60),
                  
                  // Loading indicator
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: Column(
                      children: [
                        SizedBox(
                          width: 40,
                          height: 40,
                          child: CircularProgressIndicator(
                            strokeWidth: 3,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Yuklanmoqda...',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white.withOpacity(0.9),
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            // Version info
            Positioned(
              bottom: 30,
              left: 0,
              right: 0,
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Center(
                  child: Text(
                    'Version 1.0.0',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white.withOpacity(0.6),
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
              
// Internet yo'q ekrani - YANGI!
class NoInternetScreen extends StatefulWidget {
  const NoInternetScreen({Key? key}) : super(key: key);

  @override
  State<NoInternetScreen> createState() => _NoInternetScreenState();
}

class _NoInternetScreenState extends State<NoInternetScreen> 
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;
  bool _isChecking = false;

  @override
  void initState() {
    super.initState();
    
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);
    
    _pulseAnimation = Tween<double>(begin: 0.95, end: 1.05).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  Future<void> _checkConnection() async {
    setState(() {
      _isChecking = true;
    });

    await Future.delayed(const Duration(seconds: 1));
    
    var connectivityResult = await Connectivity().checkConnectivity();
    
    if (!mounted) return;

    setState(() {
      _isChecking = false;
    });

    if (connectivityResult != ConnectivityResult.none) {
      // Internet TOPILDI - faqat endi HomeScreen ga o'tish mumkin!
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const HomeScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
          transitionDuration: Duration(milliseconds: 500),
        ),
      );
    } else {
      // HALI HAM INTERNET YO'Q - ekranda qolamiz
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(Icons.wifi_off, color: Colors.white),
              SizedBox(width: 12),
              Expanded(
                child: Text('Internet aloqasi topilmadi. Iltimos, internetga ulanib qayta urinib ko\'ring.'),
              ),
            ],
          ),
          backgroundColor: Colors.red.shade600,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          margin: EdgeInsets.all(20),
          duration: Duration(seconds: 4),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = ProgressData.getGradientColors();
    
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              colors[0].withOpacity(0.1),
              Colors.white,
              colors[1].withOpacity(0.1),
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Animated WiFi icon
                  ScaleTransition(
                    scale: _pulseAnimation,
                    child: Container(
                      width: 180,
                      height: 180,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.red.shade400,
                            Colors.red.shade600,
                          ],
                        ),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.red.withOpacity(0.3),
                            blurRadius: 30,
                            spreadRadius: 5,
                            offset: Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.wifi_off_rounded,
                        size: 90,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 50),
                  
                  // Title
                  Text(
                    'Internet Aloqasi Yo\'q',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Description
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.grey.shade300,
                      ),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: Colors.orange.shade700,
                          size: 30,
                        ),
                        SizedBox(height: 12),
                        Text(
                          'Iltimos, internetga ulaning',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Bu ilova ishlashi uchun internet aloqasi kerak',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                            height: 1.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 40),
                  
                  // Retry button
                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: _isChecking ? null : _checkConnection,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colors[0],
                        foregroundColor: Colors.white,
                        elevation: 8,
                        shadowColor: colors[0].withOpacity(0.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: _isChecking
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 3,
                                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                  ),
                                ),
                                SizedBox(width: 16),
                                Text(
                                  'Tekshirilmoqda...',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.refresh, size: 26),
                                SizedBox(width: 12),
                                Text(
                                  'Qayta Urinish',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Tips
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.blue.shade200,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.tips_and_updates, color: Colors.blue.shade700, size: 20),
                            SizedBox(width: 8),
                            Text(
                              'Maslahatlar:',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue.shade900,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12),
                        _buildTip('WiFi yoki mobil internetni yoqing'),
                        SizedBox(height: 6),
                        _buildTip('Parvoz rejimini o\'chiring'),
                        SizedBox(height: 6),
                        _buildTip('Routerni qayta ishga tushiring'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTip(String text) {
    return Row(
      children: [
        Container(
          width: 6,
          height: 6,
          decoration: BoxDecoration(
            color: Colors.blue.shade700,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 13,
              color: Colors.blue.shade900,
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void _updateProgress() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final totalProgress = ProgressData.getTotalProgress();
    final colors = ProgressData.getGradientColors();

    return Scaffold(
      body: Stack(
        children: [
          SimpleBackground(),
          SafeArea(
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(colors: colors),
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: colors[0].withOpacity(0.3),
                                    blurRadius: 15,
                                    offset: Offset(0, 8),
                                  ),
                                ],
                              ),
                              child: Text('🎓', style: TextStyle(fontSize: 32)),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Rus Tilini',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  Text(
                                    'O\'rganamiz',
                                    style: TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                      foreground: Paint()
                                        ..shader = LinearGradient(
                                          colors: colors,
                                        ).createShader(Rect.fromLTWH(0, 0, 200, 70)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        
                        // Progress Card - Yangilangan dizayn!
                        Container(
                          padding: EdgeInsets.all(28),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                colors[0],
                                colors[1],
                                colors[0].withOpacity(0.8),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(32),
                            boxShadow: [
                              BoxShadow(
                                color: colors[0].withOpacity(0.4),
                                blurRadius: 30,
                                offset: Offset(0, 15),
                                spreadRadius: 2,
                              ),
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 10,
                                offset: Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Stack(
                            children: [
                              // Background decorative circles
                              Positioned(
                                right: -30,
                                top: -30,
                                child: Container(
                                  width: 120,
                                  height: 120,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white.withOpacity(0.1),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: -20,
                                bottom: -20,
                                child: Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white.withOpacity(0.05),
                                  ),
                                ),
                              ),
                              
                              // Main content
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.all(8),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white.withOpacity(0.2),
                                                    borderRadius: BorderRadius.circular(12),
                                                  ),
                                                  child: Icon(
                                                    Icons.analytics_outlined,
                                                    color: Colors.white,
                                                    size: 20,
                                                  ),
                                                ),
                                                SizedBox(width: 12),
                                                Text(
                                                  'Umumiy Progress',
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                    shadows: [
                                                      Shadow(
                                                        color: Colors.black.withOpacity(0.3),
                                                        offset: Offset(0, 2),
                                                        blurRadius: 4,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 12),
                                            Container(
                                              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                              decoration: BoxDecoration(
                                                color: Colors.white.withOpacity(0.2),
                                                borderRadius: BorderRadius.circular(12),
                                                border: Border.all(
                                                  color: Colors.white.withOpacity(0.3),
                                                ),
                                              ),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    _getProgressEmoji(totalProgress),
                                                    style: TextStyle(fontSize: 14),
                                                  ),
                                                  SizedBox(width: 6),
                                                  Text(
                                                    _getProgressMessage(totalProgress),
                                                    style: TextStyle(
                                                      fontSize: 13,
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      // Circular progress
                                      Container(
                                        width: 90,
                                        height: 90,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white.withOpacity(0.2),
                                          border: Border.all(
                                            color: Colors.white.withOpacity(0.3),
                                            width: 3,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withOpacity(0.2),
                                              blurRadius: 15,
                                              offset: Offset(0, 5),
                                            ),
                                          ],
                                        ),
                                        child: Center(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                '$totalProgress%',
                                                style: TextStyle(
                                                  fontSize: 26,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                  shadows: [
                                                    Shadow(
                                                      color: Colors.black.withOpacity(0.3),
                                                      offset: Offset(0, 2),
                                                      blurRadius: 4,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Text(
                                                'Done',
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.white.withOpacity(0.9),
                                                  fontWeight: FontWeight.w500,
                                                  letterSpacing: 1,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 28),
                                  
                                  // Progress stats
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.all(16),
                                          decoration: BoxDecoration(
                                            color: Colors.white.withOpacity(0.15),
                                            borderRadius: BorderRadius.circular(20),
                                            border: Border.all(
                                              color: Colors.white.withOpacity(0.2),
                                            ),
                                          ),
                                          child: Column(
                                            children: [
                                              Container(
                                                padding: EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                  color: Colors.white.withOpacity(0.2),
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Text('🔤', style: TextStyle(fontSize: 24)),
                                              ),
                                              SizedBox(height: 12),
                                              Text(
                                                '${ProgressData.learnedLetters}/${ProgressData.totalLetters}',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              SizedBox(height: 4),
                                              Text(
                                                'Harflar',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white.withOpacity(0.9),
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 12),
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.all(16),
                                          decoration: BoxDecoration(
                                            color: Colors.white.withOpacity(0.15),
                                            borderRadius: BorderRadius.circular(20),
                                            border: Border.all(
                                              color: Colors.white.withOpacity(0.2),
                                            ),
                                          ),
                                          child: Column(
                                            children: [
                                              Container(
                                                padding: EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                  color: Colors.white.withOpacity(0.2),
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Text('💬', style: TextStyle(fontSize: 24)),
                                              ),
                                              SizedBox(height: 12),
                                              Text(
                                                '${ProgressData.learnedWords}/${ProgressData.totalWords}',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              SizedBox(height: 4),
                                              Text(
                                                'Gaplar',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white.withOpacity(0.9),
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        
                        const SizedBox(height: 30),
                        
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Bo\'limlar',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [colors[0].withOpacity(0.2), colors[1].withOpacity(0.2)],
                                ),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: colors[0].withOpacity(0.3),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.apps, color: colors[0], size: 16),
                                  SizedBox(width: 6),
                                  Text(
                                    '7 ta',
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: colors[0],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  sliver: SliverGrid(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: 0.85,
                    ),
                    delegate: SliverChildListDelegate([
                      MenuCard(
                        title: 'Harflar',
                        emoji: '🔤',
                        color: colors[0],
                        progress: ((ProgressData.learnedLetters / ProgressData.totalLetters) * 100).round(),
                        total: ProgressData.totalLetters,
                        learned: ProgressData.learnedLetters,
                        onTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const AlphabetScreen()),
                          );
                          _updateProgress();
                        },
                      ),
                      MenuCard(
                        title: 'Kundalik Gaplar',
                        emoji: '💬',
                        color: Color(0xFF3B82F6),
                        progress: ((ProgressData.learnedWords / ProgressData.totalWords) * 100).round(),
                        total: ProgressData.totalWords,
                        learned: ProgressData.learnedWords,
                        subtitle: '210 gap',
                        onTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const WordsScreen()),
                          );
                          _updateProgress();
                        },
                      ),
                      // ========== SHE'RLAR KARTASI - YANGI! ==========
                      MenuCard(
                        title: 'She\'rlar',
                        emoji: '📖',
                        color: Color(0xFFEF4444),
                        progress: ((ProgressData.readPoems / ProgressData.totalPoems) * 100).round(),
                        total: ProgressData.totalPoems,
                        learned: ProgressData.readPoems,
                        onTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const PoemsScreen()),
                          );
                          _updateProgress();
                        },
                      ),
                      MenuCard(
                        title: 'Tarjimon',
                        emoji: '🌐',
                        color: Color(0xFFEC4899),
                        progress: 100,
                        total: TranslationDictionary.getAllWords().length,
                        learned: TranslationDictionary.getAllWords().length,
                        onTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const TranslateScreen()),
                          );
                          _updateProgress();
                        },
                      ),
                      MenuCard(
                        title: 'O\'yinlar',
                        emoji: '🎮',
                        color: Color(0xFF10B981),
                        progress: ((ProgressData.gamesPlayed / ProgressData.totalGames) * 100).round(),
                        total: ProgressData.totalGames,
                        learned: ProgressData.gamesPlayed,
                        subtitle: '5 daraja',
                        onTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const MemoryGameScreen()),
                          );
                          _updateProgress();
                        },
                      ),
                      MenuCard(
                        title: 'Test',
                        emoji: '✅',
                        color: Color(0xFFF59E0B),
                        progress: ((ProgressData.quizzesPassed / ProgressData.totalQuizzes) * 100).round(),
                        total: ProgressData.totalQuizzes,
                        learned: ProgressData.quizzesPassed,
                        onTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const QuizScreen()),
                          );
                          _updateProgress();
                        },
                      ),
                      MenuCard(
                        title: 'So\'zlar Testi',
                        emoji: '📝',
                        color: Color(0xFF6366F1),
                        progress: ((ProgressData.wordTestsPassed / ProgressData.totalWordTests) * 100).round(),
                        total: ProgressData.totalWordTests,
                        learned: ProgressData.wordTestsPassed,
                        subtitle: '50 savol',
                        onTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const WordTestScreen()),
                          );
                          _updateProgress();
                        },
                      ),
                    ]),
                  ),
                ),
                SliverToBoxAdapter(child: SizedBox(height: 40)),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildProgressStat(String icon, int value, int total, String label) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(icon, style: TextStyle(fontSize: 24)),
          SizedBox(height: 8),
          Text(
            '$value/$total',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.white.withOpacity(0.9),
            ),
          ),
        ],
      ),
    );
  }
  
  String _getProgressMessage(int progress) {
    if (progress < 25) return 'Ajoyib boshlanish!';
    if (progress < 50) return 'Yaxshi ketmoqda!';
    if (progress < 75) return 'Ajoyib ish!';
    if (progress < 100) return 'Deyarli tugadingiz!';
    return 'Zo\'rsiz!';
  }
  
  String _getProgressEmoji(int progress) {
    if (progress < 25) return '💪';
    if (progress < 50) return '🚀';
    if (progress < 75) return '⭐';
    if (progress < 100) return '🎯';
    return '🏆';
  }
}

class MenuCard extends StatelessWidget {
  final String title;
  final String emoji;
  final Color color;
  final int progress;
  final int total;
  final int learned;
  final VoidCallback onTap;
  final String? subtitle;

  const MenuCard({
    Key? key,
    required this.title,
    required this.emoji,
    required this.color,
    required this.progress,
    required this.total,
    required this.learned,
    required this.onTap,
    this.subtitle,
  }) : super(key: key);

  Color _getDarkerShade(Color color) {
    return Color.fromRGBO(
      (color.red * 0.7).round(),
      (color.green * 0.7).round(),
      (color.blue * 0.7).round(),
      1,
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;
    final darkerColor = _getDarkerShade(color);
    
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(isSmallScreen ? 20 : 28),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              color,
              darkerColor,
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.4),
              blurRadius: 20,
              offset: Offset(0, 10),
              spreadRadius: 2,
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Background pattern
            Positioned(
              right: -20,
              top: -20,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.1),
                ),
              ),
            ),
            Positioned(
              right: 20,
              bottom: -10,
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.05),
                ),
              ),
            ),
            
            // Main content
            Padding(
              padding: EdgeInsets.all(isSmallScreen ? 14 : 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top section - Emoji
                  Container(
                    width: isSmallScreen ? 60 : 70,
                    height: isSmallScreen ? 60 : 70,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.25),
                      borderRadius: BorderRadius.circular(isSmallScreen ? 16 : 20),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.3),
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        emoji,
                        style: TextStyle(fontSize: isSmallScreen ? 32 : 38),
                      ),
                    ),
                  ),
                  
                  // Middle section - Title
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: isSmallScreen ? 18 : 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              color: Colors.black.withOpacity(0.3),
                              offset: Offset(0, 2),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                      ),
                      if (subtitle != null) ...[
                        SizedBox(height: 4),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.3),
                            ),
                          ),
                          child: Text(
                            subtitle!,
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  
                  // Bottom section - Progress
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '$learned/$total',
                            style: TextStyle(
                              fontSize: isSmallScreen ? 13 : 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.white.withOpacity(0.9),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: isSmallScreen ? 8 : 10, 
                              vertical: isSmallScreen ? 4 : 5
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.25),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.3),
                              ),
                            ),
                            child: Text(
                              title == 'Tarjimon' ? '${total} so\'z' : '$progress%',
                              style: TextStyle(
                                fontSize: isSmallScreen ? 11 : 13,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: isSmallScreen ? 8 : 10),
                      Stack(
                        children: [
                          Container(
                            height: isSmallScreen ? 6 : 8,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          FractionallySizedBox(
                            widthFactor: progress / 100,
                            child: Container(
                              height: isSmallScreen ? 6 : 8,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.white,
                                    Colors.white.withOpacity(0.8),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.white.withOpacity(0.5),
                                    blurRadius: 8,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ========== SHE'RLAR EKRANI - YANGI! ==========
class PoemsScreen extends StatelessWidget {
  const PoemsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colors = [Color(0xFFEF4444), Color(0xFFF87171)];
    final poems = PoemsDatabase.getAllPoems();

    return Scaffold(
      body: Stack(
        children: [
          SimpleBackground(),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: IconButton(
                          icon: Icon(Icons.arrow_back, color: colors[0]),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        '📖 Ruscha She\'rlar',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(20),
                    physics: const BouncingScrollPhysics(),
                    itemCount: poems.length,
                    itemBuilder: (context, index) {
                      return PoemCard(
                        poem: poems[index],
                        colors: colors,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PoemCard extends StatelessWidget {
  final Map<String, String> poem;
  final List<Color> colors;

  const PoemCard({
    Key? key,
    required this.poem,
    required this.colors,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => PoemDetailScreen(poem: poem, colors: colors),
          ),
        );
        
        if (!ProgressData.viewedPoems.contains(poem['title'])) {
          ProgressData.viewedPoems.add(poem['title']!);
          ProgressData.readPoems = ProgressData.viewedPoems.length;
        }
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: colors[0].withOpacity(0.1),
              blurRadius: 15,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    colors[0].withOpacity(0.2),
                    colors[1].withOpacity(0.15),
                  ],
                ),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Center(
                child: Text(
                  poem['emoji']!,
                  style: TextStyle(fontSize: 36),
                ),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    poem['title']!,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: colors[0],
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    poem['author']!,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: colors[0].withOpacity(0.5),
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}

// SHE'R TAFSILOTLARI EKRANI - YANGI!
class PoemDetailScreen extends StatelessWidget {
  final Map<String, String> poem;
  final List<Color> colors;

  const PoemDetailScreen({
    Key? key,
    required this.poem,
    required this.colors,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SimpleBackground(),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: IconButton(
                          icon: Icon(Icons.arrow_back, color: colors[0]),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          poem['emoji']! + ' ' + poem['title']!,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: colors[0].withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.person, color: colors[0], size: 20),
                              SizedBox(width: 8),
                              Text(
                                poem['author']!,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: colors[0],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                        
                        // Ruscha she'r
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(28),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: colors,
                            ),
                            borderRadius: BorderRadius.circular(28),
                            boxShadow: [
                              BoxShadow(
                                color: colors[0].withOpacity(0.3),
                                blurRadius: 20,
                                offset: Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      '🇷🇺 Ruscha',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Text(
                                poem['russian']!,
                                style: TextStyle(
                                  fontSize: 20,
                                  height: 1.8,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        
                        // O'zbekcha tarjima
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(28),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(28),
                            boxShadow: [
                              BoxShadow(
                                color: colors[0].withOpacity(0.15),
                                blurRadius: 20,
                                offset: Offset(0, 10),
                              ),
                            ],
                            border: Border.all(
                              color: colors[0].withOpacity(0.3),
                              width: 2,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                    decoration: BoxDecoration(
                                      color: colors[0].withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      '🇺🇿 O\'zbekcha',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: colors[0],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Text(
                                poem['uzbek']!,
                                style: TextStyle(
                                  fontSize: 18,
                                  height: 1.8,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                        
                        // Eslatma
                        Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: colors[0].withOpacity(0.05),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: colors[0].withOpacity(0.2),
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.lightbulb, color: colors[0], size: 24),
                              SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  'Bu she\'rni yodlash rus tilini o\'rganishda yordam beradi!',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black87,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
// ========== SHE'RLAR EKRANI TUGADI ==========

class TranslateScreen extends StatefulWidget {
  const TranslateScreen({Key? key}) : super(key: key);

  @override
  State<TranslateScreen> createState() => _TranslateScreenState();
}

class _TranslateScreenState extends State<TranslateScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _translationResult = '';
  String _selectedCategory = 'Hammasi';
  List<String> _searchResults = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    String query = _searchController.text.toLowerCase().trim();
    if (query.isEmpty) {
      setState(() {
        _translationResult = '';
        _searchResults = [];
      });
      return;
    }

    var details = TranslationDictionary.getWordDetails(query);
    if (details != null) {
      setState(() {
        _translationResult = details['translation']!;
        _searchResults = [];
      });
    } else {
      var allWords = TranslationDictionary.getAllWords();
      var matches = allWords.where((word) => word.contains(query)).toList();
      setState(() {
        _translationResult = '';
        _searchResults = matches.take(5).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = [Color(0xFFEC4899), Color(0xFFF472B6)];
    final categorizedWords = TranslationDictionary.getWordsByCategory();
    final categories = ['Hammasi'] + categorizedWords.keys.toList();

    return Scaffold(
      body: Stack(
        children: [
          SimpleBackground(),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: IconButton(
                          icon: Icon(Icons.arrow_back, color: colors[0]),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        '🌐 Tarjimon',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: colors[0].withOpacity(0.15),
                          blurRadius: 15,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: _searchController,
                      style: TextStyle(fontSize: 18, color: Colors.black87),
                      decoration: InputDecoration(
                        hintText: 'Rus tilida so\'z kiriting...',
                        hintStyle: TextStyle(color: Colors.black38),
                        border: InputBorder.none,
                        icon: Icon(Icons.search, color: colors[0]),
                        suffixIcon: _searchController.text.isNotEmpty
                            ? IconButton(
                                icon: Icon(Icons.clear, color: Colors.black38),
                                onPressed: () {
                                  _searchController.clear();
                                },
                              )
                            : null,
                      ),
                    ),
                  ),
                ),

                if (_translationResult.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: colors),
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: colors[0].withOpacity(0.3),
                            blurRadius: 20,
                            offset: Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Text(
                            'Tarjima:',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white.withOpacity(0.9),
                            ),
                          ),
                          SizedBox(height: 12),
                          Text(
                            _translationResult,
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                if (_searchResults.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Shunga o\'xshash so\'zlar:',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black54,
                          ),
                        ),
                        SizedBox(height: 12),
                        ..._searchResults.map((word) {
                          var details = TranslationDictionary.getWordDetails(word)!;
                          return GestureDetector(
                            onTap: () {
                              _searchController.text = word;
                            },
                            child: Container(
                              margin: EdgeInsets.only(bottom: 8),
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: colors[0].withOpacity(0.2),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Text(details['emoji']!, style: TextStyle(fontSize: 24)),
                                  SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          word,
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: colors[0],
                                          ),
                                        ),
                                        Text(
                                          details['translation']!,
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black54,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Icon(Icons.arrow_forward_ios, size: 16, color: colors[0]),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ],
                    ),
                  ),

                if (_searchController.text.isEmpty)
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: categories.map((category) {
                          bool isSelected = _selectedCategory == category;
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedCategory = category;
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.only(right: 12),
                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              decoration: BoxDecoration(
                                gradient: isSelected
                                    ? LinearGradient(colors: colors)
                                    : null,
                                color: isSelected ? null : Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: isSelected ? Colors.transparent : colors[0].withOpacity(0.3),
                                ),
                              ),
                              child: Text(
                                category,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: isSelected ? Colors.white : colors[0],
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),

                if (_searchController.text.isEmpty)
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      itemCount: _selectedCategory == 'Hammasi'
                          ? TranslationDictionary.getAllWords().length
                          : categorizedWords[_selectedCategory]?.length ?? 0,
                      itemBuilder: (context, index) {
                        String word = _selectedCategory == 'Hammasi'
                            ? TranslationDictionary.getAllWords()[index]
                            : categorizedWords[_selectedCategory]![index];
                        var details = TranslationDictionary.getWordDetails(word)!;

                        return Container(
                          margin: EdgeInsets.only(bottom: 12),
                          padding: EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: colors[0].withOpacity(0.08),
                                blurRadius: 10,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      colors[0].withOpacity(0.2),
                                      colors[1].withOpacity(0.15),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: Center(
                                  child: Text(
                                    details['emoji']!,
                                    style: TextStyle(fontSize: 28),
                                  ),
                                ),
                              ),
                              SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      word,
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: colors[0],
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      details['translation']!,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black54,
                                      ),
                                    ),
                                    if (_selectedCategory == 'Hammasi')
                                      Container(
                                        margin: EdgeInsets.only(top: 6),
                                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: colors[0].withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Text(
                                          details['category']!,
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: colors[0],
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AlphabetScreen extends StatelessWidget {
  const AlphabetScreen({Key? key}) : super(key: key);

  static const List<Map<String, String>> alphabet = [
    {'letter': 'А', 'transcription': 'a', 'sound': 'а', 'example': 'Арбуз (arbuz) - tarvuz'},
    {'letter': 'Б', 'transcription': 'b', 'sound': 'б', 'example': 'Банан (banan) - banan'},
    {'letter': 'В', 'transcription': 'v', 'sound': 'в', 'example': 'Вода (vada) - suv'},
    {'letter': 'Г', 'transcription': 'g', 'sound': 'г', 'example': 'Гриб (grib) - qo\'ziqorin'},
    {'letter': 'Д', 'transcription': 'd', 'sound': 'д', 'example': 'Дом (dom) - uy'},
    {'letter': 'Е', 'transcription': 'ye', 'sound': 'йэ', 'example': 'Ель (yel\') - archa'},
    {'letter': 'Ё', 'transcription': 'yo', 'sound': 'йо', 'example': 'Ёж (yozh) - tipratikan'},
    {'letter': 'Ж', 'transcription': 'zh', 'sound': 'ж', 'example': 'Жук (zhuk) - qo\'ng\'iz'},
    {'letter': 'З', 'transcription': 'z', 'sound': 'з', 'example': 'Заяц (zayats) - quyon'},
    {'letter': 'И', 'transcription': 'i', 'sound': 'и', 'example': 'Игра (igra) - o\'yin'},
    {'letter': 'Й', 'transcription': 'y', 'sound': 'й', 'example': 'Йод (yod) - yod'},
    {'letter': 'К', 'transcription': 'k', 'sound': 'к', 'example': 'Кот (kot) - mushuk'},
    {'letter': 'Л', 'transcription': 'l', 'sound': 'л', 'example': 'Лес (les) - o\'rmon'},
    {'letter': 'М', 'transcription': 'm', 'sound': 'м', 'example': 'Мама (mama) - ona'},
    {'letter': 'Н', 'transcription': 'n', 'sound': 'н', 'example': 'Нос (nos) - burun'},
    {'letter': 'О', 'transcription': 'o', 'sound': 'о', 'example': 'Окно (akno) - deraza'},
    {'letter': 'П', 'transcription': 'p', 'sound': 'п', 'example': 'Папа (papa) - ota'},
    {'letter': 'Р', 'transcription': 'r', 'sound': 'р', 'example': 'Рука (ruka) - qo\'l'},
    {'letter': 'С', 'transcription': 's', 'sound': 'с', 'example': 'Стол (stol) - stol'},
    {'letter': 'Т', 'transcription': 't', 'sound': 'т', 'example': 'Торт (tort) - tort'},
    {'letter': 'У', 'transcription': 'u', 'sound': 'у', 'example': 'Утро (utra) - tong'},
    {'letter': 'Ф', 'transcription': 'f', 'sound': 'ф', 'example': 'Флаг (flag) - bayroq'},
    {'letter': 'Х', 'transcription': 'kh', 'sound': 'х', 'example': 'Хлеб (xleb) - non'},
    {'letter': 'Ц', 'transcription': 'ts', 'sound': 'ц', 'example': 'Цветок (tsvetok) - gul'},
    {'letter': 'Ч', 'transcription': 'ch', 'sound': 'ч', 'example': 'Часы (chasy) - soat'},
    {'letter': 'Ш', 'transcription': 'sh', 'sound': 'ш', 'example': 'Шар (shar) - shar'},
    {'letter': 'Щ', 'transcription': 'shch', 'sound': 'щ', 'example': 'Щука (shchuka) - baliq'},
    {'letter': 'Ъ', 'transcription': '', 'sound': 'ajratuvchi belgi', 'example': 'Объект - obyekt'},
    {'letter': 'Ы', 'transcription': 'y', 'sound': 'ы', 'example': 'Мы (my) - biz'},
    {'letter': 'Ь', 'transcription': '', 'sound': 'yumshatuvchi belgi', 'example': 'День (den\') - kun'},
    {'letter': 'Э', 'transcription': 'e', 'sound': 'э', 'example': 'Эхо (exa) - aks-sado'},
    {'letter': 'Ю', 'transcription': 'yu', 'sound': 'йу', 'example': 'Юла (yula) - o\'yinchoq'},
    {'letter': 'Я', 'transcription': 'ya', 'sound': 'йа', 'example': 'Яблоко (yablaka) - olma'},
  ];

  @override
  Widget build(BuildContext context) {
    final colors = ProgressData.getGradientColors();
    
    return Scaffold(
      body: Stack(
        children: [
          SimpleBackground(),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: IconButton(
                          icon: Icon(Icons.arrow_back, color: colors[0]),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        '🔤 Rus Alifbosi',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(20),
                    physics: const BouncingScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: 0.9,
                    ),
                    itemCount: alphabet.length,
                    itemBuilder: (context, index) {
                      return LetterCard(
                        letter: alphabet[index]['letter']!,
                        transcription: alphabet[index]['transcription']!,
                        sound: alphabet[index]['sound']!,
                        example: alphabet[index]['example']!,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class LetterCard extends StatelessWidget {
  final String letter;
  final String transcription;
  final String sound;
  final String example;

  const LetterCard({
    Key? key,
    required this.letter,
    required this.transcription,
    required this.sound,
    required this.example,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colors = ProgressData.getGradientColors();
    
    return GestureDetector(
      onTap: () {
        _showLetterDialog(context);
        
        if (!ProgressData.viewedLetters.contains(letter)) {
          ProgressData.viewedLetters.add(letter);
          ProgressData.learnedLetters = ProgressData.viewedLetters.length;
        }
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: colors,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: colors[0].withOpacity(0.3),
              blurRadius: 15,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              letter,
              style: TextStyle(
                fontSize: 56,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            if (transcription.isNotEmpty)
              Text(
                '[$transcription]',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white.withOpacity(0.85),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _showLetterDialog(BuildContext context) {
    final colors = ProgressData.getGradientColors();
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
          child: Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: colors,
              ),
              borderRadius: BorderRadius.circular(32),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(28),
                  ),
                  child: Center(
                    child: Text(
                      letter,
                      style: TextStyle(
                        fontSize: 72,
                        fontWeight: FontWeight.bold,
                        color: colors[0],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Column(
                    children: [
                      Text(
                        '📢 Talaffuz',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        sound,
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Column(
                    children: [
                      Text(
                        '📝 Misol',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        example,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: colors[0],
                    padding: EdgeInsets.symmetric(horizontal: 36, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'Yopish',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class WordsScreen extends StatelessWidget {
  const WordsScreen({Key? key}) : super(key: key);

  static const List<Map<String, String>> words = [
    // Salomlashish va oddiy gaplar (20 ta)
    {'russian': 'Здравствуйте!', 'uzbek': 'Assalomu alaykum!', 'emoji': '👋'},
    {'russian': 'Доброе утро!', 'uzbek': 'Xayrli tong!', 'emoji': '🌅'},
    {'russian': 'Добрый день!', 'uzbek': 'Xayrli kun!', 'emoji': '☀️'},
    {'russian': 'Добрый вечер!', 'uzbek': 'Xayrli kech!', 'emoji': '🌆'},
    {'russian': 'Спокойной ночи!', 'uzbek': 'Xayrli tun!', 'emoji': '🌙'},
    {'russian': 'До свидания!', 'uzbek': 'Xayr!', 'emoji': '👋'},
    {'russian': 'До скорой встречи!', 'uzbek': 'Ko\'rishguncha!', 'emoji': '🤝'},
    {'russian': 'Как дела?', 'uzbek': 'Qalaysiz?', 'emoji': '😊'},
    {'russian': 'Как вы поживаете?', 'uzbek': 'Ahvolingiz qalay?', 'emoji': '🙂'},
    {'russian': 'Хорошо, спасибо!', 'uzbek': 'Yaxshi, rahmat!', 'emoji': '👍'},
    {'russian': 'Отлично!', 'uzbek': 'Ajoyib!', 'emoji': '🌟'},
    {'russian': 'Неплохо', 'uzbek': 'Yomon emas', 'emoji': '😌'},
    {'russian': 'Так себе', 'uzbek': 'Shuncha-muncha', 'emoji': '😐'},
    {'russian': 'Рад вас видеть!', 'uzbek': 'Sizni ko\'rganimdan xursandman!', 'emoji': '😃'},
    {'russian': 'Очень приятно!', 'uzbek': 'Juda xursandman!', 'emoji': '😊'},
    {'russian': 'Меня зовут...', 'uzbek': 'Mening ismim...', 'emoji': '👤'},
    {'russian': 'Приятно познакомиться', 'uzbek': 'Tanishganimdan xursandman', 'emoji': '🤝'},
    {'russian': 'Извините!', 'uzbek': 'Kechirasiz!', 'emoji': '🙏'},
    {'russian': 'Простите!', 'uzbek': 'Uzr!', 'emoji': '🙇'},
    {'russian': 'Не за что', 'uzbek': 'Arzimaydi', 'emoji': '😊'},
    
    // Iltimos va so'rashlar (15 ta)
    {'russian': 'Можно?', 'uzbek': 'Mumkinmi?', 'emoji': '🙋'},
    {'russian': 'Разрешите', 'uzbek': 'Ruxsat bering', 'emoji': '🤲'},
    {'russian': 'Можно войти?', 'uzbek': 'Kirsam bo\'ladimi?', 'emoji': '🚪'},
    {'russian': 'Помогите, пожалуйста', 'uzbek': 'Yordam bering, iltimos', 'emoji': '🆘'},
    {'russian': 'Не могли бы вы помочь?', 'uzbek': 'Yordam bera olasizmi?', 'emoji': '🙏'},
    {'russian': 'Подскажите, пожалуйста', 'uzbek': 'Aytib bering, iltimos', 'emoji': '🗣️'},
    {'russian': 'Будьте добры', 'uzbek': 'Iltimos', 'emoji': '😊'},
    {'russian': 'Не беспокойтесь', 'uzbek': 'Tashvishlanmang', 'emoji': '😌'},
    {'russian': 'Не волнуйтесь', 'uzbek': 'Xavotir olmang', 'emoji': '😊'},
    {'russian': 'Всё в порядке', 'uzbek': 'Hammasi joyida', 'emoji': '👌'},
    {'russian': 'Хорошо', 'uzbek': 'Xo\'p', 'emoji': '✅'},
    {'russian': 'Конечно', 'uzbek': 'Albatta', 'emoji': '💯'},
    {'russian': 'Без проблем', 'uzbek': 'Muammo yo\'q', 'emoji': '👍'},
    {'russian': 'С удовольствием', 'uzbek': 'Mamnuniyat bilan', 'emoji': '😊'},
    {'russian': 'Я согласен', 'uzbek': 'Men roziman', 'emoji': '✅'},
    
    // Do'konda (15 ta)
    {'russian': 'Сколько стоит?', 'uzbek': 'Bu qancha turadi?', 'emoji': '💰'},
    {'russian': 'Это дорого', 'uzbek': 'Bu qimmat', 'emoji': '💸'},
    {'russian': 'Это дешево', 'uzbek': 'Bu arzon', 'emoji': '👍'},
    {'russian': 'Дайте, пожалуйста', 'uzbek': 'Bering, iltimos', 'emoji': '🛒'},
    {'russian': 'Покажите, пожалуйста', 'uzbek': 'Ko\'rsating, iltimos', 'emoji': '👀'},
    {'russian': 'Я возьму это', 'uzbek': 'Men buni olaman', 'emoji': '🛍️'},
    {'russian': 'Мне нужно...', 'uzbek': 'Menga kerak...', 'emoji': '📝'},
    {'russian': 'У вас есть...?', 'uzbek': 'Sizda... bormi?', 'emoji': '❓'},
    {'russian': 'Сдача', 'uzbek': 'Qaytim', 'emoji': '💵'},
    {'russian': 'Где касса?', 'uzbek': 'Kassa qayerda?', 'emoji': '🏪'},
    {'russian': 'Могу я примерить?', 'uzbek': 'Kiyib ko\'rsam bo\'ladimi?', 'emoji': '👔'},
    {'russian': 'Это мне подходит', 'uzbek': 'Bu menga mos keladi', 'emoji': '👌'},
    {'russian': 'Это не подходит', 'uzbek': 'Bu mos kelmadi', 'emoji': '❌'},
    {'russian': 'Можно скидку?', 'uzbek': 'Chegirma qilasizmi?', 'emoji': '💳'},
    {'russian': 'Заверните, пожалуйста', 'uzbek': 'O\'rab bering, iltimos', 'emoji': '🎁'},
    
    // Yo'l so'rash (12 ta)
    {'russian': 'Где находится...?', 'uzbek': '... qayerda joylashgan?', 'emoji': '📍'},
    {'russian': 'Как пройти к...?', 'uzbek': '...ga qanday borish mumkin?', 'emoji': '🚶'},
    {'russian': 'Это далеко?', 'uzbek': 'Bu uzoqmi?', 'emoji': '🛣️'},
    {'russian': 'Это близко?', 'uzbek': 'Bu yaqinmi?', 'emoji': '📏'},
    {'russian': 'Направо', 'uzbek': 'O\'ngga', 'emoji': '➡️'},
    {'russian': 'Налево', 'uzbek': 'Chapga', 'emoji': '⬅️'},
    {'russian': 'Прямо', 'uzbek': 'To\'g\'ri', 'emoji': '⬆️'},
    {'russian': 'Назад', 'uzbek': 'Orqaga', 'emoji': '⬇️'},
    {'russian': 'Я заблудился', 'uzbek': 'Men adashib qoldim', 'emoji': '😵'},
    {'russian': 'Покажите на карте', 'uzbek': 'Xaritada ko\'rsating', 'emoji': '🗺️'},
    {'russian': 'Спасибо за помощь', 'uzbek': 'Yordam uchun rahmat', 'emoji': '🙏'},
    {'russian': 'Вы очень добры', 'uzbek': 'Siz juda mehribonsiz', 'emoji': '😊'},
    
    // Restoranda (10 ta)
    {'russian': 'Меню, пожалуйста', 'uzbek': 'Menyu, iltimos', 'emoji': '📋'},
    {'russian': 'Я хочу заказать', 'uzbek': 'Men buyurtma bermoqchiman', 'emoji': '🍽️'},
    {'russian': 'Принесите счёт', 'uzbek': 'Hisob keltiring', 'emoji': '💳'},
    {'russian': 'Было очень вкусно', 'uzbek': 'Juda mazali edi', 'emoji': '😋'},
    {'russian': 'Приятного аппетита!', 'uzbek': 'Yoqimli ishtaha!', 'emoji': '🍴'},
    {'russian': 'Можно воды?', 'uzbek': 'Suv olsam bo\'ladimi?', 'emoji': '💧'},
    {'russian': 'Что вы посоветуете?', 'uzbek': 'Nimani tavsiya qilasiz?', 'emoji': '🤔'},
    {'russian': 'Это острое?', 'uzbek': 'Bu achchiqmi?', 'emoji': '🌶️'},
    {'russian': 'Без соли', 'uzbek': 'Tuzsiz', 'emoji': '🧂'},
    {'russian': 'Я наелся', 'uzbek': 'Men to\'q bo\'ldim', 'emoji': '😌'},
    
    // Vaqt (8 ta)
    {'russian': 'Который час?', 'uzbek': 'Soat necha bo\'ldi?', 'emoji': '⏰'},
    {'russian': 'Когда?', 'uzbek': 'Qachon?', 'emoji': '📅'},
    {'russian': 'Во сколько?', 'uzbek': 'Soat nechada?', 'emoji': '🕐'},
    {'russian': 'Сейчас', 'uzbek': 'Hozir', 'emoji': '⏱️'},
    {'russian': 'Позже', 'uzbek': 'Keyinroq', 'emoji': '⏳'},
    {'russian': 'Скоро', 'uzbek': 'Tez orada', 'emoji': '⌛'},
    {'russian': 'Подождите минуту', 'uzbek': 'Bir daqiqa kuting', 'emoji': '⏲️'},
    {'russian': 'Я спешу', 'uzbek': 'Men shoshilyapman', 'emoji': '🏃'},
    
    // Umumiy savollar (10 ta)
    {'russian': 'Что это?', 'uzbek': 'Bu nima?', 'emoji': '❓'},
    {'russian': 'Кто это?', 'uzbek': 'Bu kim?', 'emoji': '👤'},
    {'russian': 'Почему?', 'uzbek': 'Nega?', 'emoji': '🤔'},
    {'russian': 'Как?', 'uzbek': 'Qanday?', 'emoji': '❔'},
    {'russian': 'Зачем?', 'uzbek': 'Nima uchun?', 'emoji': '🤷'},
    {'russian': 'Когда?', 'uzbek': 'Qachon?', 'emoji': '📆'},
    {'russian': 'Где?', 'uzbek': 'Qayerda?', 'emoji': '📍'},
    {'russian': 'Сколько?', 'uzbek': 'Qancha?', 'emoji': '🔢'},
    {'russian': 'Откуда?', 'uzbek': 'Qayerdan?', 'emoji': '🗺️'},
    {'russian': 'Куда?', 'uzbek': 'Qayerga?', 'emoji': '🧭'},
    
    // Tushunish va til (10 ta)
    {'russian': 'Я не понимаю', 'uzbek': 'Men tushunmayapman', 'emoji': '😕'},
    {'russian': 'Я понимаю', 'uzbek': 'Men tushunyapman', 'emoji': '💡'},
    {'russian': 'Повторите, пожалуйста', 'uzbek': 'Qaytaring, iltimos', 'emoji': '🔄'},
    {'russian': 'Говорите медленнее', 'uzbek': 'Sekinroq gapiring', 'emoji': '🐌'},
    {'russian': 'Я не говорю по-русски', 'uzbek': 'Men ruscha gapirmayman', 'emoji': '🗣️'},
    {'russian': 'Вы говорите по-узбекски?', 'uzbek': 'Siz o\'zbekcha gapira olasizmi?', 'emoji': '🇺🇿'},
    {'russian': 'Я учу русский язык', 'uzbek': 'Men rus tilini o\'rganyapman', 'emoji': '📚'},
    {'russian': 'Как это сказать?', 'uzbek': 'Buni qanday aytiladi?', 'emoji': '💬'},
    {'russian': 'Что значит...?', 'uzbek': '... nimani anglatadi?', 'emoji': '❓'},
    {'russian': 'Напишите, пожалуйста', 'uzbek': 'Yozib bering, iltimos', 'emoji': '✍️'},
    
    // MAKTAB va O'QUV (20 ta)
    {'russian': 'Где находится школа?', 'uzbek': 'Maktab qayerda?', 'emoji': '🏫'},
    {'russian': 'Можно войти в класс?', 'uzbek': 'Sinfga kirish mumkinmi?', 'emoji': '🚪'},
    {'russian': 'Я опоздал на урок', 'uzbek': 'Men darsga kechikdim', 'emoji': '⏰'},
    {'russian': 'У меня есть вопрос', 'uzbek': 'Menda savol bor', 'emoji': '❓'},
    {'russian': 'Можно выйти?', 'uzbek': 'Chiqsam bo\'ladimi?', 'emoji': '🚶'},
    {'russian': 'Я не понял задание', 'uzbek': 'Men topshiriqni tushunmadim', 'emoji': '📝'},
    {'russian': 'Когда экзамен?', 'uzbek': 'Imtihon qachon?', 'emoji': '📋'},
    {'russian': 'Какое домашнее задание?', 'uzbek': 'Uy vazifasi nima?', 'emoji': '📚'},
    {'russian': 'Можно посмотреть учебник?', 'uzbek': 'Darslikka qarasam bo\'ladimi?', 'emoji': '📖'},
    {'russian': 'Где библиотека?', 'uzbek': 'Kutubxona qayerda?', 'emoji': '📚'},
    {'russian': 'Мне нужна ручка', 'uzbek': 'Menga ruchka kerak', 'emoji': '✏️'},
    {'russian': 'У вас есть карандаш?', 'uzbek': 'Sizda qalam bormi?', 'emoji': '✏️'},
    {'russian': 'Можно стереть доску?', 'uzbek': 'Doskani o\'chirish mumkinmi?', 'emoji': '🧹'},
    {'russian': 'Я готов к уроку', 'uzbek': 'Men darsga tayyorman', 'emoji': '✅'},
    {'russian': 'Спасибо за урок', 'uzbek': 'Dars uchun rahmat', 'emoji': '🙏'},
    {'russian': 'До следующего урока', 'uzbek': 'Keyingi darsgacha', 'emoji': '👋'},
    {'russian': 'Можно пересдать экзамен?', 'uzbek': 'Imtihonni qayta topshirish mumkinmi?', 'emoji': '📝'},
    {'russian': 'Где столовая?', 'uzbek': 'Oshxona qayerda?', 'emoji': '🍽️'},
    {'russian': 'Можно взять перерыв?', 'uzbek': 'Tanaffus qilish mumkinmi?', 'emoji': '☕'},
    {'russian': 'Я закончил работу', 'uzbek': 'Men ishni tugalladim', 'emoji': '✅'},
    
    // ISH va OFIS (20 ta)
    {'russian': 'Где мой кабинет?', 'uzbek': 'Mening xonam qayerda?', 'emoji': '🏢'},
    {'russian': 'Когда начинается работа?', 'uzbek': 'Ish qachon boshlanadi?', 'emoji': '⏰'},
    {'russian': 'Где можно пообедать?', 'uzbek': 'Qayerda tushlik qilish mumkin?', 'emoji': '🍽️'},
    {'russian': 'Можно взять отпуск?', 'uzbek': 'Ta\'til olish mumkinmi?', 'emoji': '🏖️'},
    {'russian': 'Я заболел', 'uzbek': 'Men kasal bo\'ldim', 'emoji': '🤒'},
    {'russian': 'Где туалет?', 'uzbek': 'Hojatxona qayerda?', 'emoji': '🚻'},
    {'russian': 'Можно включить свет?', 'uzbek': 'Chiroqni yoqish mumkinmi?', 'emoji': '💡'},
    {'russian': 'Где принтер?', 'uzbek': 'Printer qayerda?', 'emoji': '🖨️'},
    {'russian': 'Мне нужна бумага', 'uzbek': 'Menga qog\'oz kerak', 'emoji': '📄'},
    {'russian': 'Можно использовать компьютер?', 'uzbek': 'Kompyuterdan foydalanish mumkinmi?', 'emoji': '💻'},
    {'russian': 'Где директор?', 'uzbek': 'Direktor qayerda?', 'emoji': '👔'},
    {'russian': 'У меня встреча', 'uzbek': 'Mening uchrashuvim bor', 'emoji': '🤝'},
    {'russian': 'Можно перенести встречу?', 'uzbek': 'Uchrashuvni ko\'chirish mumkinmi?', 'emoji': '📅'},
    {'russian': 'Я работаю удалённо', 'uzbek': 'Men masofadan ishlayman', 'emoji': '🏠'},
    {'russian': 'Когда зарплата?', 'uzbek': 'Maosh qachon?', 'emoji': '💰'},
    {'russian': 'Где подписать договор?', 'uzbek': 'Shartnomani qayerda imzolash kerak?', 'emoji': '📝'},
    {'russian': 'Я уже в офисе', 'uzbek': 'Men allaqachon ofisdaman', 'emoji': '🏢'},
    {'russian': 'Можно уйти пораньше?', 'uzbek': 'Erta ketish mumkinmi?', 'emoji': '🚶'},
    {'russian': 'Где парковка?', 'uzbek': 'To\'xtash joyi qayerda?', 'emoji': '🅿️'},
    {'russian': 'Спасибо за работу', 'uzbek': 'Ish uchun rahmat', 'emoji': '🙏'},
    
    // DORIXONA va SHIFOXONA (15 ta)
    {'russian': 'Где аптека?', 'uzbek': 'Dorixona qayerda?', 'emoji': '💊'},
    {'russian': 'Мне нужно лекарство', 'uzbek': 'Menga dori kerak', 'emoji': '💊'},
    {'russian': 'У меня болит голова', 'uzbek': 'Boshim og\'riyapti', 'emoji': '🤕'},
    {'russian': 'У меня температура', 'uzbek': 'Haroratim bor', 'emoji': '🌡️'},
    {'russian': 'Мне нужен врач', 'uzbek': 'Menga shifokor kerak', 'emoji': '👨‍⚕️'},
    {'russian': 'Где регистратура?', 'uzbek': 'Registratura qayerda?', 'emoji': '📋'},
    {'russian': 'Можно записаться?', 'uzbek': 'Yozilish mumkinmi?', 'emoji': '📝'},
    {'russian': 'У меня есть рецепт', 'uzbek': 'Menda retsept bor', 'emoji': '📄'},
    {'russian': 'Сколько стоит анализ?', 'uzbek': 'Tahlil qancha turadi?', 'emoji': '💉'},
    {'russian': 'Когда будут результаты?', 'uzbek': 'Natija qachon tayyor bo\'ladi?', 'emoji': '📊'},
    {'russian': 'Мне плохо', 'uzbek': 'Mening ahvolim yomon', 'emoji': '😷'},
    {'russian': 'Где процедурный кабинет?', 'uzbek': 'Muolaja xonasi qayerda?', 'emoji': '💉'},
    {'russian': 'Можно вызвать скорую?', 'uzbek': 'Tez yordam chaqirish mumkinmi?', 'emoji': '🚑'},
    {'russian': 'Где стоматолог?', 'uzbek': 'Stomatolog qayerda?', 'emoji': '🦷'},
    {'russian': 'Спасибо, доктор', 'uzbek': 'Rahmat, doktor', 'emoji': '🙏'},
    
    // BANK va POCHTA (15 ta)
    {'russian': 'Где банк?', 'uzbek': 'Bank qayerda?', 'emoji': '🏦'},
    {'russian': 'Мне нужно снять деньги', 'uzbek': 'Menga pul yechib olish kerak', 'emoji': '💰'},
    {'russian': 'Где банкомат?', 'uzbek': 'Bankomat qayerda?', 'emoji': '🏧'},
    {'russian': 'Можно открыть счёт?', 'uzbek': 'Hisob ochish mumkinmi?', 'emoji': '💳'},
    {'russian': 'Где почта?', 'uzbek': 'Pochta qayerda?', 'emoji': '📮'},
    {'russian': 'Мне нужно отправить посылку', 'uzbek': 'Menga posilka jo\'natish kerak', 'emoji': '📦'},
    {'russian': 'Сколько стоит марка?', 'uzbek': 'Marka qancha turadi?', 'emoji': '📬'},
    {'russian': 'Можно получить перевод?', 'uzbek': 'Pul o\'tkazmasini olish mumkinmi?', 'emoji': '💸'},
    {'russian': 'Где касса?', 'uzbek': 'Kassa qayerda?', 'emoji': '💵'},
    {'russian': 'Мне пришла посылка', 'uzbek': 'Menga posilka keldi', 'emoji': '📦'},
    {'russian': 'Можно обменять валюту?', 'uzbek': 'Valyuta almashtirish mumkinmi?', 'emoji': '💱'},
    {'russian': 'Какой курс доллара?', 'uzbek': 'Dollar kursi qancha?', 'emoji': '💵'},
    {'russian': 'Где заполнить бланк?', 'uzbek': 'Blankni qayerda to\'ldirish kerak?', 'emoji': '📝'},
    {'russian': 'У меня нет мелочи', 'uzbek': 'Menda mayda pul yo\'q', 'emoji': '💰'},
    {'russian': 'Можно оплатить картой?', 'uzbek': 'Karta bilan to\'lash mumkinmi?', 'emoji': '💳'},
    
    // AEROPORTDA va VOKZALDA (15 ta)
    {'russian': 'Где регистрация?', 'uzbek': 'Registratsiya qayerda?', 'emoji': '✈️'},
    {'russian': 'Где мой багаж?', 'uzbek': 'Mening yukim qayerda?', 'emoji': '🧳'},
    {'russian': 'Когда посадка?', 'uzbek': 'Qachon ko\'tarilish?', 'emoji': '🛫'},
    {'russian': 'Где выход?', 'uzbek': 'Chiqish qayerda?', 'emoji': '🚪'},
    {'russian': 'Мой рейс задержали', 'uzbek': 'Mening reysim kechiktirildi', 'emoji': '⏰'},
    {'russian': 'Где таможня?', 'uzbek': 'Bojxona qayerda?', 'emoji': '🛃'},
    {'russian': 'Можно купить билет?', 'uzbek': 'Chipta sotib olish mumkinmi?', 'emoji': '🎫'},
    {'russian': 'Где платформа?', 'uzbek': 'Platforma qayerda?', 'emoji': '🚉'},
    {'russian': 'Когда отправление?', 'uzbek': 'Qachon jo\'naydi?', 'emoji': '🚂'},
    {'russian': 'Где зал ожидания?', 'uzbek': 'Kutish zali qayerda?', 'emoji': '⏳'},
    {'russian': 'Мне нужен носильщик', 'uzbek': 'Menga yuk ko\'taruvchi kerak', 'emoji': '🧳'},
    {'russian': 'Где обмен валюты?', 'uzbek': 'Valyuta almashtirish qayerda?', 'emoji': '💱'},
    {'russian': 'Можно зарядить телефон?', 'uzbek': 'Telefonni quvvatlash mumkinmi?', 'emoji': '🔌'},
    {'russian': 'Где информация?', 'uzbek': 'Ma\'lumot qayerda?', 'emoji': 'ℹ️'},
    {'russian': 'Мне нужна помощь', 'uzbek': 'Menga yordam kerak', 'emoji': '🆘'},
    
    // RESTORAN va KAFE (10 ta)
    {'russian': 'Есть свободные места?', 'uzbek': 'Bo\'sh joy bormi?', 'emoji': '🪑'},
    {'russian': 'Можно за окном?', 'uzbek': 'Deraza yonida bo\'lsa?', 'emoji': '🪟'},
    {'russian': 'Что посоветуете?', 'uzbek': 'Nima tavsiya qilasiz?', 'emoji': '🤔'},
    {'russian': 'У меня аллергия', 'uzbek': 'Menda allergiya bor', 'emoji': '⚠️'},
    {'russian': 'Можно без лука?', 'uzbek': 'Pivozsiz bo\'ladi?', 'emoji': '🧅'},
    {'russian': 'Это острое?', 'uzbek': 'Bu achchiqmi?', 'emoji': '🌶️'},
    {'russian': 'Я вегетарианец', 'uzbek': 'Men vegetarianman', 'emoji': '🥗'},
    {'russian': 'Можно упаковать с собой?', 'uzbek': 'O\'zim bilan olib ketish mumkinmi?', 'emoji': '📦'},
    {'russian': 'Где туалет?', 'uzbek': 'Hojatxona qayerda?', 'emoji': '🚻'},
    {'russian': 'Можно WiFi пароль?', 'uzbek': 'WiFi paroli mumkinmi?', 'emoji': '📶'},
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;
    
    return Scaffold(
      body: Stack(
        children: [
          SimpleBackground(),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(isSmallScreen ? 16.0 : 20.0),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: IconButton(
                          icon: Icon(Icons.arrow_back, color: Color(0xFF3B82F6)),
                          onPressed: () => Navigator.pop(context),
                          padding: EdgeInsets.all(isSmallScreen ? 8 : 12),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '💬 Kundalik Gaplar',
                              style: TextStyle(
                                fontSize: isSmallScreen ? 18 : 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            Text(
                              '210 ta foydali ibora',
                              style: TextStyle(
                                fontSize: isSmallScreen ? 12 : 14,
                                color: Colors.black54,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.all(isSmallScreen ? 16 : 20),
                    physics: const BouncingScrollPhysics(),
                    itemCount: words.length,
                    itemBuilder: (context, index) {
                      return WordCard(
                        russian: words[index]['russian']!,
                        uzbek: words[index]['uzbek']!,
                        emoji: words[index]['emoji']!,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class WordCard extends StatelessWidget {
  final String russian;
  final String uzbek;
  final String emoji;

  const WordCard({
    Key? key,
    required this.russian,
    required this.uzbek,
    required this.emoji,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!ProgressData.viewedWords.contains(russian)) {
          ProgressData.viewedWords.add(russian);
          ProgressData.learnedWords = ProgressData.viewedWords.length;
        }
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Color(0xFF3B82F6).withOpacity(0.1),
              blurRadius: 15,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF3B82F6).withOpacity(0.2),
                    Color(0xFF60A5FA).withOpacity(0.15),
                  ],
                ),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Center(
                child: Text(
                  emoji,
                  style: TextStyle(fontSize: 36),
                ),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    russian,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF3B82F6),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    uzbek,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
            if (ProgressData.viewedWords.contains(russian))
              Icon(Icons.check_circle, color: Color(0xFF10B981), size: 28),
          ],
        ),
      ),
    );
  }
}

class MemoryGameScreen extends StatefulWidget {
  const MemoryGameScreen({Key? key}) : super(key: key);

  @override
  State<MemoryGameScreen> createState() => _MemoryGameScreenState();
}

class _MemoryGameScreenState extends State<MemoryGameScreen> {
  // Darajalar uchun sozlamalar
  int currentLevel = 1;
  int maxLevel = 5;
  
  // Har bir daraja uchun harflar soni
  Map<int, int> levelPairs = {
    1: 4,  // 4 juft = 8 ta karta (2x4)
    2: 6,  // 6 juft = 12 ta karta (3x4)
    3: 8,  // 8 juft = 16 ta karta (4x4)
    4: 10, // 10 juft = 20 ta karta (4x5)
    5: 12, // 12 juft = 24 ta karta (4x6)
  };
  
  List<String> allLetters = ['А', 'Б', 'В', 'Г', 'Д', 'Е', 'Ё', 'Ж', 'З', 'И', 'Й', 'К'];
  List<String> gameLetters = [];
  List<bool> revealed = [];
  List<int> selectedIndices = [];
  int moves = 0;
  int totalGamesWon = 0;

  @override
  void initState() {
    super.initState();
    _initializeGame();
  }

  void _initializeGame() {
    int pairCount = levelPairs[currentLevel]!;
    List<String> selectedLetters = allLetters.sublist(0, pairCount);
    
    setState(() {
      gameLetters = [...selectedLetters, ...selectedLetters];
      gameLetters.shuffle();
      revealed = List.filled(gameLetters.length, false);
      selectedIndices = [];
      moves = 0;
    });
  }

  void _onCardTap(int index) {
    if (revealed[index] || selectedIndices.length == 2) return;

    setState(() {
      revealed[index] = true;
      selectedIndices.add(index);
    });

    if (selectedIndices.length == 2) {
      moves++;
      if (gameLetters[selectedIndices[0]] == gameLetters[selectedIndices[1]]) {
        selectedIndices = [];
        
        if (revealed.every((element) => element)) {
          totalGamesWon++;
          ProgressData.gamesPlayed = totalGamesWon;
          Future.delayed(Duration(milliseconds: 500), () {
            _showWinDialog();
          });
        }
      } else {
        Future.delayed(Duration(seconds: 1), () {
          setState(() {
            revealed[selectedIndices[0]] = false;
            revealed[selectedIndices[1]] = false;
            selectedIndices = [];
          });
        });
      }
    }
  }

  void _showWinDialog() {
    final colors = [Color(0xFF10B981), Color(0xFF34D399)];
    bool isLastLevel = currentLevel >= maxLevel;
    
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
          child: Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: colors),
              borderRadius: BorderRadius.circular(32),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('🎉', style: TextStyle(fontSize: 80)),
                const SizedBox(height: 20),
                Text(
                  isLastLevel ? 'MUKAMMAL!' : 'Ajoyib!',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  isLastLevel 
                    ? 'Barcha darajalarni yakunladingiz!' 
                    : 'Daraja ${currentLevel} tugadi!',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white.withOpacity(0.9),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Harakatlar: $moves',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      if (!isLastLevel) ...[
                        SizedBox(height: 8),
                        Text(
                          'Keyingi: Daraja ${currentLevel + 1}',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white.withOpacity(0.9),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 28),
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    if (!isLastLevel)
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: colors[0],
                          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          setState(() {
                            currentLevel++;
                            _initializeGame();
                          });
                        },
                        child: Text('Keyingi daraja ➡️', style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white.withOpacity(0.2),
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        setState(() {
                          currentLevel = 1;
                          _initializeGame();
                        });
                      },
                      child: Text('🔄 Qaytadan', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white.withOpacity(0.15),
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      child: Text('Chiqish', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  int _getCrossAxisCount() {
    int totalCards = gameLetters.length;
    if (totalCards <= 8) return 4;  // 2x4
    if (totalCards <= 12) return 4; // 3x4
    if (totalCards <= 16) return 4; // 4x4
    return 4; // 4x5 yoki 4x6
  }

  @override
  Widget build(BuildContext context) {
    final colors = [Color(0xFF10B981), Color(0xFF34D399)];
    final screenWidth = MediaQuery.of(context).size.width;
    
    return Scaffold(
      body: Stack(
        children: [
          SimpleBackground(),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(screenWidth < 360 ? 12.0 : 20.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 10,
                                ),
                              ],
                            ),
                            child: IconButton(
                              icon: Icon(Icons.arrow_back, color: colors[0]),
                              onPressed: () => Navigator.pop(context),
                              padding: EdgeInsets.all(screenWidth < 360 ? 8 : 12),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              '🎮 Xotira O\'yini',
                              style: TextStyle(
                                fontSize: screenWidth < 360 ? 18 : 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: screenWidth < 360 ? 12 : 16, 
                              vertical: 8
                            ),
                            decoration: BoxDecoration(
                              color: colors[0].withOpacity(0.15),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              '🔄 $moves',
                              style: TextStyle(
                                fontSize: screenWidth < 360 ? 14 : 18,
                                fontWeight: FontWeight.bold,
                                color: colors[0],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      // Daraja ko'rsatkichi
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(colors: colors),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: colors[0].withOpacity(0.3),
                              blurRadius: 15,
                              offset: Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.emoji_events, color: Colors.white, size: 24),
                                SizedBox(width: 8),
                                Text(
                                  'Daraja $currentLevel/$maxLevel',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                '${levelPairs[currentLevel]! * 2} karta',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: GridView.builder(
                    padding: EdgeInsets.all(screenWidth < 360 ? 8 : 12),
                    physics: const BouncingScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: _getCrossAxisCount(),
                      mainAxisSpacing: screenWidth < 360 ? 8 : 12,
                      crossAxisSpacing: screenWidth < 360 ? 8 : 12,
                    ),
                    itemCount: gameLetters.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => _onCardTap(index),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: revealed[index] 
                                ? colors
                                : [Color(0xFF8B5CF6), Color(0xFFC084FC)],
                            ),
                            borderRadius: BorderRadius.circular(screenWidth < 360 ? 12 : 16),
                            boxShadow: [
                              BoxShadow(
                                color: (revealed[index] ? colors[0] : Color(0xFF8B5CF6))
                                    .withOpacity(0.3),
                                blurRadius: 10,
                                offset: Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              revealed[index] ? gameLetters[index] : '?',
                              style: TextStyle(
                                fontSize: screenWidth < 360 ? 28 : 36,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class QuizScreen extends StatefulWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentQuestion = 0;
  bool answered = false;
  int? selectedAnswer;
  int correctAnswers = 0;

  final List<Map<String, dynamic>> questions = [
    // Harflar (3 ta)
    {'question': 'Qaysi harf "a" deb talaffuz qilinadi?', 'options': ['Б', 'А', 'В', 'Г'], 'correct': 1, 'type': 'letter'},
    {'question': 'Qaysi harf "v" deb talaffuz qilinadi?', 'options': ['Б', 'А', 'В', 'Г'], 'correct': 2, 'type': 'letter'},
    {'question': 'Qaysi harf "k" deb talaffuz qilinadi?', 'options': ['К', 'Л', 'М', 'Н'], 'correct': 0, 'type': 'letter'},
    
    // Salomlashish va oddiy so'zlar
    {'question': '"Привет" so\'zi nimani anglatadi?', 'options': ['Salom', 'Xayr', 'Rahmat', 'Kechirasiz'], 'correct': 0, 'type': 'word'},
    {'question': '"Спасибо" so\'zi nimani anglatadi?', 'options': ['Iltimos', 'Rahmat', 'Kechirasiz', 'Xayr'], 'correct': 1, 'type': 'word'},
    {'question': '"До свидания" so\'zi nimani anglatadi?', 'options': ['Salom', 'Ko\'rishguncha', 'Iltimos', 'Rahmat'], 'correct': 1, 'type': 'word'},
    {'question': '"Пожалуйста" so\'zi nimani anglatadi?', 'options': ['Rahmat', 'Kechirasiz', 'Iltimos', 'Xayr'], 'correct': 2, 'type': 'word'},
    
    // Oila a'zolari
    {'question': '"Мама" so\'zi nimani anglatadi?', 'options': ['Ona', 'Ota', 'Aka', 'Opa'], 'correct': 0, 'type': 'word'},
    {'question': '"Папа" so\'zi nimani anglatadi?', 'options': ['Aka', 'Ota', 'Bobo', 'Uka'], 'correct': 1, 'type': 'word'},
    {'question': '"Бабушка" so\'zi nimani anglatadi?', 'options': ['Ona', 'Buvi', 'Opa', 'Xola'], 'correct': 1, 'type': 'word'},
    {'question': '"Дедушка" so\'zi nimani anglatadi?', 'options': ['Ota', 'Aka', 'Bobo', 'Tog\'a'], 'correct': 2, 'type': 'word'},
    
    // Joylar
    {'question': '"Дом" so\'zi nimani anglatadi?', 'options': ['Uy', 'Maktab', 'Do\'kon', 'Park'], 'correct': 0, 'type': 'word'},
    {'question': '"Школа" so\'zi nimani anglatadi?', 'options': ['Uy', 'Maktab', 'Do\'kon', 'Bog\''], 'correct': 1, 'type': 'word'},
    {'question': '"Магазин" so\'zi nimani anglatadi?', 'options': ['Uy', 'Maktab', 'Do\'kon', 'Kasalxona'], 'correct': 2, 'type': 'word'},
    {'question': '"Парк" so\'zi nimani anglatadi?', 'options': ['Ko\'cha', 'Bog\'', 'Uy', 'Maydon'], 'correct': 1, 'type': 'word'},
    
    // Vaqt
    {'question': '"Сегодня" so\'zi nimani anglatadi?', 'options': ['Kecha', 'Bugun', 'Ertaga', 'Hozir'], 'correct': 1, 'type': 'word'},
    {'question': '"Вчера" so\'zi nimani anglatadi?', 'options': ['Kecha', 'Bugun', 'Ertaga', 'Hozir'], 'correct': 0, 'type': 'word'},
    {'question': '"Завтра" so\'zi nimani anglatadi?', 'options': ['Kecha', 'Bugun', 'Ertaga', 'Hozir'], 'correct': 2, 'type': 'word'},
    {'question': '"Утро" so\'zi nimani anglatadi?', 'options': ['Ertalab', 'Kunduzi', 'Kechqurun', 'Tun'], 'correct': 0, 'type': 'word'},
    
    // Ovqatlar va ichimliklar
    {'question': '"Вода" so\'zi nimani anglatadi?', 'options': ['Choy', 'Kofe', 'Suv', 'Sut'], 'correct': 2, 'type': 'word'},
    {'question': '"Хлеб" so\'zi nimani anglatadi?', 'options': ['Non', 'Go\'sht', 'Baliq', 'Sabzi'], 'correct': 0, 'type': 'word'},
    {'question': '"Молоко" so\'zi nimani anglatadi?', 'options': ['Suv', 'Sut', 'Choy', 'Sharbat'], 'correct': 1, 'type': 'word'},
    {'question': '"Чай" so\'zi nimani anglatadi?', 'options': ['Kofe', 'Suv', 'Choy', 'Sut'], 'correct': 2, 'type': 'word'},
    {'question': '"Яблоко" so\'zi nimani anglatadi?', 'options': ['Banan', 'Olma', 'Nok', 'Uzum'], 'correct': 1, 'type': 'word'},
    
    // Ranglar
    {'question': '"Красный" so\'zi qaysi rangni anglatadi?', 'options': ['Ko\'k', 'Qizil', 'Yashil', 'Sariq'], 'correct': 1, 'type': 'word'},
    {'question': '"Синий" so\'zi qaysi rangni anglatadi?', 'options': ['Ko\'k', 'Qizil', 'Yashil', 'Sariq'], 'correct': 0, 'type': 'word'},
    {'question': '"Зелёный" so\'zi qaysi rangni anglatadi?', 'options': ['Ko\'k', 'Qizil', 'Yashil', 'Sariq'], 'correct': 2, 'type': 'word'},
    {'question': '"Белый" so\'zi qaysi rangni anglatadi?', 'options': ['Oq', 'Qora', 'Kulrang', 'Jigarrang'], 'correct': 0, 'type': 'word'},
    {'question': '"Чёрный" so\'zi qaysi rangni anglatadi?', 'options': ['Oq', 'Qora', 'Kulrang', 'Jigarrang'], 'correct': 1, 'type': 'word'},
    
    // Sonlar
    {'question': '"Один" so\'zi qaysi sonni anglatadi?', 'options': ['Bir', 'Ikki', 'Uch', 'To\'rt'], 'correct': 0, 'type': 'word'},
    {'question': '"Два" so\'zi qaysi sonni anglatadi?', 'options': ['Bir', 'Ikki', 'Uch', 'To\'rt'], 'correct': 1, 'type': 'word'},
    {'question': '"Три" so\'zi qaysi sonni anglatadi?', 'options': ['Bir', 'Ikki', 'Uch', 'To\'rt'], 'correct': 2, 'type': 'word'},
    {'question': '"Пять" so\'zi qaysi sonni anglatadi?', 'options': ['Uch', 'To\'rt', 'Besh', 'Olti'], 'correct': 2, 'type': 'word'},
    
    // Fe'llar
    {'question': '"Говорить" so\'zi nimani anglatadi?', 'options': ['Gapirmoq', 'Yozmoq', 'O\'qimoq', 'Eshitmoq'], 'correct': 0, 'type': 'word'},
    {'question': '"Читать" so\'zi nimani anglatadi?', 'options': ['Yozmoq', 'O\'qimoq', 'Gapirmoq', 'Eshitmoq'], 'correct': 1, 'type': 'word'},
    {'question': '"Писать" so\'zi nimani anglatadi?', 'options': ['O\'qimoq', 'Yozmoq', 'Gapirmoq', 'Tinglash'], 'correct': 1, 'type': 'word'},
    {'question': '"Любить" so\'zi nimani anglatadi?', 'options': ['Yomon ko\'rmoq', 'Sevmoq', 'O\'qimoq', 'Yozmoq'], 'correct': 1, 'type': 'word'},
    {'question': '"Спать" so\'zi nimani anglatadi?', 'options': ['Uxlamoq', 'O\'tirmoq', 'Turmoq', 'Yurmoq'], 'correct': 0, 'type': 'word'},
    {'question': '"Идти" so\'zi nimani anglatadi?', 'options': ['Turmoq', 'Bormoq', 'Kelmoq', 'Yugurmoq'], 'correct': 1, 'type': 'word'},
    
    // Sifatlar
    {'question': '"Большой" so\'zi nimani anglatadi?', 'options': ['Kichik', 'Katta', 'O\'rta', 'Uzun'], 'correct': 1, 'type': 'word'},
    {'question': '"Маленький" so\'zi nimani anglatadi?', 'options': ['Kichik', 'Katta', 'O\'rta', 'Uzun'], 'correct': 0, 'type': 'word'},
    {'question': '"Хороший" so\'zi nimani anglatadi?', 'options': ['Yomon', 'Yaxshi', 'O\'rta', 'Qo\'rqinchli'], 'correct': 1, 'type': 'word'},
    {'question': '"Новый" so\'zi nimani anglatadi?', 'options': ['Eski', 'Yangi', 'Yomon', 'Yaxshi'], 'correct': 1, 'type': 'word'},
    {'question': '"Красивый" so\'zi nimani anglatadi?', 'options': ['Xunuk', 'Chiroyli', 'Katta', 'Kichik'], 'correct': 1, 'type': 'word'},
    
    // Savol so'zlari
    {'question': '"Что" so\'zi nimani anglatadi?', 'options': ['Kim', 'Nima', 'Qayerda', 'Qachon'], 'correct': 1, 'type': 'word'},
    {'question': '"Кто" so\'zi nimani anglatadi?', 'options': ['Kim', 'Nima', 'Qayerda', 'Qachon'], 'correct': 0, 'type': 'word'},
    {'question': '"Где" so\'zi nimani anglatadi?', 'options': ['Kim', 'Nima', 'Qayerda', 'Qachon'], 'correct': 2, 'type': 'word'},
    {'question': '"Когда" so\'zi nimani anglatadi?', 'options': ['Kim', 'Nima', 'Qayerda', 'Qachon'], 'correct': 3, 'type': 'word'},
    
    // Umumiy so'zlar
    {'question': '"Да" so\'zi nimani anglatadi?', 'options': ['Yo\'q', 'Ha', 'Balki', 'Bilmayman'], 'correct': 1, 'type': 'word'},
    {'question': '"Нет" so\'zi nimani anglatadi?', 'options': ['Yo\'q', 'Ha', 'Balki', 'Bilmayman'], 'correct': 0, 'type': 'word'},
    {'question': '"Друг" so\'zi nimani anglatadi?', 'options': ['Do\'st', 'Dushman', 'Ota', 'Aka'], 'correct': 0, 'type': 'word'},
    {'question': '"Книга" so\'zi nimani anglatadi?', 'options': ['Daftar', 'Kitob', 'Qalam', 'Stol'], 'correct': 1, 'type': 'word'},
    {'question': '"Время" so\'zi nimani anglatadi?', 'options': ['Joy', 'Vaqt', 'Odam', 'Pul'], 'correct': 1, 'type': 'word'},
    {'question': '"Машина" so\'zi nimani anglatadi?', 'options': ['Velosiped', 'Poyezd', 'Mashina', 'Samolyot'], 'correct': 2, 'type': 'word'},
  ];

  void _checkAnswer(int selectedIndex) {
    if (answered) return;

    setState(() {
      answered = true;
      selectedAnswer = selectedIndex;
      if (selectedIndex == questions[currentQuestion]['correct']) {
        correctAnswers++;
        ProgressData.quizzesPassed = correctAnswers;
      }
    });

    Future.delayed(Duration(seconds: 2), () {
      if (currentQuestion < questions.length - 1) {
        setState(() {
          currentQuestion++;
          answered = false;
          selectedAnswer = null;
        });
      } else {
        _showResultDialog();
      }
    });
  }

  void _showResultDialog() {
    final colors = [Color(0xFFF59E0B), Color(0xFFFBBF24)];
    int totalQuestions = questions.length;
    int percentage = ((correctAnswers / totalQuestions) * 100).round();
    
    String emoji;
    String title;
    String message;
    
    if (percentage >= 90) {
      emoji = '🏆';
      title = 'Mukammal!';
      message = 'Siz zo\'r o\'quvchisiz!';
    } else if (percentage >= 75) {
      emoji = '🎉';
      title = 'Ajoyib!';
      message = 'Juda yaxshi natija!';
    } else if (percentage >= 60) {
      emoji = '👍';
      title = 'Yaxshi!';
      message = 'Davom eting!';
    } else if (percentage >= 40) {
      emoji = '💪';
      title = 'Yomon emas!';
      message = 'Ko\'proq mashq qiling!';
    } else {
      emoji = '📚';
      title = 'Mashq kerak!';
      message = 'Qaytadan urinib ko\'ring!';
    }
    
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
          child: Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: colors),
              borderRadius: BorderRadius.circular(32),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(emoji, style: TextStyle(fontSize: 80)),
                const SizedBox(height: 20),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  message,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      Text(
                        '$correctAnswers / $totalQuestions',
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        '$percentage%',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 28),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: colors[0],
                        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        setState(() {
                          currentQuestion = 0;
                          answered = false;
                          selectedAnswer = null;
                          correctAnswers = 0;
                          ProgressData.quizzesPassed = 0;
                        });
                      },
                      child: Text('Qayta', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(width: 12),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white.withOpacity(0.2),
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      child: Text('Chiqish', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final question = questions[currentQuestion];
    final colors = [Color(0xFFF59E0B), Color(0xFFFBBF24)];

    return Scaffold(
      body: Stack(
        children: [
          SimpleBackground(),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: IconButton(
                          icon: Icon(Icons.arrow_back, color: colors[0]),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        '✅ Test',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: colors[0].withOpacity(0.15),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '${currentQuestion + 1}/${questions.length}',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: colors[0],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(28),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: [
                              BoxShadow(
                                color: colors[0].withOpacity(0.15),
                                blurRadius: 20,
                                offset: Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Text(
                            question['question'],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                              height: 1.4,
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),
                        ...List.generate(question['options'].length, (index) {
                          bool isCorrect = index == question['correct'];
                          bool isSelected = selectedAnswer == index;
                          
                          Color bgColor = Colors.white;
                          Color borderColor = colors[0].withOpacity(0.3);
                          Color textColor = Colors.black87;
                          
                          if (answered) {
                            if (isCorrect) {
                              bgColor = Color(0xFF10B981);
                              borderColor = Color(0xFF10B981);
                              textColor = Colors.white;
                            } else if (isSelected) {
                              bgColor = Color(0xFFEF4444);
                              borderColor = Color(0xFFEF4444);
                              textColor = Colors.white;
                            }
                          }
                          
                          return GestureDetector(
                            onTap: () => _checkAnswer(index),
                            child: Container(
                              margin: EdgeInsets.only(bottom: 12),
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: bgColor,
                                borderRadius: BorderRadius.circular(18),
                                border: Border.all(color: borderColor, width: 2),
                                boxShadow: [
                                  BoxShadow(
                                    color: borderColor.withOpacity(0.2),
                                    blurRadius: 10,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 32,
                                    height: 32,
                                    decoration: BoxDecoration(
                                      color: answered && isCorrect 
                                        ? Colors.white.withOpacity(0.3)
                                        : colors[0].withOpacity(0.15),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: Text(
                                        String.fromCharCode(65 + index),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: answered && (isCorrect || isSelected)
                                            ? Colors.white
                                            : colors[0],
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 16),
                                  Expanded(
                                    child: Text(
                                      question['options'][index],
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: textColor,
                                      ),
                                    ),
                                  ),
                                  if (answered && isCorrect)
                                    Icon(Icons.check_circle, color: Colors.white),
                                  if (answered && isSelected && !isCorrect)
                                    Icon(Icons.cancel, color: Colors.white),
                                ],
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ========== SO'ZLAR TESTI - YANGI! ==========
class WordTestScreen extends StatefulWidget {
  const WordTestScreen({Key? key}) : super(key: key);

  @override
  State<WordTestScreen> createState() => _WordTestScreenState();
}

class _WordTestScreenState extends State<WordTestScreen> {
  int currentQuestion = 0;
  bool answered = false;
  int? selectedAnswer;
  int correctAnswers = 0;

  // Faqat so'zlar bo'yicha testlar
  final List<Map<String, dynamic>> questions = [
    // Salomlashish
    {'question': '"Привет" so\'zi nimani anglatadi?', 'options': ['Salom', 'Xayr', 'Rahmat', 'Kechirasiz'], 'correct': 0},
    {'question': '"Спасибо" so\'zi nimani anglatadi?', 'options': ['Iltimos', 'Rahmat', 'Kechirasiz', 'Xayr'], 'correct': 1},
    {'question': '"До свидания" so\'zi nimani anglatadi?', 'options': ['Salom', 'Ko\'rishguncha', 'Iltimos', 'Rahmat'], 'correct': 1},
    {'question': '"Пожалуйста" so\'zi nimani anglatadi?', 'options': ['Rahmat', 'Kechirasiz', 'Iltimos', 'Xayr'], 'correct': 2},
    {'question': '"Извините" so\'zi nimani anglatadi?', 'options': ['Rahmat', 'Kechirasiz', 'Iltimos', 'Salom'], 'correct': 1},
    
    // Oila
    {'question': '"Мама" so\'zi nimani anglatadi?', 'options': ['Ona', 'Ota', 'Aka', 'Opa'], 'correct': 0},
    {'question': '"Папа" so\'zi nimani anglatadi?', 'options': ['Aka', 'Ota', 'Bobo', 'Uka'], 'correct': 1},
    {'question': '"Бабушка" so\'zi nimani anglatadi?', 'options': ['Ona', 'Buvi', 'Opa', 'Xola'], 'correct': 1},
    {'question': '"Дедушка" so\'zi nimani anglatadi?', 'options': ['Ota', 'Aka', 'Bobo', 'Tog\'a'], 'correct': 2},
    {'question': '"Семья" so\'zi nimani anglatadi?', 'options': ['Do\'st', 'Oila', 'Uy', 'Ota-ona'], 'correct': 1},
    
    // Joylar
    {'question': '"Дом" so\'zi nimani anglatadi?', 'options': ['Uy', 'Maktab', 'Do\'kon', 'Park'], 'correct': 0},
    {'question': '"Школа" so\'zi nimani anglatadi?', 'options': ['Uy', 'Maktab', 'Do\'kon', 'Bog\''], 'correct': 1},
    {'question': '"Магазин" so\'zi nimani anglatadi?', 'options': ['Uy', 'Maktab', 'Do\'kon', 'Kasalxona'], 'correct': 2},
    {'question': '"Парк" so\'zi nimani anglatadi?', 'options': ['Ko\'cha', 'Bog\'', 'Uy', 'Maydon'], 'correct': 1},
    {'question': '"Улица" so\'zi nimani anglatadi?', 'options': ['Ko\'cha', 'Bog\'', 'Uy', 'Do\'kon'], 'correct': 0},
    
    // Vaqt
    {'question': '"Сегодня" so\'zi nimani anglatadi?', 'options': ['Kecha', 'Bugun', 'Ertaga', 'Hozir'], 'correct': 1},
    {'question': '"Вчера" so\'zi nimani anglatadi?', 'options': ['Kecha', 'Bugun', 'Ertaga', 'Hozir'], 'correct': 0},
    {'question': '"Завтра" so\'zi nimani anglatadi?', 'options': ['Kecha', 'Bugun', 'Ertaga', 'Hozir'], 'correct': 2},
    {'question': '"Утро" so\'zi nimani anglatadi?', 'options': ['Ertalab', 'Kunduzi', 'Kechqurun', 'Tun'], 'correct': 0},
    {'question': '"Вечер" so\'zi nimani anglatadi?', 'options': ['Ertalab', 'Kunduzi', 'Kechqurun', 'Tun'], 'correct': 2},
    
    // Ovqat
    {'question': '"Вода" so\'zi nimani anglatadi?', 'options': ['Choy', 'Kofe', 'Suv', 'Sut'], 'correct': 2},
    {'question': '"Хлеб" so\'zi nimani anglatadi?', 'options': ['Non', 'Go\'sht', 'Baliq', 'Sabzi'], 'correct': 0},
    {'question': '"Молоко" so\'zi nimani anglatadi?', 'options': ['Suv', 'Sut', 'Choy', 'Sharbat'], 'correct': 1},
    {'question': '"Чай" so\'zi nimani anglatadi?', 'options': ['Kofe', 'Suv', 'Choy', 'Sut'], 'correct': 2},
    {'question': '"Яблоко" so\'zi nimani anglatadi?', 'options': ['Banan', 'Olma', 'Nok', 'Uzum'], 'correct': 1},
    
    // Ranglar
    {'question': '"Красный" so\'zi qaysi rangni anglatadi?', 'options': ['Ko\'k', 'Qizil', 'Yashil', 'Sariq'], 'correct': 1},
    {'question': '"Синий" so\'zi qaysi rangni anglatadi?', 'options': ['Ko\'k', 'Qizil', 'Yashil', 'Sariq'], 'correct': 0},
    {'question': '"Зелёный" so\'zi qaysi rangni anglatadi?', 'options': ['Ko\'k', 'Qizil', 'Yashil', 'Sariq'], 'correct': 2},
    {'question': '"Белый" so\'zi qaysi rangni anglatadi?', 'options': ['Oq', 'Qora', 'Kulrang', 'Jigarrang'], 'correct': 0},
    {'question': '"Чёрный" so\'zi qaysi rangni anglatadi?', 'options': ['Oq', 'Qora', 'Kulrang', 'Jigarrang'], 'correct': 1},
    
    // Sonlar
    {'question': '"Один" so\'zi qaysi sonni anglatadi?', 'options': ['Bir', 'Ikki', 'Uch', 'To\'rt'], 'correct': 0},
    {'question': '"Два" so\'zi qaysi sonni anglatadi?', 'options': ['Bir', 'Ikki', 'Uch', 'To\'rt'], 'correct': 1},
    {'question': '"Три" so\'zi qaysi sonni anglatadi?', 'options': ['Bir', 'Ikki', 'Uch', 'To\'rt'], 'correct': 2},
    {'question': '"Пять" so\'zi qaysi sonni anglatadi?', 'options': ['Uch', 'To\'rt', 'Besh', 'Olti'], 'correct': 2},
    {'question': '"Десять" so\'zi qaysi sonni anglatadi?', 'options': ['O\'n', 'Yigirma', 'O\'ttiz', 'Qirq'], 'correct': 0},
    
    // Fe'llar
    {'question': '"Говорить" so\'zi nimani anglatadi?', 'options': ['Gapirmoq', 'Yozmoq', 'O\'qimoq', 'Eshitmoq'], 'correct': 0},
    {'question': '"Читать" so\'zi nimani anglatadi?', 'options': ['Yozmoq', 'O\'qimoq', 'Gapirmoq', 'Eshitmoq'], 'correct': 1},
    {'question': '"Писать" so\'zi nimani anglatadi?', 'options': ['O\'qimoq', 'Yozmoq', 'Gapirmoq', 'Tinglash'], 'correct': 1},
    {'question': '"Любить" so\'zi nimani anglatadi?', 'options': ['Yomon ko\'rmoq', 'Sevmoq', 'O\'qimoq', 'Yozmoq'], 'correct': 1},
    {'question': '"Спать" so\'zi nimani anglatadi?', 'options': ['Uxlamoq', 'O\'tirmoq', 'Turmoq', 'Yurmoq'], 'correct': 0},
    
    // Sifatlar
    {'question': '"Большой" so\'zi nimani anglatadi?', 'options': ['Kichik', 'Katta', 'O\'rta', 'Uzun'], 'correct': 1},
    {'question': '"Маленький" so\'zi nimani anglatadi?', 'options': ['Kichik', 'Katta', 'O\'rta', 'Uzun'], 'correct': 0},
    {'question': '"Хороший" so\'zi nimani anglatadi?', 'options': ['Yomon', 'Yaxshi', 'O\'rta', 'Qo\'rqinchli'], 'correct': 1},
    {'question': '"Новый" so\'zi nimani anglatadi?', 'options': ['Eski', 'Yangi', 'Yomon', 'Yaxshi'], 'correct': 1},
    {'question': '"Красивый" so\'zi nimani anglatadi?', 'options': ['Xunuk', 'Chiroyli', 'Katta', 'Kichik'], 'correct': 1},
    
    // Umumiy
    {'question': '"Да" so\'zi nimani anglatadi?', 'options': ['Yo\'q', 'Ha', 'Balki', 'Bilmayman'], 'correct': 1},
    {'question': '"Нет" so\'zi nimani anglatadi?', 'options': ['Yo\'q', 'Ha', 'Balki', 'Bilmayman'], 'correct': 0},
    {'question': '"Друг" so\'zi nimani anglatadi?', 'options': ['Do\'st', 'Dushman', 'Ota', 'Aka'], 'correct': 0},
    {'question': '"Книга" so\'zi nimani anglatadi?', 'options': ['Daftar', 'Kitob', 'Qalam', 'Stol'], 'correct': 1},
    {'question': '"Время" so\'zi nimani anglatadi?', 'options': ['Joy', 'Vaqt', 'Odam', 'Pul'], 'correct': 1},
  ];

  @override
  void initState() {
    super.initState();
    questions.shuffle(); // Savollarni aralashtirish
  }

  void _checkAnswer(int selectedIndex) {
    if (answered) return;

    setState(() {
      answered = true;
      selectedAnswer = selectedIndex;
      if (selectedIndex == questions[currentQuestion]['correct']) {
        correctAnswers++;
        ProgressData.wordTestsPassed = correctAnswers;
      }
    });

    Future.delayed(Duration(seconds: 2), () {
      if (currentQuestion < questions.length - 1) {
        setState(() {
          currentQuestion++;
          answered = false;
          selectedAnswer = null;
        });
      } else {
        _showResultDialog();
      }
    });
  }

  void _showResultDialog() {
    final colors = [Color(0xFF6366F1), Color(0xFF818CF8)];
    int totalQuestions = questions.length;
    int percentage = ((correctAnswers / totalQuestions) * 100).round();
    
    String emoji;
    String title;
    String message;
    
    if (percentage >= 90) {
      emoji = '🏆';
      title = 'Mukammal!';
      message = 'Siz zo\'r o\'quvchisiz!';
    } else if (percentage >= 75) {
      emoji = '🎉';
      title = 'Ajoyib!';
      message = 'Juda yaxshi natija!';
    } else if (percentage >= 60) {
      emoji = '👍';
      title = 'Yaxshi!';
      message = 'Davom eting!';
    } else if (percentage >= 40) {
      emoji = '💪';
      title = 'Yomon emas!';
      message = 'Ko\'proq mashq qiling!';
    } else {
      emoji = '📚';
      title = 'Mashq kerak!';
      message = 'Qaytadan urinib ko\'ring!';
    }
    
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
          child: Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: colors),
              borderRadius: BorderRadius.circular(32),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(emoji, style: TextStyle(fontSize: 80)),
                const SizedBox(height: 20),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  message,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      Text(
                        '$correctAnswers / $totalQuestions',
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        '$percentage%',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 28),
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: colors[0],
                        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        setState(() {
                          currentQuestion = 0;
                          answered = false;
                          selectedAnswer = null;
                          correctAnswers = 0;
                          questions.shuffle();
                          ProgressData.wordTestsPassed = 0;
                        });
                      },
                      child: Text('Qayta', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white.withOpacity(0.2),
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      child: Text('Chiqish', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final question = questions[currentQuestion];
    final colors = [Color(0xFF6366F1), Color(0xFF818CF8)];
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;

    return Scaffold(
      body: Stack(
        children: [
          SimpleBackground(),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(isSmallScreen ? 12.0 : 20.0),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: IconButton(
                          icon: Icon(Icons.arrow_back, color: colors[0]),
                          onPressed: () => Navigator.pop(context),
                          padding: EdgeInsets.all(isSmallScreen ? 8 : 12),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          '📝 So\'zlar Testi',
                          style: TextStyle(
                            fontSize: isSmallScreen ? 18 : 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: isSmallScreen ? 12 : 16, 
                          vertical: 8
                        ),
                        decoration: BoxDecoration(
                          color: colors[0].withOpacity(0.15),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '${currentQuestion + 1}/${questions.length}',
                          style: TextStyle(
                            fontSize: isSmallScreen ? 14 : 18,
                            fontWeight: FontWeight.bold,
                            color: colors[0],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(isSmallScreen ? 12 : 20),
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(isSmallScreen ? 20 : 28),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: [
                              BoxShadow(
                                color: colors[0].withOpacity(0.15),
                                blurRadius: 20,
                                offset: Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Text(
                            question['question'],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: isSmallScreen ? 18 : 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                              height: 1.4,
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),
                        ...List.generate(question['options'].length, (index) {
                          bool isCorrect = index == question['correct'];
                          bool isSelected = selectedAnswer == index;
                          
                          Color bgColor = Colors.white;
                          Color borderColor = colors[0].withOpacity(0.3);
                          Color textColor = Colors.black87;
                          
                          if (answered) {
                            if (isCorrect) {
                              bgColor = Color(0xFF10B981);
                              borderColor = Color(0xFF10B981);
                              textColor = Colors.white;
                            } else if (isSelected) {
                              bgColor = Color(0xFFEF4444);
                              borderColor = Color(0xFFEF4444);
                              textColor = Colors.white;
                            }
                          }
                          
                          return GestureDetector(
                            onTap: () => _checkAnswer(index),
                            child: Container(
                              margin: EdgeInsets.only(bottom: 12),
                              padding: EdgeInsets.all(isSmallScreen ? 16 : 20),
                              decoration: BoxDecoration(
                                color: bgColor,
                                borderRadius: BorderRadius.circular(18),
                                border: Border.all(color: borderColor, width: 2),
                                boxShadow: [
                                  BoxShadow(
                                    color: borderColor.withOpacity(0.2),
                                    blurRadius: 10,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: isSmallScreen ? 28 : 32,
                                    height: isSmallScreen ? 28 : 32,
                                    decoration: BoxDecoration(
                                      color: answered && isCorrect 
                                        ? Colors.white.withOpacity(0.3)
                                        : colors[0].withOpacity(0.15),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: Text(
                                        String.fromCharCode(65 + index),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: isSmallScreen ? 14 : 16,
                                          color: answered && (isCorrect || isSelected)
                                            ? Colors.white
                                            : colors[0],
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: isSmallScreen ? 12 : 16),
                                  Expanded(
                                    child: Text(
                                      question['options'][index],
                                      style: TextStyle(
                                        fontSize: isSmallScreen ? 16 : 18,
                                        fontWeight: FontWeight.w600,
                                        color: textColor,
                                      ),
                                    ),
                                  ),
                                  if (answered && isCorrect)
                                    Icon(Icons.check_circle, color: Colors.white, size: isSmallScreen ? 20 : 24),
                                  if (answered && isSelected && !isCorrect)
                                    Icon(Icons.cancel, color: Colors.white, size: isSmallScreen ? 20 : 24),
                                ],
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}