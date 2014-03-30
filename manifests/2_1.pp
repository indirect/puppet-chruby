# Installs ruby 2.1.1 via ruby-build and symlinks it as 2.1
#
# Usage:
#
#     include ruby::2_1
class ruby::2_1 {
  require ruby
  require ruby::2_1_1

  file { "${ruby::chruby_root}/versions/2.1":
    ensure  => symlink,
    force   => true,
    target  => "${ruby::chruby_root}/versions/2.1.1"
  }
}

