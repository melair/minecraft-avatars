module MinecraftAvatars

  class BaseException < ::Exception
  end

  class InvalidPlayerException < BaseException
    attr_accessor :player

    def initialize(player)
      self.player = player
      self.message = "Player #{player} does not exist"
      super()
    end
  end

  class InvalidResolutionException < BaseException
    attr_accessor :resolution

    def initialize(resolution)
      self.resolution = resolution
      self.message = "Resolution #{resolution} is not valid!"
      super()
    end
  end

end