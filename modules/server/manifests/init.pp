class server {
  package{["apache2","postgresql","nodejs", "memcached","php-pear","php5-dev"]:
    ensure	=> present
  }
}
