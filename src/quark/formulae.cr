module Quark
  module Formulae
    # Returns tuple {h, s, l}
    def rgb2hsl(r : Int32, g : Int32, b : Int32)
      rr = r / 255.0
      gg = g / 255.0
      bb = b / 255.0

      min = {rr, gg, bb}.min
      max = {rr, gg, bb}.max

      # Luminosity
      l = (min + max)/2.0

      # Saturation
      if min == max
        s = 0.0
      elsif l < 0.5
        s = (max - min) / (max + min)
      else # l < 0.5
        s = (max - min) / (2.0 - max - min)
      end

      # Hue
      if rr == gg == bb
        h = 0
      elsif rr == max
        h = (gg - bb) / (max - min)
      elsif gg == max
        h = (bb - rr) / (max - min)
      else # bb == max
        h = 4.0 + (rr - gg) / (max - min)
      end
      h = h * 60
      s = s * 100
      l = l * 100

      {h, s, l}
    end

    # Returns tuple {r, g, b}
    def hsl2rgb(h : Int32, s : Int32, l : Int32)
      h = h / 360.0
      s = s / 100.0
      l = l / 100.0

      r, g, b = 0, 0, 0

      if s == 0
        r = l
        g = l
        b = l
      else
        j = 0.0
        j = l * (s + 1) if l < 0.5
        j = l + s - l * s if l >= 0.5

        k = 2.0 * l - j

        r = hue2rgb(j, k, h + 1.0/3.0)
        g = hue2rgb(j, k, h)
        b = hue2rgb(j, k, h - 1.0/3.0)
      end

      r = (r * 255).round.to_i
      g = (g * 255).round.to_i
      b = (b * 255).round.to_i

      {r, g, b}
    end

    protected def hue2rgb(j, k, h)
      h += 1 if h < 0
      h -= 1 if h > 1

      if h < 1.0/6.0
        return j + (k - j) * 6 * h
      elsif h < 1.0/2.0
        return j
      elsif h < 2.0/3.0
        return j + (k - j) * (2.0/3.0 - h) * 6
      else
        return k
      end
    end
  end
end
