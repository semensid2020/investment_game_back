module VolatilityService
  def self.simulate(volatility_coefficient = 0.1, price = 100, trend = 0.001, time_step = 1)
    drift = trend * time_step
    diffusion = volatility_coefficient * gaussian_distribution * Math.sqrt(time_step)
    new_price = price * Math.exp(drift + diffusion)
    new_price
  end

  # Метод позволяет нам сгенерировать случайное число
  # в соответствии с нормальным распределением
  def self.gaussian_distribution
    theta = 2 * Math::PI * rand
    rho = Math.sqrt(-2 * Math.log(1 - rand))
    scale = 0.4

    scale * rho * Math.cos(theta)
  end
end
