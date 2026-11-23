class Fontgres < Formula
  desc "Query installed fonts from the terminal"
  homepage "https://github.com/seferino-fernandez/fontgres"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/seferino-fernandez/fontgres/releases/download/v0.1.0/fontgres-x86_64-apple-darwin.tar.gz"
      sha256 "b0e11008b3b4df04d7895a94c768f5f4e5515c145ae22a33e33b2b0b5d2168a7"
    end
    if Hardware::CPU.arm?
      url "https://github.com/seferino-fernandez/fontgres/releases/download/v0.1.0/fontgres-aarch64-apple-darwin.tar.gz"
      sha256 "f1f4911b3f9de16b4f0512edb9e780a5e8ccf26f78cae41a41c5d8cbd810cab2"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/seferino-fernandez/fontgres/releases/download/v0.1.0/fontgres-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "faff5033c2a098281208dd9ccb5b55f6cc633efe51b2ac7c1928cf419ef31054"
    end
    if Hardware::CPU.arm?
      url "https://github.com/seferino-fernandez/fontgres/releases/download/v0.1.0/fontgres-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "0015afa4bf8d5a43f5a5fe3cf6445ee27a4cc17bbf7b0291128fb200d2f7f9c8"
    end
  end

  def install
    bin.install "fontgres"
    generate_completions_from_executable(bin/"fontgres", "completions")
    system bin/"fontgres", "man", buildpath/"man"
    man1.install buildpath.glob("man/*.1")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/fontgres --version")
  end
end
