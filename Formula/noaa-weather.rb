class NoaaWeather < Formula
  desc "CLI for the NOAA Weather API"
  homepage "https://github.com/seferino-fernandez/noaa_weather"
  version "1.3.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      # macOS Intel (x86_64) binary
      url "https://github.com/seferino-fernandez/noaa_weather/releases/download/v1.3.0/noaa-weather-x86_64-apple-darwin.tar.gz"
      sha256 "97cecce3bef6089ccab36a295fee99104cc0cd752089b63596943dffdbaedfd4"
    end
    if Hardware::CPU.arm?
      # macOS Apple Silicon (aarch64) binary
      url "https://github.com/seferino-fernandez/noaa_weather/releases/download/v1.3.0/noaa-weather-aarch64-apple-darwin.tar.gz"
      sha256 "54667e4fcc3fed9e33c03787c86edc6e76fa1002b696d141b7eb081f049927cc"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      # Linux x86_64 binary
      url "https://github.com/seferino-fernandez/noaa_weather/releases/download/v1.3.0/noaa-weather-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "949a3ec6ba957d2fb2158079fea23830b8ee025ee3a1301667f9e2efa2cf99c0"
    end
    if Hardware::CPU.arm?
      # Linux ARM binary
      url "https://github.com/seferino-fernandez/noaa_weather/releases/download/v1.3.0/noaa-weather-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "e691042dea0b75ec1b9858602e858e4465baa879dfbe0aff07c5341bb0c216ec"
    end
  end

  def install
    bin.install "noaa-weather"
  end

  test do
    system "#{bin}/noaa-weather", "--version"
  end
end
