class Fontgres < Formula
  desc "Query installed fonts from the terminal"
  homepage "https://github.com/seferino-fernandez/fontgres"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/seferino-fernandez/fontgres/releases/download/v0.3.0/fontgres-x86_64-apple-darwin.tar.gz"
      sha256 "b7fc02ce424d916bcc425406d12236fda88d1fbe4a7b34f3a7c87405bad28711"
    end
    if Hardware::CPU.arm?
      url "https://github.com/seferino-fernandez/fontgres/releases/download/v0.3.0/fontgres-aarch64-apple-darwin.tar.gz"
      sha256 "54a651e43d6893290260f994f98ddaf8aa89b5981ac6e1fd86f9d9d8124ed821"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/seferino-fernandez/fontgres/releases/download/v0.3.0/fontgres-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "6e93c4543b901ec11c2d6f10f40a59f06be55f09a262070feb1fe5c1b65571df"
    end
    if Hardware::CPU.arm?
      url "https://github.com/seferino-fernandez/fontgres/releases/download/v0.3.0/fontgres-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "4469495a083a2ddc27fe09b335f1bba9743ea9fa85a26a90be6554b4286bb051"
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
