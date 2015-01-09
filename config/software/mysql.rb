
name 'mysql-server'
default_version '5.6.22'

dependency 'openssl'
dependency 'zlib'
dependency 'ncurses'


source  :url => "http://dev.mysql.com/get/Downloads/MySQL-5.6/mysql-#{version}.tar.gz",
        :md5 => '3985b634294482363f3d87e0d67f2262'

relative_path "mysql-#{version}"


# TODO - Check --enable-languages (mysqlbug)
build do
  env = with_standard_compiler_flags(with_embedded_path)

  command 'cmake -DBUILD_CONFIG=mysql_release .', env: env

  command "./configure" \
          " --prefix=#{install_dir}/embedded" \
          " --exec-prefix=#{install_dir}/embedded", env: env

  make "-j #{workers}", env: env
  make "-j #{workers} install", env: env
end
