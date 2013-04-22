module MinecraftAvatars

  class BaseException < ::Exception
  end

  class InvalidPlayerException < BaseException
    attr_accessor :player

    def initialize(player)
      self.player = player
      super "Player #{player} does not exist"
    end
  end

  class InvalidResolutionException < BaseException
    attr_accessor :resolution

    def initialize(resolution)
      self.resolution = resolution
      super "Resolution #{resolution} is not valid!"
    end
  end

end