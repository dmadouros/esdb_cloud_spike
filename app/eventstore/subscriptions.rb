class Subscriptions
  def self.listen_all
    return unless Rails.const_defined? 'Server'

    Rails.logger.level = 0

    # Thread.new do
    #   credentials =
    #     Base64.encode64("#{ENV["EVENTSTORE_USERNAME"]}:#{ENV["EVENTSTORE_PASSWORD"]}").delete("\n")
    #   metadata = { 'authorization' => "Basic #{credentials}" }
    #
    #   stub = EventStore::Client::Streams::Streams::Stub.new(ENV["EVENTSTORE_DB_URL"], ::GRPC::Core::ChannelCredentials.new(nil))
    #   read_request = EventStore::Client::Streams::ReadReq.new(
    #     options: EventStore::Client::Streams::ReadReq::Options.new(
    #       read_direction: :Forwards,
    #       resolve_links: false,
    #       uuid_option: EventStore::Client::Streams::ReadReq::Options::UUIDOption.new(
    #         string: EventStore::Client::Empty.new
    #       ),
    #       all: EventStore::Client::Streams::ReadReq::Options::AllOptions.new(
    #         start: EventStore::Client::Empty.new
    #       ),
    #       count: 20,
    #       filter: EventStore::Client::Streams::ReadReq::Options::FilterOptions.new(
    #         checkpointIntervalMultiplier: 1,
    #         stream_identifier: EventStore::Client::Streams::ReadReq::Options::FilterOptions::Expression.new(
    #           regex: "",
    #           prefix: ["user-", "user:command-", "email-", "email:command-"]
    #         ),
    #         max: 100
    #       )
    #     )
    #   )
    #
    #   responses = stub.read(read_request, metadata: metadata)
    #   responses.each { |response|
    #     p response
    #   }
    # end

    EventStoreClient.configure { |config|
      puts "*******************************************"
      puts "* eventstore_url: #{ENV["EVENTSTORE_DB_URL"]}"
      puts "*******************************************"
      config.eventstore_url = ENV["EVENTSTORE_DB_URL"]
      config.logger = Rails.logger
      config.skip_deserialization = true
    }

    sleep 2

    results = EventStoreClient.client.read("$all", options: {filter: {stream_identifier: {prefix: ["user"]}}})
              # EventStoreClient.client.read('$all', options: { filter: { stream_identifier: { prefix: ['some-stream-1', 'some-stream-2'] } } })
    # result = EventStoreClient.client.read("$streams")
    # EventStoreClient.client.hard_delete_stream('some-stream')
    # result = EventStoreClient.client.read("$all", skip_deserialization: true, options: {filter: {stream_identifier: {prefix: ["user-", "user:command-", "email-", "email:command-", "tenant-"]}}})
    puts "*" * 20
    results = results.fmap { |read_resps|
      read_resps.map { |read_resp|
        read_resp.event.event.stream_identifier.stream_name
      }
    }
    puts "*" * 20

    # Thread.new do
    #   sleep 5
    #   handler = -> (result) {
    #     result.bind { |event|
    #       puts("event: #{event}")
    #       # Message.upsert(
    #       #   {
    #       #     event_id: event.id,
    #       #     trace_id: event.data["traceId"],
    #       #     actor_id: event.data["actorId"],
    #       #     stream: event.stream_name,
    #       #     event_type: event.type,
    #       #     timestamp: event.data["timestamp"],
    #       #     data: event.data["data"]
    #       #   },
    #       #   unique_by: :event_id,
    #       #   on_duplicate: :skip
    #       # )
    #     }
    #       .or {|error|
    #         puts("error: #{error}")
    #       }
    #   }
    #
    #   EventStoreClient.client.subscribe_to_all(
    #     handler: handler,
    #     options: {filter: {stream_identifier: {prefix: ["user-", "user:command-", "email-", "email:command-"]}}}
    #   )
    # end

    # Thread.new do
    #   handler = -> (result) {
    #     result.bind { |event|
    #       Stream.upsert(
    #         {
    #           stream: event.stream_name,
    #           message_count: 1,
    #           last_message_id: event.id,
    #           last_message_global_position: event.commit_position,
    #         },
    #         unique_by: :stream,
    #         on_duplicate: Arel.sql("message_count = streams.message_count + 1, last_message_global_position = #{event.commit_position} where streams.last_message_global_position < #{event.commit_position}")
    #       )
    #     }
    #   }
    #
    #   EventStoreClient.client.subscribe_to_all(
    #     handler: handler,
    #     options: {filter: {stream_identifier: {regex: /^[^\$].*$/.to_s}}}
    #   )
    # end

    # Thread.new do
    #   handler = -> (result) {
    #     result.bind { |event|
    #       Category.upsert(
    #         {
    #           category: event.stream_name.split("-").first,
    #           message_count: 1,
    #           last_message_id: event.id,
    #           last_message_global_position: event.commit_position,
    #         },
    #         unique_by: :category,
    #         on_duplicate: Arel.sql("message_count = categories.message_count + 1, last_message_global_position = #{event.commit_position} where categories.last_message_global_position < #{event.commit_position}")
    #       )
    #     }
    #   }
    #
    #   EventStoreClient.client.subscribe_to_all(
    #     handler: handler,
    #     options: {
    #       filter: {stream_identifier: {regex: /^[^\$].*$/.to_s}},
    #       from_position: :start
    #     }
    #   )
    # end
  end
end
