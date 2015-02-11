require "minecraft-avatars/version"
require "minecraft-avatars/flat_character"
require "minecraft-avatars/face"

module MinecraftAvatars
  RESOLVE_UUID_URL = "https://api.mojang.com/users/profiles/minecraft"
  TEXTURE_URL = "https://sessionserver.mojang.com/session/minecraft/profile"

  SKIN_SECTIONS = {
    :head_front => [8, 8, 8, 8],
    :head_accessory => [40, 8, 8, 8],
    :leg_front => [4, 20, 4, 12],
    :body_front => [20, 20, 8, 12],
    :arm_front => [44, 20, 4, 12]
  }
end
