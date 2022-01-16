class minecraft::packages {
  if $minecraft::manage_java {
    class { 'java':
      distribution => 'jre',
      version      => 'latest',
      package      => 'openjdk-11-jre-headless',
    }
  }

  if $minecraft::service_provider == 'rc' {
    ensure_packages('screen')
  }
}
