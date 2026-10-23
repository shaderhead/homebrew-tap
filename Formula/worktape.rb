class Worktape < Formula
  desc "Record your terminal and its windows for devlogs and screencasts"
  homepage "https://github.com/shaderhead/worktape"
  url "https://github.com/shaderhead/worktape/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "b8b137a34e6de6bb864bf7eaf439eb4c1fdb0c9c359ad8a7f4230b1bbfc91a3b"
  license "MIT"

  bottle do
    root_url "https://github.com/shaderhead/homebrew-tap/releases/download/worktape-0.2.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "ba97b036e8102e0da952d7ba04c30783bc7d1943e6e5321d61e7e604e773993d"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "4686298f60c9ab5f81bd9c2b458518763fb3b237fb61e30fb8214de07fc62d00"
  end

  depends_on xcode: ["16.0", :build]
  depends_on "agg"
  depends_on "asciinema"
  depends_on "ffmpeg"
  depends_on macos: :sequoia

  def install
    system "swift", "build", "--disable-sandbox", "--configuration", "release"
    bin.install ".build/release/worktape"
  end

  test do
    assert_match "usage: worktape", shell_output("#{bin}/worktape --help")
    system bin/"worktape", "init"
    assert_path_exists testpath/".worktapes/.gitignore"
  end
end
