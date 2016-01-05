
module Fluent
    class JSONTCPOutput < ObjectBufferedOutput

        Plugin.register_output('jsontcp', self)

        OUTPUT_PROCS = {
            :json => Proc.new {|record| Yajl.dump(record) },
            :hash => Proc.new {|record| record.to_s },
        }

        config_param :port,   :integer, :default => 3540
        config_param :host,   :string, :default => 'localhost'

        config_param :format, :default => :json do |val|
            case val.downcase
            when 'json'
                :json
            when 'hash'
                :hash
            else
                raise ConfigError, "bufferd stdout output format should be 'json' or 'hash'"
            end
        end

        def initialize
            require 'time'
            require 'socket'
            super
        end

        def connect()
            TCPSocket.new(@host, @port)
        end

        def configure(conf)
            unless conf['buffer_path']
                raise ConfigError, "'buffer_path' parameter is required on output"
            end

            super

            @output_proc = OUTPUT_PROCS[@format]
        end

        def write_objects(tag, es)
            sock = connect()
            begin
                content = ''
                es.each {|time,record|
                    begin
                        record["time"] = "#{time}"
                        content << "#{@output_proc.call(record)}"
                    rescue
                        # Ignore faulty records (Without time)
                    end
                }
                sock.puts content
                return
            ensure
                sock.close
            end

            return false
        end

        private

    end
end
