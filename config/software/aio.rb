name 'aio'
default_version '0.3.110'

source url: "http://ftp.debian.org/debian/pool/main/liba/libaio/libaio_#{version}.orig.tar.gz",
       md5: '2a35602e43778383e2f4907a4ca39ab8'

relative_path "libaio-#{version}"

build do
  env = with_standard_compiler_flags(with_embedded_path)

  make "-j #{workers}", env: env
  make "-j #{workers} install", env: env
end
