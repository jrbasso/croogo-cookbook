node[:deploy].each do |application, deploy|
  if deploy[:application_type] != 'php'
    Chef::Log.debug("Skipping cakephp::setup application #{application} as it is not an PHP app")
    next
  end

  execute 'setup CakePHP PEAR channel' do
	action :run
	command 'pear channel-discover pear.cakephp.org'
	user 'root'
  end

  execute 'install CakePHP PEAR package' do
	action :run
	command 'pear install cakephp/CakePHP'
	user 'root'
  end
end
