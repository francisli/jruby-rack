# This is a fake Rails config/environment file to be used during testing.

RAILS_ROOT = ENV['RAILS_ROOT']
RAILS_ENV = ENV['RAILS_ENV']

# Simulate the Rails 2.0 boot process here, to test our boot hook
module Rails
  class << self
    def boot!
      unless booted?
        pick_boot.run
      end
    end

    def booted?
      defined? Rails::Initializer
    end

    def pick_boot
      Boot.new
    end
  end

  class Boot
    def run
      require 'initializer'
      Rails::Initializer.run(:set_load_path)
    end
  end
end

Rails.boot!

Rails::Initializer.run
