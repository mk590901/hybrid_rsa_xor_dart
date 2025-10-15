import 'dart:math';

List primeNumbers = [
  1993,1997,1999,2003,2011,2017,2027,2029,2039,2053,2063,2069,2081,2083,2087,2089,2099,2111,2113,2129,
  2131,2137,2141,2143,2153,2161,2179,2203,2207,2213,2221,2237,2239,2243,2251,2267,2269,2273,2281,2287,
  2293,2297,2309,2311,2333,2339,2341,2347,2351,2357,2371,2377,2381,2383,2389,2393,2399,2411,2417,2423,
  2437,2441,2447,2459,2467,2473,2477,2503,2521,2531,2539,2543,2549,2551,2557,2579,2591,2593,2609,2617
];

List<int> getTwoRandomDistinctNumbers() {

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
}