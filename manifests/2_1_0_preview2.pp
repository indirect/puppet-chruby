# Installs ruby 2.1.0-preview2.

class ruby::2_1_0_preview2 {
  require openssl
  require autoconf

  ruby::version { '2.1.0-preview2': }

  if $::operatingsystem == 'Darwin' {
    include homebrew::config

    Ruby::Version['2.1.0-preview2'] {
      env => {
        'RUBY_CONFIGURE_OPTS' => "--with-openssl-dir=${homebrew::config::installdir}/opt/openssl",
      }
    }
  }

}
