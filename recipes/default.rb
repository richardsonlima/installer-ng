# System
include_recipe 'apt'
include_recipe 'scalr-core::repos'

# Users
include_recipe 'scalr-core::users'

# Scalr Code
include_recipe 'scalr-core::package'

# Scalr Configuration
include_recipe 'scalr-core::configuration'

# Runtime dependencies
include_recipe 'scalr-core::php'
include_recipe 'scalr-core::snmp'
include_recipe 'scalr-core::scalrpy'
include_recipe 'scalr-core::rrdcached'

# Database Configuration
include_recipe 'scalr-core::database'

# Firewall configuration
include_recipe 'scalr-core::firewall'

# Service Launch
include_recipe 'scalr-core::web'
include_recipe 'scalr-core::services'
include_recipe 'scalr-core::cron'

# Validate
include_recipe 'scalr-core::validate'
