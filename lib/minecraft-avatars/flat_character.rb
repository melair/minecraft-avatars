require 'minecraft-avatars/raw_skin'
require 'minecraft-avatars/base_image'
require 'minecraft-avatars/exceptions'

module MinecraftAvatars
  class FlatCharacter < BaseImage

    def initialize(player_name, height=64, accessories=true)

      throw InvalidResolutionException unless (height & (height-1)) == 0
      
      width = height/2

      skin = RawSkin.new(player_name)

      self.chunky = ChunkyPNG::Image.new(16, 32, ChunkyPNG::Color::TRANSPARENT)

      self.chunky.compose!(skin.sections[:head_front], 4, 0)
      self.chunky.compose!(skin.sections[:head_accessory], 4, 0) if accessories
      self.chunky.compose!(skin.sections[:body_front], 4, 8)
      self.chunky.compose!(skin.sections[:leg_front], 4, 20)
      self.chunky.compose!(skin.sections[:leg_front].mirror, 8, 20)
      self.chunky.compose!(skin.sections[:arm_front], 0, 8)
      self.chunky.compose!(skin.sections[:arm_front].mirror, 12, 8)

      self.chunky.resample_nearest_neighbor!(width, height)

    end

  end
end