class Rake::Task
  def self.sanitize_and_execute(sql)
    sanitized = ActiveRecord::Base.send(:sanitize_sql, sql, nil)
    ActiveRecord::Base.connection.execute(sanitized)
  end
end

namespace :daysheet do

  namespace :settings do
    desc "Load default application settings"
    task :load => :environment do
      yaml = RAILS_ROOT + "/config/settings.yml"
      begin
        settings = YAML.load_file(yaml)
      rescue
        puts "Couldn't load #{yaml} configuration file."
        exit
      end

      # Truncate settings table if loading DaySheet settings.
      ActiveRecord::Base.establish_connection(Rails.env)
      ActiveRecord::Base.connection.execute("TRUNCATE settings")

      settings.keys.each do |key|
        sql = [ "INSERT INTO settings (name, default_value, created_at, updated_at) VALUES(?, ?, ?, ?)", key.to_s, Base64.encode64(Marshal.dump(settings[key])), Time.now, Time.now ]
        Rake::Task.sanitize_and_execute(sql)
      end
    end

    desc "Show current application settings"
    task :show => :environment do
      ActiveRecord::Base.establish_connection(Rails.env)
      names = ActiveRecord::Base.connection.select_values("SELECT name FROM settings ORDER BY name")
      names.each do |name|
        puts "\n#{name}:\n  #{Setting.send(name).inspect}"
      end
    end
  end

  desc "Prepare the database and load default application settings"
  task :setup => :environment do
    proceed = true
    if ActiveRecord::Migrator.current_version > 0
      puts "\nYour database is about to be reset, so if you choose to proceed all the existing data will be lost.\n\n"
      loop do
        print "Continue [yes/no]: "
        proceed = STDIN.gets.strip
        break unless proceed.blank?
      end
      proceed = (proceed =~ /y(?:es)*/i)
    end
    if proceed
      Rake::Task["db:migrate:reset"].invoke
      Rake::Task["daysheet:settings:load"].invoke
      Rake::Task["daysheet:setup:admin"].invoke
    end
  end

  namespace :setup do
    desc "Create admin user"
    task :admin => :environment do
      username, password, email = ENV["USERNAME"], ENV["PASSWORD"], ENV["EMAIL"]
      unless username && password && email
        puts "\nTo create the admin user you will be prompted to enter username, password,"
        puts "and email address. You might also specify the username of existing user.\n"
        loop do
          username ||= "system"
          print "\nUsername [#{username}]: "
          reply = STDIN.gets.strip
          username = reply unless reply.blank?

          password ||= "manager"
          print "Password [#{password}]: "
          echo = lambda { |toggle| return if RUBY_PLATFORM =~ /mswin/; system(toggle ? "stty echo && echo" : "stty -echo") }
          begin
            echo.call(false)
            reply = STDIN.gets.strip
            password = reply unless reply.blank?
          ensure
            echo.call(true)
          end

          loop do
            print "Email: "
            email = STDIN.gets.strip
            break unless email.blank?
          end

          puts "\nThe admin user will be created with the following credentials:\n\n"
          puts "  Username: #{username}"
          puts "  Password: #{'*' * password.length}"
          puts "     Email: #{email}\n\n"
          loop do
            print "Continue [yes/no/exit]: "
            reply = STDIN.gets.strip
            break unless reply.blank?
          end
          break if reply =~ /y(?:es)*/i
          redo if reply =~ /no*/i
          puts "No admin user was created."
          exit
        end
      end
      User.reset_column_information # Reload the class since we've added new fields in migrations.
      user = User.find_by_username(username) || User.new
      user.update_attributes(:username => username, :password => password, :email => email)
      role = Role.create!(:name => 'Admin')
      user.roles << role
      puts "Admin user has been created."
    end
  end
end

