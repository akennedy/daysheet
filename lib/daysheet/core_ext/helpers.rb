class ActionController::Base
  
  # Extract helper names from files in app/helpers/*.rb -- no app/admin/helpers
  # or any other subdirectories are included.
  #----------------------------------------------------------------------------
  def self.application_helpers
    extract = /^#{Regexp.quote(helpers_dir)}\/?(.*)_helper.rb$/
    Dir["#{helpers_dir}/*_helper.rb"].map { |file| file.sub extract, '\1' }
  end 

end