class MetaCortex < Formula
  desc "Install the Meta-Cortex development framework in a project"
  homepage "https://github.com/ai-ai-ai-ai-ai-ai-ai/meta-cortex"
  version "0.12.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ai-ai-ai-ai-ai-ai-ai/meta-cortex/releases/download/v0.12.2/meta-cortex-aarch64-apple-darwin.tar.xz"
      sha256 "679e4ac0689f9058171f60253481556cc3f9b47de5ba8711830e460a2711ffc9"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ai-ai-ai-ai-ai-ai-ai/meta-cortex/releases/download/v0.12.2/meta-cortex-x86_64-apple-darwin.tar.xz"
      sha256 "62bcd8d9d73812484940770d98a1ed748e86ebf4ec587f08b16b19ebacd8e81b"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ai-ai-ai-ai-ai-ai-ai/meta-cortex/releases/download/v0.12.2/meta-cortex-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "2be4b87b8a33adf7e341e70af6ab0d1992d200d0822244ea1d9a414f0ff0c5c9"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ai-ai-ai-ai-ai-ai-ai/meta-cortex/releases/download/v0.12.2/meta-cortex-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "17f0840feebc6d7f33779990e21838ecfba315725eb519a1559b69c4ab02faea"
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
