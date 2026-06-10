class Rhood < Formula
  desc "Terminal CLI for the Robinhood trading API"
  homepage "https://github.com/seferino-fernandez/rhood-rs"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/seferino-fernandez/rhood-rs/releases/download/v0.1.2/rhood-x86_64-apple-darwin.tar.gz"
      sha256 "390651b3e27121f49107a4a3a3f7ec7de08438f282427cb5bc570f10f2a99b8c"
    end
    if Hardware::CPU.arm?
      url "https://github.com/seferino-fernandez/rhood-rs/releases/download/v0.1.2/rhood-aarch64-apple-darwin.tar.gz"
      sha256 "258276b6c426b23cb49699269bac965c1fd52d62116319dbec33557758cc8f08"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/seferino-fernandez/rhood-rs/releases/download/v0.1.2/rhood-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "afd198baa667148fbdc240d6de08c8b976088e12c4aca7174588072647dc823c"
    end
    if Hardware::CPU.arm?
      url "https://github.com/seferino-fernandez/rhood-rs/releases/download/v0.1.2/rhood-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "b7d7879266f006092b81a9d33347d2c300e01df695616d9bae6e87d3940261a3"
    end
  end

  def install
    bin.install "rhood"
  end

  test do
    system bin/"rhood", "--version"
  end
end
