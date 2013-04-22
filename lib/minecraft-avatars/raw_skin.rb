require 'open-uri'
require 'chunky_png'
require 'minecraft-avatars/exceptions'

module MinecraftAvatars

  class RawSkin

    attr_accessor :player_name
    attr_accessor :sections
    attr_accessor :image

    def initialize(player_name)

      self.sections = {}
      self.player_name = player_name
      begin
        image_uri = open "#{MinecraftAvatars::SKIN_URL}/#{player_name}.png"
        raw_data = image_uri.read
      rescue OpenURI::HTTPError => e
        if e.message == "403 Forbidden"
          raise MinecraftAvatars::InvalidPlayerException.new(player_name)
        else
          raise e
        end
      end

      self.image = ChunkyPNG::Image.from_blob(raw_data)

      deconstruct

    end

    def deconstruct

      MinecraftAvatars::SKIN_SECTIONS.each do |name, section|
        x, y, width, height = section
        chunk = self.image.crop x, y, width, height

        self.sections[name] = chunk
      end

    end

  end
end