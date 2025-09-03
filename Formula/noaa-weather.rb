class NoaaWeather < Formula
  desc "CLI for the NOAA Weather API"
  homepage "https://github.com/seferino-fernandez/noaa_weather"
  version "0.1.7"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      # macOS Intel (x86_64) binary
      url "https://github.com/seferino-fernandez/noaa_weather/releases/download/v0.1.7/noaa-weather-x86_64-apple-darwin.tar.gz"
      sha256 "275779eceb70d90cab13fa6b0a194cbc4ba0456fa6e64568332979126a2a3141"
    end
    if Hardware::CPU.arm?
      # macOS Apple Silicon (aarch64) binary
      url "https://github.com/seferino-fernandez/noaa_weather/releases/download/v0.1.7/noaa-weather-aarch64-apple-darwin.tar.gz"
      sha256 "4fa18cc44dd33c5175d9f7051ca29a47eb1d636408b8fca08fabc536c65be7f1"
    end
  end

  def install
    bin.install "noaa-weather"
  end

  test do
    system "#{bin}/noaa-weather", "--version"
  end
end
