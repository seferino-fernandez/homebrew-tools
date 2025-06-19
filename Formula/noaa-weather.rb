class NoaaWeather < Formula
  desc "A CLI for the NOAA Weather API"
  homepage "https://github.com/seferino-fernandez/noaa_weather"
  license "MIT"
  version "0.1.1"

  on_macos do
    if Hardware::CPU.intel?
      # macOS Intel (x86_64) binary
      url "https://github.com/seferino-fernandez/noaa_weather/releases/download/noaa_weather_cli-v0.1.1/noaa-weather-x86_64-apple-darwin.tar.gz"
      sha256 "cccf6f39c2be01b30278c5363b6008a0151ad8bd91eb78a0fe798c0ca4fbbe3f"
    end
    if Hardware::CPU.arm?
      # macOS Apple Silicon (aarch64) binary
      url "https://github.com/seferino-fernandez/noaa_weather/releases/download/noaa_weather_cli-v0.1.1/noaa-weather-aarch64-apple-darwin.tar.gz"
      sha256 "a279577e515b7e5a2f73b5c62a3fc6af68423863319594ae4fa1bb4626889827"
    end
  end

  def install
    bin.install "noaa-weather"
  end

  test do
    system "#{bin}/noaa-weather", "--version"
  end
end