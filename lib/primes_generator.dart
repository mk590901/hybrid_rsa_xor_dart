// import 'dart:math';
// import 'dart:typed_data';
//
// // Класс для криптографически безопасного генератора простых чисел
// class PrimeCSPRNG {
//   final Random _secureRandom;
//
//   PrimeCSPRNG() : _secureRandom = Random.secure();
//
//   // Простой тест Миллера-Рабина для проверки простоты
//   bool _isPrime(BigInt n, int iterations) {
//     if (n <= BigInt.one) return false;
//     if (n == BigInt.two || n == BigInt.from(3)) return true;
//     if (n.isEven) return false;
//
//     // Представляем n-1 как 2^r * d
//     BigInt nMinusOne = n - BigInt.one;
//     int r = 0;
//     BigInt d = nMinusOne;
//     while (d.isEven) {
//       d = d ~/ BigInt.two;
//       r++;
//     }
//
//     // Тест Миллера-Рабина
//     for (int i = 0; i < iterations; i++) {
//       BigInt a = BigInt.from(_secureRandom.nextInt(1000000)) + BigInt.two;
//       if (a >= n) a = a % (n - BigInt.two) + BigInt.two;
//
//       BigInt x = a.modPow(d, n);
//       if (x == BigInt.one || x == nMinusOne) continue;
//
//       bool composite = true;
//       for (int j = 0; j < r - 1; j++) {
//         x = (x * x) % n;
//         if (x == nMinusOne) {
//           composite = false;
//           break;
//         }
//       }
//       if (composite) return false;
//     }
//     return true;
//   }
//
//   // Генерация случайного простого числа заданной битовой длины
//   BigInt generatePrime(int bitLength) {
//     if (bitLength < 2) {
//       throw ArgumentError('Bit length must be at least 2');
//     }
//
//     while (true) {
//       // Генерируем случайное число заданной длины
//       final bytes = Uint8List((bitLength + 7) ~/ 8);
//       for (int i = 0; i < bytes.length; i++) {
//         bytes[i] = _secureRandom.nextInt(256);
//       }
//       // Устанавливаем старший бит, чтобы гарантировать нужную длину
//       bytes[0] |= (1 << ((bitLength % 8 == 0 ? 8 : bitLength % 8) - 1));
//       // Устанавливаем младший бит в 1, чтобы число было нечетным
//       bytes[bytes.length - 1] |= 1;
//
//       // Преобразуем байты в BigInt
//       BigInt candidate = BigInt.parse(
//         bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join(),
//         radix: 16,
//       );
//
//       // Проверяем, является ли число простым
//       if (_isPrime(candidate, 10)) {
//         return candidate;
//       }
//     }
//   }
// }
import 'dart:math';

List primeNumbers = [
  1993,1997,1999,2003,2011,2017,2027,2029,2039,2053,2063,2069,2081,2083,2087,2089,2099,2111,2113,2129,
  2131,2137,2141,2143,2153,2161,2179,2203,2207,2213,2221,2237,2239,2243,2251,2267,2269,2273,2281,2287,
  2293,2297,2309,2311,2333,2339,2341,2347,2351,2357,2371,2377,2381,2383,2389,2393,2399,2411,2417,2423,
  2437,2441,2447,2459,2467,2473,2477,2503,2521,2531,2539,2543,2549,2551,2557,2579,2591,2593,2609,2617
];

List<int> getTwoRandomDistinctNumbers(/*List<num> numbers*/) {
  // if (numbers.length < 2) {
  //   throw ArgumentError('Список должен содержать как минимум 2 элемента.');
  // }

  int length = primeNumbers.length;

  final Random random = Random();
  int index1 = random.nextInt(length);
  int index2;

  // Generate the second index until it differs from the first one
  do {
    index2 = random.nextInt(length);
  } while (index1 == index2);

  return [primeNumbers[index1], primeNumbers[index2]];
}

void testPrimes() {

  List<int> list = [];
  for (int i = 0; i < 32; i++) {
    list = getTwoRandomDistinctNumbers();
    print("$list");
  }

  // final csprng = PrimeCSPRNG();
  // int bits = 16;
  // // Генерируем два простых числа для RSA (например, 16 бит для демонстрации)
  // print('Случайное простое число p ($bits бит): ${csprng.generatePrime(/*16*/bits)}');
  // print('Случайное простое число q ($bits бит): ${csprng.generatePrime(/*16*/bits)}');
}