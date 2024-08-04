class TelegramAuth
  def initialize(app)
    @app = app
  end

  def call(env)
    # Здесь, используя redis мы находим или создаём
    # по токену пользователя и сохраняем его user_id в сессию

    request = Rack::Request.new(env)

    token = request.params['tg_token']

    if token.present?
      user_info_json = REDIS.get(token)
      user_info = JSON.parse(user_info_json)
      user = User.find_or_initialize_by(telegram_id: user_info['telegram_id'])
      user.update(
        name: user_info['name'],
        username: user_info['username']
      )
      env['rack.session'][:user_id] = user.id
      REDIS.del(token)
      return [302, {'Location' => '/'}, []]
    else
      puts "Some error"
    end

    @app.call(env)
  end
end
