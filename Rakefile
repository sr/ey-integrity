desc "Migrate database"
task "db:migrate" do
  require "init"
  DataMapper.auto_upgrade!
end

desc "Start a resque worker"
task :worker do
  require "init"
  require "resque/tasks"

  dir     = Pathname(__FILE__).dirname.expand_path
  key     = dir.join("ssh_key.id_dsa")
  wrapper = dir.join("bin", "ssh-wrapper")

  if key.file? && wrapper.file?
    ENV["SSH_KEY"]  = key
    ENV["GIT_SSH"]  = wrapper
    key.chmod(0600)
  end

  ENV["QUEUE"]    = "integrity"

  Rake::Task["resque:work"].invoke
end

desc "Clean-up build directory"
task :cleanup do
  require "init"
  Integrity::Build.all(:completed_at.not => nil).each { |build|
    dir = Integrity.directory.join(build.id.to_s)
    dir.rmtree if dir.directory?
  }
end
