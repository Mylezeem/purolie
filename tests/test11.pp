# toto titi
#
# tata
class apache::test (
  $a = b,
  $c = d,
) {
  
  include ::test
  include apache::mod::php
  class { 'test' :
    toto => tata,

    titi => toto
  }
}
