include_attribute 'deploy'

default[:croogo][:database][:datasource] = 'Database/Mysql'
default[:croogo][:database][:host] = '127.0.0.1'
default[:croogo][:database][:username] = 'root'
default[:croogo][:database][:password] = 'root'
default[:croogo][:database][:database] = 'croogo'
default[:croogo][:database][:prefix] = ''
default[:croogo][:database][:encoding] = 'utf8'
default[:croogo][:database][:port] = 3306

default[:croogo][:site][:email] = 'you@your-site.com'
default[:croogo][:site][:tagline] = 'A CakePHP powered Content Management System.'
default[:croogo][:site][:title] = 'Croogo'

default[:croogo][:meta][:description] = 'Croogo - A CakePHP powered Content Management System'
default[:croogo][:meta][:generator] = 'Croogo - Content Management System'
default[:croogo][:meta][:keywords] = 'croogo, Croogo'

default[:croogo][:askimet][:key] = 'your-key'
default[:croogo][:askimet][:url] = 'http://your-blog.com'

default[:croogo][:recaptcha][:public_key] = 'your-public-key'
default[:croogo][:recaptcha][:private_key] = 'your-private-key'
