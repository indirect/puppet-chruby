# Installs ruby 2.0.0-p353.

class ruby::2_0_0_p353 {
  require openssl

  ruby::version { '2.0.0-p353': }

  if $::operatingsystem == 'Darwin' {
    include homebrew::config

    Ruby::Version['2.0.0-p353'] {
      env => {
        'RUBY_CONFIGURE_OPTS' => "--with-openssl-dir=${homebrew::config::installdir}/opt/openssl",
      }
    }
  }

}
