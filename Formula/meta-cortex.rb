class MetaCortex < Formula
  desc "Install the Meta-Cortex development framework in a project"
  homepage "https://github.com/ai-ai-ai-ai-ai-ai-ai/meta-cortex"
  version "0.1.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ai-ai-ai-ai-ai-ai-ai/meta-cortex/releases/download/v0.1.3/meta-cortex-aarch64-apple-darwin.tar.xz"
      sha256 "9b18c2cc7b1a890e1677e10b5a2e106b87d056182372cc31623a0afba22d8db5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ai-ai-ai-ai-ai-ai-ai/meta-cortex/releases/download/v0.1.3/meta-cortex-x86_64-apple-darwin.tar.xz"
      sha256 "f2204ca557c3958d961cf639f41ce85e13c571c0202e7e548f1d23dd09b030d7"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ai-ai-ai-ai-ai-ai-ai/meta-cortex/releases/download/v0.1.3/meta-cortex-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "28f944cbb1b8350af45dd3ecebfcf1b89384a6f9c49536b5abeb833a350594bd"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ai-ai-ai-ai-ai-ai-ai/meta-cortex/releases/download/v0.1.3/meta-cortex-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "0589e71edb9d239d3c44a59cf3d8956e04b2254417760c88245ba62c3e109eac"
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
