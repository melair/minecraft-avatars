module MinecraftAvatars
  class BaseImage
    
    attr_accessor :chunky

    def to_blob(constraints = {})
      chunky.to_blob(constraints)
    end

    def save(filename, constraints = {})
      chunky.save(filename, constraints)
    end

    def write(io, constraints = {})
      chunky.write(io, constraints)
    end

  end
end