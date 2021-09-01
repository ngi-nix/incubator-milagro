let

  pkgs = import <nixpkgs> {};

  inherit (pkgs) stdenv fetchgit lib cmake doxygen ;

  AMCL = stdenv.mkDerivation rec {
    pname = "apache-incubator-milagro-crypto-c";
    version = "2.0.1";
    src = fetchgit {
      sha256 = "0z7r8h6r7fda5jh656wfq9nm493fnw93ynfvwwqnz2wpqbs44cgc";
      url = "https://github.com/apache/incubator-milagro-crypto-c.git";
    };
  
    phases = [ "installPhase" ];

    buildInputs = [ cmake doxygen ];
  
    installPhase = ''
      mkdir -p $out/target/build
      cp -r $src/* $out/
      cd $out/target/build
      cmake -D CMAKE_BUILD_TYPE=Release -D BUILD_SHARED_LIBS=ON -D AMCL_CHUNK=64 -D AMCL_CURVE="SECP256K1" -D AMCL_RSA="" -D BUILD_PYTHON=OFF -D BUILD_BLS=ON -D BUILD_WCC=OFF -D BUILD_MPIN=OFF -D BUILD_X509=OFF -DCMAKE_C_FLAGS="-fPIC" $out
      export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:./
      make
      make test
      make doc
      make install
    '';
  
    meta = {
      homepage = "https://milagro.incubator.apache.org/";
      description = "Standards compliant C cryptographic library with no external dependencies";
      license = lib.licenses.asl20;
      platforms = lib.platforms.unix;
    };
  
};
in AMCL
