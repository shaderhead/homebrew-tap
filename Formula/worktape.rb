class Worktape < Formula
  desc "Record your terminal and its windows for devlogs and screencasts"
  homepage "https://github.com/shaderhead/worktape"
  url "https://github.com/shaderhead/worktape/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "0107664d18aa35a1bab4cb8ceab96024c623bef51b96656dc9bf40b4cf3d40d7"
  license "MIT"

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
