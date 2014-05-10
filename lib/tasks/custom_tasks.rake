namespace :session do

	desc "Clear expired sessions" 
	task :clear_expired => :environment do
		sql = "DELETE FROM sessions WHERE updated_at < ((NOW() AT TIME ZONE 'UTC') - INTERVAL '24 HOURS');"
		puts sql
		ActiveRecord::Base.connection.execute(sql)
	end
	
end