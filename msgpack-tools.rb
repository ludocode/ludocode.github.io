# Homebrew formula for msgpack-tools
# Maintainer: Nicholas Fraser <nicholas.rd.fraser@gmail.com>
class MsgpackTools < Formula
  desc "Command-line tools for converting between MessagePack and JSON"
  homepage "https://github.com/ludocode/msgpack-tools"
  url "https://github.com/ludocode/msgpack-tools/releases/download/v0.6/msgpack-tools-0.6.tar.gz"
  version "0.6"
  sha256 "98c8b789dced626b5b48261b047e2124d256e5b5d4fbbabdafe533c0bd712834"

  depends_on "cmake" => :build

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "env", "CTEST_OUTPUT_ON_FAILURE=1", "make", "test"
    system "make", "install"
  end

  test do
    system "json2msgpack", "-v"
    system "msgpack2json", "-v"
    system "bash", "-o", "pipefail", "-c", 'echo "{\"Hello\": \"world!\"}" | json2msgpack | msgpack2json -d'
  end
end
