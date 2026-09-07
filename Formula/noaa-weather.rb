class NoaaWeather < Formula
  desc "CLI for the NOAA Weather API"
  homepage "https://github.com/seferino-fernandez/noaa_weather"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      # macOS Intel (x86_64) binary
      url "https://github.com/seferino-fernandez/noaa_weather/releases/download/v2.0.0/noaa-weather-x86_64-apple-darwin.tar.gz"
      sha256 "d86e1fe5dd92a1536fbdbfc33b4841d2c615bc11f09c52f5440d302b3fa6a372"
    end
    if Hardware::CPU.arm?
      # macOS Apple Silicon (aarch64) binary
      url "https://github.com/seferino-fernandez/noaa_weather/releases/download/v2.0.0/noaa-weather-aarch64-apple-darwin.tar.gz"
      sha256 "9be7809c718148e62d9a0a1d9f4f3bb8aaa51fe1485fe2756f2b976ecacd9319"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      # Linux x86_64 binary
      url "https://github.com/seferino-fernandez/noaa_weather/releases/download/v2.0.0/noaa-weather-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "cce40a085f66959b40241eb71f6daec9c3ae91c932fe71c9711a45c850ac1cdd"
    end
    if Hardware::CPU.arm?
      # Linux ARM binary
      url "https://github.com/seferino-fernandez/noaa_weather/releases/download/v2.0.0/noaa-weather-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "2b0cfc2e60366bab0d02c531b01ff641ee46d5aab602569aa57d8aa9f1bf5584"
    end
  end

  def install
    bin.install "noaa-weather"
  end

  test do
    system bin/"noaa-weather", "--version"
  end
end
