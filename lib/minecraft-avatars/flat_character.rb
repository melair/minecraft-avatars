require 'minecraft-avatars/raw_skin'
require 'minecraft-avatars/base_image'
require 'minecraft-avatars/exceptions'

module MinecraftAvatars
  class FlatCharacter < BaseImage
    attr_accessor :skin
    attr_accessor :accessories

    def initialize(player_name, height=64, accessories=true)
      throw InvalidResolutionException unless (height & (height-1)) == 0

      self.skin = RawSkin.new(player_name)
      self.accessories = accessories
    end

    def resize(height)
      throw InvalidResolutionException unless (height & (height-1)) == 0

      width = height/2

      self.chunky = ChunkyPNG::Image.new(16, 32, ChunkyPNG::Color::TRANSPARENT)

      self.chunky.compose!(self.skin.sections[:head_front], 4, 0)
      self.chunky.compose!(self.skin.sections[:head_accessory], 4, 0) if self.accessories
      self.chunky.compose!(self.skin.sections[:body_front], 4, 8)
      self.chunky.compose!(self.skin.sections[:leg_front], 4, 20)
      self.chunky.compose!(self.skin.sections[:leg_front].mirror, 8, 20)
      self.chunky.compose!(self.skin.sections[:arm_front], 0, 8)
      self.chunky.compose!(self.skin.sections[:arm_front].mirror, 12, 8)

      self.chunky.resample_nearest_neighbor!(width, height)
    end
  end
end
