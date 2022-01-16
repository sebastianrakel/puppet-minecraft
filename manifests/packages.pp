class minecraft::packages {
  if $minecraft::manage_java {
    class { 'java':
      distribution => 'jre',
      version      => '17',
    }
  }

  if $minecraft::service_provider == 'rc' {
    ensure_packages('screen')
  }
}
