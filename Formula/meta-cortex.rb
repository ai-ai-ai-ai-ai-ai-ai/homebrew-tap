class MetaCortex < Formula
  desc "Install the Meta-Cortex development framework in a project"
  homepage "https://github.com/ai-ai-ai-ai-ai-ai-ai/meta-cortex"
  version "0.12.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ai-ai-ai-ai-ai-ai-ai/meta-cortex/releases/download/v0.12.3/meta-cortex-aarch64-apple-darwin.tar.xz"
      sha256 "d786aaab53a4f86d31bb35daa4bd4fe00d9077dd4c2ce763b5a5bdf82722347b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ai-ai-ai-ai-ai-ai-ai/meta-cortex/releases/download/v0.12.3/meta-cortex-x86_64-apple-darwin.tar.xz"
      sha256 "5445fe527a13b25d35e9f7c96b3607e93e304a46531c95686e48ae7ee46c4bb6"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ai-ai-ai-ai-ai-ai-ai/meta-cortex/releases/download/v0.12.3/meta-cortex-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "bdf44353352b2925c4ab5d6dee5f04ea502f58d9786e8b905ebada9d6f877fd9"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ai-ai-ai-ai-ai-ai-ai/meta-cortex/releases/download/v0.12.3/meta-cortex-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "92d5e495236265780edcc4604242a921778991ac50aebf260fcc7580aab081cb"
    end
  end
  license "Apache-2.0"

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin": {},
    "x86_64-pc-windows-gnu": {},
    "x86_64-unknown-linux-gnu": {}
  }

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "meta-cortex"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "meta-cortex"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "meta-cortex"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "meta-cortex"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
