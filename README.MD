# Postcard (Ruby version) 

## An abstraction layer over message brokers clients

This library, created for both languages `Javascript` and `Ruby`(https://rubygems.org/gems/postcard_rb), is an abstraction layer over `RabbitMQ` clients. 
It allows the communication among the microservices, providing functionality for publishing and subscribing events.

The microservices interact through topics created with one of three routing types: `Wide`, `Explicit` and `PatternMatching`. 

Each topic may have multiple rooms and, according to the routing type, microservices exchange messages on a different way.

#### Wide topic

Each message published on a wide topic is received by each room connected to it.

```ruby
# Send a message

topic = postcardRB.createTopic(name: "order", routing: Routing.Wide)
topic.publish(payload: "Place a new order")

# Receive a message

topic = postcardRB.createTopic(name: "order", routing: Routing.Wide)
room = topic.createRoom(name: "place")

room.subscribe { |properties, payload|
   puts " [x] Received #{payload}"
}

```

#### Explicit topic

For this kind of topic a message is published on an specific room using its exact name.
 
```ruby
# Send a message

topic = postcardRB.createTopic(name: "order", routing: Routing.Explicit)
topic.publish(room: "place", payload: "Place a new order")

# Receive a message

topic = postcardRB.createTopic(name: "order", routing: Routing.Explicit)
room = topic.createRoom(name: "place")

room.subscribe { |properties, payload|
   puts " [x] Received #{payload}"
}

```

#### Pattern matching topic

Using a pattern matching routing, a microservice subscribe to a room based on matching between a message routing key and the pattern that was used to create that room.

```ruby
# Send a message

topic = postcardRB.createTopic(name: "delivery", routing: Routing.PatternMatching)
topic.publish(room: "sms.customers", payload: "Important news")

# Receive a message

topic = postcardRB.createTopic(name: "delivery", routing: Routing.PatternMatching)
room = topic.createRoom(name: "sms.*")

room.subscribe { |properties, payload|
   puts " [x] Received #{payload}"
}

```

--------------------------------------------------------------------------------

### Prerequisites

What things you need to install the software

```
docker 17+
docker-compose 1.19.0+

```

--------------------------------------------------------------------------------

### Development

```bash
# Change the directory to the docker development 
cd docker/dev

# Create a .env file with your local application folder
echo "APP_FOLDER=/path-to-your-local/app" > .env 

# Run the services using docker compose
sudo docker-compose up -d

# Get into the container with the following command:
# sudo docker exec -it Postcard bash

# The examples folder path into the running container is:
# /usr/src/app/examples

```

--------------------------------------------------------------------------------

### PostcardRB gem creation

```bash
# Get into the container with the following command:
sudo docker exec -it Postcard bash

# Move to the Postcard folder
cd /usr/src/app/lib/PostcardRB

# Build the gem
gem build PostcardRB.gemspec

# Install it
gem install postcard_rb-<version>.gem

# Get into the ruby command line ...
irb

# ... and check the correct installation with the following command:
require "postcard_rb"

# The irb would responde with the following line:
# => true

```

--------------------------------------------------------------------------------

## Authors

- **Simone Adelchino** - [_claclacla_](https://twitter.com/_claclacla_)

--------------------------------------------------------------------------------

## License

This project is licensed under the MIT License

--------------------------------------------------------------------------------

## Acknowledgments

- [RabbitMQ](https://www.rabbitmq.com)
