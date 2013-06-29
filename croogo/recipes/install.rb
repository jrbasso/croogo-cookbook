node[:deploy].each do |application, deploy|
  if deploy[:application_type] != 'php'
    Chef::Log.debug("Skipping croogo::install application #{application} as it is not an PHP app")
    next
  end

  execute 'write permission to tmp folder' do
	action :run
	user 'root'
	command "chmod 777 -R #{deploy[:deploy_to]}/current/tmp"
  end

  execute 'make croogo' do
	action :run
	user deploy[:user]
	command "cd #{deploy[:deploy_to]}/current && ./Console/cake croogo make"
  end

  %w(croogo.php database.php settings.json).each do |file|
	template "#{deploy[:deploy_to]}/current/Config/#{file}" do
	  source "#{file}.erb"
	  group deploy[:group]
	  only_if do
		File.directory?("#{deploy[:deploy_to]}/current")
	  end
	end

	file "#{deploy[:deploy_to]}/current/Config/#{file}.install" do
	  action :delete
	end
  end
end
