# Class: apache
#
# This class installs Apache
#
# Parameters:
#
# Actions:
#   - Install Apache
#   - Manage Apache service
#
# Requires:
#
# Sample Usage:
#
class apache (
  $service_name         = $::apache::params::service_name,
  $default_mods         = true,
  $default_vhost        = true,
  $default_confd_files  = true,
  $default_ssl_vhost    = false,
  $default_ssl_cert     = $::apache::params::default_ssl_cert,
  $default_ssl_key      = $::apache::params::default_ssl_key,
  $default_ssl_chain    = undef,
  $default_ssl_ca       = undef,
  $default_ssl_crl_path = undef,
  $default_ssl_crl      = undef,
  $ip                   = undef,
  $service_enable       = true,
  $service_ensure       = 'running',
  $purge_configs        = true,
  $purge_vdir           = false,
  $serveradmin          = 'root@localhost',
  $sendfile             = 'On',
  $error_documents      = false,
  $timeout              = '120',
  $httpd_dir            = $::apache::params::httpd_dir,
  $server_root          = $::apache::params::server_root,
  $confd_dir            = $::apache::params::confd_dir,
  $vhost_dir            = $::apache::params::vhost_dir,
  $vhost_enable_dir     = $::apache::params::vhost_enable_dir,
  $mod_dir              = $::apache::params::mod_dir,
  $mod_enable_dir       = $::apache::params::mod_enable_dir,
  $mpm_module           = $::apache::params::mpm_module,
  $conf_template        = $::apache::params::conf_template,
  $servername           = $::apache::params::servername,
  $manage_user          = true,
  $manage_group         = true,
  $user                 = $::apache::params::user,
  $group                = $::apache::params::group,
  $keepalive            = $::apache::params::keepalive,
  $keepalive_timeout    = $::apache::params::keepalive_timeout,
  $max_keepalive_requests = $apache::params::max_keepalive_requests,
  $logroot              = $::apache::params::logroot,
  $log_level            = $::apache::params::log_level,
  $log_formats          = {},
  $ports_file           = $::apache::params::ports_file,
  $apache_version       = $::apache::version::default,
  $server_tokens        = 'OS',
  $server_signature     = 'On',
  $trace_enable         = 'On',
  $package_ensure       = 'installed',
) inherits ::apache::params {
}
