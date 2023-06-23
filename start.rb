require 'telegram/bot'

token = ENV['LocationDev_bot']

Location = Telegram::Bot::Types::Location

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    case 
    when !message.location.nil?
      puts message.location.inspect
      puts
    when message.text
      answer = 'отправьте боту место положение, выберите период отслеживания вашего места положения'
      bot.api.send_message(chat_id: message.chat.id, text:answer)
    end
  end
end