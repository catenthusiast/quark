module Quark
  class Color
    def initialize(*, r : Int32, g : Int32, b : Int32)
      @red = r
      @green = g
      @blue = b
    end

    def initialize(*, h : Int32, s : Int32, l : Int32)
      rgb = Quark.hsl2rgb(h, s, l)
      @red = rgb[0]
      @green = rgb[1]
      @blue = rgb[2]
    end

    def rgb
      {red: @red, green: @green, blue: @blue}
    end

    def css_rgb
      "rgb(#{@red}, #{@green}, #{@blue})"
    end

    def hex
      "#%02x%02x%02x".upcase % [@red, @green, @blue]
    end

    def hsl
      hsl = Quark.rgb2hsl(@red, @green, @blue)
      {hue: hsl[0], saturation: hsl[1], luminosity: hsl[2]}
    end

    def css_hsl
      "hsl(#{hsl[:hue]}, #{hsl[:saturation]}, #{hsl[:luminosity]})"
    end
  end
end
