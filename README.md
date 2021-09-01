# incubator-milagro
Milagro is a set of crypto libraries and core security infrastructure applications, built for decentralized networks yet suitable for enterprises.

Project page:
https://github.com/apache/incubator-milagro

- Crypto-C: \
I'm getting a error in the 'make test' phase:\
  98% tests passed, 9 tests failed out of 374\
  \
  Total Test time (real) =  92.18 sec\
  \
  The following tests FAILED:\
           37 - test_output_functions_BLS24 (Failed)\
           67 - test_output_functions_BLS381 (Failed)\
           96 - test_output_functions_BLS383 (Failed)\
          126 - test_output_functions_BLS461 (Failed)\
          156 - test_output_functions_BLS48 (Failed)\
          184 - test_output_functions_BN254 (Failed)\
          212 - test_output_functions_BN254CX (Failed)\
          251 - test_output_functions_FP256BN (Failed)\
          281 - test_output_functions_FP512BN (Failed)
          \
  Errors while running CTest\
  make: *** [Makefile:127: test] Error 8

