require File.dirname(__FILE__) + '/achievements'
require File.dirname(__FILE__) + '/generators/triumph/triumph_generator'

%w{ models controllers }.each do |dir|
  path = File.join(File.dirname(__FILE__), 'app', dir)
  $LOAD_PATH << path
  ActiveSupport::Dependencies.load_paths << path
  ActiveSupport::Dependencies.load_once_paths.delete(path)
end