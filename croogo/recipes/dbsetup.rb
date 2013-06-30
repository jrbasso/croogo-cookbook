node[:deploy].each do |application, deploy|
  if deploy[:application_type] != 'php'
    Chef::Log.debug("Skipping croogo::dbsetup application #{application} as it is not an PHP app")
    next
  end

  execute "create mysql database" do
    command "/usr/bin/mysql -u#{node[:croogo][:database][:username]} -p#{node[:croogo][:database][:password]} -e 'CREATE DATABASE IF NOT EXISTS #{node[:croogo][:database][:database]}'"
    action :run
  end

  execute "create mysql tables" do
    command "/usr/bin/mysql -u#{node[:croogo][:database][:username]} -p#{node[:croogo][:database][:password]} #{node[:croogo][:database][:database]} < #{deploy[:deploy_to]}/current/Config/Schema/sql/croogo.sql"
    action :run
  end

  execute "import mysql data" do
    command "/usr/bin/mysql -u#{node[:croogo][:database][:username]} -p#{node[:croogo][:database][:password]} #{node[:croogo][:database][:database]} < #{deploy[:deploy_to]}/current/Config/Schema/sql/croogo_data.sql"
    action :run
  end

  execute "mark croogo as installed" do
    command "/usr/bin/mysql -u#{node[:croogo][:database][:username]} -p#{node[:croogo][:database][:password]} #{node[:croogo][:database][:database]} -e 'INSERT IGNORE INTO `settings` (`id`, `key`, `value`, `title`, `description`, `input_type`, `editable`, `weight`, `params`) VALUES (0, \'Croogo.installed\', \'1\', \'\', \'\', \'\', 1, 1, \'\')"
    action :run
  end

end
