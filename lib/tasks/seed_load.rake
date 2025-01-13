
#########################################################################
# Load seed data into development database
#########################################################################
namespace :agile do
  desc "Load seed data into database"
  task :seed_load => :environment do |t, args|

    p "", "", "", "Define application administrator username and password", ""
    puts "Enter administrator username:"
    admin = gets.chomp
    if admin.size < 4
      p "Administrator's username should be at least 4 characters long"
      break
    end

    puts "Enter administrator's password"
    password = gets.chomp
    if password.size < 1
      p "Administrator's password should be at least 8 characters long"
      break
    end

    unless ArSite.all.count + ArPage.all.count + ArUser.all.count == 0
      p "It looks like database is not empty. Aborting."
      break
    end

    # fill database
    data = YAML.unsafe_load_file( File.expand_path('../seed_data.yaml', __FILE__))
    data.each do |model_name, records|
      model = model_name.classify.constantize
      model.delete_all
      records.each do |record|
        new_record = model.new
        record.each do |field_name, value|
          new_record.send(field_name + '=', value)
        end
        new_record.save
      end
    end
    # update admin data
    adm = ArUser.find(2)
    adm.username = admin
    adm.password = password
    adm.password_confirmation = password
    adm.save
  end
end
