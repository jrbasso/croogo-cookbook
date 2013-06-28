node[:deploy].each do |application, deploy|
  if deploy[:application_type] != 'php'
    Chef::Log.debug("Skipping php::timezone_cfg application #{application} as it is not an PHP app")
    next
  end

  execute 'install CakePHP PEAR package' do
	action :run
	command "sed -i 's/;date\.timezone.*/date.timezone = UTC/g' `php -r 'echo php_ini_loaded_file();'`"
	user 'root'
  end
end
