# System
include_recipe 'scalr-core::repos'

# Cron
include_recipe 'cron'

# Users
include_recipe 'scalr-core::users'

# Services
# Note: must be defined first, otherwise Chef will complain that the init
# files are missing. We're not launching them yet, though.
include_recipe 'scalr-core::stub-services'

# Scalr Code
include_recipe 'scalr-core::package'

# PuTTYgen (SSH Launcher support for Windows clients)
include_recipe 'scalr-core::puttygen'

# Runtime dependencies
include_recipe 'scalr-core::php'
include_recipe 'scalr-core::snmp'
include_recipe 'scalr-core::scalrpy'
include_recipe 'scalr-core::rrdcached'

# Scalr configuration and PHP settings
include_recipe 'scalr-core::configuration'
include_recipe 'scalr-core::php_settings'

# Database Configuration
include_recipe 'scalr-core::database_init_structure'
include_recipe 'scalr-core::database_init_admin'

# Set sysctl requirements
include_recipe 'scalr-core::sysctl'

# Service Configuration and Launch
include_recipe 'scalr-core::web'
include_recipe 'scalr-core::services'
include_recipe 'scalr-core::cron'

# Validate
include_recipe 'scalr-core::validate'
