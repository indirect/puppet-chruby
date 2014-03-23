# Installs ruby 2.1.1

class ruby::2_1_1 {
  require openssl
  require autoconf

  ruby::version { '2.1.1': }

  if $::operatingsystem == 'Darwin' {
    include homebrew::config

    Ruby::Version['2.1.1'] {
      env => {
        'RUBY_CONFIGURE_OPTS' => "--with-openssl-dir=${homebrew::config::installdir}/opt/openssl",
      }
    }
  }

}
