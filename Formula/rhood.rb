class Rhood < Formula
  desc "Terminal CLI for the Robinhood trading API"
  homepage "https://github.com/seferino-fernandez/rhood-rs"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/seferino-fernandez/rhood-rs/releases/download/v0.3.0/rhood-x86_64-apple-darwin.tar.gz"
      sha256 "7fa12b3f58b5f8a967c8e7c030183d96d20308cb84dfca4a0f1b3c6e66f64c44"
    end
    if Hardware::CPU.arm?
      url "https://github.com/seferino-fernandez/rhood-rs/releases/download/v0.3.0/rhood-aarch64-apple-darwin.tar.gz"
      sha256 "f1304002c2398f8503cf9f34d356616c00c2084f915315be37d2484251d764da"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/seferino-fernandez/rhood-rs/releases/download/v0.3.0/rhood-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "5cf0088006c959c2f37de34d76909753836c3dd1dfb38bb696e5c16be6982504"
    end
    if Hardware::CPU.arm?
      url "https://github.com/seferino-fernandez/rhood-rs/releases/download/v0.3.0/rhood-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "4012eb7c8bc90adede49294a412e803ebb3ed5aa909c07300cbfb723c3a8edbe"
    end
  end

  def install
    bin.install "rhood"
  end

  test do
    system bin/"rhood", "--version"
  end
end
