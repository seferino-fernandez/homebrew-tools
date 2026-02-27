class NoaaWeather < Formula
  desc "CLI for the NOAA Weather API"
  homepage "https://github.com/seferino-fernandez/noaa_weather"
  version "1.1.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      # macOS Intel (x86_64) binary
      url "https://github.com/seferino-fernandez/noaa_weather/releases/download/v1.1.0/noaa-weather-x86_64-apple-darwin.tar.gz"
      sha256 "3188fa5878fb7b82cfc18e6577223bd973521c179cd6d6504487f29e4f022ffe"
    end
    if Hardware::CPU.arm?
      # macOS Apple Silicon (aarch64) binary
      url "https://github.com/seferino-fernandez/noaa_weather/releases/download/v1.1.0/noaa-weather-aarch64-apple-darwin.tar.gz"
      sha256 "e6f3355c33c38b83a68a822862dbdd131829627c31e861ab4f90fc49e0d29bd6"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      # Linux x86_64 binary
      url "https://github.com/seferino-fernandez/noaa_weather/releases/download/v1.1.0/noaa-weather-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "b56ff3b615e8cab7c9bf59c6a8e94272c794770607dfc9e30900108f47e45171"
    end
  end

  def install
    bin.install "noaa-weather"
  end

  test do
    system "#{bin}/noaa-weather", "--version"
  end
end
