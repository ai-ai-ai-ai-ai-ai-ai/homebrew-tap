class MetaCortex < Formula
  desc "Install the Meta-Cortex development framework in a project"
  homepage "https://github.com/ai-ai-ai-ai-ai-ai-ai/meta-cortex"
  version "0.16.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/ai-ai-ai-ai-ai-ai-ai/meta-cortex/releases/download/v0.16.0/meta-cortex-aarch64-apple-darwin.tar.xz"
      sha256 "1349f661825c8a2fb85afabc4f34d9fc865fd6a54580021a0dbb1189a677ad5b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ai-ai-ai-ai-ai-ai-ai/meta-cortex/releases/download/v0.16.0/meta-cortex-x86_64-apple-darwin.tar.xz"
      sha256 "1a95c1e9fce878ac495b380f29a6746fa36dc252929d9dcc11a53646d639099a"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/ai-ai-ai-ai-ai-ai-ai/meta-cortex/releases/download/v0.16.0/meta-cortex-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "971bc2c4c9fa9828481ecaac9c74553c61df12a6d45c3e07eb256a8c8c5b7c30"
    end
    if Hardware::CPU.intel?
      url "https://github.com/ai-ai-ai-ai-ai-ai-ai/meta-cortex/releases/download/v0.16.0/meta-cortex-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "52f2638f9c4972f8d6dd07a41b6db3d233bb792be1867714a0908a05257c10a4"
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
