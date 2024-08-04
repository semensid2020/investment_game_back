# Импортируем конфиг окружения и библиотеку
require File.expand_path('../config/environment', __dir__)
require 'telegram/bot'

class TelegramBot
  def initialize
    # При инициализации важно указать API токен его можно
    # получить в тг создав бота с помощью https://t.me/BotFather
    @bot = Telegram::Bot::Client.new(ENV['TOKEN'])
  end

  def run
    # В данном методе мы "ловим" основные типы
    # апдейтов, которые могут прийти к нам от ТГ
    @bot.listen do |update|
      case update
      when Telegram::Bot::Types::Message
        handle_message(update)
      when Telegram::Bot::Types::CallbackQuery
        handle_callback_query(update)
      when Telegram::Bot::Types::ChatMemberUpdated
        handle_chat_member_updated(update)
      else
        puts "Необработанное обновление типа: #{update.class}"
      end
    end
  end

  private

  def handle_message(message)
    case message.text
    when '/start'
      start_command(message)
    when '/stop'
      stop_command(message)
    else
      handle_unknown_command(message)
    end
  end

  def handle_callback_query(callback_query)
    puts "Получен callback query: #{callback_query.data}"
  end

  def handle_chat_member_updated(chat_member_updated)
    puts "Обновление для пользователя: #{chat_member_updated.from.id}"
  end

  def start_command(message)
    # Здесь мы вызываем генерацию токена и отправляем
    # пользователю сообщение содержащее кнопку с ссылкой на наш
    # сервис. Важно отметить, что сгенерированный токен мы кладём в
    # Редис, чтобы потом произвести аутентификацию пользователя

    auth_token = generate_auth_token(message)
    webapp_url = "#{ENV['NGROK_URL']}?tg_token=#{auth_token}"

    keyboard = Telegram::Bot::Types::InlineKeyboardMarkup.new(
      inline_keyboard: [
        [
          Telegram::Bot::Types::InlineKeyboardButton.new(
            text: 'Investment game app',
            web_app: { url: webapp_url }
          )
        ]
      ]
    )

    @bot.api.send_message(
      chat_id: message.chat.id,
      text: "Играть в один клик!",
      reply_markup: keyboard
    )
  end

  def stop_command(message)
    @bot.api.send_message(chat_id: message.chat.id, text: "До свидания, #{message.from.first_name}!")
  end

  def handle_unknown_command(message)
    @bot.api.send_message(chat_id: message.chat.id, text: "Неизвестная команда.")
  end

  def generate_auth_token(message)
    token = SecureRandom.hex(16)
    user_info = {
      telegram_id: message.from.id,
      name: message.from.first_name,
      username: message.from.username
    }

    REDIS.set(token, user_info.to_json)
    token
  end
end

bot = TelegramBot.new
bot.run
