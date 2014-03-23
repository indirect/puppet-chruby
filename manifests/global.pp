# Public: specify the global ruby version as per rbenv
#
# Usage:
#
#   class { 'ruby::global': version => '1.9.3' }

class ruby::global($version = '2.1.1') {
  require ruby

  if $version != 'system' {
   $klass = join(['ruby', join(split($version, '[.-]'), '_')], '::')
   require $klass
  }

  file { "${ruby::chruby_root}/version":
   ensure  => present,
   owner   => $ruby::user,
   mode    => '0644',
   content => "${version}\n",
  }
}
