require 'formula'

class Cppcms < Formula
  homepage 'http://cppcms.com'
  url 'http://downloads.sourceforge.net/project/cppcms/cppcms/1.0.3/cppcms-1.0.3.tar.bz2'
  sha1 '67db09c4724e87a1f60d90a19b5bbc413968a14b'

  depends_on 'cmake' => :build
  depends_on 'pcre'

  option 'with-static', 'Enable building of static version of cppcms library'

  option 'without-iconv', "Disable usage of iconv (ICU would be used instead)" # Doesn't seem to work!
  option 'without-gcrypt', "Disable usage of gcrypt library"
  option 'without-openssl', "Disable usage of OpenSSL"
  option 'without-fcgi', "Build without FastCGI Server API"
  option 'without-scgi', "Build without SCGI Server API."
  option 'without-http', "Build without internal HTTP server"
  option 'without-icu', "Do not use ICU for localization"
  option 'without-prefork-cache', "Disable cache support for preforking modes (process shared cache)"
  option 'without-tcpcache', "Disable distributed cache support (memcached-like solution support)"
  option 'without-cache', "Disable caching system at all"
  option 'without-gzip', "Disable output gzip compression support (eliminates dependency on zlib)"

  fails_with :clang do
    build 425
  end

  def install
    args = std_cmake_args

    args << "-DDISABLE_STATIC=ON" unless build.include? 'with-static'

    args << "-DDISABLE_ICONV=ON" if build.include? 'without-iconv'
    args << "-DDISABLE_GCRYPT=ON" if build.include? 'without-gcrypt'
    args << "-DDISABLE_OPENSSL=ON" if build.include? 'without-openssl'
    args << "-DDISABLE_FCGI=ON" if build.include? 'without-fcgi'
    args << "-DDISABLE_SCGI=ON" if build.include? 'without-scgi'
    args << "-DDISABLE_HTTP=ON" if build.include? 'without-http'
    args << "-DDISABLE_ICU_LOCALE=ON" if build.include? 'without-icu'
    args << "-DDISABLE_PREFORK_CACHE=ON" if build.include? 'without-prefork-cache'
    args << "-DDISABLE_TCPCACHE=ON" if build.include? 'without-tcpcache'
    args << "-DDISABLE_CACHE=ON" if build.include? 'without-cache'
    args << "-DDISABLE_GZIP=ON" if build.include? 'without-gzip'

    mkdir "build" do
      system "cmake", "..", *args
      system "make", "install"
    end
  end
end
