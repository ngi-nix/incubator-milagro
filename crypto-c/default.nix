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

    buildInputs = [ cmake doxygen ];

    usePython = false;
    buildBLS = true;
    buildWCC = false;
    buildMPIN = false;
    buildX509 = false;
    buildShareLib = true;

    cmakeFlags = [
      "-DCMAKE_BUILD_TYPE=Release"
      "-DAMCL_CHUNK=64"
      "-DBUILD_SHARED_LIBS=${if buildShareLib then "ON" else "OFF"}"
      "-DBUILD_PYTHON=${if usePython then "ON" else "OFF"}"
      "-DBUILD_BLS=${if buildBLS then "ON" else "OFF"}"
      "-DBUILD_WCC=${if buildWCC then "ON" else "OFF"}"
      "-DBUILD_MPIN=${if buildMPIN then "ON" else "OFF"}"
      "-DBUILD_X509=${if buildX509 then "ON" else "OFF"}"
      "-DCMAKE_INSTALL_PREFIX=/usr/local"
      ''-DAMCL_CURVE="SECP256K1"''
      ''-DAMCL_RSA=""''
      ''-DCMAKE_C_FLAGS="-fPIC"''
    ];

    installPhase = ''
      mkdir -p $out/build
      cp -r $src/. $out/
      cd $out/build
      cmake ${toString cmakeFlags} $out
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
