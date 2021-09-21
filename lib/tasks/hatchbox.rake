require 'yaml'
require 'optparse'

namespace :hatchbox do
  namespace :pull do
    desc 'Downloads and imports the production database'
    task db: :environment do
      puts '➙ Generating production DB dump...'
      execute_on_server %(
      pg_dump #{ENV['PSQL_DATA_URI']} --column-inserts --no-owner --no-privileges > #{backup_file_name}
    )

      puts '➙ Downloading production DB dump...'
      system "scp #{server_user_and_host}:#{backup_file_name} ."

      puts '➙ Deleting production DB dump...'
      execute_on_server "rm #{backup_file_name}"

      puts '➙ Cleaning your local DB...'
      system 'bin/rails db:environment:set RAILS_ENV=development'
      %w[drop create].each { |task| Rake::Task["db:#{task}"].invoke }

      puts '➙ Importing production DB dump...'
      system "bin/rails db -e development < #{backup_file_name} > /dev/null"

      puts '➙ Removing local dump...'
      system "rm #{backup_file_name}"

      system 'bin/rails db:environment:set RAILS_ENV=development'

      puts '➙ Database imported!'
    end

    desc 'Downloads and imports the production assets'
    task assets: :environment do
      options = { alchemy: false }
      o = OptionParser.new do |opts|
        opts.banner = "Usage: rake hatchbox:pull -- [--alchemy]"
        opts.on("-a", "--alchemy", 'Download AlchemyCMS assets as well') { options[:alchemy] = true }
      end
      args = o.order!(ARGV) {}
      o.parse!(args)

      if options[:alchemy]
        puts '➙ Downloading alchemy assets...'
        system "rsync -a --del -L -K -vv --progress --rsh='ssh' #{server_user_and_host}:/home/deploy/example.com/current/uploads ."
      end

      puts '➙ Downloading storage assets...'
      system "rsync -a --del -L -K -vv --progress --rsh='ssh' #{server_user_and_host}:/home/deploy/example.com/current/storage ."

      puts '➙ Downloading public/system assets...'
      system "rsync -a --del -L -K -vv --progress --rsh='ssh' #{server_user_and_host}:/home/deploy/example.com/current/public/system ./public"

      puts '➙ Assets downloaded!'
    end
  end

  task pull: :environment do
    Rake::Task['hatchbox:pull:db'].invoke
    Rake::Task['hatchbox:pull:assets'].invoke
  end

  def execute_on_server(commands)
    system %(ssh -T #{server_user_and_host} << 'SSH'
      #{commands}
    SSH).split("\n").map(&:strip).join("\n")
  end

  def server_user_and_host
    'deploy@please-change-me'
  end

  def backup_file_name
    'backup.dump'
  end

end

