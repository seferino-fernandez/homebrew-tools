class NoaaWeather < Formula
  desc "CLI for the NOAA Weather API"
  homepage "https://github.com/seferino-fernandez/noaa_weather"
  version "1.2.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      # macOS Intel (x86_64) binary
      url "https://github.com/seferino-fernandez/noaa_weather/releases/download/v1.2.0/noaa-weather-x86_64-apple-darwin.tar.gz"
      sha256 "584c77b6816f3f4d0b5ce9b8c4ba705720eb0fb669736ab005ccd63c7a1095e4"
    end
    if Hardware::CPU.arm?
      # macOS Apple Silicon (aarch64) binary
      url "https://github.com/seferino-fernandez/noaa_weather/releases/download/v1.2.0/noaa-weather-aarch64-apple-darwin.tar.gz"
      sha256 "41f9d11d82034a2f6b8b8c69568cf48e6db33fe42f751edaef18e4d57e32a474"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      # Linux x86_64 binary
      url "https://github.com/seferino-fernandez/noaa_weather/releases/download/v1.2.0/noaa-weather-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "9ad9d20b14c637899ed90eda1a1f2c0c9b3a30efe29b91993eec96f2ec26a262"
    end
  end

  def install
    bin.install "noaa-weather"
  end

  test do
    system "#{bin}/noaa-weather", "--version"
  end
end
