class Modsman < Formula
  desc "Minecraft mod manager for the command-line"
  homepage "https://gitlab.com/sargunv-mc-mods/modsman"
  head "https://gitlab.com/sargunv-mc-mods/modsman.git"

  url "https://github.com/sargunv/modsman/releases/download/0.22.0/modsman-cli-0.22.0.zip"
  sha256 "66a63a05e7b2068a8e0480ebbb29a552f751c1c504f1982ae392ea3e255dba83"  # MUST BE LOWERCASE
  version "0.22.0"

  depends_on :java => "11+"

  def install
    if build.head?
      system "./gradlew", ":modsman-cli:installDist"
      libexec.install Dir["modsman-cli/build/install/modsman-cli/*"]
    else
      libexec.install %w[bin lib]
      system "chmod", "+x", "#{libexec}/bin/modsman-cli"
    end

    rm_f Dir["#{libexec}/bin/*.bat"]
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    (testpath/".modlist.json").write('{"config": {"game_version": "1.14"}, "mods": []}')
    system bin/"modsman-cli", "list"
  end
end
