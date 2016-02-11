require 'open-uri'
require 'json'
require 'base64'
require 'chunky_png'
require 'minecraft-avatars/exceptions'

module MinecraftAvatars

  class RawSkin

    attr_accessor :player_name
    attr_accessor :player_uuid

    attr_accessor :sections
    attr_accessor :image

    attr_accessor :texture_url
    attr_accessor :slim

    def initialize(player_name, uuid => nil)
      self.sections = {}
      self.player_name = player_name

      if uuid.nil?
        self.player_uuid = resolve_uuid player_name
      else
        self.player_uuid = uuid
      end

      self.texture_url, self.slim = resolve_texture self.player_uuid
      
      download_texture

      deconstruct
    end

    def resolve_uuid(player_name)
      begin
        profile_uri = open "#{RESOLVE_UUID_URL}/#{player_name}"
        profile = profile_uri.read
        profile_json = JSON.parse profile
        return profile_json["id"]
      rescue JSON::ParserError => e
        raise MinecraftAvatars::InvalidPlayerException.new(self.player_name)
      rescue OpenURI::HTTPError => e
        raise MinecraftAvatars::InvalidPlayerException.new(self.player_name)
      end
    end

    def resolve_texture(uuid)
      begin
        texture_uri = open "#{TEXTURE_URL}/#{uuid}"
        texture = texture_uri.read
        texture_json = JSON.parse texture

        properties = texture_json["properties"]

        properties.each do |property|
          if property["name"] == "textures"
            decoded_texture_raw = Base64.decode64 property["value"]
            texture_data = JSON.parse decoded_texture_raw

            if texture_data.has_key?("textures") && texture_data["textures"].has_key?("SKIN") && texture_data["textures"]["SKIN"].has_key?("url")
              url = texture_data["textures"]["SKIN"]["url"]

              slim = false

              if texture_data["textures"]["SKIN"].has_key?("metadata") && texture_data["textures"]["SKIN"]["metadata"].has_key?("model")
                slim = texture_data["textures"]["SKIN"]["metadata"]["model"] == "slim"
              end

              return [ url, slim ]
            end
          end
        end

        raise MinecraftAvatars::InvalidPlayerException.new(self.player_name)
      rescue JSON::ParserError => e
        raise MinecraftAvatars::InvalidPlayerException.new(self.player_name)
      rescue OpenURI::HTTPError => e
        raise MinecraftAvatars::InvalidPlayerException.new(self.player_name)
      end        
    end

    def download_texture
      begin
        image_uri = open self.texture_url
        raw_data = image_uri.read
      rescue OpenURI::HTTPError => e
        if e.message == "403 Forbidden"
          raise MinecraftAvatars::InvalidPlayerException.new(self.player_name)
        else
          raise e
        end
      end

      self.image = ChunkyPNG::Image.from_blob(raw_data)
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
