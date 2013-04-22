# minecraft-avatars

This is a Ruby gem that allows you to easily retrieve a player's raw Minecraft skin from Amazon S3 (http://s3.amazonaws.com/MinecraftSkins/Notch.png) and restructure it into a variety of usable sizes and formats.

It relies on the simple, pure-ruby 'chunky_png' gem to parse and restructure the skins, rather than huge libraries like RMagick.

It uses nearest neighbor resizing to perfectly resize the avatars to the size you desire.

## Installation

Add this line to your application's Gemfile:

    gem 'minecraft-avatars'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install minecraft-avatars

## Documentation
Usage of minecraft-avatars is extremely simple and straightforward. As of right now, there are two types of avatars.
```ruby
# Extract the 8x8 face and head accessory to a 64x64 image
image = MinecraftAvatars::Face.new(player_name, size = 64, accessories = true)

# Extract the standard character avatar (front of the head, arms, legs, and torso) to a 32x64 image
image = MinecraftAvatars::FlatCharacter.new(player_name, size = 64, accessories = true)
```
Keep in mind that avatars are not lazy-loaded and perform an HTTP request every time the class is intialized.
```ruby
# Get the raw blob (this is what youll likely be using)
image.to_blob(constraints = {})

# Save the image to a file
image.save(file_path, constraints = {})

# Output the image to an I/O stream
image.write(io, constraints = {})
```
All returned avatars share a set of methods used for exporting the image data in a variety of ways. 
These methods are simply aliases to the internal ChunkyPNG::Canvas::PNGEncoding methods. Therefor, you can use the same parameters you can for ChunkyPNG.

The documentation can be found at http://rdoc.info/gems/chunky_png/ChunkyPNG/Canvas/PNGEncoding
## Examples

Retrieve a 128x128 face avatar for Notch with no accessories and save it to /tmp/notch.png. Also catch exceptions incase Notch somehow doesn't exist.
```ruby
begin
    image = MinecraftAvatars::Face.new "Notch", 128, false
    image.save '/tmp/notch.png'
rescue MinecraftAvatars::InvalidPlayerException => e
    # Notch doesn't exist? WHAT THE FU-
end
```
