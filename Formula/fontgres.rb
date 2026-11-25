class Fontgres < Formula
  desc "Query installed fonts from the terminal"
  homepage "https://github.com/seferino-fernandez/fontgres"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/seferino-fernandez/fontgres/releases/download/v0.4.0/fontgres-x86_64-apple-darwin.tar.gz"
      sha256 "5a1d519d7356adfb9abd8c819ec7b7e0b563da684972d08d07cc70c9812d77f0"
    end
    if Hardware::CPU.arm?
      url "https://github.com/seferino-fernandez/fontgres/releases/download/v0.4.0/fontgres-aarch64-apple-darwin.tar.gz"
      sha256 "18e2a343c1bd3384b828ecc7ec70a6e6c7ca2a251ba668e20afaa38c2487c3d4"
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/seferino-fernandez/fontgres/releases/download/v0.4.0/fontgres-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "6cb503555ceeef69683ad0206b0a54048c32b9ff8a2ea3be6ad4177125c454ac"
    end
    if Hardware::CPU.arm?
      url "https://github.com/seferino-fernandez/fontgres/releases/download/v0.4.0/fontgres-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "7ed7234986905caed74292fb3f35228ee43bdbc2ed146b9a3872d4050ad8b02d"
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
