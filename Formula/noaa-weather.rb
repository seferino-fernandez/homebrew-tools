class NoaaWeather < Formula
  desc "A CLI for the NOAA Weather API"
  homepage "https://github.com/seferino-fernandez/noaa_weather"
  license "MIT"
  version "0.1.5"

  on_macos do
    if Hardware::CPU.intel?
      # macOS Intel (x86_64) binary
      url "https://github.com/seferino-fernandez/noaa_weather/releases/download/noaa_weather_cli-v0.1.5/noaa-weather-x86_64-apple-darwin.tar.gz"
      sha256 "36659eff3d4518c2ceaf4a855376854cd0dd27ada6894fcdd8c07b5602510886"
    end
    if Hardware::CPU.arm?
      # macOS Apple Silicon (aarch64) binary
      url "https://github.com/seferino-fernandez/noaa_weather/releases/download/noaa_weather_cli-v0.1.5/noaa-weather-aarch64-apple-darwin.tar.gz"
      sha256 "de7e894551f66acd3b3d37a0326de58330b89a36c8def0c26d552da8bf4f560f"
    end
  end

  def install
    bin.install "noaa-weather"
  end

  test do
    system "#{bin}/noaa-weather", "--version"
  end
end