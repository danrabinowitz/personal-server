require 'fileutils'

def plugin_installed?(plugin)
  File.exists? plugin_tracker_filename(plugin)
end

def install_plugin(plugin)
  puts "Installing plugin: #{plugin}"
  `vagrant plugin install #{plugin}`
  FileUtils.mkdir_p plugin_tracker_directory
  FileUtils.touch plugin_tracker_filename(plugin)
end

def plugin_tracker_filename(plugin)
  "#{plugin_tracker_directory}/#{plugin}"
end

def plugin_tracker_directory
  ".vagrant/plugin_tracker"
end

def ensure_plugin_is_installed(plugin)
  install_plugin(plugin) unless plugin_installed?(plugin)
end

def blank?(string)
  string.nil? || string.empty?
end

def require_env_values(required_values)
  required_values.each do |required_value|
    raise "ERROR: #{required_value} is required but not set." if blank?(ENV[required_value])
  end
end

def merge_if_present(hash, env_keys)
  env_keys.each do |env_key|
    value = ENV[env_key]
    next if blank?(value)
    hash_key = env_key.downcase.to_sym
    hash.merge!({hash_key => value})
  end
end
