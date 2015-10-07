
module Fluent
  class JSONTCPOutput < TimeSlicedOutput

    Plugin.register_output('jsontcp', self)

    config_param :path, :string
    config_param :format, :string, :default => 'json'
    config_param :port,   :integer, :default => 3540
    config_param :host,   :string, :default => 'localhost'

    def initialize
      require 'time'
      require 'socket'
      super
    end

    def connect()
      TCPSocket.new(@host, @port)
    end

    def configure(conf)
      if path = conf['path']
        @path = path
      end
      unless @path
        raise ConfigError, "'path' parameter is required on output"
      end

      if pos = @path.index('*')
        @path_prefix = @path[0,pos]
        @path_suffix = @path[pos+1..-1]
        conf['buffer_path'] ||= "#{@path}"
      else
        @path_prefix = @path+"."
        @path_suffix = ".log"
        conf['buffer_path'] ||= "#{@path}.*"
      end

      super

      @formatter = Plugin.new_formatter(@format)
      @formatter.configure(conf)

      @buffer.symlink_path = @symlink_path if @symlink_path
    end

    def format(tag, time, record)
      @formatter.format(tag, time, record)
    end

    def write(chunk)
	sock = connect()
	begin
		chunk.write_to(sock)
		return
	ensure
		sock.close
	end

      return false
    end

    def secondary_init(primary)
      # don't warn even if primary.class is not FileOutput
    end

    private

  end
end
