class NoaaWeather < Formula
  desc "CLI for the NOAA Weather API"
  homepage "https://github.com/seferino-fernandez/noaa_weather"
  version "0.1.6"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      # macOS Intel (x86_64) binary
      url "https://github.com/seferino-fernandez/noaa_weather/releases/download/noaa_weather_client-v0.1.6/noaa-weather-x86_64-apple-darwin.tar.gz"
      sha256 "bf7ddedf4456f1581cdb268e53b3cebbe0811d41ee4192fe2e4e35f62c584067"
    end
    if Hardware::CPU.arm?
      # macOS Apple Silicon (aarch64) binary
      url "https://github.com/seferino-fernandez/noaa_weather/releases/download/noaa_weather_client-v0.1.6/noaa-weather-aarch64-apple-darwin.tar.gz"
      sha256 "83338eb8cc652080e4256e42e5e1410288186f442d9468166eaf247e9886e85b"
    end
  end

  def install
    bin.install "noaa-weather"
  end

  test do
    system "#{bin}/noaa-weather", "--version"
  end
end
