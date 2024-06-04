class BunnyClient
    class << self
        def connect!
            @connection = Bunny.new(ENV['RABBITMQ_URL'])
            @connection.start
            @channel = @connection.create_channel
            @fan_out = @channel.fanout('movies.out')
            @queue = @channel.queue("movies", :exclusive => false, :auto_delete => false, :durable => true)
            @queue.bind(@fan_out)
            @connected = true
        end

        def push(payload)
            connect! unless @connected
            @queue.publish(payload, { app_id: "movies" })
            true
        end
    end
end