class mysql {
  package{"mysql-server":
    ensure => latest
  }

  service{ "mysql":
    ensure => running,
    require => Package["mysql-server"]
  }

  exec{ "allow mysql connections from all":
    user => root, group => root,
    command => "/usr/bin/mysql -e \"GRANT ALL PRIVILEGES ON *.* TO 'root'@'%';\"",
    require => [ Package["mysql-server"], Service["mysql"] ]
  }

  file{ "/etc/mysql/conf.d/custom.cnf":
    mode => 644, owner => root, group => root,
    ensure => file,
    require => Package["mysql-server"],
    content => "[mysqld]\nbind-address		= 0.0.0.0\n",
    notify => Service["mysql"]
  }
}
