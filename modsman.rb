class Modsman < Formula
  desc "Minecraft mod manager for the command-line"
  homepage "https://gitlab.com/sargunv-mc-mods/modsman"
  head "https://gitlab.com/sargunv-mc-mods/modsman.git"

  url "https://github.com/sargunv/modsman/releases/download/0.32.1/modsman-cli-0.32.1.zip"
  sha256 "596b894224d31db0c416d42d8c5a266c8ae146e8b9cb81e02bb16f8ab776b693"  # MUST BE LOWERCASE
  version "0.32.1"

  depends_on "openjdk@11"

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
