# HYBRID-RSA-XOR-DART
Below is a set of classes for implementing a hybrid message encryption method.

## Introduction
Represented message encryption uses a combination of asymmetric and symmetric encryption methods:

• The server generates __public__ and __private__ keys using the __RSA__ algorithm. The __public key__ is sent to the client.

• On the client, the message is encrypted using an __XOR cipher__ with a random key. The random key is then encrypted with the open __RSA public key__, and a packet containing the encrypted key and the text is sent to the server.

• The server decodes the random key using the secret __RSA private key__ and uses it to recover the text sent by the client.

## Note:
A full explanation of the project's goals and purpose can be found in the README.md file in the https://github.com/mk590901/hybrid_rsa_xor_toit repository.Current project contains a porting of the asymmetric and symmetric encoding/decoding on __Dart__ to achieve full forward and backward compatibility with apps written on __Toit__.

## Project goal
It was important for me to create an environment and develop a method for encoding and decoding hybrid messages for future apps.

## Run app
```
/home/micrcx/snap/flutter/common/flutter/bin/cache/dart-sdk/bin/dart --enable-asserts --no-serve-devtools /home/micrcx/IdeaProjects/assymetric_xor/bin/assymetric_xor.dart
Encrypted (base64):
ZVpWFG15ZRh8XlJASkRBX1hWGVFdVVxGXEJfVRlZQhJQEkVRR08XXV9WVFFHXUNTF0FcRBFXUkdMFkNXGVlcQl1XXlFbQhdVXERZXVcUWlAXS0BdXFdHRlxVF11XU0NLQUZaW1sYF3xMVRFGXBRcQkQYXFZXV1BAXEBSVlxDQhJQXFcURl9aSFVZUltHTRkWQ1BcEGl9YRRwWFRKQEBFW15cE11GFlZWGVVJRkFRWFNbQRlTXl9eW1sWVFdUQF5cVFxHFEBFUlwZWV8SXltHUxdbVl1BXlZMFVNZW0tJQUZYXV0UVFpQV0tZRVpeRxVDRF1dEF9dRFVRV05LFxBlWlQSa3tnFlJWWkJIQkddWlgXWVVXXkBaQF1bF1FKEFBcEVdLVVhGW10ZX1cSQE1YW1JMS1lSElZaVkROSE1ZXlwRRVtRR1MXTFFVEUFSWVAWXF1AEFhBE0FGU1MYTV8RUF5GWxRQWFRKQEBFElJaURZTXVpCSEJHFFQWWl1KQ1BVVBw=
Decrypted:
The XOR Encryption algorithm is a very effective yet easy to implement method of symmetric encryption. Due to its effectiveness and simplicity, the XOR Encryption is an extremely common component used in more complex encryption algorithms used nowadays. The XOR encryption algorithm is an example of symmetric encryption where the same key is used to both encrypt and decrypt a message.
cipherText->
BgRUUBYiK04tTy9GJ08tNkYmWkIUVSM4AzZDBRIUTBEzTEcVPBRZCw5HKVcqVi86CTEfV1hXLTkTYl8HEhRSQT4JXBUgGVkDDVUkWzofNjkJOwNOFVc4OAMhCw1cHk1IIhhYHyBDWSodRGxAMR8wK1poH0UeVy8+AzROBlcOTBEzAlVQPQQUHgRIL10qRnV/XSAfAyB9HmovLEgaSw1LWD0CERk9TRgASEQ0QCxaNDpFMVpAF18hJQRiSAdfDVBfNwJFUDseHApISCIUM1ArOgkrFU4IXikySidFC0AET0U7A19QLwEeARpIOFwzTHkqWi0eAxZdOysOI1IbHF1rWTdMaT8cTRwAC1M1RCpWNjEJKRZEF0AlPgIvCwFBXV5fcglJESMdFQtITioULUY0Mkw8CEobEikkCTBSGEYUUF9yG1kVPAhZGgBEbEc/Ujx/Qi0DAxFBbD8ZJ09IRhIfUz0YWVArAxocEVE4FD9RPX9NLRlRAUI4agtiRg1BDl5WN0I=
decryptedText->
The XOR Encryption algorithm is a very effective yet easy to implement method of symmetric encryption. Due to its effectiveness and simplicity, the XOR Encryption is an extremely common component used in more complex encryption algorithms used nowadays. The XOR encryption algorithm is an example of symmetric encryption where the same key is used to both encrypt and decrypt a message.
publicKey->[[1234],4051973,65537]
packet->
{"encrypted_key":["2212144","1350053","1403681","933361","2457218","1625468","1169986","3087997","1403681","2037648","2227773","3899687","3441342","2457218","728810","329301","1625468","3441342","3917639","966267","933361","2750939","1535508","1419559","329301","3827649","2393618","3333935","2521465","3917639","3870663","1535508"],"id":"1234","encrypted_text":"ZjU+ejt8GFAeIicEFBMIGFwDSEM2C18MGEM9GUEBGRBTfS0/EUpqFT0qIRUZCgoUExQNVnoJUQ0IFyEbQQEHQF44Nj8NR2odPjgsGQlDExcTHhFPNwlEDBhUdREPCxhJQikyNQ0dajQuKWQCAkMVBUBNDUQ8CVMKGEEwGgQbGRBTMz96EFonADclJx8ZGlBRRwUNAgIjYl40WTYGGBgeWV0zezMQEyseeyk8Ah8GERRfFEhBNQFdER8XNhsMGAVeVzMvehZALxR7JSpWAAwOFBMOB08qAFUGUVI7FxMRGkRbMjV6Al8tHyklMB4AEFwEQAgMAjQDRx8VViwHT0g+WFd9AxUxEy8eOD49BhkKEx8TDARFNR5ZChladR0SSAteEjgjOw5DJhV7IyJWHhoRHFYZGks5TFUQEkUsBBUBBV4SKjM/EVZqBDMpZAUMDhlRWAgRAjMfEAsCUjFUFQdKUl0pM3oGXSkCIjwwVgwNGFFXCAtQIxxEXhAXOBESGwtXV3M="}
privateKey->[[1234],4051973,2497193,1999,2027]
decrypted decryptedKey: 2][Zc3Jp[LDvmc|q3mh"Zl0~q7Utahj0
restoreText->
[The XOR Encryption algorithm is a very effective yet easy to implement method of symmetric encryption. Due to its effectiveness and simplicity, the XOR Encryption is an extremely common component used in more complex encryption algorithms used nowadays. The XOR encryption algorithm is an example of symmetric encryption where the same key is used to both encrypt and decrypt a message.]
publicKey->[[810adcb7-1fe2-2783-b1e6-9ba9a4a38ea5],4051973,65537]
packet->
{"encrypted_key":["1615810","2029737","2393618","2182521","2037648","2212144","4047115","3333935","1046396","728810","1736147","3671365","467986","1423541","3917565","2236889","3671365","1258541","1419559","2212144","1340869","1312166","2521465","1535508","1340869","3488880","1898852","648488","2037648","3488880","482117","1012384"],"id":"810adcb7-1fe2-2783-b1e6-9ba9a4a38ea5","encrypted_text":"FyowcRR9J1QNEjtaLTFRXUcuXlNDRA5CRgcjCQ=="}
******* test Dart Server -> Toit Client *******
******* RSAKeyPair->[feb75c93-41b1-4aae-829d-15c13eb7f56b] *******
public->[[feb75c93-41b1-4aae-829d-15c13eb7f56b],5114953,65537] private->[[feb75c93-41b1-4aae-829d-15c13eb7f56b],5114953,826173,2423,2111]
PUBLIC  json->[{"id":"feb75c93-41b1-4aae-829d-15c13eb7f56b","modulus":5114953,"exponent":65537}]
PRIVATE json->[{"id":"feb75c93-41b1-4aae-829d-15c13eb7f56b","modulus":5114953,"exponent":826173,"fp":2423,"sp":2111}]
packet->
{"encrypted_key":["4344456","3404806","2088684","3672272","4497266","4487388","1367164","2354251","2213257","4518705","3721348","3404806","3672272","1397698","639798","4079567","5004874","4297605","2536723","4373892","392506","1209009","2638604","2040950","4518705","1892546","3067961","3502034","3144680","2260345","2213257","3672272"],"id":"feb75c93-41b1-4aae-829d-15c13eb7f56b","encrypted_text":"D0MjBjRqekcnMAdZX0U9KhgPdSsCFxwSNyI1JQMfEQY6CzBDHlwIAgQ4AUhSXD8mVxgwPk4VEhMndiknAx8PVjdOK0MCUQgKByoMREIVJiVXEiwnAxUHEjc1fS1NFRBfK18vSQILCCMXO0RfSRUgNwRBMCwIFRAUNyA4JkYFEQY6RSIGH0xFFw43B0JSTGVjAwkwajY/IUAbOD46WgYWTzRFZk8fBUkJQjscX1RQJCYbGHUpAR0eDzB2PidOBg1IPkUyBhlWTQNCNwoLS1o7JlcCOiceHBYYfjMzK1EPElIyRCgGDUlPCBA3EENLRmk2BAQxagAfBAE6NyQ7DVY2Tj4LHmk+BU0JASwdW1JcJi1XADktAQIaFDY7fSFQVgNIe04+RwFVRAJCMQILVUwkLhIVJyMNUBYOPSQkOFcfDUh7XC5DHkAIEwo7RFhHWCxjHAQsagcDUxUtMzloVxlCRDRfLgYJS0sVGy4QC0dbLWMTBDY4FwAHQD92MC1QBQNBPgU="}
decrypted decryptedKey: [+F&l%(gb^d+&5ICwaUJnps`^V]H#vb&
restoreText->
[The XOR Encryption algorithm is a very effective yet easy to implement method of symmetric encryption. Due to its effectiveness and simplicity, the XOR Encryption is an extremely common component used in more complex encryption algorithms used nowadays. The XOR encryption algorithm is an example of symmetric encryption where the same key is used to both encrypt and decrypt a message.]
test Restore Toit Packet
PRIVATE key->[[64295ecc-8d4a-49ad-baf9-d685da815b47],4051973,2497193,1999,2027]
decrypted decryptedKey: @EH3gJY7wD[rxD<oB<5jj]&Gh$=5/-RG
restoreToitText->
[Exclusive or, exclusive disjunction, exclusive alternation, logical non-equivalence]
[2347, 2039]
[2221, 2591]
[2521, 2399]
[2417, 2377]
[2417, 2003]
[2029, 2221]
[2417, 2131]
[2539, 2389]
[2381, 2113]
[2357, 2521]
[2473, 2351]
[2027, 2347]
[2467, 1997]
[2297, 2311]
[2081, 2549]
[2081, 2131]
[2131, 1999]
[2099, 2113]
[2137, 2273]
[2617, 2089]
[2531, 2089]
[2309, 2281]
[2237, 1993]
[2551, 2243]
[2383, 1999]
[2251, 2273]
[2351, 2011]
[2143, 2027]
[2339, 2441]
[2339, 2251]
[2243, 2371]
[2081, 2311]
Ok: ok!

Process finished with exit code 0
```
