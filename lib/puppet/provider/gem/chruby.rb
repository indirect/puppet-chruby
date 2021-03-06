require 'puppet/util/execution'

Puppet::Type.type(:gem).provide(:chruby) do
  include Puppet::Util::Execution
  desc ""

  def gem_path
    @gem_path ||= execute("gem env gemdir", default_command_opts).chomp
  end

  def default_command_opts
    @default_command_opts ||= {
      :failonfail         => true,
      :uid                => (Facter.value(:boxen_user) || Facter.value(:id) || "root"),
      :custom_environment => {
        "PATH" => "#{@resource[:ruby_root]}/bin",
      },
      :combine            => true,
    }
  end

  def gem(command)
    full_command = "gem #{command}"

    command_opts = default_command_opts
    command_opts[:custom_environment].merge!({
      "GEM_PATH" => gem_path,
      "GEM_HOME" => gem_path,
    })

    output = execute(full_command, command_opts)
    [output, $?]
  end

  def create
    [@resource[:ensure]].flatten.each do |e|
      gem "install '#{@resource[:gem]}' -v '#{e}'"
    end
  end

  def destroy
    gem "uninstall '#{@resource[:gem]}' -x -a"
  end

  def query
    h = {
      :name     => @resource[:name],
      :gem      => @resource[:gem],
      :provider => :chruby,
    }

    all_versions = []

    Dir.chdir "#{gem_path}/gems" do
      all_versions = Dir["#{@resource[:gem]}-*"].map { |g| g.rpartition("-").last }.sort
    end

    if all_versions.any?
      if [:present, :absent].member?(@resource[:ensure])
        h.merge!(:ensure => :present)
      else
        h.merge!(:ensure => all_versions)
      end
    else
      h.merge!(:ensure => :absent)
    end

    h
  end

  def exists?
    is     = self.query[:ensure]
    should = [@resource[:ensure]].flatten.sort

    is == should ? should : is
  end

private
  def execute(*args)
    if Puppet.features.bundled_environment?
      Bundler.with_clean_env do
        super
      end
    else
      super
    end
  end

  def self.execute(*args)
    if Puppet.features.bundled_environment?
      Bundler.with_clean_env do
        super
      end
    else
      super
    end
  end
end
