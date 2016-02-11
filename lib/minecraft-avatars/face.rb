require 'minecraft-avatars/raw_skin'
require 'minecraft-avatars/base_image'
require 'minecraft-avatars/exceptions'

module MinecraftAvatars
  class Face < BaseImage
    attr_accessor :skin

    def initialize(player_name, size=64)
      throw InvalidResolutionException unless (size & (size-1)) == 0

      if player_name.length == 36
        self.skin = RawSkin.new(nil, player_name)
      else
        self.skin = RawSkin.new(player_name)
      end

      resize size
    end

    def resize(size)
      throw InvalidResolutionException unless (size & (size-1)) == 0

      self.chunky = ChunkyPNG::Image.new(8, 8, ChunkyPNG::Color::TRANSPARENT)

      self.chunky.compose!(self.skin.sections[:head_front], 0, 0)
      self.chunky.compose!(self.skin.sections[:head_accessory], 0, 0)

      self.chunky.resample_nearest_neighbor!(size, size)
    end
  end
end
