class NoaaWeatherMcp < Formula
  desc "MCP server for the NOAA Weather API"
  homepage "https://github.com/seferino-fernandez/noaa_weather"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      # macOS Intel (x86_64) binary
      url "https://github.com/seferino-fernandez/noaa_weather/releases/download/v2.0.0/noaa-weather-mcp-x86_64-apple-darwin.tar.gz"
      sha256 "888e5f613d96eddb1d5c9bc70548a1cd6343e605ea84ee67830ffa519435d144"
    end
    if Hardware::CPU.arm?
      # macOS Apple Silicon (aarch64) binary
      url "https://github.com/seferino-fernandez/noaa_weather/releases/download/v2.0.0/noaa-weather-mcp-aarch64-apple-darwin.tar.gz"
      sha256 "b3f159045d895d795a8041f9b6841f8b674ea55b1828626924b64787ad176e28"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      # Linux x86_64 binary
      url "https://github.com/seferino-fernandez/noaa_weather/releases/download/v2.0.0/noaa-weather-mcp-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "418717198ab6de92e6bc426876f3aba74f53fe81abfec0577a307630441a3bab"
    end
    if Hardware::CPU.arm?
      # Linux ARM binary
      url "https://github.com/seferino-fernandez/noaa_weather/releases/download/v2.0.0/noaa-weather-mcp-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "feee79f789da1ce514bf01d2b5b9c8f18c9cf2ba01bcc95d681401d36e75b3a1"
    end
  end

  def install
    bin.install "noaa-weather-mcp"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/noaa-weather-mcp --version")
  end
end
