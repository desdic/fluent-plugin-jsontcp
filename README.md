# Fluent::Plugin::Jsontcp

Simple plugin for Fluentd to export JSON to a TCP socket

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'fluent-plugin-jsontcp'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install fluent-plugin-jsontcp

## Usage

```
...
<match rsyslog.** legacyrsyslog.**>
  type jsontcp
  format json
  utc
  port 3540
  buffer_type file
  buffer_path /var/log/td-agent/fluent_buffer0
  buffer_chunk_limit 1k
  buffer_queue_limit 8192
  flush_interval 1s
</match>
...
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/desdic/fluent-plugin-jsontcp.

