class Rhood < Formula
  desc "Terminal CLI for the Robinhood trading API"
  homepage "https://github.com/seferino-fernandez/rhood-rs"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/seferino-fernandez/rhood-rs/releases/download/v0.1.3/rhood-x86_64-apple-darwin.tar.gz"
      sha256 "47436135701c890e6e82107f2675f819390f28394c9db57cceb788132626d644"
    end
    if Hardware::CPU.arm?
      url "https://github.com/seferino-fernandez/rhood-rs/releases/download/v0.1.3/rhood-aarch64-apple-darwin.tar.gz"
      sha256 "f8e38d225b56b4a86f2984146637171370df2e0ae23fd217ac67cf432875a3d3"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/seferino-fernandez/rhood-rs/releases/download/v0.1.3/rhood-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "f23b49e66563877936e121d78f8bb3f185b2168e29a85c2d1ae7cbf07a5e3a3c"
    end
    if Hardware::CPU.arm?
      url "https://github.com/seferino-fernandez/rhood-rs/releases/download/v0.1.3/rhood-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "db5935c870974853f2d277edece0eae18c61dcf994edfed87666ebfa0fe05000"
    end
  end

  def install
    bin.install "rhood"
  end

  test do
    system bin/"rhood", "--version"
  end
end
