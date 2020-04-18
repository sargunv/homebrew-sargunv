class Modsman < Formula
  desc "Minecraft mod manager for the command-line"
  homepage "https://gitlab.com/sargunv-mc-mods/modsman"
  head "https://gitlab.com/sargunv-mc-mods/modsman.git"

  url "https://github.com/sargunv/modsman/releases/download/0.32.0/modsman-cli-0.32.0.zip"
  sha256 "799cc4c965c2a1cc6253095887424276fafc25abf2323f4c867e0c29cc0189e8"  # MUST BE LOWERCASE
  version "0.32.0"

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
