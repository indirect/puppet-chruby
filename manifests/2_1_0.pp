# Installs ruby 2.1.0-preview2 via ruby-build and symlinks it as 2.1.0.
#
# Usage:
#
#     include ruby::2_1_0
class ruby::2_1_0 {
  require ruby
  require ruby::2_1_0_preview2

  file { "${ruby::chruby_root}/versions/2.1.0":
    ensure  => symlink,
    force   => true,
    target  => "${ruby::chruby_root}/versions/2.1.0-preview2"
  }
}

