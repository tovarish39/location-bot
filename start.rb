require 'telegram/bot'

token = ENV['LocationDev_bot']

Location = Telegram::Bot::Types::Location

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    # puts message.location.inspect if !message.location.nil?
    # puts '-'
    case 
    when !message.location.nil?
      # puts message.location.inspect
      if message.location.live_period.nil?
        answer = 'Бот перестал получать отслеживание.'
        bot.api.send_message(chat_id: message.chat.id, text:answer)
      elsif message.location.horizontal_accuracy.nil?
        answer = "Бот получил ваше место положение в реальном времени."
        bot.api.send_message(chat_id: message.chat.id, text:answer)
      else
        horizontal_accuracy = message.location.horizontal_accuracy
        answer = "Бот получил изменение вашего места положения. Точность отслеживания #{horizontal_accuracy} метра"
        bot.api.send_message(chat_id: message.chat.id, text:answer)
      end

      # puts
    when message.text
      answer = 'Отправьте боту ваше место положение в реальном времени'
      bot.api.send_message(chat_id: message.chat.id, text:answer)

      photo_paths = ['./images/1.png','./images/2.png']
      photo_paths.each do |photo_path|
        path = File.expand_path(photo_path)
        bot.api.send_photo(chat_id: message.chat.id, photo: Faraday::UploadIO.new(path, 'image/png'))
      end
    end
  end
end