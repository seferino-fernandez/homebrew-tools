class NoaaWeather < Formula
  desc "CLI for the NOAA Weather API"
  homepage "https://github.com/seferino-fernandez/noaa_weather"
  version "0.1.8"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      # macOS Intel (x86_64) binary
      url "https://github.com/seferino-fernandez/noaa_weather/releases/download/v0.1.8/noaa-weather-x86_64-apple-darwin.tar.gz"
      sha256 "e17cb6c190fa5204f7c00fb787ae192c431f656449f09f42fc89df67755db3c3"
    end
    if Hardware::CPU.arm?
      # macOS Apple Silicon (aarch64) binary
      url "https://github.com/seferino-fernandez/noaa_weather/releases/download/v0.1.8/noaa-weather-aarch64-apple-darwin.tar.gz"
      sha256 "fb6f915e694e6ed5b97aeff7384c859b41553662610b3a8b0e7247909b5bae6a"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      # Linux x86_64 binary
      url "https://github.com/seferino-fernandez/noaa_weather/releases/download/v0.1.8/noaa-weather-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "4b64f411d4e1b1a3cfcf111394a57e4aee4f8e0fb52dc0573d8c5d8e6bc85a62"
    end
  end

  def install
    bin.install "noaa-weather"
  end

  test do
    system "#{bin}/noaa-weather", "--version"
  end
end
