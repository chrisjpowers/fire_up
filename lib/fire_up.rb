class FireUp
  require 'rubygems'
  require 'iterm_window'
  require 'yaml'
  
  CONFIG_PATH = File.expand_path "~/.fire_up_config"
  
  def initialize(project_name)
    @project_name = project_name
    load_config!
  end
  
  def open_window
    this = self
    ItermWindow.open do
      open_tab :log do
        write "cd #{this.project_dir}"
        write "tail -f #{this.log_path}" # Using Passenger, just tail log
        set_title "#{this.title} Log"
      end
      open_tab :console do
        write "cd #{this.project_dir}"
        if File.exist?(File.expand_path(File.join(this.project_dir, 'script', 'console')))
          write "script/console"
        else
          write "rails console"
        end
        set_title "#{this.title} Console"
      end
      open_tab :dir do
        write "cd #{this.project_dir}"
        if tmproj = Dir[File.expand_path(File.join(this.project_dir, '*.tmproj'))].first
          write "open #{tmproj}"
        else
          write "mate ./"
        end
        set_title "#{this.title} Dir"
      end
    end
    write_config!
  end
  
  def project_dir
    get_config('project_dir', "What is your project directory's path?", :type => :path)
  end
  
  def title
    get_config('title', "What is the title of this project?")
  end
  
  def log_path
    path = File.expand_path(File.join(project_dir, 'log', 'development.log'))
    if File.exist?(path)
      path
    else
      get_config('log_path', "Where is your server log file?", :type => :path)
    end
  end
  
  private
  
  def get_config(key, question, options={})
    options[:regex] ||= /\w+/
    until @config[key] =~ options[:regex]
      puts question
      value = gets.chomp
      if options[:type] == :path
        value = File.expand_path(value)
      end
      @config[key] = value
    end
    @config[key]
  end
  
  def load_config!
    @full_config = File.exist?(CONFIG_PATH) ? YAML.load(File.read(CONFIG_PATH)) : {}
    @config = @full_config[@project_name] || {}
  end
  
  def write_config!
    @full_config[@project_name] = @config
    File.open(CONFIG_PATH, 'w') do |f|
      f.puts YAML.dump(@full_config)
    end
  end

end