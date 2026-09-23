class MetaCortex < Formula
  desc "Install the Meta-Cortex development framework in a project"
  homepage "https://github.com/ai-ai-ai-ai-ai-ai-ai/meta-cortex"
  version "0.6.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ai-ai-ai-ai-ai-ai-ai/meta-cortex/releases/download/v0.6.2/meta-cortex-aarch64-apple-darwin.tar.xz"
      sha256 "654fa50a7a21df36eab60256682539fe96312a5e1d03396b5b2b09cd3db86f60"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ai-ai-ai-ai-ai-ai-ai/meta-cortex/releases/download/v0.6.2/meta-cortex-x86_64-apple-darwin.tar.xz"
      sha256 "fc80ca7afe71a202791ffc8aec46900527a733cf03e19b8f7975b418db94376b"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ai-ai-ai-ai-ai-ai-ai/meta-cortex/releases/download/v0.6.2/meta-cortex-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "c714581110ed519d63ed34d41c5c28304fbb24ea69f5d5ce1475c868e4b62311"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ai-ai-ai-ai-ai-ai-ai/meta-cortex/releases/download/v0.6.2/meta-cortex-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "210e51d13336886b7a07a59234add4534c7bcb53ecb309a55fd722de8128c651"
    end
  end
  license "Apache-2.0"

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin": {},
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
