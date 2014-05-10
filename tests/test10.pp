#
# toto
class profile::apache (
  $a = b,
) {


  include ::apache
  include ::apache::mod::php
  include profile::bla::blo
  include profile::bla

}
