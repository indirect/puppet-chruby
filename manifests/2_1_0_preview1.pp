# Installs ruby 2.1.0-preview1.

class ruby::2_1_0_preview1 {
  require openssl

  ruby::version { '2.1.0-preview1': }

  if $::operatingsystem == 'Darwin' {
    include homebrew::config

    package { 'autoconf': }

    Ruby::Version['2.1.0-preview1'] {
      require => Package['autoconf'],
      env => {
        'RUBY_CONFIGURE_OPTS' => "--with-openssl-dir=${homebrew::config::installdir}/opt/openssl",
      }
    }
  }

}
