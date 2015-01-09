
name 'mysql-server'
default_version '5.6.22'

dependency 'zlib'
dependency 'ncurses'
dependency 'openssl'


source  :url => "http://dev.mysql.com/get/Downloads/MySQL-5.6/mysql-#{version}.tar.gz",
        :md5 => '3985b634294482363f3d87e0d67f2262'

relative_path "mysql-#{version}"


# TODO - Check --enable-languages (mysqlbug)
build do
  env = with_standard_compiler_flags(with_embedded_path)

  command [
              'cmake',
              # General flags
              '-DCMAKE_SKIP_RPATH=YES',
              '-DBUILD_CONFIG=mysql_release',
              # Path flag
              "-DCMAKE_INSTALL_PREFIX=#{install_dir}/embedded",
              # Lib flags
              '-DWITH_SSL=system',
              "-DOPENSSL_INCLUDE_DIR:PATH=#{install_dir}/embedded/include",
              "-DOPENSSL_LIBRARIES:FILEPATH=#{install_dir}/embedded/lib/libssl.so",
              '-DWITH_ZLIB=system',
              "-DZLIB_INCLUDE_DIR:PATH=#{install_dir}/embedded/include",
              "-DZLIB_LIBRARY:FILEPATH=#{install_dir}/embedded/lib/libz.so",
              "-DCRYPTO_LIBRARY:FILEPATH=#{install_dir}/embedded/lib/libcrypto.so",
              # Feature flags
              '-DDEFAULT_CHARSET=utf8',
              '-DDEFAULT_COLLATION=utf8_unicode_ci',
              '.',
          ].join(' '), :env => env

  make "-j #{workers}", env: env
  make "-j #{workers} install", env: env
end
