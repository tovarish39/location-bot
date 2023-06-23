require 'telegram/bot'

token = ENV['LocationDev_bot']

Location = Telegram::Bot::Types::Location

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    puts message.location.inspect if !message.location.nil?
    puts '-'
    case 
    when !message.location.nil?
      # puts message.location.inspect
      if message.location.live_period.nil?
        answer = 'бот перестал получать отслеживание'
        bot.api.send_message(chat_id: message.chat.id, text:answer)
      else
        horizontal_accuracy = message.location.horizontal_accuracy
        answer = "Бот получил изменение вашего места положения. Точность отслеживания #{horizontal_accuracy} метра"
        bot.api.send_message(chat_id: message.chat.id, text:answer)
      end

      # puts
    when message.text
      answer = 'отправьте боту место положение, выберите период отслеживания вашего места положения'
      bot.api.send_message(chat_id: message.chat.id, text:answer)
    end
  end
end