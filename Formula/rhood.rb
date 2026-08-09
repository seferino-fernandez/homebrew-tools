class Rhood < Formula
  desc "Terminal CLI for the Robinhood trading API"
  homepage "https://github.com/seferino-fernandez/rhood-rs"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/seferino-fernandez/rhood-rs/releases/download/v0.1.4/rhood-x86_64-apple-darwin.tar.gz"
      sha256 "a03cc970e65d4f3d9a0f6fb38713c73102e0549cd9df1e82c9991751c3df2cac"
    end
    if Hardware::CPU.arm?
      url "https://github.com/seferino-fernandez/rhood-rs/releases/download/v0.1.4/rhood-aarch64-apple-darwin.tar.gz"
      sha256 "004e7ccfc1eb15443195b72f36aac8f97bd01b7979d75abf25b7b9267ae4f7b5"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/seferino-fernandez/rhood-rs/releases/download/v0.1.4/rhood-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "1d9b632a3fc775b5f378303872c5b6131dc0ff6bfb0ca54234d9d2f49788260a"
    end
    if Hardware::CPU.arm?
      url "https://github.com/seferino-fernandez/rhood-rs/releases/download/v0.1.4/rhood-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "c973e98fbefd42807e22e867d2c581ce8063a62e0e470c3bb46f750f81554539"
    end
  end

  def install
    bin.install "rhood"
  end

  test do
    system bin/"rhood", "--version"
  end
end
