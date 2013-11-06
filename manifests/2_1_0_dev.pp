# Installs ruby 2.1.0-dev.

class ruby::2_1_0_dev {
  require openssl

  ruby::version { '2.1.0-dev': }

  if $::operatingsystem == 'Darwin' {
    include homebrew::config
    include autoconf

    Ruby::Version['2.1.0-dev'] {
      require => Package['autoconf'],
      env => {
        'RUBY_CONFIGURE_OPTS' => "--with-openssl-dir=${homebrew::config::installdir}/opt/openssl",
      }
    }
  }

}
