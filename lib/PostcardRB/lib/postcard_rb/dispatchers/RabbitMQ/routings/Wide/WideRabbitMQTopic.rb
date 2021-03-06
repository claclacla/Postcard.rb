require_relative '../BaseRabbitMQTopic'
require_relative './WideRabbitMQRoom'

class WideRabbitMQTopic < BaseRabbitMQTopic
  def initialize name:, channel:
    super()

    @channel = channel
    @exchange = @channel.fanout(name, :durable => false)
  end  

  def createRoom name:, exclusive: false, autoDelete: false
    room = WideRabbitMQRoom.new(
      name: name,
      exclusive: exclusive,
      autoDelete: autoDelete,
      channel: @channel,
      exchange: @exchange
    )
    
    addRoom(room: room)

    return room
  end

  def publish payload:, correlationId: nil, replyTo: nil
    @exchange.publish(
      payload, 
      :correlation_id => correlationId,
      :reply_to => replyTo,
      :persistent => false
    )
  end
end