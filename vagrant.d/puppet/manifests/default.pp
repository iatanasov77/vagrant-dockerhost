
host { 'mydockerhost.lh':
	ip           => '10.2.2.2',
	host_aliases => 'www.mydockerhost.lh',
}

class { 'docker':
	dns => ['10.0.2.3', '8.8.8.8'],
}

class { 'docker::compose':
	ensure => present,
	version => '1.22.0',
}
