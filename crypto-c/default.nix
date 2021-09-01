let

  pkgs = import <nixpkgs> {};

  inherit (pkgs) stdenv fetchgit lib cmake doxygen python39Packages python39 ;

  AMCL = stdenv.mkDerivation rec {
    pname = "apache-incubator-milagro-crypto-c";
    version = "2.0.1";
    src = fetchgit {
      sha256 = "0z7r8h6r7fda5jh656wfq9nm493fnw93ynfvwwqnz2wpqbs44cgc";
      url = "https://github.com/apache/incubator-milagro-crypto-c.git";
    };
  
    phases = [ "installPhase" ];

    buildInputs = [ cmake doxygen python39Packages.cffi python39 ];
  
    installPhase = ''
      mkdir -p $out/target/build
      cp -r $src/* $out/
      cd $out/target/build
      cmake $out
      export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:./
      make
      make test
      make doc
#      make install
    '';
  
    meta = {
      homepage = "https://milagro.incubator.apache.org/";
      description = "Standards compliant C cryptographic library with no external dependencies";
      license = lib.licenses.asl20;
      platforms = lib.platforms.unix;
    };
  
};
in AMCL
